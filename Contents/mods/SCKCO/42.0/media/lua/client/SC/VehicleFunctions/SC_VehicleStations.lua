--
-- SC_VehicleStations.lua
-- Shark and Cytt's Kentucky Car Overhaul -- vehicle-mounted stations
--
-- One file, one canonical Config, one shared VehicleFunctions API. Merged back from the
-- previously-split three-file version after cross-file dependencies and stale-file bugs.
--
-- Table of contents:
--   1. Core       -- SCKCO.VehicleFunctions init, Config, marker helpers, sound helpers,
--                    stepTransfer, context dispatcher, event binding.
--   2. Actions    -- Fluids (container <-> tank), tank-to-tank, fuel pump (tanker -> vehicle
--                    gas tank), hydrant fill, drafting, gas pump -> tanker refuel, and the
--                    ISVehicleMenu.FillPartMenu hooks for target-vehicle radials.
--   3. Generator  -- Vehicle-mounted generator: hookup, refuel, start/stop, safety sweeps.
--

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
    rate_container      = 0.33,   -- container <-> tank (fill/draw a jerry can, etc.)
    rate_tank_to_tank   = 0.33,   -- vehicle-to-vehicle content transfer
    rate_fuel_dispense  = 0.02,   -- tanker -> vehicle gas tank; vanilla-equivalent (~50 ticks/L)
    rate_hydrant        = 0.33,   -- hydrant -> cistern; matches pump->tanker feel
    rate_draft          = 0.33,   -- river/lake -> cistern; matches pump->tanker feel
    rate_pump_refuel    = 0.33,   -- gas pump -> tanker
    rate_drain          = 0.33,   -- drain tank to ground (fluid discarded); 1:1 with fill rates
    -- action ceilings (ticks). Kept large; actions end when source/target hits limits.
    time_ceiling        = 6000,
    -- proximity radii (tiles)
    proximity_action    = 6,      -- how close the player must be to a station vehicle
    proximity_hydrant   = 4,      -- hydrant search around cistern
    proximity_draft     = 4,      -- water tile search around cistern
    proximity_pump      = 3,      -- pump search around tanker
    proximity_target    = 3,      -- target vehicle search around source
    -- sounds & animations (mirroring vanilla ISTakeGasolineFromPump / ISTakeGasolineFromVehicle)
    pump_sound          = "VehicleAddFuelFromGasPump",
    pump_anim           = "fill_container_tap",
    container_sound     = "GeneratorAddFuel",         -- vanilla ISAddFuel start sound
    container_anim      = "refuelgascan",          -- vanilla can-refuel animation state  -- vanilla ISRefuelFromGasPump anim state
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
    -- Measure the actual add: addFluid(Fluid object) can silently no-op on some builds when the
    -- destination is empty; measuring and subtracting the delta keeps source and dest in sync.
    local before = dstFC:getAmount()
    dstFC:addFluid(srcFC:getPrimaryFluid(), amount)
    local moved = dstFC:getAmount() - before
    if moved > 0 then
        srcFC:removeFluid(moved)
    end
    return moved
end

function VehicleFunctions.stopPumpSound(action)
    if action.character and action.pumpSound then
        action.character:stopOrTriggerSound(action.pumpSound)
        action.pumpSound = nil
    end
end

-- Container-refuel sound: prefer the vanilla can-refuel clip; fall back to the pump loop if
-- the primary id returns nil (build/mod may not ship RefuelWithCan).
function VehicleFunctions.startContainerSound(action)
    if not action.character or action.pumpSound then return end
    local snd = action.character:playSound(Config.container_sound)
    if snd == nil or snd == 0 or snd == -1 then
        snd = action.character:playSound(Config.pump_sound)
    end
    action.pumpSound = snd
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


--------------------------------------------------------------------------------
-- 2. Actions
--------------------------------------------------------------------------------

-- SCKCO VehicleFunctions actions: fluids, tank-to-tank, fuel pump, hydrant, drafting, gas pump -> tanker.
-- Depends on SC_VehicleFunctions_1_Core.lua (loaded first alphabetically).

--------------------------------------------------------------------------------
-- Fluids (any liquid)
--------------------------------------------------------------------------------
-- The tank part's installed item IS a FluidContainer (item WaterTankSC). Storage, fluid
-- identity, mixtures, whitelist/poison, save and MP sync are handled by the engine; fill/draw
-- is a container-to-container transfer. transmitPartItem carries the tank item's fluid state
-- to other clients. Options appear on the vehicle (world) and on any fluid container in an
-- inventory/trunk while near the tank.

-- Tank part id lists live on VehicleFunctions (Core file) so the Generator file can also read them.
-- Fluid transfer rate/ceiling come from Config.

local function tankContainer(item)
    return item:getFluidContainer()
end

