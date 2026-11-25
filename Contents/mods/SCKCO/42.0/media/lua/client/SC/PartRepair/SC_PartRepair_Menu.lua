require "SC/PartRepair/SC_PartRepair"

-- Client half of part repair: context menus and halo feedback from the server.
local AR = SCKCO.PartRepair
local sv = AR.getOption
local round = AR.round

-- halo notes raised by complete() on a dedicated server (AR.notify)
Events.OnServerCommand.Add(function(module, command, args)
    if module ~= AR.netModule or command ~= "halo" or type(args) ~= "table" or not args.key then return end
    local player = getPlayer()
    if player then player:setHaloNote(getText(args.key), args.r or 255, args.g or 255, args.b or 255, 300) end
end)

-- IGUI_VehiclePart<Id> resolves from this mod or vanilla; an unresolved key returns itself
function AR.getPartName(part)
    if AR.isLoose(part) then return part.looseItem:getDisplayName() end
    local key = "IGUI_VehiclePart" .. part:getId()
    local name = getText(key)
    return name == key and part:getId() or name
end

function AR.getRepairLabel(part, withCondition)
    local profile = AR.getProfile(part)
    local label = getText(profile and profile.verb or "IGUI_SCKCO_RepairVerb") .. " " .. AR.getPartName(part)
    if not withCondition then return label end
    return label .. " (" .. round(part:getCondition()) .. "% / " .. round(AR.getConditionCeiling(part:getInventoryItem())) .. ")"
end

local function setTooltip(option, text)
    local tooltip = ISWorldObjectContextMenu.addToolTip()
    tooltip.description = text
    option.toolTip = tooltip
end

-- one builder for every entry point so labels, availability and tooltips match
local function addRepairOption(context, character, part, withCondition, onSelect, arg)
    local option = context:addOption(AR.getRepairLabel(part, withCondition), character, onSelect or AR.onRepairPart, arg or part)
    local reason = AR.getBlockReason(character, part)
    if reason then
        option.notAvailable = true
        setTooltip(option, reason)
    else
        local item = part:getInventoryItem()
        setTooltip(option, getText("IGUI_SCKCO_Tip",
            tostring(math.floor(AR.getFailChance(character, part, item))),
            tostring(math.floor(AR.getPassAmount(character, part, item)))))
    end
end

-- scrap is only offered once a part is destroyed, so it never competes with repair
local function addScrapOption(context, character, part)
    if AR.getScrapBlockReason(character, part) ~= nil then return end
    local option = context:addOption(getText("IGUI_SCKCO_ScrapVerb") .. " " .. AR.getPartName(part), character, AR.onScrapPart, part)
    setTooltip(option, getText("IGUI_SCKCO_ScrapTip", tostring(math.floor(100 - AR.getScrapLossChance(character)))))
end

-- ---------------------------------------------------------------------------------------
-- Vehicle: world menu groups by class, mechanics panel per part
-- ---------------------------------------------------------------------------------------

-- when tools are missing every entry is blocked; the mechanics panel still shows them
local function anyActionable(character, parts)
    for _, part in ipairs(parts) do
        if AR.getBlockReason(character, part) == nil or AR.getScrapBlockReason(character, part) == nil then return true end
    end
    return false
end

function AR.addMenu(playerIndex, context, vehicle)
    if not sv("RepairEnabled") or not AR.isSupportedVehicle(vehicle) then return end
    local character = getSpecificPlayer(playerIndex)
    if not character or character:getVehicle() then return end

    local groups = {}
    for i = 0, vehicle:getPartCount() - 1 do
        local part = vehicle:getPartByIndex(i)
        local cls = part:getInventoryItem() and AR.getPartClass(part)
        if cls then
            groups[cls] = groups[cls] or {}
            table.insert(groups[cls], part)
        end
    end
    for _, cls in ipairs(AR.classOrder) do
        local parts = groups[cls]
        if parts and (not sv("RepairHideUnusable") or anyActionable(character, parts)) then
            local submenu = ISContextMenu:getNew(context)
            context:addSubMenu(context:addOption(getText(AR.profiles[cls].header), nil, nil), submenu)
            for _, part in ipairs(parts) do
                addRepairOption(submenu, character, part, true)
                addScrapOption(submenu, character, part)
            end
        end
    end
end

local original_FillMenuOutsideVehicle = ISVehicleMenu.FillMenuOutsideVehicle
function ISVehicleMenu.FillMenuOutsideVehicle(playerIndex, context, vehicle, test)
    original_FillMenuOutsideVehicle(playerIndex, context, vehicle, test)
    if not test then AR.addMenu(playerIndex, context, vehicle) end
