require "TimedActions/ISBaseTimedAction"

-- Part repair rules and timed actions. Shared so the server runs complete() in MP;
-- menus live in client/SC/PartRepair/SC_PartRepair_Menu.lua, the bench recipe bridge in
-- SC_RepairRecipe.lua, per-item scrap yields in SC_PartRepair_BuildCosts.lua.

SCKCO = SCKCO or {}
SCKCO.PartRepair = SCKCO.PartRepair or {}
local AR = SCKCO.PartRepair

-- ---------------------------------------------------------------------------------------
-- Options
-- ---------------------------------------------------------------------------------------

AR.defaults = {
    RepairEnabled = true,
    RestrictToSCVehicles = true,
    RepairLooseParts = true,
    RepairHideUnusable = true,
    ReplaceVanillaRepair = true,
    RepairMaterialScale = 1.0,
    RepairSkillMode = 3,            -- 1 Mechanics, 2 MetalWelding, 3 highest of the two
    RepairMinSkill = 0,

    ArmorRepairEnabled = true,
    BodyRepairEnabled = true,
    TireRepairEnabled = true,
    TireFlatThreshold = 0.1,
    SeatRepairEnabled = true,
    SeatAllowTape = true,
    SeatTapeFailPenalty = 25,
    MetalRequireMask = true,

    -- a pass closes (base + skill * perSkill) of the gap to the ceiling
    RepairCloseFraction = 0.25,
    RepairCloseFractionPerSkill = 0.05,
    -- the ceiling drops per successful pass until the part is scrap
    RepairDegradePerPass = 3,
    RepairScrapCeiling = 25,
    RepairTotalLossThreshold = 0,
    RepairMinGap = 1,

    RepairBaseTime = 120,
    RepairTimePerDamage = 4,
    RepairTimePerSkillLevel = 8,

    RepairFailBase = 5,
    RepairFailPerDamage = 0.6,
    RepairFailPerSkill = 4,
    RepairFailMax = 75,
    RepairBotchChance = 30,
    RepairBotchDamage = 8,

    RepairXP = 5,
    RepairXPPerDamage = 0.2,

    ScrapEnabled = true,
    ScrapYieldScale = 1.0,
    ScrapLossBase = 40,
    ScrapLossPerSkill = 3,
}

-- read at call time: MP clients receive SandboxVars after Lua loads
local function sv(key)
    local vars = SandboxVars.SCKCO
    local v = vars and vars[key]
    if v == nil then return AR.defaults[key] end
    return v
end
AR.getOption = sv

local function clamp(v, lo, hi)
    if v < lo then return lo end
    if hi and v > hi then return hi end
    return v
end

function AR.round(v) return math.floor(v + 0.5) end

-- per-pass material use, all multiplied by RepairMaterialScale. torch is a fraction of one
-- torch; the rest are whole uses
AR.cost = { torchFraction = 0.08, rodBase = 1, rodPerDamage = 0.05, tirePatch = 1, seatThread = 2, seatTape = 2 }
local function cost(key) return AR.cost[key] * sv("RepairMaterialScale") end

AR.MIN_PASS_TIME = 40
AR.SCRAP_TIME = 300
local SKILL_MECHANICS, SKILL_WELDING = 1, 2
local DEFAULT_ANIM = "VehicleWorkOnMid"   -- the only vehicle work anim in vanilla

-- ---------------------------------------------------------------------------------------
-- Tools and materials
-- ---------------------------------------------------------------------------------------

-- tag constant first, then explicit types. base:blowtorch is registered but no item carries
-- it, so torches always resolve through the type list.
AR.tools = {
    torch  = { tag = "BLOW_TORCH", types = { "Base.BlowTorch", "Base.WeldingTorch" } },
    rods   = { types = { "Base.WeldingRods" } },
    mask   = { tag = "WELDING_MASK", types = { "Base.WeldingMask", "Base.Glasses_OldWeldingGoggles", "Base.WeldingGoggles" } },
    patch  = { types = { "SCKCO.TirePatchKit" } },
    needle = { tag = "SEWING_NEEDLE", types = { "Base.Needle", "Base.SutureNeedle" } },
    thread = { tag = "THREAD", types = { "Base.Thread" } },
    strips = { types = { "Base.LeatherStrips", "Base.DenimStrips", "Base.RippedSheets" } },
    tape   = { tag = "REPAIR_WITH_TAPE", types = { "Base.DuctTape" } },
}