-- Seed hook (test convenience): fill with water once on spawn.
--   part WaterTankSC { lua { create = SCKCO.Create.WaterTankFull } }
-- Test seed: run the vanilla default create (which installs the part), then fill with water once.
-- Production vehicles just use create = Vehicles.Create.Default in the template.
function SCKCO.Create.WaterTankFull(vehicle, part)
    Vehicles.Create.Default(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    if md.SCTankSeeded then return end
    md.SCTankSeeded = true
    local fc = item:getFluidContainer()
    if fc and fc:isEmpty() then
        fc:addFluid("Water", fc:getCapacity())
        if vehicle and vehicle.transmitPartItem then vehicle:transmitPartItem(part) end
    end
end

SCKCO_FluidXfer = ISBaseTimedAction:derive("SCKCO_FluidXfer")

function SCKCO_FluidXfer:getSoundRadius() return 15 end

function SCKCO_FluidXfer:start()
    -- Mirror vanilla ISAddFuel: refuelgascan animation with the container held in the primary hand.
    if self.setActionAnim then self:setActionAnim(Config.container_anim) end
    if self.setOverrideHandModels and self.target then
        local model = self.target.getStaticModel and self.target:getStaticModel() or nil
        self:setOverrideHandModels(model, nil)
    end
    VehicleFunctions.startContainerSound(self)
end

function SCKCO_FluidXfer:waitToStart()
    if self.vehicle then self.character:faceThisObject(self.vehicle) end
    return self.character:shouldBeTurning()
end

function SCKCO_FluidXfer:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_FluidXfer:isValid()
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return false end
    local tankFC = tankContainer(item)
    local itemFC = self.target and self.target:getFluidContainer()
    if not tankFC or not itemFC then return false end
    if not self.character:getInventory():contains(self.target) then return false end
    if not VehicleFunctions.near(self.character, self.vehicle) then return false end
    -- Stop as soon as the transfer has nothing left to move.
    if self.fromTank then
        if tankFC:isEmpty() or itemFC:isFull() then return false end
    else
        if itemFC:isEmpty() or tankFC:isFull() then return false end
    end
    return true
end

function SCKCO_FluidXfer:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return end
    local tankFC = tankContainer(item)
    local itemFC = self.target:getFluidContainer()
    if not tankFC or not itemFC then return end
    local moved
    if self.fromTank then
        moved = VehicleFunctions.stepTransfer(tankFC, itemFC, self, Config.rate_container)
    else
        moved = VehicleFunctions.stepTransfer(itemFC, tankFC, self, Config.rate_container)
    end
    if moved > 0 then self.vehicle:transmitPartItem(part) end
end

function SCKCO_FluidXfer:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_FluidXfer:new(character, vehicle, target, fromTank)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.target           = target
    o.fromTank         = fromTank
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onDraw(player, vehicle, item)
    ISTimedActionQueue.add(SCKCO_FluidXfer:new(player, vehicle, item, true))
end

local function onFill(player, vehicle, item)
    ISTimedActionQueue.add(SCKCO_FluidXfer:new(player, vehicle, item, false))
end

-- Fluid enabled + a valid tank container for this vehicle; returns tankFC or nil.
local function tankFor(vehicle)
    local sv = SandboxVars.SCKCO or {}
    if sv.FluidsEnabled == false then return nil end
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return nil end
    return tankContainer(item)
end

-- World menu: right-click the vehicle / nearby ground.
local function fluidsContext(context, player, vehicle)
    local tankFC = tankFor(vehicle)
    if not tankFC then return end

    if VehicleFunctions.clickedVehicle(vehicle) then
        context:addOption(string.format("Liquid tank: %.0f / %.0f L", tankFC:getAmount(), tankFC:getCapacity()), nil, nil)
    end


    if not tankFC:isEmpty() then
        local recv = VehicleFunctions.inventoryMatching(player, function(it)
            local fc = it:getFluidContainer()
            return fc ~= nil and not fc:isFull() and not fc:isInputLocked()
        end)
        if #recv > 0 then
            VehicleFunctions.addSub(context, "Fill from tank", recv, player, vehicle, onDraw)
        end
    end
    if not tankFC:isFull() then
        local give = VehicleFunctions.inventoryMatching(player, function(it)
            local fc = it:getFluidContainer()
            return fc ~= nil and not fc:isEmpty()
        end)
        if #give > 0 then
            VehicleFunctions.addSub(context, "Empty into tank", give, player, vehicle, onFill)
        end
    end
end

VehicleFunctions.register(fluidsContext)

--------------------------------------------------------------------------------
-- Drain tank to ground
--------------------------------------------------------------------------------
-- Empties a station tank onto the ground (fluid discarded). Incremental like the other pump
-- actions -- interruptible, self-terminates when the tank hits empty.

SCKCO_TankDrain = ISBaseTimedAction:derive("SCKCO_TankDrain")

function SCKCO_TankDrain:isValid()
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return false end
    local fc = item:getFluidContainer()
    if not fc or fc:isEmpty() then return false end
    return VehicleFunctions.near(self.character, self.vehicle)
end

function SCKCO_TankDrain:start()
    if self.setActionAnim then self:setActionAnim(Config.pump_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
end

function SCKCO_TankDrain:waitToStart()
    if self.vehicle then self.character:faceThisObject(self.vehicle) end
    return self.character:shouldBeTurning()
end

function SCKCO_TankDrain:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_TankDrain:update()
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isEmpty() then return end
    local amount = math.min(Config.rate_drain, fc:getAmount())
    if amount > 0 then
        fc:removeFluid(amount)
        self.vehicle:transmitPartItem(part)
    end
end

function SCKCO_TankDrain:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_TankDrain:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onDrainTank(player, vehicle)
    ISTimedActionQueue.add(SCKCO_TankDrain:new(player, vehicle))
end

local function drainContext(context, player, vehicle)
    if not VehicleFunctions.clickedVehicle(vehicle) then return end   -- vehicle-click only
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isEmpty() then return end
    context:addOption("Drain tank", player, onDrainTank, vehicle)
end

VehicleFunctions.register(drainContext)

-- Inventory/trunk menu: right-click a fluid container while near the tank (e.g. standing on
-- the trunk area with the trailer trunk open).
local function resolveItem(entry)
    if instanceof(entry, "InventoryItem") then return entry end
    if type(entry) == "table" and entry.items and entry.items[1] then return entry.items[1] end
    return nil
end

local function onInvContext(playerNum, context, items)
    local player = getSpecificPlayer(playerNum)
    if not player then return end
    local vehicle = VehicleFunctions.contextVehicle(player, {})
    if not vehicle or not VehicleFunctions.near(player, vehicle) then return end
    local tankFC = tankFor(vehicle)
    if not tankFC then return end

    for _, entry in ipairs(items) do
        local it = resolveItem(entry)
        local fc = it and it:getFluidContainer()
        if fc then
            if not fc:isEmpty() and not tankFC:isFull() then
                context:addOption("Empty into liquid tank", player, onFill, vehicle, it)
            end
            if not fc:isFull() and not fc:isInputLocked() and not tankFC:isEmpty() then
                context:addOption("Fill from liquid tank", player, onDraw, vehicle, it)
            end
            break
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(onInvContext)

--------------------------------------------------------------------------------
-- Vehicle-to-vehicle content transfer
--------------------------------------------------------------------------------
-- A tank vehicle dispenses its fluid into a nearby vehicle's tank (e.g. cistern/pump -> water
-- buffalo). Type/whitelist/fullness are enforced by the FluidContainer transfer.

local function nearestTankVehicle(source)
    local cell = getCell()
    if not cell then return nil end
    local sx, sy, sz = math.floor(source:getX()), math.floor(source:getY()), math.floor(source:getZ())
    local best, bestD
    local r = Config.proximity_target
    for dx = -r, r do
        for dy = -r, r do
            local sq = cell:getGridSquare(sx + dx, sy + dy, sz)
            local v = sq and sq:getVehicleContainer()
            if v and v ~= source then
                local tp, ti = VehicleFunctions.markerAny(v, VehicleFunctions.TANK_PARTS)
                local tfc = ti and ti:getFluidContainer()
                if tfc and not tfc:isFull() then
                    local ddx, ddy = v:getX() - source:getX(), v:getY() - source:getY()
                    local d = ddx * ddx + ddy * ddy
                    if not bestD or d < bestD then best, bestD = v, d end
                end
            end
        end
    end
    return best
end

SCKCO_TankXfer = ISBaseTimedAction:derive("SCKCO_TankXfer")

function SCKCO_TankXfer:getSoundRadius() return 15 end

function SCKCO_TankXfer:start()
    if self.setActionAnim then self:setActionAnim(Config.pump_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
end

function SCKCO_TankXfer:waitToStart()
    if self.vehicle then self.character:faceThisObject(self.vehicle) end
    return self.character:shouldBeTurning()
end

function SCKCO_TankXfer:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_TankXfer:isValid()
    local sp, si = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.TANK_PARTS)
    local tp, ti = VehicleFunctions.markerAny(self.target, VehicleFunctions.TANK_PARTS)
    if not sp or not tp then return false end
    local sfc, tfc = si:getFluidContainer(), ti:getFluidContainer()
    return sfc ~= nil and tfc ~= nil and not sfc:isEmpty() and not tfc:isFull()
        and VehicleFunctions.near(self.character, self.vehicle)
end

function SCKCO_TankXfer:update()
    VehicleFunctions.updatePumpSound(self)
    local sp, si = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.TANK_PARTS)
    local tp, ti = VehicleFunctions.markerAny(self.target, VehicleFunctions.TANK_PARTS)
    if not sp or not tp then return end
    local sfc, tfc = si:getFluidContainer(), ti:getFluidContainer()
    if VehicleFunctions.stepTransfer(sfc, tfc, self, Config.rate_tank_to_tank) > 0 then
        self.vehicle:transmitPartItem(sp)
        self.target:transmitPartItem(tp)
    end
end

function SCKCO_TankXfer:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_TankXfer:new(character, sourceVehicle, targetVehicle)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = sourceVehicle
    o.target           = targetVehicle
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onTankXfer(player, vehicle, target)
    ISTimedActionQueue.add(SCKCO_TankXfer:new(player, vehicle, target))
end

local function contentsTransferContext(context, player, vehicle)
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isEmpty() then return end
    local target = nearestTankVehicle(vehicle)
    if not target then return end
    context:addOption("Transfer contents to nearby vehicle", player, onTankXfer, vehicle, target)
end

VehicleFunctions.register(contentsTransferContext)

