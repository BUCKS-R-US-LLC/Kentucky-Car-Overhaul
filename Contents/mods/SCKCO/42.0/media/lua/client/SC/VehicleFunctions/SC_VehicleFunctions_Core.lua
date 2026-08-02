-- Vehicle stations: capabilities backed by per-vehicle marker parts (installed + condition>0).
-- Shared core resolves the vehicle, gates on the marker part, checks proximity, and handles
-- item-modData state with MP sync via transmitPartItem (state rides the part's installed item,
-- so it travels + saves with the vehicle). Each capability registers a context contributor and
-- its own SCKCO.Create.* seed hook. Water is the first section; power/crafting slot in the same way.
--
-- Note: entity components (FluidContainer, CraftBench) cannot be attached to a VehiclePart and a
-- world component entity is chunk-bound, so stations store state in part-item modData rather than
-- hanging engine components off the vehicle.
require "TimedActions/ISBaseTimedAction"

SCKCO          = SCKCO or {}
SCKCO.Create   = SCKCO.Create or {}
SCKCO.Update   = SCKCO.Update or {}
SCKCO.VehicleFunctions = SCKCO.VehicleFunctions or {}

local VehicleFunctions = SCKCO.VehicleFunctions
VehicleFunctions.contributors = VehicleFunctions.contributors or {}

-- True when the right-click's worldobjects include this vehicle (i.e. clicked the vehicle,
-- not empty ground or an adjacent object). Contributors use this to decide whether to show
-- info readouts that only make sense when inspecting the vehicle.
function VehicleFunctions.clickedVehicle(vehicle)
    local wobjs = VehicleFunctions.currentWorldObjects
    if not wobjs then return false end
    for _, o in ipairs(wobjs) do
        if o == vehicle then return true end
        if instanceof(o, "BaseVehicle") and o == vehicle then return true end
        local sq = o.getSquare and o:getSquare()
        if sq and sq:getVehicleContainer() == vehicle then return true end
    end
    return false
end