-- ItemTag is a class of static constants; hasTag/getFirstTagRecurse need the instance and
-- throw on a raw string
local tagCache = {}
function AR.getTagValue(name)
    if tagCache[name] == nil then
        tagCache[name] = type(ItemTag) == "table" and ItemTag[name] or false
    end
    return tagCache[name] or nil
end

function AR.findTool(character, key)
    local tool, inv = AR.tools[key], character:getInventory()
    local tag = tool.tag and AR.getTagValue(tool.tag)
    local item = tag and inv:getFirstTagRecurse(tag)
    if item then return item end
    for _, t in ipairs(tool.types) do
        item = inv:getFirstTypeRecurse(t)
        if item then return item end
    end
end
local find = AR.findTool

-- consumption runs in complete() (server in MP) through the synced mutators vanilla uses
local function consumeUses(item, uses)
    if item == nil or uses <= 0 or not item:IsDrainable() then return end
    for _ = 1, uses do
        if item:getContainer() == nil or item:getCurrentUses() <= 0 then return end
        item:UseAndSync()
    end
end

-- UseAndSync is the only synced drainable mutator, so a fractional cost rounds up
local function consumeFraction(item, fraction)
    if item == nil or fraction <= 0 or not item:IsDrainable() then return end
    local step = item:getUseDelta()
    if step == nil or step <= 0 then step = 0.1 end
    consumeUses(item, math.max(1, math.ceil(fraction / step - 1e-6)))
end

local function consumeAny(item, uses)
    if item == nil then return end
    if item:IsDrainable() then return consumeUses(item, uses) end
    local c = item:getContainer()
    if c then
        c:Remove(item)
        sendRemoveItemFromContainer(c, item)
    end
end

-- ---------------------------------------------------------------------------------------
-- Class rules
-- ---------------------------------------------------------------------------------------

local function rodCost(part, item)
    return clamp(math.ceil(cost("rodBase") + AR.getMissing(part, item) * cost("rodPerDamage")), 1)
end

local function metalBlock(character, part, item)
    local torch = find(character, "torch")
    if not torch then return getText("IGUI_SCKCO_MetalNeedTorch") end
    if torch:getCurrentUsesFloat() < cost("torchFraction") then return getText("IGUI_SCKCO_MetalTorchEmpty") end
    local rods = find(character, "rods")
    if not rods then return getText("IGUI_SCKCO_MetalNeedRods") end
    if rods:getCurrentUses() < rodCost(part, item) then return getText("IGUI_SCKCO_MetalNeedMoreRods") end
    if sv("MetalRequireMask") and not find(character, "mask") then return getText("IGUI_SCKCO_MetalNeedMask") end
end

local function metalConsume(character, part, item)
    consumeFraction(find(character, "torch"), cost("torchFraction"))
    consumeUses(find(character, "rods"), rodCost(part, item))
end

-- cutting a destroyed plate or panel off still needs a torch
local function metalScrapBlock(character)
    if not find(character, "torch") then return getText("IGUI_SCKCO_MetalNeedTorch") end
end

-- tape is the fallback when the full stitch kit is absent; it carries a fail penalty
local function hasStitchKit(character)
    return find(character, "needle") and find(character, "thread") and find(character, "strips") and true or false
end

local function hasTape(character)
    return sv("SeatAllowTape") and find(character, "tape") ~= nil
end

-- name rules apply to loose items; armor also matches its exact scrap list
local function nameHas(...)
    local words = { ... }
    return function(name)
        for _, w in ipairs(words) do
            if string.find(name, w, 1, true) then return true end
        end
        return false
    end
end