-- Nearest cistern-carrying vehicle within Config.proximity_target of `target`. Source must
-- hold Water; refuses Petrol/other-fluid sources so the wrong fluid can't reach a water tank.
local function nearestCisternFor(target)
    local cell = getCell()
    if not cell then return nil end
    local tx, ty, tz = math.floor(target:getX()), math.floor(target:getY()), math.floor(target:getZ())
    local best, bestD
    local r = Config.proximity_target
    for dx = -r, r do
        for dy = -r, r do
            local sq = cell:getGridSquare(tx + dx, ty + dy, tz)
            local v = sq and sq:getVehicleContainer()
            if v and v ~= target then
                local sp, si = VehicleFunctions.markerAny(v, VehicleFunctions.CISTERN_PARTS)
                local sfc = si and si:getFluidContainer()
                if sfc and not sfc:isEmpty()
                   and (sfc:isPrimaryFluidType("Water") or sfc:isPrimaryFluidType("TaintedWater")) then
                    local ddx, ddy = v:getX() - target:getX(), v:getY() - target:getY()
                    local d = ddx * ddx + ddy * ddy
                    if not bestD or d < bestD then best, bestD = v, d end
                end
            end
        end
    end
    return best
end

-- Hook ISVehicleMenu.FillPartMenu on the target vehicle to inject "Refill from cistern" when
-- the target has a water-capable tank part with room and a cistern truck is parked nearby.
-- Vanilla runs first; we add our slice/option after.
local ISVehicleMenu_FillPartMenu_forCistern = ISVehicleMenu.FillPartMenu
function ISVehicleMenu.FillPartMenu(playerIndex, context, slice, vehicle)
    ISVehicleMenu_FillPartMenu_forCistern(playerIndex, context, slice, vehicle)

    local sv = SandboxVars.SCKCO or {}
    if sv.CisternRefillEnabled == false then return end

    local playerObj = getSpecificPlayer(playerIndex)
    if not playerObj or not vehicle then return end
    if playerObj:DistToProper(vehicle) >= 4 then return end

    -- Target must have a water-capable tank part (WaterTankSC or any cistern) with room.
    local tp, ti = VehicleFunctions.markerAny(vehicle, VehicleFunctions.TANK_PARTS)
    if not tp then return end
    local tfc = ti:getFluidContainer()
    if not tfc or tfc:isFull() then return end
    -- If the target tank currently holds petrol (installed as a fuel tank), don't offer water.
    if not tfc:isEmpty() and tfc:isPrimaryFluidType("Petrol") then return end

    local cistern = nearestCisternFor(vehicle)
    if not cistern then return end

    local label = "Refill from Cistern"
    local onSelect = function(pObj, targetVeh)
        ISTimedActionQueue.add(SCKCO_TankXfer:new(pObj, cistern, targetVeh))
    end
    if slice then
        slice:addSlice(label, getTexture(Config.dispense_icon), onSelect, playerObj, vehicle)
    elseif context then
        context:addOption(label, playerObj, onSelect, vehicle)
    end
end

-- Test seeds for the new tanks (install via default, then fill once).
function SCKCO.Create.CisternFull(vehicle, part)
    Vehicles.Create.Default(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    if md.SCTankSeeded then return end
    md.SCTankSeeded = true
    local fc = item:getFluidContainer()
    if fc and fc:isEmpty() then
        fc:addFluid("Water", fc:getCapacity())
        if vehicle and vehicle.transmitPartItem then vehicle:transmitPartItem(part) end
    end
end

function SCKCO.Create.FuelTankFull(vehicle, part)
    Vehicles.Create.Default(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    if md.SCTankSeeded then return end
    md.SCTankSeeded = true
    local fc = item:getFluidContainer()
    if fc and fc:isEmpty() then
        fc:addFluid("Petrol", fc:getCapacity())
        if vehicle and vehicle.transmitPartItem then vehicle:transmitPartItem(part) end
    end
end

--------------------------------------------------------------------------------
-- Fuel pump (mobile gas station)
--------------------------------------------------------------------------------
-- A vehicle with a FuelTankSC (a FluidContainer holding petrol) can dispense into a nearby
-- vehicle's fuel tank. Filling the tanker itself uses the generic fluids station above. B42
-- vehicle fuel is a FluidContainer on the gas-tank part, so this is a container-to-container
-- transfer; a container-amount fallback covers the legacy fuel path.

-- Nearest OTHER vehicle with a gas tank, within range of the tanker.
local function nearestFuelTarget(source)
    local cell = getCell()
    if not cell then return nil end
    local sx, sy, sz = math.floor(source:getX()), math.floor(source:getY()), math.floor(source:getZ())
    local best, bestD
    local r = Config.proximity_target
    for dx = -r, r do
        for dy = -r, r do
            local sq = cell:getGridSquare(sx + dx, sy + dy, sz)
            local v = sq and sq:getVehicleContainer()
            if v and v ~= source and v:getPartById("GasTank") then
                local ddx, ddy = v:getX() - source:getX(), v:getY() - source:getY()
                local d = ddx * ddx + ddy * ddy
                if not bestD or d < bestD then best, bestD = v, d end
            end
        end
    end
    return best
end

SCKCO_FuelDispense = ISBaseTimedAction:derive("SCKCO_FuelDispense")

function SCKCO_FuelDispense:getSoundRadius() return 15 end

function SCKCO_FuelDispense:start()
    -- Mirror vanilla pump refuel; face the target so the crouch is aimed right.
    if self.setActionAnim then self:setActionAnim(Config.dispense_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
end

function SCKCO_FuelDispense:waitToStart()
    if self.target then self.character:faceThisObject(self.target) end
    return self.character:shouldBeTurning()
end

function SCKCO_FuelDispense:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

-- Locate a vehicle's fuel storage part. Falls back to any Gasoline-container part.
local function findGasTankPart(vehicle)
    if not vehicle then return nil end
    local p = vehicle:getPartById("GasTank")
    if p then return p end
    for i = 1, vehicle:getPartCount() do
        local q = vehicle:getPartByIndex(i - 1)
        if q:isContainer() and q:getContainerContentType() == "Gasoline" then return q end
    end
    return nil
end

-- Explicit-Petrol tick transfer: measure add, subtract equal from source. Skips whitelist
-- issues that VehicleFunctions.stepTransfer's addFluid(getPrimaryFluid()) hits when the destination
-- is empty (getPrimaryFluid returns nil and the add silently no-ops).
local function stepFuelDispense(srcFC, dstFC, rate)
    if not (srcFC and dstFC) then return 0 end
    if srcFC.isEmpty and srcFC:isEmpty() then return 0 end
    if dstFC.isFull and dstFC:isFull() then return 0 end
    local requested = math.min(rate, srcFC:getAmount(), dstFC:getFreeCapacity())
    if requested <= 0 then return 0 end
    local before = dstFC:getAmount()
    dstFC:addFluid("Petrol", requested)
    local moved = dstFC:getAmount() - before
    if moved > 0 then srcFC:removeFluid(moved) end
    return moved
end

function SCKCO_FuelDispense:isValid()
    if not (self.vehicle and self.target and self.character) then return false end
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.FUELTANK_PARTS)
    local fc = part and item and item:getFluidContainer()
    if not fc or fc:isEmpty() then return false end                                       -- source dry
    if not fc:isPrimaryFluidType("Petrol") then return false end                          -- wrong fluid
    local gas = findGasTankPart(self.target)
    if not gas then return false end
    if gas:getContainerContentAmount() >= gas:getContainerCapacity() then return false end -- target full
    return true
end

function SCKCO_FuelDispense:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.FUELTANK_PARTS)
    if not part then return end
    local srcFC = item:getFluidContainer()
    local gas = findGasTankPart(self.target)
    if not srcFC or not gas then return end

    -- Vanilla pump refuel writes the target vehicle's fuel via setContainerContentAmount(litres)
    -- and syncs via transmitPartModData(part) -- confirmed from ISRefuelFromGasPump. The
    -- getFluidContainer path on a vehicle gas tank part is not the storage; the container-amount
    -- accessor IS the fuel (in litres), scaled by capacity.
    local cur = gas:getContainerContentAmount()
    local cap = gas:getContainerCapacity()
    local room = cap - cur
    if room <= 0 then return end
    local requested = math.min(Config.rate_fuel_dispense, srcFC:getAmount(), room)
    if requested <= 0 then return end

    gas:setContainerContentAmount(cur + requested)
    srcFC:removeFluid(requested)
    self.target:transmitPartModData(gas)
    self.vehicle:transmitPartItem(part)
end

function SCKCO_FuelDispense:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_FuelDispense:new(character, sourceVehicle, targetVehicle)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = sourceVehicle
    o.target           = targetVehicle
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onDispense(player, vehicle, target)
    ISTimedActionQueue.add(SCKCO_FuelDispense:new(player, vehicle, target))
end

local function fuelPumpContext(context, player, vehicle)
    local sv = SandboxVars.SCKCO or {}
    if sv.FuelPumpEnabled == false then return end
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.FUELTANK_PARTS)
    if not part then return end

    local target = nearestFuelTarget(vehicle)
    if not target then return end
    local gas = findGasTankPart(target)
    if not gas then return end
    if gas:getContainerContentAmount() >= gas:getContainerCapacity() then return end   -- target full
    context:addOption("Pump from Fuel Tanker", player, onDispense, vehicle, target)
