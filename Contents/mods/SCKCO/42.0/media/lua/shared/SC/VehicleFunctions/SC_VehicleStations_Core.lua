--
-- SC_VehicleStations_Core.lua
-- Shark and Cytt's Kentucky Car Overhaul -- vehicle-mounted stations, shared half
--
-- Loaded on client and server. Holds what the server needs to exist: the Config, the marker and
-- state helpers, the vehicle create hooks named in the vehicle scripts, and the timed actions
-- that have been converted to the B42 server-authoritative pattern. Context menus and the
-- not-yet-converted actions stay in client/SC/VehicleFunctions/SC_VehicleStations.lua.
--
-- Converted action pattern (mirrors vanilla ISAddFluidFromItemAction):
--   new()       snapshots the start amount and the total to move; the server rebuilds the action
--               from new()'s arguments, so they must be engine objects or primitives, never tables
--   update()    SP only (not isClient): moves fluid toward jobDelta * total
--   serverStart emulateAnimEvent drives animEvent on the server, which moves fluid toward
--               netAction:getProgress() * total; an interrupted action keeps what already moved
--   complete()  moves whatever is left (server in MP, local in SP)
--
require "TimedActions/ISBaseTimedAction"

SCKCO          = SCKCO or {}
SCKCO.Create   = SCKCO.Create or {}
SCKCO.Update   = SCKCO.Update or {}
SCKCO.VehicleFunctions = SCKCO.VehicleFunctions or {}

local VehicleFunctions = SCKCO.VehicleFunctions

--------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------
-- Rates are litres per update tick (calibrated so a full 2000 L transfer takes about a minute of
-- real time). Converted actions derive their duration from rate; unconverted ones still use
-- time_ceiling and stop on empty/full.
SCKCO.VehicleFunctions.Config = SCKCO.VehicleFunctions.Config or {
    -- transfer rates (litres per tick)
    rate_container      = 0.33,   -- container <-> tank (fill/draw a jerry can, etc.)
    rate_tank_to_tank   = 0.33,   -- vehicle-to-vehicle content transfer
    rate_fuel_dispense  = 0.02,   -- tanker -> vehicle gas tank; vanilla-equivalent (~50 ticks/L)
    rate_hydrant        = 0.33,   -- hydrant -> cistern
    rate_draft          = 0.33,   -- river/lake -> cistern
    rate_pump_refuel    = 0.33,   -- gas pump -> tanker
    rate_drain          = 0.33,   -- drain tank to ground (fluid discarded)
    -- action ceilings (ticks) for unconverted actions
    time_ceiling        = 6000,
    -- floor for converted actions so tiny transfers still play an animation
    time_min            = 30,
    -- MP: minimum gap between tank part syncs during a running transfer (ms)
    sync_interval_ms    = 1000,
    -- proximity radii (tiles)
    proximity_action    = 6,
    proximity_hydrant   = 4,
    proximity_draft     = 4,
    proximity_pump      = 3,
    proximity_target    = 3,
    -- sounds & animations (mirroring vanilla ISTakeGasolineFromPump / ISTakeGasolineFromVehicle)
    pump_sound          = "VehicleAddFuelFromGasPump",
    pump_anim           = "fill_container_tap",
    container_sound     = "GeneratorAddFuel",
    container_anim      = "refuelgascan",
    dispense_sound      = "VehicleAddFuelFromGasPump",
    dispense_anim       = "fill_container_tap",
    dispense_icon       = "media/ui/vehicles/vehicle_refuel_from_pump.png",
    dispense_label      = "ContextMenu_VehicleRefuelFromPump",
}
local Config = SCKCO.VehicleFunctions.Config

VehicleFunctions.TANK_PARTS = {
    "WaterTankSC",
    "SmallCisternSC",  "MediumCisternSC",  "LargeCisternSC",
    "SmallFuelTankSC", "MediumFuelTankSC", "LargeFuelTankSC",
}
VehicleFunctions.CISTERN_PARTS  = { "SmallCisternSC",  "MediumCisternSC",  "LargeCisternSC" }
VehicleFunctions.FUELTANK_PARTS = { "SmallFuelTankSC", "MediumFuelTankSC", "LargeFuelTankSC" }

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

-- part,item when the marker part is installed with condition>0 and holds its item; else nil.
function VehicleFunctions.marker(vehicle, partId)
    local p = vehicle and vehicle:getPartById(partId)
    if not p or p:getCondition() <= 0 then return nil, nil end
    local item = p:getInventoryItem()
    if not item then return nil, nil end
    return p, item