-- Adding a class means adding a profile here and its name to matchOrder (and classOrder
-- for the menu). Text keys are <prefix><suffix>, e.g. IGUI_SCKCO_TireTooWorn.
--   skill: fixed perk, otherwise RepairSkillMode picks Mechanics/MetalWelding
--   botchParent: a failed weld damages the part the plate protects, not the plate
--   replaceVanilla: hide vanilla's Repair on the parts this class claims
AR.profiles = {
    armor = {
        prefix = "IGUI_SCKCO_Armor", enable = "ArmorRepairEnabled",
        verb = "IGUI_SCKCO_RepairVerb", header = "IGUI_SCKCO_RepairArmor",
        sound = "BlowTorch", botchParent = true,
        buildCost = { { "Base.SheetMetal", 2 }, { "Base.ScrapMetal", 2 } },
        matchPart = function(part)
            return part:getCategory() == "SCUCKarmor" or string.sub(part:getId(), 1, 7) == "SCArmor"
        end,
        matchItem = function(name, item) return AR.buildCost[item:getFullType()] ~= nil or string.find(name, "Armor", 1, true) ~= nil end,
        block = metalBlock, consume = metalConsume, scrapBlock = metalScrapBlock,
    },
    body = {
        prefix = "IGUI_SCKCO_Body", enable = "BodyRepairEnabled",
        verb = "IGUI_SCKCO_WeldVerb", header = "IGUI_SCKCO_RepairBody",
        sound = "BlowTorch", replaceVanilla = true,
        buildCost = { { "Base.SheetMetal", 1 }, { "Base.ScrapMetal", 2 } },
        -- vanilla's bodywork column is chosen by category (ISVehicleMechanics); lights excluded
        matchPart = function(part)
            local c = part:getCategory()
            return c == "door" or c == "bodywork"
        end,
        matchItem = nameHas("Door", "Hood", "TrunkLid"),
        block = metalBlock, consume = metalConsume, scrapBlock = metalScrapBlock,
    },
    tire = {
        prefix = "IGUI_SCKCO_Tire", enable = "TireRepairEnabled", skill = "Mechanics",
        verb = "IGUI_SCKCO_PatchVerb", header = "IGUI_SCKCO_RepairTire",
        sound = "RepairWithGlue",
        matchPart = function(part) return string.sub(part:getId(), 1, 4) == "Tire" end,
        matchItem = function(name, item)
            local tag = AR.getTagValue("WHOLE_TIRE")
            return (tag and item:hasTag(tag)) or string.find(name, "Tire", 1, true) ~= nil
        end,
        -- a flat tire is pumped first
        block = function(character, part)
            if AR.isFlat(part) then return getText("IGUI_SCKCO_TireFlat") end
            local kit = find(character, "patch")
            if not kit then return getText("IGUI_SCKCO_TireNeedPatch") end
            if kit:getCurrentUses() < cost("tirePatch") then return getText("IGUI_SCKCO_TireKitEmpty") end
        end,
        consume = function(character) consumeUses(find(character, "patch"), cost("tirePatch")) end,
    },
    seat = {
        prefix = "IGUI_SCKCO_Seat", enable = "SeatRepairEnabled", skill = "Tailoring",
        verb = "IGUI_SCKCO_StitchVerb", header = "IGUI_SCKCO_RepairSeat",
        matchPart = function(part) return part:getCategory() == "seat" end,
        matchItem = nameHas("Seat"),
        block = function(character)
            if hasStitchKit(character) or hasTape(character) then return nil end
            if not find(character, "needle") then return getText("IGUI_SCKCO_SeatNeedNeedle") end
            if not find(character, "thread") then return getText("IGUI_SCKCO_SeatNeedThread") end
            return getText("IGUI_SCKCO_SeatNeedMaterial")
        end,
        consume = function(character)
            if hasStitchKit(character) then
                consumeUses(find(character, "thread"), cost("seatThread"))
                consumeAny(find(character, "strips"), 1)
            else
                consumeAny(find(character, "tape"), cost("seatTape"))
            end
        end,
        penalty = function(character)
            if hasStitchKit(character) then return 0 end
            return sv("SeatTapeFailPenalty")
        end,
    },
}

-- tire before the metal classes so a tire never gets the welding toolset; armor before body
-- because armor item names also contain "Door"
local matchOrder = { "tire", "seat", "armor", "body" }
-- menu order
AR.classOrder = { "armor", "body", "tire", "seat" }

-- ---------------------------------------------------------------------------------------
-- Classification
-- ---------------------------------------------------------------------------------------

-- loose items are filtered by display category first: name rules alone also hit bags,
-- clothing and weapons. These name-matching non-parts sit in those categories.
AR.looseCategories = { VehicleMaintenance = true, VehicleArmor = true }
AR.looseExclude = {
    ["SCKCO.TirePatchKit"] = true,
    ["Base.TirePump"] = true,
    ["Base.HoodOrnament_Badger"] = true,
    ["Base.HoodOrnament_Beaver"] = true,
    ["Base.HoodOrnament_Spiffo"] = true,
}

