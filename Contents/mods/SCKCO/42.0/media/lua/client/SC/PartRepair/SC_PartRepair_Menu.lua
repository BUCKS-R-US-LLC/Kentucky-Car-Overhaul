require "SC/PartRepair/SC_PartRepair"

-- Client half of part repair: menus, halo feedback and the boot self-check. The rules and
-- the timed actions live in shared/SC/PartRepair/SC_PartRepair.lua so the server can run
-- their complete().
local AR = SCKCO.PartRepair
local sv = AR.getOption
local round = AR.round
local defaults = AR.defaults

-- halo notes raised by complete() on a dedicated server (AR.notify)
local function onServerCommand(module, command, args)
    if module ~= AR.netModule or command ~= "halo" or type(args) ~= "table" then return end
    local player = getPlayer()
    if player and args.key then
        player:setHaloNote(getText(args.key), args.r or 255, args.g or 255, args.b or 255, 300)
    end
end
Events.OnServerCommand.Add(onServerCommand)

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
local function addRepairOption(context, character, part, withCondition, onSelect, arg)
    local option = context:addOption(AR.getRepairLabel(part, withCondition),
        character, onSelect or AR.onRepairPart, arg or part)
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

-- Loose parts. A ground part is picked up first (the vanilla grab, same MP split as
-- onGrabWItem) so the repair action can take a carried InventoryItem the server resolves.
local function grabThenRepair(character, worldItem)
    local item = worldItem:getItem()
    local square = worldItem:getSquare()
    if not item or not square or not luautils.walkAdj(character, square) then return end
    if isClient() then
        ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(character, item,
            item:getContainer(), character:getInventory()))
    else
        ISTimedActionQueue.add(ISGrabItemAction:new(character, worldItem,
            ISWorldObjectContextMenu.grabItemTime(character, worldItem)))
    end
    AR.onRepairLoose(character, item)
end

local function looseEnabled()
    return sv("RepairEnabled") and sv("RepairLooseParts")
end

local function looseWorldParts(worldobjects)
    local found, seenSquare, seenItem = {}, {}, {}
    for _, obj in ipairs(worldobjects) do
        local square = obj:getSquare()
        if square and not seenSquare[square] then
            seenSquare[square] = true
            local wobs = square:getWorldObjects()
            for i = 0, wobs:size() - 1 do
                local wob = wobs:get(i)
                local item = wob:getItem()
                if item and not seenItem[item] then
                    seenItem[item] = true
                    local part = AR.itemAsPart(item)
                    if part and AR.getPartClass(part) then
                        found[#found + 1] = { world = wob, part = part }
                    end
                end
            end
        end
    end
    return found
end

local function onFillWorldObjectContextMenu(playerIndex, context, worldobjects, test)
    if test or not looseEnabled() then return end
    local character = getSpecificPlayer(playerIndex)
    if not character or character:getVehicle() then return end
    for _, entry in ipairs(looseWorldParts(worldobjects)) do
        addRepairOption(context, character, entry.part, true, grabThenRepair, entry.world)
    end
end
Events.OnFillWorldObjectContextMenu.Add(onFillWorldObjectContextMenu)

-- carried parts: main inventory only, matching ISSCKCORepairLoose:isValid
local function onFillInventoryObjectContextMenu(playerIndex, context, items)
    if not looseEnabled() then return end
    local character = getSpecificPlayer(playerIndex)
    if not character then return end
    local inv = character:getInventory()
    for _, entry in ipairs(items) do
        local item = entry
        if type(entry) == "table" then item = entry.items and entry.items[1] end
        if item and inv:contains(item) then
            local part = AR.itemAsPart(item)
            if part and AR.getPartClass(part) then
                addRepairOption(context, character, part, true, AR.onRepairLoose, item)
            end
        end
    end
end
Events.OnFillInventoryObjectContextMenu.Add(onFillInventoryObjectContextMenu)

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
    if ISGrabItemAction == nil or ISInventoryTransferUtil == nil
        or ISWorldObjectContextMenu == nil or ISWorldObjectContextMenu.grabItemTime == nil then
        warn("grab helpers missing; ground-part repair cannot pick the part up")
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