end

VehicleFunctions.register(fuelPumpContext)

-- Refuel an SCKCO generator (hooked up to another nearby vehicle) from a fuel tanker.
-- Vanilla hand-placed generators are not offered by intent.
local function nearestOurGenerator(source)
    local liveGens = VehicleFunctions.liveGens
    if not liveGens then return nil end
    local best, bestD
    local sx, sy = source:getX(), source:getY()
    local r = Config.proximity_target
    for _, e in pairs(liveGens) do
        if e.gen and e.item and e.item:getModData().SCGenHooked then
            local dx, dy = e.x - sx, e.y - sy
            local d = dx * dx + dy * dy
            if d <= r * r and (not bestD or d < bestD) then best, bestD = e, d end
        end
    end
    return best
end

SCKCO_TankerToGenerator = ISBaseTimedAction:derive("SCKCO_TankerToGenerator")

function SCKCO_TankerToGenerator:isValid()
    if not (self.vehicle and self.character and self.entry and self.entry.gen) then return false end
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.FUELTANK_PARTS)
    local fc = part and item and item:getFluidContainer()
    if not fc or fc:isEmpty() or not fc:isPrimaryFluidType("Petrol") then return false end
    if self.entry.gen:getFuel() >= 100 then return false end
    return VehicleFunctions.near(self.character, self.vehicle)
end

function SCKCO_TankerToGenerator:start()
    if self.setActionAnim then self:setActionAnim(Config.pump_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
end

function SCKCO_TankerToGenerator:waitToStart()
    if self.vehicle then self.character:faceThisObject(self.vehicle) end
    return self.character:shouldBeTurning()
end

function SCKCO_TankerToGenerator:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_TankerToGenerator:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.FUELTANK_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    local gen = self.entry and self.entry.gen
    if not fc or not gen then return end
    local curFuel = gen:getFuel()
    local room = 100 - curFuel
    if room <= 0 then return end
    -- Generator fuel is a 0-100 %; treat 1 unit = 1 L for parity with pump refuel.
    local requested = math.min(Config.rate_pump_refuel, fc:getAmount(), room)
    if requested <= 0 then return end
    fc:removeFluid(requested)
    gen:setFuel(curFuel + requested)
    -- mirror into modData so our persistent state matches, and sync the tanker part
    if self.entry.item then self.entry.item:getModData().SCGenFuel = gen:getFuel() end
    self.vehicle:transmitPartItem(part)
end

function SCKCO_TankerToGenerator:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_TankerToGenerator:new(character, vehicle, entry)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.entry            = entry
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onTankerToGen(player, vehicle, entry)
    ISTimedActionQueue.add(SCKCO_TankerToGenerator:new(player, vehicle, entry))
end

local function tankerToGenContext(context, player, vehicle)
    local sv = SandboxVars.SCKCO or {}
    if sv.FuelPumpEnabled == false then return end
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.FUELTANK_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isEmpty() or not fc:isPrimaryFluidType("Petrol") then return end
    local entry = nearestOurGenerator(vehicle)
    if not entry then return end
    if entry.gen:getFuel() >= 100 then return end
    context:addOption("Refuel generator from tanker", player, onTankerToGen, vehicle, entry)
end

VehicleFunctions.register(tankerToGenContext)

--------------------------------------------------------------------------------
-- Hydrant tap (firetruck cistern)
--------------------------------------------------------------------------------
-- A vehicle with a CisternSC parked next to a fire hydrant (tile street_decoration_01_12) can
-- be filled with water, provided the player holds a wrench and the city mains are still on.
-- Hydrants are decorative in vanilla, so this is a custom water source.
local HYDRANT_SPRITE = "street_decoration_01_12"

-- FLAG: no direct isWaterOn() exists; prefer it if the build exposes it, else fall back to the
-- sandbox water-shutoff day vs world age (approximate). Verify this against your build.
-- Vanilla-like square power check with graceful fallback.
--   A) real per-square getter when exposed (haveElectricity/hasElectricity),
--   B) mains-on proxy (grid still on) as world-clock fallback,
--   C) an active SCKCO generator whose anchor square is within vanilla generator range of sq
--      (20 tiles horiz, +/-3 z). Any hit powers the square.
local function genElectricityOn()
    local w = getWorld()
    if w and w.isElectricityOn then return w:isElectricityOn() end
    local shut = SandboxVars and SandboxVars.ElecShutModifier
    if shut == nil then return true end
    if shut < 0 then return false end
    return (getGameTime():getWorldAgeHours() / 24.0) < shut
end

local function squarePoweredByOurGenerator(sq)
    local liveGens = VehicleFunctions.liveGens
    if not sq or not liveGens then return false end
    local sx, sy, sz = sq:getX(), sq:getY(), sq:getZ()
    for _, e in pairs(liveGens) do
        if e.gen and e.item and e.item:getModData().SCGenOn and math.abs(sz - e.z) <= 3 then
            local dx, dy = sx - e.x, sy - e.y
            if dx * dx + dy * dy <= 400 then return true end   -- 20-tile radius, same as vanilla
        end
    end
    return false
end

-- Object-level power (vanilla IsoObject.hasGridPower) is the authoritative check that
-- matches the tile report's "Fuel Pump has No Power" line. Square-level and world-clock
-- proxies are kept as fallbacks; the SCKCO-generator override still applies for post-shutoff.
local function objectPowered(o, sq)
    if o and o.hasGridPower and o:hasGridPower() then return true end
    if sq and sq.haveElectricity and sq:haveElectricity() then return true end
    if sq and sq.hasElectricity  and sq:hasElectricity()  then return true end
    if genElectricityOn() then return true end
    return squarePoweredByOurGenerator(sq)
end

-- Retained for callers that only have a square (no object). Same layered logic.
local function squarePowered(sq)
    return objectPowered(nil, sq)
end

local function mainsWaterOn()
    local w = getWorld()
    if w and w.isWaterOn then return w:isWaterOn() end
    local shut = SandboxVars and SandboxVars.WaterShutModifier
    if shut == nil then return true end
    if shut < 0 then return false end
    return (getGameTime():getWorldAgeHours() / 24.0) < shut
