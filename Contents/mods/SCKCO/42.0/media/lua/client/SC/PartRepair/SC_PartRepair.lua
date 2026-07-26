require "TimedActions/ISBaseTimedAction"

SCKCO = SCKCO or {}
SCKCO.PartRepair = SCKCO.PartRepair or {}
local AR = SCKCO.PartRepair

AR.category = "SCUCKarmor"
AR.namePrefix = "SCArmor"
-- ItemTag constants confirmed present in B42 42.19.0 (zombie.scripting.objects.ItemTag).
-- A constant existing does NOT mean any item carries it: base:blowtorch is registered but
-- has zero items, so the torch tag lookup always misses and the type list does the work.
-- (Using that empty tag as a craftRecipe input is a hard script load error, which is why
-- SCKCO_recipes_parts.txt references tools by explicit type.) base:weldingmask does carry
-- items. Keeping both tags costs one failed lookup and starts working if TIS tags the item.
AR.torchTag = "BLOW_TORCH"
AR.maskTag = "WELDING_MASK"
AR.torchTypes = { "Base.BlowTorch", "Base.WeldingTorch" }
AR.rodTypes = { "Base.WeldingRods" }
AR.maskTypes = { "Base.WeldingMask", "Base.Glasses_OldWeldingGoggles", "Base.WeldingGoggles" }

-- vanilla routes parts to its bodywork column by category (ISVehicleMechanics:81).
-- claiming categories rather than part ids covers future vehicles automatically; lights
-- carry category "lights" so they are excluded for free.
AR.bodyCategories = { door = true, bodywork = true }
AR.bodyExclude = {}

-- tires: identified by the vanilla TireXxx id convention. getWheelIndex() (confirmed on
-- VehiclePart) maps a tire part to its wheel slot for inflation calls.
AR.tirePrefix = "Tire"
-- seats come from vanilla templates, so identify by runtime category like body panels
AR.seatCategories = { seat = true }
-- needle and thread are matched by confirmed ItemTag constants; strips are vanilla types
AR.needleTag = "SEWING_NEEDLE"
AR.needleTypes = { "Base.Needle", "Base.SutureNeedle" }
AR.threadTag = "THREAD"
AR.threadTypes = { "Base.Thread" }
AR.stripTypes = { "Base.LeatherStrips", "Base.DenimStrips", "Base.RippedSheets" }
-- duct tape is a bodge path: no needle or thread, but a failure penalty
AR.tapeTag = "REPAIR_WITH_TAPE"
AR.tapeTypes = { "Base.DuctTape" }
-- primary path: a purpose-made patch kit. crude path: rubber cement plus a rubber source
-- cut as a boot, which works but carries a failure penalty.
AR.patchTypes = { "SCKCO.TirePatchKit" }

AR.SKILL_MECHANICS, AR.SKILL_WELDING, AR.SKILL_HIGHEST = 1, 2, 3

-- Per-class presentation and rules. Adding a class means adding a row here plus an
-- identification rule in getPartClass; nothing else in the file changes.
--   skill : nil = follow RepairSkillMode, otherwise a fixed Perk
--   block : extra block-reason function, assigned after definition (load order)
--   sound : nil plays nothing. IDs must exist in a loaded bank or they silently no-op.
--   anim  : must be a real node in player/actions. "VehicleWorkOnMid" is the only vehicle
--           work anim present in vanilla; an unknown id spams AdvancedAnimator warnings.
AR.profiles = {
    armor = {
        prefix = "IGUI_SCKCO_Armor", botchParent = true,
        enable = "ArmorRepairEnabled",
        buildCost = { { "Base.SheetMetal", 2 }, { "Base.ScrapMetal", 2 } },
        verb = "IGUI_SCKCO_RepairVerb", header = "IGUI_SCKCO_RepairArmor",
        sound = "BlowTorch", anim = "VehicleWorkOnMid",
    },
    body = {
        prefix = "IGUI_SCKCO_Body",
        enable = "BodyRepairEnabled", replaceVanilla = true,
        buildCost = { { "Base.SheetMetal", 1 }, { "Base.ScrapMetal", 2 } },
        verb = "IGUI_SCKCO_WeldVerb", header = "IGUI_SCKCO_RepairBody",
        sound = "BlowTorch", anim = "VehicleWorkOnMid",
    },
    tire = {
        prefix = "IGUI_SCKCO_Tire",
        enable = "TireRepairEnabled",
        verb = "IGUI_SCKCO_PatchVerb", header = "IGUI_SCKCO_RepairTire",
        sound = "RepairWithGlue", anim = "VehicleWorkOnMid",
        skill = "Mechanics",
    },
    seat = {
        prefix = "IGUI_SCKCO_Seat",
        enable = "SeatRepairEnabled",
        verb = "IGUI_SCKCO_StitchVerb", header = "IGUI_SCKCO_RepairSeat",
        sound = nil, anim = "VehicleWorkOnMid",
        skill = "Tailoring",
    },
}

-- class-scoped string: <prefix><suffix>, e.g. IGUI_SCKCO_TireTooWorn. Adding a class means
-- adding its prefix here and the matching keys in the generator, nothing else.
function AR.text(part, suffix, ...)
    local profile = AR.getProfile(part)
    return getText((profile and profile.prefix or "IGUI_SCKCO_Armor") .. suffix, ...)
end

-- menu and iteration order; also the authoritative list of classes
AR.classOrder = { "armor", "body", "tire", "seat" }



function AR.getProfile(part)
    local cls = AR.getPartClass(part)
    if cls == nil then return nil end
    return AR.profiles[cls]
end

-- single source of truth; sandbox-options.txt and translation keys are generated from
-- this table by gen_sandbox.py. gen_sandbox.py --check gates drift.
local defaults = {
    RepairEnabled = true,
    RestrictToSCVehicles = true,
    RepairMaterialScale = 1.0,
    ScrapEnabled = true,
    ScrapYieldScale = 1.0,
    ScrapUseRecipes = true,
    ScrapLossBase = 40,
    ScrapLossPerSkill = 3,
    RepairSkillMode = 3,
    RepairMinSkill = 0,
    ArmorRepairEnabled = true,
    BodyRepairEnabled = true,
    ReplaceVanillaRepair = true,

    -- tires: Mechanics-gated, patch kit or crude cement-and-boot
    RepairHideUnusable = true,
    SeatRepairEnabled = true,
    SeatAllowTape = true,
    SeatTapeFailPenalty = 25,
    TireRepairEnabled = true,
    TireFlatThreshold = 0.1,

    -- pass closes (base + skill*perSkill) of the missing condition, clamped to 1.0
    RepairCloseFraction = 0.25,
    RepairCloseFractionPerSkill = 0.05,

    -- ceiling decays per successful pass until the part is scrap
    RepairDegradePerPass = 3,
    RepairScrapCeiling = 25,
    RepairTotalLossThreshold = 0,
    RepairMinGap = 1,

    -- rods are WHOLE USES (a box holds ~30); torch is a fraction of one torch
    MetalRequireMask = true,

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
}