function AR.getItemClass(item)
    if item == nil or instanceof(item, "InventoryContainer") then return nil end
    if not AR.looseCategories[item:getDisplayCategory()] or AR.looseExclude[item:getFullType()] then return nil end
    local name = item:getType()
    for _, cls in ipairs(matchOrder) do
        if AR.profiles[cls].matchItem(name, item) then return cls end
    end
end

-- An uninstalled part as a table with just enough of the VehiclePart surface for the
-- shared maths. getVehicle() nil is what skips vehicle transmits and parent botches.
function AR.itemAsPart(item)
    local cls = AR.getItemClass(item)
    if cls == nil then return nil end
    return {
        looseClass = cls,
        looseItem = item,
        getCondition = function(self) return self.looseItem:getCondition() end,
        setCondition = function(self, v) self.looseItem:setCondition(v) end,
        getInventoryItem = function(self) return self.looseItem end,
        getId = function(self) return self.looseItem:getType() end,
        getCategory = function() return nil end,
        getVehicle = function() return nil end,
        getScriptPart = function() return nil end,
    }
end

-- the shim is a Lua table, a real VehiclePart is userdata
function AR.isLoose(part)
    return type(part) == "table" and part.looseClass ~= nil
end

local function classEnabled(cls)
    return sv("RepairEnabled") and sv(AR.profiles[cls].enable) == true
end

function AR.getPartClass(part)
    if part == nil then return nil end
    local cls = part.looseClass
    if not AR.isLoose(part) then
        cls = nil
        for _, c in ipairs(matchOrder) do
            if AR.profiles[c].matchPart(part) then cls = c break end
        end
    end
    if cls and classEnabled(cls) then return cls end
end

function AR.getProfile(part)
    local cls = AR.getPartClass(part)
    return cls and AR.profiles[cls]
end

-- script names read "Base.SC_X"; only the part after the module is compared
function AR.isSupportedVehicle(vehicle)
    if not sv("RestrictToSCVehicles") then return true end
    local name = vehicle and vehicle:getScriptName()
    if name == nil then return false end
    return string.sub(string.match(name, "%.(.+)$") or name, 1, 3) == "SC_"
end

-- claimed parts carry an inventory item: ceiling and decay live on it
function AR.isClaimed(part)
    if part == nil or part:getInventoryItem() == nil then return false end
    if not AR.isLoose(part) and not AR.isSupportedVehicle(part:getVehicle()) then return false end
    return AR.getPartClass(part) ~= nil
end

-- ---------------------------------------------------------------------------------------
-- Text and feedback
-- ---------------------------------------------------------------------------------------

function AR.textKey(part, suffix)
    local profile = AR.getProfile(part)
    return (profile and profile.prefix or "IGUI_SCKCO_Armor") .. suffix
end

function AR.text(part, suffix, ...)
    return getText(AR.textKey(part, suffix), ...)
end

-- complete() runs on the server in MP, where a halo would draw for nobody; the key goes to
-- the player's client and is translated there (SC_PartRepair_Menu.lua)
AR.netModule = "SCKCO_PartRepair"

function AR.notify(character, key, r, g, b)
    if isServer() then
        sendServerCommand(character, AR.netModule, "halo", { key = key, r = r, g = g, b = b })
    else
        character:setHaloNote(getText(key), r, g, b, 300)
    end
end

-- ---------------------------------------------------------------------------------------
-- Repair maths
-- ---------------------------------------------------------------------------------------

function AR.getSkill(character, part)
    local profile = part and AR.getProfile(part)
    if profile and profile.skill then return character:getPerkLevel(Perks[profile.skill]) end
    local mode = sv("RepairSkillMode")
    local mech = character:getPerkLevel(Perks.Mechanics)
    local weld = character:getPerkLevel(Perks.MetalWelding)
    if mode == SKILL_MECHANICS then return mech end
    if mode == SKILL_WELDING then return weld end
    return math.max(mech, weld)
end

-- the repair count is mod-owned ModData: vanilla's repair counters are non-zero on parts
-- this mod never touched. ModData rides along with transmitPartItem / syncItemFields.
AR.repairKey = "SCKCO_Repairs"

function AR.getRepairs(item)
    local n = item:getModData()[AR.repairKey]
    return type(n) == "number" and n or 0
end

function AR.addRepair(item)
    item:getModData()[AR.repairKey] = AR.getRepairs(item) + 1