--------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------
-- All tunables live here. Rates are per update tick (empirically calibrated so a full
-- 2000 L transfer takes about 1 minute of real time at the game's actual update rate).
-- Times are ceilings; the action ends earlier when the source runs dry or the target fills.
SCKCO.VehicleFunctions.Config = SCKCO.VehicleFunctions.Config or {
    -- transfer rates (litres per tick)
    rate_container      = 3.0,    -- container <-> tank (fill/draw a jerry can, etc.)
    rate_tank_to_tank   = 3.0,    -- vehicle-to-vehicle content transfer
    rate_fuel_dispense  = 0.02,   -- tanker -> vehicle gas tank; vanilla-equivalent (~50 ticks/L)
    rate_hydrant        = 0.33,   -- hydrant -> cistern; matches pump->tanker feel
    rate_draft          = 0.33,   -- river/lake -> cistern; matches pump->tanker feel
    rate_pump_refuel    = 0.33,   -- gas pump -> tanker
    -- action ceilings (ticks). Kept large; actions end when source/target hits limits.
    time_ceiling        = 6000,
    -- proximity radii (tiles)
    proximity_action    = 6,      -- how close the player must be to a station vehicle
    proximity_hydrant   = 3,      -- hydrant search around cistern
    proximity_draft     = 4,      -- water tile search around cistern
    proximity_pump      = 3,      -- pump search around tanker
    proximity_target    = 3,      -- target vehicle search around source
    -- sounds & animations (mirroring vanilla ISTakeGasolineFromPump / ISTakeGasolineFromVehicle)
    pump_sound          = "VehicleAddFuelFromGasPump",
    pump_anim           = "fill_container_tap",  -- vanilla ISRefuelFromGasPump anim state
    dispense_sound      = "VehicleAddFuelFromGasPump",
    dispense_anim       = "fill_container_tap",
    dispense_icon       = "media/ui/vehicles/vehicle_refuel_from_pump.png",
    dispense_label      = "ContextMenu_VehicleRefuelFromPump",
}
local Config = SCKCO.VehicleFunctions.Config

-- Part id lists shared across files. Any station action that operates on a tank looks these up.
VehicleFunctions.TANK_PARTS = {
    "WaterTankSC",
    "SmallCisternSC",  "MediumCisternSC",  "LargeCisternSC",
    "SmallFuelTankSC", "MediumFuelTankSC", "LargeFuelTankSC",
}
VehicleFunctions.CISTERN_PARTS  = { "SmallCisternSC",  "MediumCisternSC",  "LargeCisternSC" }
VehicleFunctions.FUELTANK_PARTS = { "SmallFuelTankSC", "MediumFuelTankSC", "LargeFuelTankSC" }


--------------------------------------------------------------------------------
-- Shared core
--------------------------------------------------------------------------------

-- Vehicle from the player's seat, else a BaseVehicle among the clicked world objects.
function VehicleFunctions.contextVehicle(player, worldobjects)
    local v = player:getVehicle()
    if v then return v end
    for _, o in ipairs(worldobjects) do
        if instanceof(o, "BaseVehicle") then return o end
    end
    -- standing beside it: scan squares around the player for a vehicle occupant
    local cell = player:getCell()
    if cell then
        local px, py, pz = math.floor(player:getX()), math.floor(player:getY()), math.floor(player:getZ())
        local r = 2
        for dx = -r, r do
            for dy = -r, r do
                local sq = cell:getGridSquare(px + dx, py + dy, pz)
                local vc = sq and sq:getVehicleContainer()
                if vc then return vc end
            end
        end
    end
    return nil
end

-- Marker gate: returns part,item when the marker part is installed with condition>0 and holds
-- its item; otherwise nil.
function VehicleFunctions.marker(vehicle, partId)
    local p = vehicle and vehicle:getPartById(partId)
    if not p or p:getCondition() <= 0 then return nil, nil end
    local item = p:getInventoryItem()
    if not item then return nil, nil end
    return p, item
end

-- First installed marker part from a list; returns part, item, id.
function VehicleFunctions.markerAny(vehicle, ids)
    for i = 1, #ids do
        local part, item = VehicleFunctions.marker(vehicle, ids[i])
        if part then return part, item, ids[i] end
    end
    return nil
end

-- Vanilla ISTakeGasolineFromVehicle uses character:playSound + stopOrTriggerSound for the
-- sound lifecycle, not the emitter. Mirroring that here so the pump sound actually plays.
function VehicleFunctions.startPumpSound(action)
    if action.character and not action.pumpSound then
        action.pumpSound = action.character:playSound(Config.pump_sound)
    end
end

-- Kept as a no-op for backwards compatibility with existing update() calls; the character
-- sound handle persists for the whole action, so no per-tick retrigger is needed.
function VehicleFunctions.updatePumpSound(action) end

-- Incremental fluid transfer: move a bounded amount per call, so partial progress is kept if
-- the action is interrupted. maxTime scales the intended total; step is per-update. Returns
-- the amount actually moved (0 when there's no room / nothing to move).
function VehicleFunctions.stepTransfer(srcFC, dstFC, action, rate)
    if not (srcFC and dstFC) then return 0 end
    if srcFC.isEmpty and srcFC:isEmpty() then return 0 end
    if dstFC.isFull and dstFC:isFull() then return 0 end
    local perTick = rate or Config.rate_container
    local amount = math.min(perTick, srcFC:getAmount(), dstFC:getFreeCapacity())
    if amount <= 0 then return 0 end
    dstFC:addFluid(srcFC:getPrimaryFluid(), amount)
    srcFC:removeFluid(amount)
    return amount
end

function VehicleFunctions.stopPumpSound(action)
    if action.character and action.pumpSound then
        action.character:stopOrTriggerSound(action.pumpSound)
        action.pumpSound = nil
    end
end

-- Within ~4 tiles of the vehicle origin.
function VehicleFunctions.near(player, vehicle)
    local dx, dy = vehicle:getX() - player:getX(), vehicle:getY() - player:getY()
    local r = Config.proximity_action
    return dx * dx + dy * dy < r * r
end

function VehicleFunctions.get(item, key, default)
    local v = item:getModData()[key]
    if v == nil then return default end
    return v
end

-- Writes state onto the part's installed item and transmits it for MP.
function VehicleFunctions.set(vehicle, part, item, key, value)
    item:getModData()[key] = value
    vehicle:transmitPartItem(part)
end


-- Deduped list of inventory items matching predicate (one entry per full type).
function VehicleFunctions.inventoryMatching(player, predicate)
    local list = player:getInventory():getItems()
    local found, seen = {}, {}
    for i = 0, list:size() - 1 do
        local item = list:get(i)
        if predicate(item) then
            local t = item:getFullType()
            if not seen[t] then seen[t] = true; found[#found + 1] = item end
        end
    end
    return found
end

-- Submenu whose entries call fn(player, vehicle, item).
function VehicleFunctions.addSub(context, label, items, player, vehicle, fn)
    local option = context:addOption(label, nil, nil)
    local sub = ISContextMenu:getNew(context)
    context:addSubMenu(option, sub)
    for i = 1, #items do
        sub:addOption(items[i]:getName(), player, fn, vehicle, items[i])
    end
end

function VehicleFunctions.register(fn)
    VehicleFunctions.contributors[#VehicleFunctions.contributors + 1] = fn
end

local function onContext(playerNum, context, worldobjects, test)
    if test then return end
    local player = getSpecificPlayer(playerNum)
    if not player then return end
    local vehicle = VehicleFunctions.contextVehicle(player, worldobjects)
    if not vehicle or not VehicleFunctions.near(player, vehicle) then return end
    VehicleFunctions.currentWorldObjects = worldobjects   -- exposed so contributors can inspect the clicked square
    for i = 1, #VehicleFunctions.contributors do
        VehicleFunctions.contributors[i](context, player, vehicle)
    end
    VehicleFunctions.currentWorldObjects = nil
end
Events.OnFillWorldObjectContextMenu.Add(onContext)