end

local function hydrantNear(vehicle)
    local cell = getCell()
    if not cell then return false end
    local vx, vy, vz = math.floor(vehicle:getX()), math.floor(vehicle:getY()), math.floor(vehicle:getZ())
    for dx = -Config.proximity_hydrant, Config.proximity_hydrant do
        for dy = -Config.proximity_hydrant, Config.proximity_hydrant do
            local sq = cell:getGridSquare(vx + dx, vy + dy, vz)
            if sq then
                local objs = sq:getObjects()
                for i = 0, objs:size() - 1 do
                    local o = objs:get(i)
                    local spr = o:getSprite()
                    if spr and spr:getName() == HYDRANT_SPRITE then return true end
                end
            end
        end
    end
    return false
end

-- Wrench detection across main inventory + worn bags. The container/item tag methods are not
-- reliably exposed in this build, so match known full types first (covers vanilla) and try the
-- tag paths for modded wrenches.
local WRENCH_TYPES = {
    ["Base.Wrench"] = true,
    ["Base.PipeWrench"] = true,
    ["Base.LugWrench"] = true,
}

-- Tag methods (hasTag/containsTag/getTags) all throw or return nil in this build, so match by
-- full type only. Add modded wrench types here as needed.
-- TODO: broaden this to resolve the Wrench tag generically (e.g. a getScriptManager
-- tag->items lookup built once at load) so modded wrenches are covered without a hardcoded list.
local function isWrench(it)
    return WRENCH_TYPES[it:getFullType()] == true
end

local function hasWrench(player)
    local containers = ISInventoryPaneContextMenu.getContainers(player)
    if not containers then return false end
    for c = 0, containers:size() - 1 do
        local items = containers:get(c):getItems()
        for i = 0, items:size() - 1 do
            if isWrench(items:get(i)) then return true end
        end
    end
    return false
end

SCKCO_HydrantFill = ISBaseTimedAction:derive("SCKCO_HydrantFill")

function SCKCO_HydrantFill:getSoundRadius() return 15 end

function SCKCO_HydrantFill:start()
    if self.setActionAnim then self:setActionAnim(Config.pump_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
end

function SCKCO_HydrantFill:waitToStart()
    if self.vehicle then self.character:faceThisObject(self.vehicle) end
    return self.character:shouldBeTurning()
end

function SCKCO_HydrantFill:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_HydrantFill:isValid()
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.CISTERN_PARTS)
    if not part then return false end
    local fc = item:getFluidContainer()
    return fc ~= nil and not fc:isFull()
        and VehicleFunctions.near(self.character, self.vehicle)
        and hydrantNear(self.vehicle) and mainsWaterOn() and hasWrench(self.character)
end

function SCKCO_HydrantFill:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.CISTERN_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isFull() then return end
    local amount = math.min(Config.rate_hydrant, fc:getFreeCapacity())
    if amount > 0 then
        fc:addFluid("TaintedWater", amount)
        self.vehicle:transmitPartItem(part)
    end
end

function SCKCO_HydrantFill:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_HydrantFill:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onHydrantFill(player, vehicle)
    ISTimedActionQueue.add(SCKCO_HydrantFill:new(player, vehicle))
end

local function disabledOption(context, label, reason)
    local opt = context:addOption(label, nil, nil)
    opt.notAvailable = true
    local tt = ISWorldObjectContextMenu.addToolTip()
    tt.description = reason
    opt.toolTip = tt
end

local function hydrantContext(context, player, vehicle)
    local sv = SandboxVars.SCKCO or {}
    if sv.HydrantEnabled == false then return end
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.CISTERN_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isFull() then return end
    if not hydrantNear(vehicle) then return end

    if not mainsWaterOn() then
        disabledOption(context, "Fill cistern from hydrant", "The hydrant is dry -- city water has been shut off.")
    elseif not hasWrench(player) then
        disabledOption(context, "Fill cistern from hydrant", "Requires a wrench to open the hydrant.")
    else
        context:addOption("Fill cistern from hydrant", player, onHydrantFill, vehicle)
    end
end

VehicleFunctions.register(hydrantContext)

--------------------------------------------------------------------------------
-- Drafting (pull from rivers / lakes)
--------------------------------------------------------------------------------
-- A cistern pumper parked next to open water (a water tile) can draft water into its cistern.
-- River/lake water is tainted. No wrench or mains needed -- open source, always available.

-- Water tile detection without enum-arg calls. Tries several accessors the build may expose,
-- so whichever is present will resolve: IsoWaterGeometry on the square, IsoRoom water flags,
-- IsoWater in the object list, or an IsoWorld.MetaGrid river lookup as a last resort.
local function isWaterSquare(sq)
    if not sq then return false end
    if sq.getWater and sq:getWater() then return true end
    if sq.hasWater and sq:hasWater() then return true end
    if sq.HasWater and sq:HasWater() then return true end
    if sq.getWaterGeometry and sq:getWaterGeometry() then return true end
    local objs = sq:getObjects()
    for i = 0, objs:size() - 1 do
        local o = objs:get(i)
        if instanceof(o, "IsoWater") then return true end
    end
    local w = getWorld()
    local mg = w and w.getMetaGrid and w:getMetaGrid()
    if mg and mg.isValidSquare and mg:isValidSquare(sq:getX(), sq:getY()) then
        if mg.isWaterFast and mg:isWaterFast(sq:getX(), sq:getY()) then return true end
        if mg.isWater and mg:isWater(sq:getX(), sq:getY()) then return true end
    end
    return false
end

local function waterSourceNear(vehicle)
    local cell = getCell()
    if not cell then return false end
    local vx, vy, vz = math.floor(vehicle:getX()), math.floor(vehicle:getY()), math.floor(vehicle:getZ())
    for dx = -Config.proximity_draft, Config.proximity_draft do
        for dy = -Config.proximity_draft, Config.proximity_draft do
            if isWaterSquare(cell:getGridSquare(vx + dx, vy + dy, vz)) then return true end
        end
    end
    return false
end

SCKCO_Draft = ISBaseTimedAction:derive("SCKCO_Draft")

function SCKCO_Draft:getSoundRadius() return 15 end

function SCKCO_Draft:start()
    if self.setActionAnim then self:setActionAnim(Config.pump_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
end

function SCKCO_Draft:waitToStart()
    if self.vehicle then self.character:faceThisObject(self.vehicle) end
    return self.character:shouldBeTurning()
end

function SCKCO_Draft:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_Draft:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.CISTERN_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isFull() then return end
    local amount = math.min(Config.rate_draft, fc:getFreeCapacity())
    if amount > 0 then
        fc:addFluid("TaintedWater", amount)
        self.vehicle:transmitPartItem(part)
    end
end

function SCKCO_Draft:isValid()
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.CISTERN_PARTS)
    if not part then return false end
    local fc = item:getFluidContainer()
    return fc ~= nil and not fc:isFull()
        and VehicleFunctions.near(self.character, self.vehicle) and waterSourceNear(self.vehicle)
end

function SCKCO_Draft:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_Draft:new(character, vehicle)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onDraft(player, vehicle)
    ISTimedActionQueue.add(SCKCO_Draft:new(player, vehicle))
end

local function draftContext(context, player, vehicle)
    local sv = SandboxVars.SCKCO or {}
    if sv.DraftEnabled == false then return end
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.CISTERN_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isFull() then return end
    if not waterSourceNear(vehicle) then return end
    if hydrantNear(vehicle) then return end   -- prefer tapping the hydrant over drafting when both are in range
    context:addOption("Draft water from source", player, onDraft, vehicle)