end

-- guards mirror vanilla doPartContextMenu: on its early returns self.context is a stale menu
local original_doPartContextMenu = ISVehicleMechanics.doPartContextMenu
function ISVehicleMechanics:doPartContextMenu(part, x, y)
    original_doPartContextMenu(self, part, x, y)
    if UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then return end
    local playerObj = getSpecificPlayer(self.playerNum)
    if playerObj:getVehicle() ~= nil and not (isDebugEnabled()
        or (isClient() and (isAdmin() or getAccessLevel() == "moderator"))) then return end
    if not sv("RepairEnabled") or not AR.isClaimed(part) then return end

    -- armor, tires and seats have no vanilla repair to replace
    if AR.getProfile(part).replaceVanilla and sv("ReplaceVanillaRepair") then
        self.context:removeOptionByName(getText("ContextMenu_Repair"))
    end
    addRepairOption(self.context, playerObj, part, false)
    addScrapOption(self.context, playerObj, part)
end

-- ---------------------------------------------------------------------------------------
-- Loose parts: carried (main inventory, matching ISSCKCORepairLoose:isValid) or on the ground
-- ---------------------------------------------------------------------------------------

local function looseEnabled()
    return sv("RepairEnabled") and sv("RepairLooseParts")
end

local function loosePart(item)
    local part = AR.itemAsPart(item)
    return part and AR.getPartClass(part) and part
end

-- the repair action needs a carried item the server can resolve, so a ground part is picked
-- up first with vanilla's grab (same MP split as onGrabWItem)
local function grabThenRepair(character, worldItem)
    local item, square = worldItem:getItem(), worldItem:getSquare()
    if not item or not square or not luautils.walkAdj(character, square) then return end
    if isClient() then
        ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(character, item, item:getContainer(), character:getInventory()))
    else
        ISTimedActionQueue.add(ISGrabItemAction:new(character, worldItem, ISWorldObjectContextMenu.grabItemTime(character, worldItem)))
    end
    AR.onRepairLoose(character, item)
end

Events.OnFillWorldObjectContextMenu.Add(function(playerIndex, context, worldobjects, test)
    if test or not looseEnabled() then return end
    local character = getSpecificPlayer(playerIndex)
    if not character or character:getVehicle() then return end
    local seenSquare, seenItem = {}, {}
    for _, obj in ipairs(worldobjects) do
        local square = obj:getSquare()
        if square and not seenSquare[square] then
            seenSquare[square] = true
            local wobs = square:getWorldObjects()
            for i = 0, wobs:size() - 1 do
                local wob = wobs:get(i)
                local item = wob:getItem()
                local part = item and not seenItem[item] and loosePart(item)
                if item then seenItem[item] = true end
                if part then addRepairOption(context, character, part, true, grabThenRepair, wob) end
            end
        end
    end
end)

Events.OnFillInventoryObjectContextMenu.Add(function(playerIndex, context, items)
    if not looseEnabled() then return end
    local character = getSpecificPlayer(playerIndex)
    if not character then return end
    local inv = character:getInventory()
    for _, entry in ipairs(items) do
        local item = entry
        if type(entry) == "table" then item = entry.items and entry.items[1] end
        local part = item and inv:contains(item) and loosePart(item)
        if part then addRepairOption(context, character, part, true, AR.onRepairLoose, item) end
    end
end)

-- the vanilla hooks above fail silently if renamed, so log what is missing at boot
Events.OnGameBoot.Add(function()
    local missing = {}
    local function need(ok, what) if not ok then missing[#missing + 1] = what end end
    need(ISVehicleMenu and ISVehicleMenu.FillMenuOutsideVehicle, "ISVehicleMenu.FillMenuOutsideVehicle")
    need(ISVehicleMechanics and ISVehicleMechanics.doPartContextMenu, "ISVehicleMechanics.doPartContextMenu")
    need(ISContextMenu and ISContextMenu.removeOptionByName, "ISContextMenu.removeOptionByName")
    need(ISGrabItemAction and ISInventoryTransferUtil and ISWorldObjectContextMenu and ISWorldObjectContextMenu.grabItemTime, "grab helpers")
    need(getText("ContextMenu_Repair") ~= "ContextMenu_Repair", "ContextMenu_Repair text")
    for _, cls in ipairs(AR.classOrder) do
        local header = AR.profiles[cls].header
        need(getText(header) ~= header, header .. " text")
    end
    if #missing > 0 then print("[SCKCO PartRepair] WARN missing: " .. table.concat(missing, ", ")) end
end)
