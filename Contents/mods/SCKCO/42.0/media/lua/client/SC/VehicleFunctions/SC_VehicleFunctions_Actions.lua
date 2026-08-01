-- SCKCO VehicleFunctions actions: fluids, tank-to-tank, fuel pump, hydrant, drafting, gas pump -> tanker.
-- Depends on SC_VehicleFunctions_1_Core.lua (loaded first alphabetically).
require "TimedActions/ISBaseTimedAction"

local Config   = SCKCO.VehicleFunctions.Config
local VehicleFunctions = SCKCO.VehicleFunctions

--------------------------------------------------------------------------------
-- Fluids (any liquid)
--------------------------------------------------------------------------------
-- The tank part's installed item IS a FluidContainer (item WaterTankSC). Storage, fluid
-- identity, mixtures, whitelist/poison, save and MP sync are handled by the engine; fill/draw
-- is a container-to-container transfer. transmitPartItem carries the tank item's fluid state
-- to other clients. Options appear on the vehicle (world) and on any fluid container in an
-- inventory/trunk while near the tank.

local TANK_PARTS = {
    "WaterTankSC",
    "SmallCisternSC",  "MediumCisternSC",  "LargeCisternSC",
    "SmallFuelTankSC", "MediumFuelTankSC", "LargeFuelTankSC",
}
local CISTERN_PARTS  = { "SmallCisternSC",  "MediumCisternSC",  "LargeCisternSC" }
local FUELTANK_PARTS = { "SmallFuelTankSC", "MediumFuelTankSC", "LargeFuelTankSC" }
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
    if self.setActionAnim then self:setActionAnim(Config.pump_anim) end
    if self.setOverrideHandModels then self:setOverrideHandModels(nil, nil) end
    VehicleFunctions.startPumpSound(self)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, TANK_PARTS)
    return part ~= nil and tankContainer(item) ~= nil
        and self.target:getFluidContainer() ~= nil
        and self.character:getInventory():contains(self.target)
        and VehicleFunctions.near(self.character, self.vehicle)
end

function SCKCO_FluidXfer:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, TANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(vehicle, TANK_PARTS)
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
                local tp, ti = VehicleFunctions.markerAny(v, TANK_PARTS)
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
    local sp, si = VehicleFunctions.markerAny(self.vehicle, TANK_PARTS)
    local tp, ti = VehicleFunctions.markerAny(self.target, TANK_PARTS)
    if not sp or not tp then return false end
    local sfc, tfc = si:getFluidContainer(), ti:getFluidContainer()
    return sfc ~= nil and tfc ~= nil and not sfc:isEmpty() and not tfc:isFull()
        and VehicleFunctions.near(self.character, self.vehicle)
end

function SCKCO_TankXfer:update()
    VehicleFunctions.updatePumpSound(self)
    local sp, si = VehicleFunctions.markerAny(self.vehicle, TANK_PARTS)
    local tp, ti = VehicleFunctions.markerAny(self.target, TANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(vehicle, TANK_PARTS)
    if not part then return end
    local fc = item:getFluidContainer()
    if not fc or fc:isEmpty() then return end
    local target = nearestTankVehicle(vehicle)
    if not target then return end
    context:addOption("Transfer contents to nearby vehicle", player, onTankXfer, vehicle, target)
end

VehicleFunctions.register(contentsTransferContext)

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
    local part, item = VehicleFunctions.markerAny(self.vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, CISTERN_PARTS)
    if not part then return false end
    local fc = item:getFluidContainer()
    return fc ~= nil and not fc:isFull()
        and VehicleFunctions.near(self.character, self.vehicle)
        and hydrantNear(self.vehicle) and mainsWaterOn() and hasWrench(self.character)
end

function SCKCO_HydrantFill:update()
    VehicleFunctions.updatePumpSound(self)
    local part, item = VehicleFunctions.markerAny(self.vehicle, CISTERN_PARTS)
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
    local part, item = VehicleFunctions.markerAny(vehicle, CISTERN_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, CISTERN_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, CISTERN_PARTS)
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
    local part, item = VehicleFunctions.markerAny(vehicle, CISTERN_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(self.vehicle, FUELTANK_PARTS)
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
    local part, item = VehicleFunctions.markerAny(vehicle, FUELTANK_PARTS)
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