end

VehicleFunctions.register(draftContext)

--------------------------------------------------------------------------------
-- Gas pump -> fuel tanker
--------------------------------------------------------------------------------
-- Vanilla only refuels a vehicle GasTank at a pump, so a FuelTankSC tanker is skipped. A pump
-- is an IsoObject holding a fuel container (contentType Gasoline). Detection scans nearby
-- squares for an object with a Gasoline container; the pump square must also be powered.

-- Vanilla pump fuel is read via getPipedFuelAmount() (integer units); this is what the tile
-- report shows as "Fuel Pump Amount Remaining". Returns amount (number) or nil if unavailable.
local function pumpAmount(o)
    if o and o.getPipedFuelAmount then return o:getPipedFuelAmount() end
    return nil
end

-- Pump detection by sprite name: the IsoObject container/power getters aren't exposed here
-- (same overload family that has broken every enum-arg call in this build), but sprite name is
-- reliable and matches the pattern used for hydrant detection. Fuel/power gating is left to
-- the timed action -- transferring fuel out is attempted with a nil-guarded amount write.
local PUMP_SPRITE_PREFIXES = { "location_shop_fossoil_", "location_shop_gas2go_", "location_shop_gas_" }

local function isPumpSprite(name)
    if not name then return false end
    for i = 1, #PUMP_SPRITE_PREFIXES do
        if name:find(PUMP_SPRITE_PREFIXES[i], 1, true) == 1 then return true end
    end
    return false
end

local function isPumpObject(o)
    local spr = o and o:getSprite()
    return spr ~= nil and isPumpSprite(spr:getName())
end

-- Nearest working pump within 3 tiles. A dry or unpowered neighbor doesn't block a live one
-- (each nozzle is independent, matching how vanilla treats pumps).
local function nearestPump(vehicle)
    local cell = getCell()
    if not cell then return nil end
    local vx, vy, vz = math.floor(vehicle:getX()), math.floor(vehicle:getY()), math.floor(vehicle:getZ())
    local best, bestD
    local r = Config.proximity_pump
    for dx = -r, r do
        for dy = -r, r do
            local sq = cell:getGridSquare(vx + dx, vy + dy, vz)
            if sq then
                local objs = sq:getObjects()
                for i = 0, objs:size() - 1 do
                    local o = objs:get(i)
                    if isPumpObject(o) and objectPowered(o, sq) then
                        local a = pumpAmount(o)
                        if a ~= nil and a > 0 then
                            local d = dx * dx + dy * dy
                            if not bestD or d < bestD then best, bestD = o, d end
                        end
                    end
                end
            end
        end
    end
    return best
end

SCKCO_PumpToTanker = ISBaseTimedAction:derive("SCKCO_PumpToTanker")

function SCKCO_PumpToTanker:getSoundRadius() return 15 end

function SCKCO_PumpToTanker:start()
    -- Mirroring vanilla ISRefuelFromGasPump: setActionAnim + setOverrideHandModels + playSound.
    if self.setActionAnim then self:setActionAnim(Config.pump_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
end

function SCKCO_PumpToTanker:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_PumpToTanker:isValid()
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.FUELTANK_PARTS)
    if not part then return false end
    local dstFC = item:getFluidContainer()
    if not dstFC or dstFC:isFull() then return false end
    -- Same-fluid guard: refuse if the tanker is holding anything but petrol.
    if not dstFC:isEmpty() and not dstFC:isPrimaryFluidType("Petrol") then return false end
    local amt = pumpAmount(self.pump)
    return self.pump ~= nil and isPumpObject(self.pump)
        and objectPowered(self.pump, self.pump:getSquare())
        and amt ~= nil and amt > 0
        and VehicleFunctions.near(self.character, self.vehicle)
end

function SCKCO_PumpToTanker:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, VehicleFunctions.FUELTANK_PARTS)
    if not part then return end
    local dstFC = item:getFluidContainer()
    if not dstFC or dstFC:isFull() then return end
    local pumpAmt = pumpAmount(self.pump)
    if pumpAmt == nil or pumpAmt <= 0 then return end
    local requested = math.min(Config.rate_pump_refuel, dstFC:getFreeCapacity(), pumpAmt)
    if requested <= 0 then return end
    -- Explicit add + drain: works with an empty target container and stays consistent with the
    -- other station transfers. transferFluidTo may no-op when the target has no primary fluid.
    local before = dstFC:getAmount()
    dstFC:addFluid("Petrol", requested)
    local delta = dstFC:getAmount() - before
    if delta > 0 and self.pump.setPipedFuelAmount then
        self.pump:setPipedFuelAmount(math.max(0, math.floor(pumpAmt - delta)))
    end
    self.vehicle:transmitPartItem(part)
end

function SCKCO_PumpToTanker:perform()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_PumpToTanker:waitToStart()
    if self.pump then self.character:faceThisObject(self.pump) end
    return self.character:shouldBeTurning()
end

function SCKCO_PumpToTanker:new(character, vehicle, pump)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.pump             = pump
    o.maxTime          = Config.time_ceiling
    o.forceProgressBar = true
    return o
end

local function onPumpToTanker(player, vehicle, pump)
    ISTimedActionQueue.add(SCKCO_PumpToTanker:new(player, vehicle, pump))
end

-- Pump directly under the cursor if the player clicked a pump sprite, else nil.
local function clickedPump()
    local wobjs = VehicleFunctions.currentWorldObjects
    if not wobjs then return nil end
    for _, o in ipairs(wobjs) do
        if isPumpObject(o) then return o end
    end
    return nil
end

local function pumpToTankerContext(context, player, vehicle)
    local sv = SandboxVars.SCKCO or {}
    if sv.PumpRefuelEnabled == false then return end
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.FUELTANK_PARTS)
    if not part then return end
    local dstFC = item:getFluidContainer()
    if not dstFC or dstFC:isFull() then return end

    -- If the click was on a pump, gate strictly on THAT pump. Otherwise (click on the tanker
    -- or empty ground) fall through to the nearest live pump.
    local pump = clickedPump()
    if pump then
        if not objectPowered(pump, pump:getSquare()) then return end
        local a = pumpAmount(pump)
        if a == nil or a <= 0 then return end
    else
        pump = nearestPump(vehicle)
        if not pump then return end
    end

    -- Show the amount only when the player clicked a pump directly; the fallback (nearest live
    -- pump) omits the number to avoid presenting a figure that doesn't match the tile-report on
    -- the pump the player is actually looking at.
    local label = "Refuel tanker from gas pump"
    if clickedPump() then
        label = string.format("%s (%d L available)", label, math.floor(pumpAmount(pump) or 0))
    end
    context:addOption(label, player, onPumpToTanker, vehicle, pump)
end

VehicleFunctions.register(pumpToTankerContext)


--------------------------------------------------------------------------------
-- 3. Generator
--------------------------------------------------------------------------------

-- SCKCO Vehicle generator: hookup phase, refuel, start/stop, safety sweeps.
-- Depends on SC_VehicleFunctions_1_Core.lua (loaded first alphabetically).

--------------------------------------------------------------------------------
-- Generator (power)
--------------------------------------------------------------------------------
-- Power flows through the engine grid, so while hooked up we anchor a real (sprite-hidden)
-- IsoGenerator at the vehicle's square and let vanilla distribute power and drain fuel. Two
-- phases mirror vanilla: HOOK UP (connect) is a knowledge-gated timed action; START/STOP just
-- toggles activation. State (hooked, on, fuel 0-100) lives in the part-item modData and syncs
-- via transmitPartItem. The generator only powers a building/radius when parked in or beside
-- one -- same as a hand-placed generator.