end

function AR.getConditionCeiling(item)
    return clamp(100 - AR.getRepairs(item) * sv("RepairDegradePerPass"), sv("RepairScrapCeiling"))
end

function AR.isScrap(item)
    return AR.getConditionCeiling(item) <= sv("RepairScrapCeiling")
end

-- total loss is raw damage; scrap is accumulated repair wear
function AR.isTotalLoss(part)
    return part:getCondition() <= sv("RepairTotalLossThreshold")
end

function AR.isFlat(part)
    if AR.isLoose(part) then return false end
    local psi, max = part:getContainerContentAmount(), part:getContainerCapacity()
    if psi == nil or max == nil or max <= 0 then return false end
    return psi / max <= sv("TireFlatThreshold")
end

function AR.getMissing(part, item)
    return clamp(AR.getConditionCeiling(item) - part:getCondition(), 0)
end

function AR.getPassAmount(character, part, item)
    local fraction = clamp(sv("RepairCloseFraction") + AR.getSkill(character, part) * sv("RepairCloseFractionPerSkill"), 0, 1)
    return AR.getMissing(part, item) * fraction
end

function AR.getPassTime(character, part, item)
    return clamp(sv("RepairBaseTime")
        + AR.getMissing(part, item) * sv("RepairTimePerDamage")
        - AR.getSkill(character, part) * sv("RepairTimePerSkillLevel"), AR.MIN_PASS_TIME)
end

function AR.getFailChance(character, part, item)
    local profile = AR.getProfile(part)
    local penalty = profile and profile.penalty and profile.penalty(character, part) or 0
    return clamp(sv("RepairFailBase")
        + AR.getMissing(part, item) * sv("RepairFailPerDamage")
        - AR.getSkill(character, part) * sv("RepairFailPerSkill")
        + penalty, 0, sv("RepairFailMax"))
end

-- the part an armor plate protects is its script parent; nil skips the botch damage
function AR.getProtectedPart(vehicle, part)
    local script = part:getScriptPart()
    if not script or not vehicle then return nil end
    if script.getParentName then return vehicle:getPartById(script:getParentName()) end
    if script.getParent then
        local p = script:getParent()
        if type(p) == "string" then return vehicle:getPartById(p) end
        if p and p.getId then return vehicle:getPartById(p:getId()) end
    end
end

-- nil when repairable, else the reason
function AR.getBlockReason(character, part)
    local item = part:getInventoryItem()
    if not item then return AR.text(part, "NothingInstalled") end
    local minSkill = sv("RepairMinSkill")
    if AR.getSkill(character, part) < minSkill then return getText("IGUI_SCKCO_SkillTooLow", tostring(minSkill)) end
    if AR.isTotalLoss(part) then return getText("IGUI_SCKCO_TotalLoss") end
    if AR.isScrap(item) then return AR.text(part, "Scrap") end
    -- compare the gap, not 100: condition can read 99.x while the label rounds up
    if AR.getMissing(part, item) < sv("RepairMinGap") then
        local ceiling = AR.getConditionCeiling(item)
        if ceiling >= 100 then return getText("IGUI_SCKCO_AlreadyFull") end
        return AR.text(part, "TooWorn", tostring(math.floor(ceiling)))
    end
    local profile = AR.getProfile(part)
    if profile and profile.block then return profile.block(character, part, item) end
end

-- One pass: fail roll (with an optional botch), else close part of the gap under the
-- ceiling and count the repair. sync(part) publishes a changed part. Returns success.
function AR.applyPass(character, part, item, sync, canBotch)
    local profile = AR.getProfile(part)
    if ZombRand(100) < AR.getFailChance(character, part, item) then
        local victim
        if canBotch and ZombRand(100) < sv("RepairBotchChance") then
            if profile and profile.botchParent then
                victim = AR.getProtectedPart(part:getVehicle(), part)
            else
                victim = part
            end
        end
        if victim then
            victim:setCondition(clamp(victim:getCondition() - sv("RepairBotchDamage"), 0))
            sync(victim)
            AR.notify(character, AR.textKey(part, "Botched"), 255, 60, 60)
        else
            AR.notify(character, AR.textKey(part, "Failed"), 255, 160, 60)
        end
        return false
    end
    part:setCondition(math.min(part:getCondition() + AR.getPassAmount(character, part, item),
        AR.getConditionCeiling(item)))
    AR.addRepair(item)
    sync(part)
    return true
