-- SCKCO Vehicle generator: hookup phase, refuel, start/stop, safety sweeps.
-- Depends on SC_VehicleFunctions_1_Core.lua (loaded first alphabetically).
require "TimedActions/ISBaseTimedAction"

local Config   = SCKCO.VehicleFunctions.Config
local VehicleFunctions = SCKCO.VehicleFunctions

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