local GEN_PART = "GeneratorSC"
local GEN_ITEM = "Base.Generator"
VehicleFunctions.liveGens = VehicleFunctions.liveGens or {}
local liveGens = VehicleFunctions.liveGens  -- shared; Actions section reads this too

local function vehSquare(vehicle)
    local cell = getCell()
    if not cell then return nil end
    return cell:getGridSquare(math.floor(vehicle:getX()), math.floor(vehicle:getY()), math.floor(vehicle:getZ()))
end

local function genFuel(item)
    return VehicleFunctions.get(item, "SCGenFuel", 0)
end

local function setGenFuel(vehicle, part, item, v)
    if v < 0 then v = 0 elseif v > 100 then v = 100 end
    VehicleFunctions.set(vehicle, part, item, "SCGenFuel", v)
end

-- Same gate as vanilla: the "Generator" recipe (How to Use Generators magazine, or granted by
-- Electrical 3 / Electrician / Engineer).
local function knowsGenerator(player)
    local known = player:getKnownRecipes()
    return known ~= nil and known:contains("Generator")
end

-- Hide the generator: null its sprite (render is null-guarded) and refresh the square. The
-- object stays on the square so it still powers; reasserted each tick in case state changes
-- restore a sprite.
local function hideGen(gen)
    if gen:getSprite() ~= nil then
        gen:setSprite(nil)
        local sq = gen:getSquare()
        if sq then sq:RecalcAllWithNeighbours(true) end
    end
end

-- Build or adopt the generator at the vehicle square, configured from modData state.
-- Entry carries part/item so the sweep can clear state without re-resolving.
local function spawnGen(vehicle, part, item)
    local sq = vehSquare(vehicle)
    if not sq then return nil end
    local gen = sq:getGenerator()
    if not gen then
        local gitem = instanceItem(GEN_ITEM)
        if not gitem then return nil end
        gen = IsoGenerator.new(gitem, sq:getCell(), sq)
        gen:addToWorld()
    end
    local md = item:getModData()
    gen:setCondition(part:getCondition())
    gen:setFuel(genFuel(item))
    gen:setConnected(md.SCGenHooked == true)
    gen:setActivated(md.SCGenOn == true)
    gen:setSurroundingElectricity()
    hideGen(gen)
    gen:getModData().SCKCOGen = true
    liveGens[vehicle] = { gen = gen, part = part, item = item, x = sq:getX(), y = sq:getY(), z = sq:getZ() }
    return gen
end

-- Deactivate (drops power), then remove from the world.
local function killGen(gen)
    gen:setActivated(false)
    gen:setConnected(false)
    gen:setSurroundingElectricity()
    gen:remove()
end

-- Clear all generator state on the part item (forces a fresh hook-up).
local function clearGenState(vehicle, part, item)
    local md = item:getModData()
    md.SCGenHooked = false
    md.SCGenOn = false
    if vehicle and vehicle.transmitPartItem then vehicle:transmitPartItem(part) end
end

local function teardownGen(vehicle, part, item)
    local e = liveGens[vehicle]
    if e and e.gen then
        item:getModData().SCGenFuel = e.gen:getFuel()
        killGen(e.gen)
    end
    liveGens[vehicle] = nil
end

-- Phase 1: hook up (connect). Creates the connected-but-off generator.
local function hookupGen(player, vehicle)
    local part, item = VehicleFunctions.marker(vehicle, GEN_PART)
    if not part then return end
    item:getModData().SCGenHooked = true
    spawnGen(vehicle, part, item)
    vehicle:transmitPartItem(part)
end

local function disconnectGen(player, vehicle)
    local part, item = VehicleFunctions.marker(vehicle, GEN_PART)
    if not part then return end
    teardownGen(vehicle, part, item)
    clearGenState(vehicle, part, item)
end

-- Phase 2: start / stop (activation only; requires being hooked up).
local function startGen(player, vehicle)
    local part, item = VehicleFunctions.marker(vehicle, GEN_PART)
    if not part then return end
    local md = item:getModData()
    if not md.SCGenHooked or genFuel(item) <= 0 then return end
    md.SCGenOn = true
    local e = liveGens[vehicle]
    if e and e.gen then
        e.gen:setActivated(true)
        e.gen:setSurroundingElectricity()
    else
        spawnGen(vehicle, part, item)
    end
    vehicle:transmitPartItem(part)
end

local function stopGen(player, vehicle)
    local part, item = VehicleFunctions.marker(vehicle, GEN_PART)
    if not part then return end
    item:getModData().SCGenOn = false
    local e = liveGens[vehicle]
    if e and e.gen then
        e.gen:setActivated(false)
        e.gen:setSurroundingElectricity()
    end
    vehicle:transmitPartItem(part)
end

local function refuelGen(player, vehicle, petrolItem)
    local part, item = VehicleFunctions.marker(vehicle, GEN_PART)
    if not part then return end
    local fc = petrolItem:getFluidContainer()
    if not fc or not fc:isPrimaryFluidType("Petrol") then return end
    local amount = math.min(fc:getPrimaryFluidAmount(), 100 - genFuel(item))
    if amount <= 0 then return end
    fc:removeFluid(amount)
    setGenFuel(vehicle, part, item, genFuel(item) + amount)
    local e = liveGens[vehicle]
    if e and e.gen then e.gen:setFuel(genFuel(item)) end
end

SCKCO_GenAction = ISBaseTimedAction:derive("SCKCO_GenAction")

function SCKCO_GenAction:isValid()
    if self.kind == "hookup" and not knowsGenerator(self.character) then return false end
    return VehicleFunctions.marker(self.vehicle, GEN_PART) ~= nil
        and VehicleFunctions.near(self.character, self.vehicle)
        and (self.kind ~= "refuel" or self.character:getInventory():contains(self.target))
end

function SCKCO_GenAction:start()
    -- Only the hand-refuel branch: mirror vanilla ISAddFuel (refuelgascan anim + RefuelWithCan
    -- sound + petrol container held in primary hand). Other kinds (hookup/disconnect/start/stop)
    -- have no can involved, so they don't get the animation.
    if self.kind ~= "refuel" then return end
    if self.setActionAnim then self:setActionAnim(Config.container_anim) end
    if self.setOverrideHandModels and self.target then
        local model = self.target.getStaticModel and self.target:getStaticModel() or nil
        self:setOverrideHandModels(model, nil)
    end
    VehicleFunctions.startContainerSound(self)
end

function SCKCO_GenAction:stop()
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.stop(self)
end

function SCKCO_GenAction:update() end

function SCKCO_GenAction:perform()
    if self.kind == "hookup" then
        hookupGen(self.character, self.vehicle)
    elseif self.kind == "disconnect" then
        disconnectGen(self.character, self.vehicle)
    elseif self.kind == "start" then
        startGen(self.character, self.vehicle)
    elseif self.kind == "stop" then
        stopGen(self.character, self.vehicle)
    elseif self.kind == "refuel" then
        refuelGen(self.character, self.vehicle, self.target)
    end
    VehicleFunctions.stopPumpSound(self)
    ISBaseTimedAction.perform(self)
end

function SCKCO_GenAction:new(character, vehicle, kind, target)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.kind             = kind
    o.target           = target
    o.maxTime          = ({ hookup = 300, disconnect = 200, refuel = 200 })[kind] or 100
    o.forceProgressBar = true
    return o
end

local function q(kind)
    return function(player, vehicle, target)
        ISTimedActionQueue.add(SCKCO_GenAction:new(player, vehicle, kind, target))
    end
end
local qHookup, qDisconnect, qStart, qStop, qRefuel = q("hookup"), q("disconnect"), q("start"), q("stop"), q("refuel")