end

-- fixed-skill classes train that skill; metal classes follow RepairSkillMode. fixedOnly is
-- for the bench recipe, which already awards its own MetalWelding xp.
function AR.awardXp(character, part, xp, fixedOnly)
    local profile = AR.getProfile(part)
    if profile and profile.skill then return addXp(character, Perks[profile.skill], xp) end
    if fixedOnly then return end
    local mode = sv("RepairSkillMode")
    if mode ~= SKILL_WELDING then addXp(character, Perks.Mechanics, xp) end
    if mode ~= SKILL_MECHANICS then addXp(character, Perks.MetalWelding, xp) end
end

-- ---------------------------------------------------------------------------------------
-- Scrap
-- ---------------------------------------------------------------------------------------

-- per-item yields come from SC_PartRepair_BuildCosts.lua (generated from the disassembly
-- recipes); anything not listed falls back to its class default
AR.buildCost = AR.buildCost or {}

function AR.getBuildCost(part)
    local item = part:getInventoryItem()
    local declared = item and AR.buildCost[item:getFullType()]
    if declared then return declared end
    local profile = AR.getProfile(part)
    return profile and profile.buildCost
end

function AR.getScrapLossChance(character)
    return clamp(sv("ScrapLossBase") - AR.getSkill(character) * sv("ScrapLossPerSkill"), 0, 100)
end