-- read at call time: MP clients receive sandbox vars after Lua parses, so caching at
-- load would pin the defaults permanently
local function sv(key)
    local vars = SandboxVars.SCKCO
    if vars and vars[key] ~= nil then return vars[key] end
    return defaults[key]
end
AR.getOption = sv

-- Vehicle scoping. Script names read as "Base.SC_ChevroletCaprice85", so the prefix after
-- the module is the discriminator. BaseVehicle:getScriptName() is public API.
-- Matching is on the name after the module prefix, so a script declared in any module
-- still matches. An unreadable name is treated as unsupported: better to do nothing on a
-- vehicle we cannot identify than to claim parts on someone else's.
AR.vehiclePrefixes = { "SC_" }

-- getScriptName is confirmed public API. Do NOT probe for it with vehicle.getScriptName:
-- indexing Java userdata with a field name throws rather than returning nil.
function AR.getVehicleScriptName(vehicle)
    if vehicle == nil then return nil end
    return vehicle:getScriptName()
end

function AR.isSupportedVehicle(vehicle)
    if not sv("RestrictToSCVehicles") then return true end
    local name = AR.getVehicleScriptName(vehicle)
    if name == nil then return false end
    local short = string.match(name, "%.(.+)$") or name
    for _, prefix in ipairs(AR.vehiclePrefixes) do
        if string.sub(short, 1, #prefix) == prefix then return true end
    end
    return false
end

-- Per-pass material costs. These were six separate sandbox options that nobody tunes
-- individually; RepairMaterialScale multiplies all of them instead.
--   torchFraction : fraction of one torch per pass
--   rod*/patch/thread/tape : whole uses per pass
AR.cost = {
    torchFraction = 0.08,
    rodBase = 1,
    rodPerDamage = 0.05,
    tirePatch = 1,
    seatThread = 2,
    seatTape = 2,
}

local function cost(key)
    return AR.cost[key] * sv("RepairMaterialScale")
end

-- fixed floors: too fine-grained to be worth a server option
AR.MIN_PASS_TIME = 40
AR.SCRAP_TIME = 300

local function clamp(v, lo, hi)
    if v < lo then return lo end
    if hi and v > hi then return hi end
    return v
end

local function round(v) return math.floor(v + 0.5) end

local function findType(character, types)
    local inv = character:getInventory()
    for i = 1, #types do
        local item = inv:getFirstTypeRecurse(types[i])
        if item then return item end
    end
end

-- ItemTag (zombie.scripting.objects.ItemTag) is a class of static constants, not an enum.
-- hasTag(ItemTag) and getFirstTagRecurse(ItemTag) both require that instance and throw on
-- a raw tag string. ItemTag.register(id) resolves an arbitrary tag id for anything without
-- a named constant. The type(ItemTag)=="table" guard avoids indexing exposed userdata.
local tagCache = {}
local function tagValue(constName, id)
    local hit = tagCache[constName]
    if hit ~= nil then
        if hit == false then return nil end
        return hit
    end
    local found = nil
    if type(ItemTag) == "table" then
        found = ItemTag[constName]
        if found == nil and id and ItemTag.register then found = ItemTag.register(id) end
    end
    if found == nil then tagCache[constName] = false else tagCache[constName] = found end
    return found
end
AR.getTagValue = tagValue

-- vanilla recursive lookup by tag (ISInventoryPaneContextMenu:1490)
local function findTag(character, constName, id)
    local tag = tagValue(constName, id)
    if tag == nil then return nil end
    return character:getInventory():getFirstTagRecurse(tag)
end

-- tag first, type list as fallback if the tag does not resolve on this build
local function findTool(character, constName, types)
    return findTag(character, constName) or findType(character, types)
end

-- getUsedDelta reads back nil on a full DrainableComboItem; getCurrentUsesFloat is the
-- reader vanilla's UI trusts (ISVehicleMechanics:869) and is always populated.
-- setUsedDelta takes the REMAINING fraction (0 == empty, per ISInv:873).
local function consumeFraction(item, delta)
    if item == nil or delta <= 0 or not item:IsDrainable() then return end
    local remaining = item:getCurrentUsesFloat() - delta
    if remaining > 0 then
        item:setUsedDelta(remaining)
    else
        local c = item:getContainer()
        if c then c:Remove(item) end
    end
end

-- multi-use drainables count whole uses (getCurrentUses, ISInv:3110) while getUseDelta
-- is the fraction one use represents (ISInv:4010). Converting here avoids calling an
-- unconfirmed integer setter.
local function consumeUses(item, uses)
    if item == nil or uses <= 0 or not item:IsDrainable() then return end
    local step = item:getUseDelta()
    if step == nil or step <= 0 then step = 0.1 end
    consumeFraction(item, uses * step)
end

-- drainables spend uses; a plain item is consumed whole. lets one call site handle both
-- without caring which the material happens to be.
local function consumeAny(item, uses)
    if item == nil then return end
    if item:IsDrainable() then
        consumeUses(item, uses)
    else
        local c = item:getContainer()
        if c then c:Remove(item) end
    end
end

function AR.isArmorPart(part)
    if not part then return false end
    if part:getCategory() == AR.category then return true end
    return string.sub(part:getId(), 1, #AR.namePrefix) == AR.namePrefix
end

function AR.isBodyPart(part)
    if not part then return false end
    if AR.bodyExclude[part:getId()] then return false end
    return AR.bodyCategories[part:getCategory()] == true
end

-- identification predicates are pure: they answer "is this that kind of part", not
-- "is that kind of part switched on". Enablement is applied once, in getPartClass.
function AR.isSeatPart(part)
    if not part then return false end
    return AR.seatCategories[part:getCategory()] == true
end

function AR.isTirePart(part)
    if not part then return false end
    return string.sub(part:getId(), 1, #AR.tirePrefix) == AR.tirePrefix
end

-- every class carries its own enable option; RepairEnabled is the master above them
function AR.isClassEnabled(cls)
    if not sv("RepairEnabled") then return false end
    local profile = AR.profiles[cls]
    if profile == nil or profile.enable == nil then return true end
    return sv(profile.enable) == true
end

-- tire checked first: a tire must never fall through to the metal toolset
local function rawPartClass(part)
    if AR.isTirePart(part) then return "tire" end
    if AR.isSeatPart(part) then return "seat" end
    if AR.isArmorPart(part) then return "armor" end
    if AR.isBodyPart(part) then return "body" end
end

-- Classify an uninstalled part sitting in inventory. Installed parts are classified by
-- category/id; a loose item has neither, so this keys off the item type instead.
-- buildCost is the exact armor list, which also covers bumpers (armor despite the name).
function AR.getItemClass(item)
    if item == nil then return nil end
    local full = item:getFullType()
    if AR.buildCost[full] then return "armor" end
    local name = item:getType()
    if string.find(name, "Armor") then return "armor" end
    local tireTag = AR.getTagValue("WHOLE_TIRE")
    if tireTag and item:hasTag(tireTag) then return "tire" end
    if string.find(name, "Tire") then return "tire" end
    if string.find(name, "Seat") then return "seat" end
    if string.find(name, "Door") or string.find(name, "Hood") or string.find(name, "TrunkLid") then
        return "body"
    end
    return nil
end

-- A loose item wearing just enough of the VehiclePart surface for the repair math, so
-- quality, cost, time and failure are computed identically to an installed part.
-- getVehicle() returning nil is what makes perform() skip the MP transmit calls, and what
-- makes an armor botch damage the plate itself rather than a parent it no longer has.
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
        getCategory = function(self) return nil end,
        getVehicle = function(self) return nil end,
        getScriptPart = function(self) return nil end,
    }
end

function AR.isLoose(part)
    return type(part) == "table" and part.looseClass ~= nil
end

function AR.getPartClass(part)
    if AR.isLoose(part) then
        if AR.isClassEnabled(part.looseClass) then return part.looseClass end
        return nil
    end
    local cls = rawPartClass(part)
    if cls and AR.isClassEnabled(cls) then return cls end
end

-- B42 models tire pressure as container contents, not a separate inflation field:
-- getContainerContentAmount() is current PSI and getContainerCapacity() is max. This is
-- what vanilla's own inflate/deflate uses (ISVehiclePartMenu:298) and what the mechanics
-- panel prints as "Tire Pressure: 35 / 35".
function AR.getTirePressure(part)
    local psi = part:getContainerContentAmount()
    local max = part:getContainerCapacity()
    if psi == nil or max == nil or max <= 0 then return nil end
    return psi / max
end

function AR.isFlat(part)
    local frac = AR.getTirePressure(part)
    if frac == nil then return false end
    return frac <= sv("TireFlatThreshold")
end

-- claimed parts must carry an inventory item: the ceiling/decay state lives on the item
function AR.isClaimed(part)
    if part == nil or part:getInventoryItem() == nil then return false end
    -- a loose part is scoped by its item type, not by a vehicle it is no longer on.
    -- the shim is a Lua table; a real VehiclePart is userdata, so type() separates them
    -- without indexing Java objects for fields they do not have.
    if not AR.isLoose(part) and not AR.isSupportedVehicle(part:getVehicle()) then return false end
    return AR.getPartClass(part) ~= nil
end

-- a class with a fixed skill ignores the metal skill mode entirely
function AR.getSkill(character, part)
    local profile = part and AR.getProfile(part)
    if profile and profile.skill then
        return character:getPerkLevel(Perks[profile.skill])
    end
    local mode = sv("RepairSkillMode")
    local mech = character:getPerkLevel(Perks.Mechanics)
    local weld = character:getPerkLevel(Perks.MetalWelding)
    if mode == AR.SKILL_MECHANICS then return mech end
    if mode == AR.SKILL_WELDING then return weld end
    return math.max(mech, weld)
end

-- Weld count lives in the item's own ModData, not getHaveBeenRepaired/getTimesRepaired:
-- those are vanilla-owned with undocumented semantics and are non-zero on parts this mod
-- has never touched, which produced bogus ceilings. ModData is mod-owned, persists with
-- the item, and rides along with transmitPartItem for MP.
AR.repairKey = "SCKCO_Repairs"

function AR.getRepairs(item)
    local md = item:getModData()
    local n = md and md[AR.repairKey]
    if type(n) ~= "number" then return 0 end
    return n
end

function AR.addRepair(item)
    local md = item:getModData()
    if md then md[AR.repairKey] = AR.getRepairs(item) + 1 end
end

function AR.getConditionCeiling(item)
    local repairs = AR.getRepairs(item)
    return clamp(100 - repairs * sv("RepairDegradePerPass"), sv("RepairScrapCeiling"))
end

function AR.isScrap(item)
    return AR.getConditionCeiling(item) <= sv("RepairScrapCeiling")
end

-- total loss is raw damage; scrap is accumulated repair wear. distinct causes.
function AR.isTotalLoss(part)
    return part:getCondition() <= sv("RepairTotalLossThreshold")
end

function AR.getMissing(part, item)
    return clamp(AR.getConditionCeiling(item) - part:getCondition(), 0)
end

function AR.getCloseFraction(character, part)
    return clamp(sv("RepairCloseFraction")
        + AR.getSkill(character, part) * sv("RepairCloseFractionPerSkill"), 0, 1.0)
end

function AR.getPassAmount(character, part, item)
    return AR.getMissing(part, item) * AR.getCloseFraction(character, part)
end

-- whole rod uses, minimum 1
function AR.getRodCost(part, item)
    return clamp(math.ceil(cost("rodBase")
        + AR.getMissing(part, item) * cost("rodPerDamage")), 1)
end

function AR.getPassTime(character, part, item)
    return clamp(sv("RepairBaseTime")
        + AR.getMissing(part, item) * sv("RepairTimePerDamage")
        - AR.getSkill(character, part) * sv("RepairTimePerSkillLevel"), AR.MIN_PASS_TIME)
end

-- extra fail percent from a class-specific shortcut (e.g. taping a seat rather than
-- stitching it). profile.penalty is optional; absent means zero.
function AR.getPenalty(character, part)
    local profile = AR.getProfile(part)
    if profile and profile.penalty then return profile.penalty(character, part) end
    return 0
end

function AR.getFailChance(character, part, item)
    return clamp(sv("RepairFailBase")
        + AR.getMissing(part, item) * sv("RepairFailPerDamage")
        - AR.getSkill(character, part) * sv("RepairFailPerSkill")
        + AR.getPenalty(character, part), 0, sv("RepairFailMax"))
end

-- the part an armor plate protects is its script parent. the accessor is not exposed on
-- every build, so resolve defensively: nil means a botch simply skips part damage.
function AR.getProtectedPart(vehicle, part)
    local script = part:getScriptPart()
    if not script then return nil end
    if script.getParentName then return vehicle:getPartById(script:getParentName()) end
    if script.getParent then
        local p = script:getParent()
        if type(p) == "string" then return vehicle:getPartById(p) end
        if p and p.getId then return vehicle:getPartById(p:getId()) end
    end
end

-- nil when repairable, else the reason string
function AR.getBlockReason(character, part)
    local item = part:getInventoryItem()
    if not item then return AR.text(part, "NothingInstalled") end

    local minSkill = sv("RepairMinSkill")
    if AR.getSkill(character, part) < minSkill then
        return getText("IGUI_SCKCO_SkillTooLow", tostring(minSkill))
    end
    if AR.isTotalLoss(part) then return getText("IGUI_SCKCO_TotalLoss") end
    if AR.isScrap(item) then return AR.text(part, "Scrap") end

    -- a sub-threshold gap means either already full or worn to its ceiling; float
    -- condition can read 99.x while the label rounds to 100, so compare the gap not 100
    local ceiling = AR.getConditionCeiling(item)
    if AR.getMissing(part, item) < sv("RepairMinGap") then
        if ceiling >= 100 then return getText("IGUI_SCKCO_AlreadyFull") end
        return AR.text(part, "TooWorn", tostring(math.floor(ceiling)))
    end

    local profile = AR.getProfile(part)
    if profile and profile.block then return profile.block(character, part, item) end
end

-- torch, rods and eye protection: shared by armor plates and bare body panels
function AR.getMetalBlockReason(character, part, item)
    local torch = findTool(character, AR.torchTag, AR.torchTypes)
    if not torch then return getText("IGUI_SCKCO_MetalNeedTorch") end
    if torch:getCurrentUsesFloat() < cost("torchFraction") then
        return getText("IGUI_SCKCO_MetalTorchEmpty")
    end
    local rods = findType(character, AR.rodTypes)
    if not rods then return getText("IGUI_SCKCO_MetalNeedRods") end
    if rods:getCurrentUses() < AR.getRodCost(part, item) then
        return getText("IGUI_SCKCO_MetalNeedMoreRods")
    end
    if sv("MetalRequireMask") and not findTool(character, AR.maskTag, AR.maskTypes) then
        return getText("IGUI_SCKCO_MetalNeedMask")
    end
end

-- consumption, one function per class, all with the same signature
function AR.consumeMetal(character, part, item)
    consumeFraction(findTool(character, AR.torchTag, AR.torchTypes), cost("torchFraction"))
    consumeUses(findType(character, AR.rodTypes), AR.getRodCost(part, item))
end

function AR.consumeTire(character, part, item)
    consumeUses(findType(character, AR.patchTypes), cost("tirePatch"))
end

function AR.consumeSeat(character, part, item)
    if AR.hasStitchKit(character) then
        consumeUses(findTool(character, AR.threadTag, AR.threadTypes), cost("seatThread"))
        consumeAny(findType(character, AR.stripTypes), 1)
    else
        consumeAny(findTool(character, AR.tapeTag, AR.tapeTypes), cost("seatTape"))
    end
end

-- cutting a dead plate or panel off still needs a torch; rubber and upholstery can be
-- torn out by hand.
function AR.getMetalScrapBlock(character, part)
    if not findTool(character, AR.torchTag, AR.torchTypes) then
        return getText("IGUI_SCKCO_MetalNeedTorch")
    end
end

-- nil when the part can be scrapped, otherwise the reason. Scrapping is the counterpart
-- to repair: it unlocks exactly when a part is too destroyed to weld.
-- Per-item build costs, keyed by full item type. Takes priority over the class default.
-- Normally populated by SCKCO_PartRepair_BuildCosts.lua, generated from the recipe scripts,
-- because reading input item names at runtime needs getJavaField, which the game restricts
-- to debug mode. Anything not in that table falls through to the recipe tier (debug only)
-- and then to the class default.
AR.buildCost = AR.buildCost or {}

-- Recipe ids to try for an item, most specific first. %s is the item name without its
-- module prefix. Point these at the recipes that already exist rather than writing new
-- ones: scrapping then recovers whatever those recipes consume, and stays correct when
-- they change.
--
-- getCraftRecipe/getInputs are confirmed present in B42; reading input quantities and
-- telling consumed inputs from held tools is not, so any failure falls through to the
-- declared tables rather than inventing a yield.
AR.recipeIdPatterns = {}

-- SCKCO armor recipes are named <Vehicle>.Make<PartType>, e.g. ChevyCaprice85 armor items
-- come from ChevyCaprice85.MakeWindshieldArmor. Item names are the same minus the dot plus
-- an SC<n> version suffix, so the id derives cleanly for 141 of 142 recipes.
AR.recipeSuffixes = { "WindshieldArmor", "WindowArmor", "DoorArmor", "Bumper" }

-- items whose recipe name does not follow from their item name
AR.recipeIdOverride = {
    ChevyC70FabricatedBrushGuardSC2 = "ChevyC70.MakeBumper",
}

-- recipes are declared in module Base, and getCraftRecipe needs that prefix even though
-- the recipe name itself already contains a dot (confirmed: "ChevyCaprice85.MakeBumper"
-- returns nil, "Base.ChevyCaprice85.MakeBumper" resolves).
AR.recipeModule = "Base."

AR.recipeIdFor = function(short)
    local override = AR.recipeIdOverride[short]
    if override then return AR.recipeModule .. override end
    local base = string.gsub(short, "SC%d+$", "")
    for _, suffix in ipairs(AR.recipeSuffixes) do
        local vehicle = string.match(base, "^(.+)" .. suffix .. "$")
        if vehicle then return AR.recipeModule .. vehicle .. ".Make" .. suffix end
    end
end

-- Inputs consumed by the recipe but not embodied in the finished part, so not recoverable.
-- The armor recipes burn 7-9 BlowTorch as fuel; returning those on salvage would let a
-- player scrap plates for torches.
AR.scrapExclude = {
    ["Base.BlowTorch"] = true,
}

local function recipeYield(fullType)
    if not sv("ScrapUseRecipes") then return nil end
    if getScriptManager == nil or getJavaField == nil then return nil end
    local short = string.match(fullType, "%.(.+)$") or fullType
    local mgr = getScriptManager()
    if mgr.getCraftRecipe == nil then return nil end

    local ids = {}
    if AR.recipeIdFor then
        local custom = AR.recipeIdFor(short)
        if custom then ids[#ids + 1] = custom end
    end
    for _, pattern in ipairs(AR.recipeIdPatterns) do ids[#ids + 1] = string.format(pattern, short) end

    for _, id in ipairs(ids) do
        local recipe = mgr:getCraftRecipe(id)
        if recipe and recipe.getInputs then
            local inputs = recipe:getInputs()
            local out = {}
            for i = 0, inputs:size() - 1 do
                local input = inputs:get(i)
                local items = getJavaField(input, "loadedItems")
                local amount = input.getAmount and input:getAmount() or 1
                -- a held tool is not consumed, so it is not recoverable either
                local keep = input.isKeep and input:isKeep()
                local itemType = items and items:size() > 0 and items:get(0)
                if itemType and not keep and amount > 0 and not AR.scrapExclude[itemType] then
                    out[#out + 1] = { itemType, amount }
                end
            end
            if #out > 0 then return out end
        end
    end
    return nil
end

-- item override, then recipe, then class default. nil means not scrappable.
-- second return value names the tier that answered, for AR.auditScrap().
function AR.getBuildCost(part)
    local item = part:getInventoryItem()
    if item then
        local declared = AR.buildCost[item:getFullType()]
        if declared then return declared, "declared" end
        local fromRecipe = recipeYield(item:getFullType())
        if fromRecipe then return fromRecipe, "recipe" end
    end
    local profile = AR.getProfile(part)
    if profile and profile.buildCost then return profile.buildCost, "class" end
    return nil, "none"
end

-- Step-by-step diagnostic for one part: reports exactly where recipe resolution stops.
-- SCKCO.PartRepair.debugRecipe() on the part you are looking at, or pass an item type.
function AR.debugRecipe(fullType)
    local TAG = "[SCKCO PartRepair] debugRecipe: "
    if fullType == nil then
        local player = getSpecificPlayer(0)
        local vehicle = player and player:getVehicle()
        if vehicle then
            for i = 0, vehicle:getPartCount() - 1 do
                local part = vehicle:getPartByIndex(i)
                if AR.isArmorPart(part) and part:getInventoryItem() then
                    fullType = part:getInventoryItem():getFullType()
                    break
                end
            end
        end
    end
    if fullType == nil then print(TAG .. "no armor item found; pass an item type") return end
    print(TAG .. "item = " .. fullType)

    print(TAG .. "getScriptManager present: " .. tostring(getScriptManager ~= nil))
    print(TAG .. "getJavaField present:     " .. tostring(getJavaField ~= nil))
    if getScriptManager == nil then return end

    local short = string.match(fullType, "%.(.+)$") or fullType
    local id = AR.recipeIdFor and AR.recipeIdFor(short)
    print(TAG .. "derived recipe id: " .. tostring(id))
    if id == nil then return end

    local mgr = getScriptManager()
    print(TAG .. "mgr.getCraftRecipe present: " .. tostring(mgr.getCraftRecipe ~= nil))
    if mgr.getCraftRecipe == nil then return end

    local recipe = mgr:getCraftRecipe(id)
    print(TAG .. "getCraftRecipe returned: " .. tostring(recipe))
    if recipe == nil then
        -- the name may need a module prefix on this build
        for _, alt in ipairs({ "Base." .. id, "SCKCO." .. id }) do
            local r2 = mgr:getCraftRecipe(alt)
            print(TAG .. "  try " .. alt .. " -> " .. tostring(r2))
            if r2 then recipe = r2 break end
        end
    end
    if recipe == nil then return end

    print(TAG .. "probing InputScript getters for item names:")
    do
        local ins = recipe.getInputs and recipe:getInputs()
        local probe = ins and ins:size() > 0 and ins:get(0)
        if probe then
            for _, name in ipairs({ "getItems", "getItemTypes", "getLoadedItems", "getItemList",
                                    "getFullTypes", "getScriptItems", "getMapper", "getItemMapper",
                                    "getSource", "getSources", "getTypes" }) do
                if probe[name] ~= nil then print(TAG .. "  HAS " .. name) end
            end
        end
    end
    print(TAG .. "recipe.getInputs present: " .. tostring(recipe.getInputs ~= nil))
    if recipe.getInputs == nil then return end
    local inputs = recipe:getInputs()
    print(TAG .. "inputs size: " .. tostring(inputs and inputs:size()))
    if inputs == nil then return end

    for i = 0, inputs:size() - 1 do
        local input = inputs:get(i)
        local items = getJavaField and getJavaField(input, "loadedItems")
        local amount = input.getAmount and input:getAmount()
        local keep = input.isKeep and input:isKeep()
        print(string.format("%s  input %d: items=%s amount=%s keep=%s first=%s",
            TAG, i,
            tostring(items and items:size()),
            tostring(amount), tostring(keep),
            tostring(items and items:size() > 0 and items:get(0))))
    end
end

-- Console audit: reports which tier every claimed part on the vehicle you are looking at
-- resolves through, so a silent fall-through to the class default is visible rather than
-- assumed. Call from the Lua console as SCKCO.PartRepair.auditScrap().
function AR.auditScrap(vehicle)
    vehicle = vehicle or (getSpecificPlayer(0) and getSpecificPlayer(0):getVehicle())
    if vehicle == nil then
        print("[SCKCO PartRepair] auditScrap: pass a vehicle or sit in one")
        return
    end
    print("[SCKCO PartRepair] vehicle script: " .. tostring(AR.getVehicleScriptName(vehicle))
        .. "  supported: " .. tostring(AR.isSupportedVehicle(vehicle)))
    local tally = {}
    for i = 0, vehicle:getPartCount() - 1 do
        local part = vehicle:getPartByIndex(i)
        if AR.isClaimed(part) then
            local costs, tier = AR.getBuildCost(part)
            tally[tier] = (tally[tier] or 0) + 1
            local detail = ""
            if costs then
                for _, e in ipairs(costs) do detail = detail .. " " .. e[1] .. "x" .. e[2] end
            end
            print(string.format("[SCKCO PartRepair] %-24s %-8s%s", part:getId(), tier, detail))
        end
    end
    for tier, n in pairs(tally) do
        print("[SCKCO PartRepair] total " .. tier .. ": " .. n)
    end
end

-- Recovery is lossy: each unit is rolled independently, so a strip yields a believable
-- spread rather than a fixed number. Skill reduces the waste.
function AR.getScrapLossChance(character)
    return clamp(sv("ScrapLossBase") - AR.getSkill(character) * sv("ScrapLossPerSkill"), 0, 100)
end

function AR.rollScrapYield(character, part)
    local costs = AR.getBuildCost(part)
    if costs == nil then return {} end
    local loss = AR.getScrapLossChance(character)
    local scale = sv("ScrapYieldScale")
    local out = {}
    for _, entry in ipairs(costs) do
        local units = math.floor(entry[2] * scale + 0.5)
        local kept = 0
        for _ = 1, units do
            if ZombRand(100) >= loss then kept = kept + 1 end
        end
        if kept > 0 then out[#out + 1] = { entry[1], kept } end
    end
    return out
end

function AR.getScrapBlockReason(character, part)
    if not sv("ScrapEnabled") then return getText("IGUI_SCKCO_ScrapDisabled") end
    if not AR.isClaimed(part) then return getText("IGUI_SCKCO_ScrapNothing") end
    if not AR.isTotalLoss(part) then return getText("IGUI_SCKCO_ScrapNotDestroyed") end
    local profile = AR.getProfile(part)
    -- only classes declaring a yield are scrappable in place; tires and seats are simply
    -- uninstalled through vanilla, which is what ripping one out already means
    if AR.getBuildCost(part) == nil then return getText("IGUI_SCKCO_ScrapNotSupported") end
    if profile.scrapBlock then return profile.scrapBlock(character, part) end
end

AR.profiles.armor.scrapBlock = AR.getMetalScrapBlock
AR.profiles.body.scrapBlock = AR.getMetalScrapBlock

AR.profiles.armor.block = AR.getMetalBlockReason
AR.profiles.body.block = AR.getMetalBlockReason
AR.profiles.armor.consume = AR.consumeMetal
AR.profiles.body.consume = AR.consumeMetal
AR.profiles.tire.consume = AR.consumeTire
AR.profiles.seat.consume = AR.consumeSeat

-- a flat tire is pumped first: patching a deflated carcass is not what this represents
function AR.getTireBlockReason(character, part)
    if AR.isFlat(part) then
        return getText("IGUI_SCKCO_TireFlat")
    end
    local kit = findType(character, AR.patchTypes)
    if not kit then return getText("IGUI_SCKCO_TireNeedPatch") end
    if kit:getCurrentUses() < cost("tirePatch") then
        return getText("IGUI_SCKCO_TireKitEmpty")
    end
end
AR.profiles.tire.block = AR.getTireBlockReason

-- seat upholstery: needle, thread and something to patch with
-- taping is the fallback: it needs no needle or thread, so it is only "in use" when the
-- full stitch kit is absent. one predicate drives both the block reason and the penalty.
function AR.hasStitchKit(character)
    return findTool(character, AR.needleTag, AR.needleTypes) ~= nil
        and findTool(character, AR.threadTag, AR.threadTypes) ~= nil
        and findType(character, AR.stripTypes) ~= nil
end

function AR.hasTape(character)
    return sv("SeatAllowTape") and findTool(character, AR.tapeTag, AR.tapeTypes) ~= nil
end

function AR.getSeatBlockReason(character, part)
    if AR.hasStitchKit(character) or AR.hasTape(character) then return nil end
    if not findTool(character, AR.needleTag, AR.needleTypes) then
        return getText("IGUI_SCKCO_SeatNeedNeedle")
    end
    if not findTool(character, AR.threadTag, AR.threadTypes) then
        return getText("IGUI_SCKCO_SeatNeedThread")
    end
    return getText("IGUI_SCKCO_SeatNeedMaterial")
end
AR.profiles.seat.block = AR.getSeatBlockReason

function AR.getSeatPenalty(character, part)
    if AR.hasStitchKit(character) then return 0 end
    return sv("SeatTapeFailPenalty")
end
AR.profiles.seat.penalty = AR.getSeatPenalty

ISSCKCORepairPart = ISBaseTimedAction:derive("ISSCKCORepairPart")

function ISSCKCORepairPart:new(character, part)
    local o = ISBaseTimedAction.new(self, character)
    o.part, o.vehicle = part, part:getVehicle()
    local item = part:getInventoryItem()
    o.maxTime = item and AR.getPassTime(character, part, item) or sv("RepairBaseTime")
    o.stopOnWalk, o.stopOnRun = true, true
    return o
end

function ISSCKCORepairPart:isValid()
    return AR.getPartClass(self.part) ~= nil and AR.getBlockReason(self.character, self.part) == nil
end

function ISSCKCORepairPart:waitToStart()
    self.character:faceThisObject(self.vehicle)
    return self.character:shouldBeTurning()
end

function ISSCKCORepairPart:start()
    local profile = AR.getProfile(self.part)
    self:setActionAnim(profile and profile.anim or "VehicleWorkOnMid")
    self.character:setMetabolicTarget(Metabolics.HeavyWork)
    if profile and profile.sound then
        self.sound = self.character:playSound(profile.sound)
    end
end

function ISSCKCORepairPart:update()
    self.character:setMetabolicTarget(Metabolics.HeavyWork)
end

function ISSCKCORepairPart:stop()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
    ISBaseTimedAction.stop(self)
end

function ISSCKCORepairPart:perform()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end

    local item = self.part:getInventoryItem()
    local missing = AR.getMissing(self.part, item)

    -- materials burn whether the pass succeeds or fails; cost is read before condition moves
    local profile = AR.getProfile(self.part)
    if profile and profile.consume then
        profile.consume(self.character, self.part, item)
    end

    if ZombRand(100) < AR.getFailChance(self.character, self.part, item) then
        -- botch target by class: armor gouges the part beneath it, a bare panel gouges
        -- itself. an unresolved armor parent means no damage rather than self-damage.
        local victim
        if ZombRand(100) < sv("RepairBotchChance") then
            if profile and profile.botchParent then
                victim = AR.getProtectedPart(self.vehicle, self.part)
            else
                victim = self.part
            end
        end
        if victim then
            victim:setCondition(clamp(victim:getCondition() - sv("RepairBotchDamage"), 0))
            if self.vehicle then self.vehicle:transmitPartCondition(victim) end
            self.character:setHaloNote(AR.text(self.part, "Botched"), 255, 60, 60, 300)
        else
            self.character:setHaloNote(AR.text(self.part, "Failed"), 255, 160, 60, 300)
        end
    else
        local ceiling = AR.getConditionCeiling(item)
        self.part:setCondition(math.min(
            self.part:getCondition() + AR.getPassAmount(self.character, self.part, item), ceiling))
        -- decay is charged per SUCCESSFUL pass, driving the part toward scrap
        AR.addRepair(item)
        if self.vehicle then
            self.vehicle:transmitPartCondition(self.part)
            self.vehicle:transmitPartItem(self.part)
        end

        local xp = sv("RepairXP") + missing * sv("RepairXPPerDamage")
        local prof = AR.getProfile(self.part)
        if prof and prof.skill then
            self.character:getXp():AddXP(Perks[prof.skill], xp)
        else
            local mode = sv("RepairSkillMode")
            if mode ~= AR.SKILL_WELDING then self.character:getXp():AddXP(Perks.Mechanics, xp) end
            if mode ~= AR.SKILL_MECHANICS then self.character:getXp():AddXP(Perks.MetalWelding, xp) end
        end
    end

    ISBaseTimedAction.perform(self)

    -- auto-repeat until the gap closes or materials run out; getBlockReason covers both
    if AR.getBlockReason(self.character, self.part) == nil then
        ISTimedActionQueue.add(ISSCKCORepairPart:new(self.character, self.part))
    end
end

ISSCKCOScrapPart = ISBaseTimedAction:derive("ISSCKCOScrapPart")

function ISSCKCOScrapPart:new(character, part)
    local o = ISBaseTimedAction.new(self, character)
    o.part, o.vehicle = part, part:getVehicle()
    o.maxTime = AR.SCRAP_TIME
    o.stopOnWalk, o.stopOnRun = true, true
    return o
end

function ISSCKCOScrapPart:isValid()
    return AR.getScrapBlockReason(self.character, self.part) == nil
end

function ISSCKCOScrapPart:waitToStart()
    self.character:faceThisObject(self.vehicle)
    return self.character:shouldBeTurning()
end

function ISSCKCOScrapPart:start()
    local profile = AR.getProfile(self.part)
    self:setActionAnim(profile and profile.anim or "VehicleWorkOnMid")
    self.character:setMetabolicTarget(Metabolics.HeavyWork)
    if profile and profile.sound then
        self.sound = self.character:playSound(profile.sound)
    end
end

function ISSCKCOScrapPart:update()
    self.character:setMetabolicTarget(Metabolics.HeavyWork)
end

function ISSCKCOScrapPart:stop()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
    ISBaseTimedAction.stop(self)
end

function ISSCKCOScrapPart:perform()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end

    local inv = self.character:getInventory()
    local recovered = 0
    for _, yield in ipairs(AR.rollScrapYield(self.character, self.part)) do
        for _ = 1, yield[2] do
            inv:AddItem(yield[1])
            recovered = recovered + 1
        end
    end
    if recovered == 0 then
        self.character:setHaloNote(getText("IGUI_SCKCO_ScrapNothingUsable"), 255, 160, 60, 300)
    end

    -- clearing the slot is the destructive step: setInventoryItem(nil) empties the part
    -- and transmitPartItem is what carries that to other clients.
    self.part:setInventoryItem(nil)
    self.vehicle:transmitPartItem(self.part)

    ISBaseTimedAction.perform(self)
end

function AR.onScrapPart(character, part)
    ISTimedActionQueue.add(ISSCKCOScrapPart:new(character, part))
end

function AR.onRepairPart(character, part)
    ISTimedActionQueue.add(ISSCKCORepairPart:new(character, part))
end

-- getText resolves IGUI_VehiclePart<Id> from this mod for SCArmor* parts and from vanilla
-- for stock body parts; an unresolved key returns itself, so fall back to the bare id.
function AR.getPartName(part)
    if AR.isLoose(part) then return part.looseItem:getDisplayName() end
    local key = "IGUI_VehiclePart" .. part:getId()
    local name = getText(key)
    if name == key then return part:getId() end
    return name
end

function AR.getRepairLabel(part, withCondition)
    local profile = AR.getProfile(part)
    local verb = getText(profile and profile.verb or "IGUI_SCKCO_RepairVerb")
    local label = verb .. " " .. AR.getPartName(part)
    if not withCondition then return label end
    local item = part:getInventoryItem()
    return label .. " (" .. round(part:getCondition()) .. "% / "
        .. round(AR.getConditionCeiling(item)) .. ")"
end

-- single builder for both entry points (mechanics panel and world menu) so their
-- labels, availability and tooltips cannot drift apart
local function addRepairOption(context, character, part, withCondition)
    local option = context:addOption(AR.getRepairLabel(part, withCondition),
        character, AR.onRepairPart, part)
    local reason = AR.getBlockReason(character, part)
    local tooltip = ISWorldObjectContextMenu.addToolTip()
    if reason then
        option.notAvailable = true
        tooltip.description = reason
    else
        local item = part:getInventoryItem()
        tooltip.description = getText("IGUI_SCKCO_Tip",
            tostring(math.floor(AR.getFailChance(character, part, item))),
            tostring(math.floor(AR.getPassAmount(character, part, item))))
    end
    option.toolTip = tooltip
    return option
end

-- scrap is only offered once a part is destroyed, so it never competes with repair
local function addScrapOption(context, character, part, withCondition)
    if AR.getScrapBlockReason(character, part) ~= nil then return end
    local label = getText("IGUI_SCKCO_ScrapVerb") .. " " .. AR.getPartName(part)
    local option = context:addOption(label, character, AR.onScrapPart, part)
    local tooltip = ISWorldObjectContextMenu.addToolTip()
    tooltip.description = getText("IGUI_SCKCO_ScrapTip",
        tostring(math.floor(100 - AR.getScrapLossChance(character))))
    option.toolTip = tooltip
end

function AR.addPartOption(character, context, part)
    if not sv("RepairEnabled") or not AR.isClaimed(part) then return end
    addRepairOption(context, character, part, false)
    addScrapOption(context, character, part, false)
end

-- a group with nothing actionable in it is noise on the world menu: missing tools block
-- every entry at once, so the whole submenu would render red. the mechanics panel still
-- shows the blocked option with its reason, which is where the feature stays discoverable.
local function anyActionable(character, parts)
    for i = 1, #parts do
        if AR.getBlockReason(character, parts[i]) == nil then return true end
        if AR.getScrapBlockReason(character, parts[i]) == nil then return true end
    end
    return false
end

local function buildSubmenu(context, character, parts, headerKey)
    local parent = context:addOption(getText(headerKey), nil, nil)
    local submenu = ISContextMenu:getNew(context)
    context:addSubMenu(parent, submenu)
    for i = 1, #parts do
        addRepairOption(submenu, character, parts[i], true)
        addScrapOption(submenu, character, parts[i], true)
    end
end

function AR.addMenu(playerIndex, context, vehicle)
    if not sv("RepairEnabled") then return end
    local character = getSpecificPlayer(playerIndex)
    if not character or character:getVehicle() then return end
    if not AR.isSupportedVehicle(vehicle) then return end

    local groups = {}
    for _, cls in ipairs(AR.classOrder) do groups[cls] = {} end
    for i = 0, vehicle:getPartCount() - 1 do
        local part = vehicle:getPartByIndex(i)
        if part:getInventoryItem() then
            local cls = AR.getPartClass(part)
            if cls then
                local g = groups[cls]
                g[#g + 1] = part
            end
        end
    end
    for _, cls in ipairs(AR.classOrder) do
        local parts = groups[cls]
        if #parts > 0 and (not sv("RepairHideUnusable") or anyActionable(character, parts)) then
            buildSubmenu(context, character, parts, AR.profiles[cls].header)
        end
    end
end

local original_FillMenuOutsideVehicle = ISVehicleMenu.FillMenuOutsideVehicle
function ISVehicleMenu.FillMenuOutsideVehicle(playerIndex, context, vehicle, test)
    original_FillMenuOutsideVehicle(playerIndex, context, vehicle, test)
    if test then return end
    AR.addMenu(playerIndex, context, vehicle)
end

-- guards mirror vanilla doPartContextMenu: on its early returns self.context is a stale
-- menu from a previous open and must not be appended to
local original_doPartContextMenu = ISVehicleMechanics.doPartContextMenu
function ISVehicleMechanics:doPartContextMenu(part, x, y)
    original_doPartContextMenu(self, part, x, y)
    if UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then return end
    local playerObj = getSpecificPlayer(self.playerNum)
    if playerObj:getVehicle() ~= nil and not (isDebugEnabled()
        or (isClient() and (isAdmin() or getAccessLevel() == "moderator"))) then return end

    -- replace rather than duplicate vanilla's repair for parts we claim
    -- only classes that actually replace a vanilla repair path suppress it. armor has no
    -- vanilla equivalent, and vanilla offers no seat or tire repair to remove.
    local profile = AR.isClaimed(part) and AR.getProfile(part)
    if profile and profile.replaceVanilla and sv("ReplaceVanillaRepair") then
        self.context:removeOptionByName(getText("ContextMenu_Repair"))
    end
    AR.addPartOption(playerObj, self.context, part)
end

-- Every failure mode in this file is otherwise silent (an option that stops appearing, a
-- botch that no-ops), so assert the vanilla surface at boot and log what is missing.
-- Diagnostic only: never alters behaviour.
-- Overridden/depended-on vanilla symbols are exactly what this checks, so this list is
-- also the dependency manifest. Record the tested build here: B42 <fill in>.
local function selfCheck()
    local TAG = "[SCKCO PartRepair] "
    local issues = 0
    local function warn(msg) issues = issues + 1; print(TAG .. "WARN: " .. msg) end

    if ISVehicleMenu == nil or ISVehicleMenu.FillMenuOutsideVehicle == nil then
        warn("ISVehicleMenu.FillMenuOutsideVehicle missing; world menu will not appear")
    end
    if ISVehicleMechanics == nil or ISVehicleMechanics.doPartContextMenu == nil then
        warn("ISVehicleMechanics.doPartContextMenu missing; panel option will not appear")
    end
    if ISContextMenu == nil or ISContextMenu.removeOptionByName == nil then
        warn("ISContextMenu.removeOptionByName missing; vanilla Repair will not be suppressed")
    end
    if getText("ContextMenu_Repair") == "ContextMenu_Repair" then
        warn("ContextMenu_Repair unresolved; vanilla Repair suppression will no-op")
    end
    if type(ItemTag) ~= "table" then
        warn("ItemTag unavailable; torch/mask tag lookup disabled, falling back to type lists")
    else
        if ItemTag[AR.torchTag] == nil then
            warn("ItemTag." .. AR.torchTag .. " missing; torch matched by type list only")
        end
        if ItemTag[AR.maskTag] == nil then
            warn("ItemTag." .. AR.maskTag .. " missing; mask matched by type list only")
        end
    end

    -- every class must be fully described by its profile: a missing hook means that class
    -- silently stops consuming materials or stops enforcing its toolset
    for _, cls in ipairs(AR.classOrder) do
        local profile = AR.profiles[cls]
        if profile == nil then
            warn("class '" .. cls .. "' in classOrder has no profile")
        else
            for _, field in ipairs({ "prefix", "verb", "header", "anim", "block", "consume", "enable" }) do
                if profile[field] == nil then
                    warn("profile '" .. cls .. "' is missing " .. field)
                end
            end
            if getText(profile.header) == profile.header then
                warn("profile '" .. cls .. "' header " .. profile.header .. " has no translation")
            end
        end
    end

    local vars = SandboxVars.SCKCO
    if vars then
        local missing = {}
        for k in pairs(defaults) do
            if vars[k] == nil then missing[#missing + 1] = k end
        end
        if #missing > 0 then
            warn("sandbox options absent, using defaults: " .. table.concat(missing, ", "))
        end
    end

    if issues == 0 then
        print(TAG .. "self-check passed")
    else
        print(TAG .. "self-check found " .. issues .. " issue(s)")
    end
end

Events.OnGameBoot.Add(selfCheck)