-- Test seed: vanilla default create (installs the part), then full fuel once. Production
-- vehicles just use create = Vehicles.Create.Default in the template.
function SCKCO.Create.GeneratorFuelFull(vehicle, part)
    Vehicles.Create.Default(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    if md.SCGenSeeded then return end
    md.SCGenSeeded = true
    md.SCGenFuel = 100
    if vehicle and vehicle.transmitPartItem then vehicle:transmitPartItem(part) end
end

local function generatorContext(context, player, vehicle)
    local sv = SandboxVars.SCKCO or {}
    if sv.GeneratorEnabled == false then return end
    local part, item = VehicleFunctions.marker(vehicle, GEN_PART)
    if not part then return end
    local md = item:getModData()
    local hooked = md.SCGenHooked == true
    local on = md.SCGenOn == true
    local e = liveGens[vehicle]
    local fuel = (e and e.gen and e.gen:getFuel()) or genFuel(item)
    local cond = (e and e.gen and e.gen:getCondition()) or md.SCGenCondition or part:getCondition()

    local status = (not hooked) and "not hooked up" or (on and "running" or "hooked up, off")
    context:addOption(string.format("Generator: %s  (condition %d%%, fuel %d%%)", status, math.floor(cond), math.floor(fuel)), nil, nil)

    if not hooked then
        if knowsGenerator(player) then
            context:addOption("Hook up generator", player, qHookup, vehicle)
        else
            local opt = context:addOption("Hook up generator", nil, nil)
            opt.notAvailable = true
            local tt = ISWorldObjectContextMenu.addToolTip()
            tt.description = "You don't know how to hook up a generator."
            opt.toolTip = tt
        end
    else
        if on then
            context:addOption("Stop generator", player, qStop, vehicle)
        elseif fuel > 0 then
            context:addOption("Start generator", player, qStart, vehicle)
        end
        context:addOption("Disconnect generator", player, qDisconnect, vehicle)
    end

    if fuel < 100 then
        local cans = VehicleFunctions.inventoryMatching(player, function(it)
            local fc = it:getFluidContainer()
            return fc ~= nil and fc:isPrimaryFluidType("Petrol") and fc:getPrimaryFluidAmount() > 0
        end)
        if #cans > 0 then
            VehicleFunctions.addSub(context, "Add petrol to generator", cans, player, vehicle, qRefuel)
        end
    end
end

VehicleFunctions.register(generatorContext)

-- Lifecycle manager. The part update hook is unreliable for a parked, unoccupied trailer, so
-- all maintenance runs here off OnTick (throttled). For each live generator: if the vehicle has
-- left the anchor square (moved or removed) -> disconnect (kill + clear state, forcing a fresh
-- hook-up); otherwise keep it hidden, mirror fuel/condition, and switch off if it ran dry.
local sweepTick = 0
Events.OnTick.Add(function()
    sweepTick = sweepTick + 1
    if sweepTick < 15 then return end
    sweepTick = 0
    local cell = getCell()
    if not cell then return end
    for vehicle, e in pairs(liveGens) do
        local asq = cell:getGridSquare(e.x, e.y, e.z)
        if not asq then
            liveGens[vehicle] = nil                       -- unloaded; re-adopted on square load
        elseif asq:getVehicleContainer() ~= vehicle then
            if e.gen then
                e.item:getModData().SCGenFuel = e.gen:getFuel()
                killGen(e.gen)
            end
            clearGenState(vehicle, e.part, e.item)         -- moved/removed -> disconnect
            liveGens[vehicle] = nil
        elseif e.gen then
            hideGen(e.gen)
            local md = e.item:getModData()
            md.SCGenFuel = e.gen:getFuel()
            md.SCGenCondition = e.gen:getCondition()
            if md.SCGenOn and (md.SCGenFuel <= 0 or not e.gen:isActivated()) then
                md.SCGenOn = false
                e.gen:setActivated(false)
                e.gen:setSurroundingElectricity()
                if vehicle.transmitPartItem then vehicle:transmitPartItem(e.part) end
            end
        end
    end
end)

-- Re-adopt (or clean) generators as their square loads. A marked generator with a hooked-up
-- vehicle on the square is re-hidden and re-registered; otherwise it is an orphan and removed.
Events.LoadGridsquare.Add(function(square)
    if not square then return end
    local gen = square:getGenerator()
    if not (gen and gen:getModData().SCKCOGen) then return end
    local vehicle = square:getVehicleContainer()
    local part = vehicle and vehicle:getPartById(GEN_PART)
    local item = part and part:getInventoryItem()
    if item and item:getModData().SCGenHooked then
        hideGen(gen)
        liveGens[vehicle] = { gen = gen, part = part, item = item, x = square:getX(), y = square:getY(), z = square:getZ() }
    else
        killGen(gen)
    end
end)


--------------------------------------------------------------------------------
-- Vehicle radial: "Refuel from tanker" (mirrors vanilla "Refuel from Gas Pump")
--------------------------------------------------------------------------------
-- Hook ISVehicleMenu.FillPartMenu, which is called for the target vehicle from both the
-- outside radial (with slice) and the world context menu (with context). We inject a slice /
-- option targeting a nearby fuel tanker, following the exact vanilla pump-refuel pattern.

local function nearestTankerFor(target)
    local cell = getCell()
    if not cell then return nil end
    local tx, ty, tz = math.floor(target:getX()), math.floor(target:getY()), math.floor(target:getZ())
    local best, bestD
    local r = Config.proximity_target
    for dx = -r, r do
        for dy = -r, r do
            local sq = cell:getGridSquare(tx + dx, ty + dy, tz)
            local v = sq and sq:getVehicleContainer()
            if v and v ~= target then
                local part, item = VehicleFunctions.markerAny(v, VehicleFunctions.FUELTANK_PARTS)
                local fc = item and item:getFluidContainer()
                if fc and not fc:isEmpty() and fc:isPrimaryFluidType("Petrol") then
                    local ddx, ddy = v:getX() - target:getX(), v:getY() - target:getY()
                    local d = ddx * ddx + ddy * ddy
                    if not bestD or d < bestD then best, bestD = v, d end
                end
            end
        end
    end
    return best
end

local ISVehicleMenu_FillPartMenu = ISVehicleMenu.FillPartMenu
function ISVehicleMenu.FillPartMenu(playerIndex, context, slice, vehicle)
    -- run vanilla first so their pump option (if any) still appears alongside ours
    ISVehicleMenu_FillPartMenu(playerIndex, context, slice, vehicle)

    local sv = SandboxVars.SCKCO or {}
    if sv.FuelPumpEnabled == false then return end

    local playerObj = getSpecificPlayer(playerIndex)
    if not playerObj or not vehicle then return end
    if playerObj:DistToProper(vehicle) >= 4 then return end

    -- target must have a gas tank part with room
    local gas
    for i = 1, vehicle:getPartCount() do
        local part = vehicle:getPartByIndex(i - 1)
        if part:isContainer() and part:getContainerContentType() == "Gasoline"
           and part:getContainerContentAmount() < part:getContainerCapacity() then
            gas = part; break
        end
    end
    if not gas then return end

    if gas:getContainerContentAmount() >= gas:getContainerCapacity() then return end   -- target full
    local tanker = nearestTankerFor(vehicle)
    if not tanker then return end

    local label = "Pump from Fuel Tanker"
    local onSelect = function(pObj, targetVeh)
        ISTimedActionQueue.add(SCKCO_FuelDispense:new(pObj, tanker, targetVeh))
    end
    if slice then
        slice:addSlice(label, getTexture(Config.dispense_icon), onSelect, playerObj, vehicle)
    elseif context then
        context:addOption(label, playerObj, onSelect, vehicle)
    end
end