end

-- first installed marker part from a list; part, item, id.
function VehicleFunctions.markerAny(vehicle, ids)
    for i = 1, #ids do
        local part, item = VehicleFunctions.marker(vehicle, ids[i])
        if part then return part, item, ids[i] end
    end
    return nil
end

-- within proximity_action tiles of the vehicle origin
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

-- writes state onto the part's installed item and transmits it
function VehicleFunctions.set(vehicle, part, item, key, value)
    item:getModData()[key] = value
    vehicle:transmitPartItem(part)
end

-- character sound lifecycle, as vanilla ISTakeGasolineFromVehicle (playSound + stopOrTriggerSound)
function VehicleFunctions.startPumpSound(action)
    if action.character and not action.pumpSound then
        action.pumpSound = action.character:playSound(Config.pump_sound)
    end
end

-- kept as a no-op for unconverted actions that still call it each update
function VehicleFunctions.updatePumpSound(action) end

function VehicleFunctions.stopPumpSound(action)
    if action.character and action.pumpSound then
        action.character:stopOrTriggerSound(action.pumpSound)
        action.pumpSound = nil
    end
end

-- can-refuel clip, falling back to the pump loop when the primary id does not resolve
function VehicleFunctions.startContainerSound(action)
    if not action.character or action.pumpSound then return end
    local snd = action.character:playSound(Config.container_sound)
    if snd == nil or snd == 0 or snd == -1 then
        snd = action.character:playSound(Config.pump_sound)
    end
    action.pumpSound = snd
end

-- Per-tick transfer used by the unconverted actions. Moves the primary fluid only; converted
-- actions use FluidContainer.Transfer, which keeps mixtures.
function VehicleFunctions.stepTransfer(srcFC, dstFC, action, rate)
    if not (srcFC and dstFC) then return 0 end
    if srcFC.isEmpty and srcFC:isEmpty() then return 0 end
    if dstFC.isFull and dstFC:isFull() then return 0 end
    local perTick = rate or Config.rate_container
    local amount = math.min(perTick, srcFC:getAmount(), dstFC:getFreeCapacity())
    if amount <= 0 then return 0 end
    -- measure the actual add: addFluid can no-op on an empty destination on some builds
    local before = dstFC:getAmount()
    dstFC:addFluid(srcFC:getPrimaryFluid(), amount)
    local moved = dstFC:getAmount() - before
    if moved > 0 then
        srcFC:removeFluid(moved)
    end
    return moved
end

-- installed station tank: fluidContainer, part
function VehicleFunctions.tank(vehicle)
    local part, item = VehicleFunctions.markerAny(vehicle, VehicleFunctions.TANK_PARTS)
    if not part then return nil, nil end
    return item:getFluidContainer(), part
end

--------------------------------------------------------------------------------
-- Vehicle create hooks (run on the server in MP, so they must live in shared)
--------------------------------------------------------------------------------