-- each unit rolls separately so the yield spreads; skill reduces the waste
function AR.rollScrapYield(character, part)
    local out, loss, scale = {}, AR.getScrapLossChance(character), sv("ScrapYieldScale")
    for _, entry in ipairs(AR.getBuildCost(part) or {}) do
        local kept = 0
        for _ = 1, math.floor(entry[2] * scale + 0.5) do
            if ZombRand(100) >= loss then kept = kept + 1 end
        end
        if kept > 0 then out[#out + 1] = { entry[1], kept } end
    end
    return out
end

-- scrap unlocks exactly when a part is too destroyed to repair. tires and seats have no
-- yield; uninstalling them through vanilla already covers ripping them out.
function AR.getScrapBlockReason(character, part)
    if not sv("ScrapEnabled") then return getText("IGUI_SCKCO_ScrapDisabled") end
    if not AR.isClaimed(part) then return getText("IGUI_SCKCO_ScrapNothing") end
    if not AR.isTotalLoss(part) then return getText("IGUI_SCKCO_ScrapNotDestroyed") end
    if AR.getBuildCost(part) == nil then return getText("IGUI_SCKCO_ScrapNotSupported") end
    local profile = AR.getProfile(part)
    if profile.scrapBlock then return profile.scrapBlock(character, part) end
end

-- ---------------------------------------------------------------------------------------
-- Timed actions
-- ---------------------------------------------------------------------------------------
-- B42 MP: the client runs start/update/perform for animation and sound; the server rebuilds
-- the action from new()'s arguments and runs complete(), where every state change happens.
-- new() arguments are engine objects only (VehiclePart / InventoryItem) for that reason.

ISSCKCOPartAction = ISBaseTimedAction:derive("ISSCKCOPartAction")

local function newAction(class, character, fields)
    local o = ISBaseTimedAction.new(class, character)
    for k, v in pairs(fields) do o[k] = v end
    o.stopOnWalk, o.stopOnRun = true, true
    o.maxTime = o:getDuration()
    return o
end

function ISSCKCOPartAction:getDuration()
    if self.character:isTimedActionInstant() then return 1 end
    return self:passTime()
end

function ISSCKCOPartAction:waitToStart()
    if self.vehicle == nil then return false end
    self.character:faceThisObject(self.vehicle)
    return self.character:shouldBeTurning()
end

function ISSCKCOPartAction:start()
    local profile = self.part and AR.getProfile(self.part)
    self:setActionAnim(profile and profile.anim or DEFAULT_ANIM)
    self.character:setMetabolicTarget(Metabolics.HeavyWork)
    if profile and profile.sound then self.sound = self.character:playSound(profile.sound) end
end

function ISSCKCOPartAction:update()
    self.character:setMetabolicTarget(Metabolics.HeavyWork)
end

function ISSCKCOPartAction:stopSound()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
end

function ISSCKCOPartAction:stop()
    self:stopSound()
    ISBaseTimedAction.stop(self)
end

-- repair repeats until the gap closes or materials run out. In MP the client may still see
-- the pre-pass condition; the queued pass re-checks isValid on the server.
function ISSCKCOPartAction:perform()
    self:stopSound()
    ISBaseTimedAction.perform(self)
    local nextPass = self.again and self:again()
    if nextPass then ISTimedActionQueue.add(nextPass) end
end

-- installed part ------------------------------------------------------------------------

ISSCKCORepairPart = ISSCKCOPartAction:derive("ISSCKCORepairPart")

function ISSCKCORepairPart:new(character, part)
    return newAction(self, character, { part = part, vehicle = part:getVehicle() })
end

function ISSCKCORepairPart:passTime()
    local item = self.part and self.part:getInventoryItem()
    return item and AR.getPassTime(self.character, self.part, item) or sv("RepairBaseTime")
end

function ISSCKCORepairPart:isValid()
    return AR.getPartClass(self.part) ~= nil and AR.getBlockReason(self.character, self.part) == nil
end

function ISSCKCORepairPart:again()
    if AR.getBlockReason(self.character, self.part) == nil then
        return ISSCKCORepairPart:new(self.character, self.part)
    end
end

function ISSCKCORepairPart:sync(part)
    self.vehicle:transmitPartCondition(part)
    self.vehicle:transmitPartItem(part)
end

-- materials burn whether the pass succeeds or fails
function ISSCKCORepairPart:complete()
    local item = self.part:getInventoryItem()
    if item == nil then return false end
    local missing = AR.getMissing(self.part, item)
    local profile = AR.getProfile(self.part)
    if profile and profile.consume then profile.consume(self.character, self.part, item) end
    if AR.applyPass(self.character, self.part, item, function(p) self:sync(p) end, true) then
        AR.awardXp(self.character, self.part, sv("RepairXP") + missing * sv("RepairXPPerDamage"))
    end
    return true
end

-- uninstalled part: takes the carried InventoryItem so the server can resolve it; the
-- ground menu queues a pickup first
ISSCKCORepairLoose = ISSCKCORepairPart:derive("ISSCKCORepairLoose")

function ISSCKCORepairLoose:new(character, item)
    return newAction(self, character, { item = item, part = AR.itemAsPart(item) })
end

function ISSCKCORepairLoose:isValid()
    return sv("RepairLooseParts") and self.part ~= nil
        and self.character:getInventory():contains(self.item)
        and ISSCKCORepairPart.isValid(self)
end

function ISSCKCORepairLoose:again()
    if AR.getBlockReason(self.character, self.part) == nil then
        return ISSCKCORepairLoose:new(self.character, self.item)
    end
end

function ISSCKCORepairLoose:sync()
    syncItemFields(self.character, self.item)
end

-- scrap ---------------------------------------------------------------------------------

ISSCKCOScrapPart = ISSCKCOPartAction:derive("ISSCKCOScrapPart")

function ISSCKCOScrapPart:new(character, part)
    return newAction(self, character, { part = part, vehicle = part:getVehicle() })
end

function ISSCKCOScrapPart:passTime()
    return AR.SCRAP_TIME
end

function ISSCKCOScrapPart:isValid()
    return AR.getScrapBlockReason(self.character, self.part) == nil
end

-- clearing the slot is the destructive step; transmitPartItem carries it to other clients
function ISSCKCOScrapPart:complete()
    if self.part:getInventoryItem() == nil then return false end
    local inv, recovered = self.character:getInventory(), 0
    for _, yield in ipairs(AR.rollScrapYield(self.character, self.part)) do
        for _ = 1, yield[2] do
            local added = inv:AddItem(yield[1])
            if added then
                sendAddItemToContainer(inv, added)
                recovered = recovered + 1
            end
        end
    end
    if recovered == 0 then AR.notify(self.character, "IGUI_SCKCO_ScrapNothingUsable", 255, 160, 60) end
    self.part:setInventoryItem(nil)
    self.vehicle:transmitPartItem(self.part)
    return true
end

function AR.onRepairPart(character, part) ISTimedActionQueue.add(ISSCKCORepairPart:new(character, part)) end
function AR.onRepairLoose(character, item) ISTimedActionQueue.add(ISSCKCORepairLoose:new(character, item)) end
function AR.onScrapPart(character, part) ISTimedActionQueue.add(ISSCKCOScrapPart:new(character, part)) end