-- vanilla default create installs the part, then the tank is filled once
local function seedTank(vehicle, part, fluid)
    Vehicles.Create.Default(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    if md.SCTankSeeded then return end
    md.SCTankSeeded = true
    local fc = item:getFluidContainer()
    if fc and fc:isEmpty() then
        fc:addFluid(fluid, fc:getCapacity())
        vehicle:transmitPartItem(part)
    end
end

function SCKCO.Create.WaterTankFull(vehicle, part) seedTank(vehicle, part, "Water") end
function SCKCO.Create.CisternFull(vehicle, part)   seedTank(vehicle, part, "Water") end
function SCKCO.Create.FuelTankFull(vehicle, part)  seedTank(vehicle, part, "Petrol") end

function SCKCO.Create.GeneratorFuelFull(vehicle, part)
    Vehicles.Create.Default(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    if md.SCGenSeeded then return end
    md.SCGenSeeded = true
    md.SCGenFuel = 100
    vehicle:transmitPartItem(part)
end

--------------------------------------------------------------------------------
-- SCKCO_FluidXfer: inventory fluid container <-> station tank (converted)
--------------------------------------------------------------------------------

SCKCO_FluidXfer = ISBaseTimedAction:derive("SCKCO_FluidXfer")

local ANIM_EVENT = "SCKCOFluidXfer"

-- source FC, destination FC, tank part; nil when either side is gone
function SCKCO_FluidXfer:endpoints()
    local tankFC, part = VehicleFunctions.tank(self.vehicle)
    local itemFC = self.target and self.target:getFluidContainer()
    if not tankFC or not itemFC then return nil end
    if self.fromTank then return tankFC, itemFC, part end
    return itemFC, tankFC, part
end

-- Fluid compatibility is checked once at start: re-checking every tick would turn a source that
-- empties exactly at 100% into a stop instead of a completion. The client's copy of the fluid
-- state can lag the server, so only the server (or SP) applies the fluid checks.
function SCKCO_FluidXfer:isValidStart()
    if isClient() then return true end
    if (SandboxVars.SCKCO or {}).FluidsEnabled == false then return false end
    local src, dst = self:endpoints()
    return src ~= nil and self.units > 0 and FluidContainer.CanTransfer(src, dst)
end

function SCKCO_FluidXfer:isValid()
    if not self.vehicle or not self.target then return false end
    if not self.character:getInventory():contains(self.target) then return false end
    if not VehicleFunctions.near(self.character, self.vehicle) then return false end
    if isClient() then return true end
    return self:endpoints() ~= nil
end

function SCKCO_FluidXfer:waitToStart()
    self.character:faceThisObject(self.vehicle)
    return self.character:shouldBeTurning()
end

-- move fluid until the source is down to srcStart - units * delta. Driven by jobDelta in SP and
-- netAction progress on the server; both are monotonic, so repeated calls only top up.
function SCKCO_FluidXfer:transferTo(delta, forceSync)
    if self.units <= 0 then return end
    local src, dst, part = self:endpoints()
    if not src then return end
    local amount = math.max(0, src:getAmount() - (self.srcStart - self.units * delta))
    if amount > 0 then
        FluidContainer.Transfer(src, dst, amount)
        self.target:syncItemFields()
        self.dirty = true
    end
    if self.dirty then
        local now = getTimestampMs()
        if forceSync or now - (self.lastSync or 0) >= Config.sync_interval_ms then
            self.vehicle:transmitPartItem(part)
            self.lastSync, self.dirty = now, false
        end
    end
end

function SCKCO_FluidXfer:update()
    self.target:setJobDelta(self:getJobDelta())
    if not isClient() then
        self:transferTo(self:getJobDelta())
    end
end

function SCKCO_FluidXfer:start()
    self.target:setJobType(getText(self.fromTank and "IGUI_JobType_PourIn" or "IGUI_JobType_PourOut"))
    self.target:setJobDelta(0.0)
    self:setActionAnim(Config.container_anim)
    self:setOverrideHandModels(self.target:getStaticModel(), nil)
    VehicleFunctions.startContainerSound(self)
end

function SCKCO_FluidXfer:serverStart()
    emulateAnimEvent(self.netAction, 100, ANIM_EVENT, nil)
end

function SCKCO_FluidXfer:animEvent(event, parameter)
    if isServer() and event == ANIM_EVENT then
        self:transferTo(self.netAction:getProgress())
    end
end

function SCKCO_FluidXfer:stop()
    VehicleFunctions.stopPumpSound(self)
    self.target:setJobDelta(0.0)
    ISBaseTimedAction.stop(self)
end

function SCKCO_FluidXfer:perform()
    VehicleFunctions.stopPumpSound(self)
    self.target:setJobDelta(0.0)
    if self.target:getContainer() then self.target:getContainer():setDrawDirty(true) end
    ISBaseTimedAction.perform(self)
end

function SCKCO_FluidXfer:complete()
    self:transferTo(1, true)
    return true
end

function SCKCO_FluidXfer:getDuration()
    if self.character:isTimedActionInstant() then return 1 end
    return math.max(Config.time_min, self.units / Config.rate_container)
end

function SCKCO_FluidXfer:new(character, vehicle, target, fromTank)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle  = vehicle
    o.target   = target
    o.fromTank = fromTank
    o.forceProgressBar = true
    -- snapshot from whichever side builds the action: the client for its progress bar, the
    -- server from its own authoritative state when it rebuilds the action
    o.units, o.srcStart = 0, 0
    local src, dst = o:endpoints()
    if src then
        o.srcStart = src:getAmount()
        o.units = math.max(0, math.min(src:getAmount(), dst:getFreeCapacity()))
    end
    o.maxTime = o:getDuration()
    return o
end
