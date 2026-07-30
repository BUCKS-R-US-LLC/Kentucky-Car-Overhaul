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
SCKCO.Stations = SCKCO.Stations or {}

local Stations = SCKCO.Stations
Stations.contributors = Stations.contributors or {}

--------------------------------------------------------------------------------
-- Shared core
--------------------------------------------------------------------------------

-- Vehicle from the player's seat, else a BaseVehicle among the clicked world objects.
function Stations.contextVehicle(player, worldobjects)
    local v = player:getVehicle()
    if v then return v end
    for _, o in ipairs(worldobjects) do
        if instanceof(o, "BaseVehicle") then return o end
    end
    -- standing beside it: scan squares around the player for a vehicle occupant
    local cell = player:getCell()
    if cell then
        local px, py, pz = math.floor(player:getX()), math.floor(player:getY()), math.floor(player:getZ())
        for dx = -2, 2 do
            for dy = -2, 2 do
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
function Stations.marker(vehicle, partId)
    local p = vehicle and vehicle:getPartById(partId)
    if not p or p:getCondition() <= 0 then return nil, nil end
    local item = p:getInventoryItem()
    if not item then return nil, nil end
    return p, item
end

-- Within ~4 tiles of the vehicle origin.
function Stations.near(player, vehicle)
    local dx, dy = vehicle:getX() - player:getX(), vehicle:getY() - player:getY()
    return dx * dx + dy * dy < 36
end

function Stations.get(item, key, default)
    local v = item:getModData()[key]
    if v == nil then return default end
    return v
end

-- Writes state onto the part's installed item and transmits it for MP.
function Stations.set(vehicle, part, item, key, value)
    item:getModData()[key] = value
    vehicle:transmitPartItem(part)
end

-- Deduped list of inventory items matching predicate (one entry per full type).
function Stations.inventoryMatching(player, predicate)
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
function Stations.addSub(context, label, items, player, vehicle, fn)
    local option = context:addOption(label, nil, nil)
    local sub = ISContextMenu:getNew(context)
    context:addSubMenu(option, sub)
    for i = 1, #items do
        sub:addOption(items[i]:getName(), player, fn, vehicle, items[i])
    end
end

function Stations.register(fn)
    Stations.contributors[#Stations.contributors + 1] = fn
end

local function onContext(playerNum, context, worldobjects, test)
    if test then return end
    local player = getSpecificPlayer(playerNum)
    if not player then return end
    local vehicle = Stations.contextVehicle(player, worldobjects)
    if not vehicle or not Stations.near(player, vehicle) then return end
    for i = 1, #Stations.contributors do
        Stations.contributors[i](context, player, vehicle)
    end
end
Events.OnFillWorldObjectContextMenu.Add(onContext)

--------------------------------------------------------------------------------
-- Fluids (any liquid)
--------------------------------------------------------------------------------
-- The tank part's installed item IS a FluidContainer (item WaterTankSC). Storage, fluid
-- identity, mixtures, whitelist/poison, save and MP sync are handled by the engine; fill/draw
-- is a container-to-container transfer. transmitPartItem carries the tank item's fluid state
-- to other clients. Options appear on the vehicle (world) and on any fluid container in an
-- inventory/trunk while near the tank.

local FLUID_PART = "WaterTankSC"
local FLUID_TIME = 120

local function tankContainer(item)
    return item:getFluidContainer()
end

-- Seed hook (test convenience): fill with water once on spawn.
--   part WaterTankSC { lua { create = SCKCO.Create.WaterTankFull } }
function SCKCO.Create.WaterTankFull(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    if md.SCTankSeeded then return end
    md.SCTankSeeded = true
    local fc = tankContainer(item)
    if fc and fc:isEmpty() then
        fc:addFluid("Water", fc:getCapacity())
        if vehicle and vehicle.transmitPartItem then vehicle:transmitPartItem(part) end
    end
end

SCKCO_FluidXfer = ISBaseTimedAction:derive("SCKCO_FluidXfer")

function SCKCO_FluidXfer:isValid()
    local part, item = Stations.marker(self.vehicle, FLUID_PART)
    return part ~= nil and tankContainer(item) ~= nil
        and self.target:getFluidContainer() ~= nil
        and self.character:getInventory():contains(self.target)
        and Stations.near(self.character, self.vehicle)
end

function SCKCO_FluidXfer:update() end

function SCKCO_FluidXfer:perform()
    local part, item = Stations.marker(self.vehicle, FLUID_PART)
    if part then
        local tankFC = tankContainer(item)
        local itemFC = self.target:getFluidContainer()
        if tankFC and itemFC then
            if self.fromTank then
                tankFC:transferTo(itemFC)
            else
                tankFC:transferFrom(itemFC)
            end
            self.vehicle:transmitPartItem(part)
        end
    end
    ISBaseTimedAction.perform(self)
end

function SCKCO_FluidXfer:new(character, vehicle, target, fromTank)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.target           = target
    o.fromTank         = fromTank
    o.maxTime          = FLUID_TIME
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
    local part, item = Stations.marker(vehicle, FLUID_PART)
    if not part then return nil end
    return tankContainer(item)
end

-- World menu: right-click the vehicle / nearby ground.
local function fluidsContext(context, player, vehicle)
    local tankFC = tankFor(vehicle)
    if not tankFC then return end

    context:addOption(string.format("Liquid tank: %.0f / %.0f L", tankFC:getAmount(), tankFC:getCapacity()), nil, nil)

    if not tankFC:isEmpty() then
        local recv = Stations.inventoryMatching(player, function(it)
            local fc = it:getFluidContainer()
            return fc ~= nil and not fc:isFull() and not fc:isInputLocked()
        end)
        if #recv > 0 then
            Stations.addSub(context, "Fill from tank", recv, player, vehicle, onDraw)
        end
    end
    if not tankFC:isFull() then
        local give = Stations.inventoryMatching(player, function(it)
            local fc = it:getFluidContainer()
            return fc ~= nil and not fc:isEmpty()
        end)
        if #give > 0 then
            Stations.addSub(context, "Empty into tank", give, player, vehicle, onFill)
        end
    end
end

Stations.register(fluidsContext)

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
    local vehicle = Stations.contextVehicle(player, {})
    if not vehicle or not Stations.near(player, vehicle) then return end
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
-- Generator (power)
--------------------------------------------------------------------------------
-- Power must flow through the engine grid (IsoGenerator drives haveElectricity/appliances),
-- so while "on" we anchor a real IsoGenerator at the vehicle's square and let vanilla do the
-- distribution and fuel drain. State (on, fuel 0-100) lives in the part-item modData; the
-- transient generator object is (re)built by the part update hook, adopted from the square on
-- reload, and torn down on stop / move / empty so it never orphans. Generators only power a
-- building/radius when parked in or beside one -- same as a hand-placed generator.

local GEN_PART = "GeneratorSC"
local GEN_ITEM = "Base.Generator"
local liveGens = {}  -- [vehicle] = { gen = IsoGenerator, x, y, z }

local function vehSquare(vehicle)
    local cell = getCell()
    if not cell then return nil end
    return cell:getGridSquare(math.floor(vehicle:getX()), math.floor(vehicle:getY()), math.floor(vehicle:getZ()))
end

local function genFuel(item)
    return Stations.get(item, "SCGenFuel", 0)
end

local function setGenFuel(vehicle, part, item, v)
    if v < 0 then v = 0 elseif v > 100 then v = 100 end
    Stations.set(vehicle, part, item, "SCGenFuel", v)
end

-- Build or adopt the generator at the vehicle square and activate it.
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
    gen:setCondition(part:getCondition())
    gen:setFuel(genFuel(item))
    gen:setActivated(true)
    gen:setConnected(true)
    gen:setSurroundingElectricity()
    liveGens[vehicle] = { gen = gen, x = sq:getX(), y = sq:getY(), z = sq:getZ() }
    return gen
end

local function teardownGen(vehicle, part, item)
    local e = liveGens[vehicle]
    if e and e.gen then
        item:getModData().SCGenFuel = e.gen:getFuel()
        e.gen:setActivated(false)
        e.gen:setConnected(false)
        e.gen:setSurroundingElectricity()
        e.gen:remove()
    end
    liveGens[vehicle] = nil
end

local function startGen(player, vehicle)
    local part, item = Stations.marker(vehicle, GEN_PART)
    if not part or genFuel(item) <= 0 then return end
    spawnGen(vehicle, part, item)
    item:getModData().SCGenOn = true
    vehicle:transmitPartItem(part)
end

local function stopGen(player, vehicle)
    local part, item = Stations.marker(vehicle, GEN_PART)
    if not part then return end
    teardownGen(vehicle, part, item)
    item:getModData().SCGenOn = false
    vehicle:transmitPartItem(part)
end

local function refuelGen(player, vehicle, petrolItem)
    local part, item = Stations.marker(vehicle, GEN_PART)
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

-- Per-vehicle update: recreate/adopt on load, mirror fuel (no per-tick transmit), and tear
-- down on move or empty. lua { update = SCKCO.Update.Generator }
function SCKCO.Update.Generator(vehicle, part)
    local item = part:getInventoryItem()
    if not item then return end
    local md = item:getModData()
    local e = liveGens[vehicle]
    if md.SCGenOn then
        if not e then
            spawnGen(vehicle, part, item)
            return
        end
        local sq = vehSquare(vehicle)
        if not sq or sq:getX() ~= e.x or sq:getY() ~= e.y or sq:getZ() ~= e.z then
            teardownGen(vehicle, part, item)
            md.SCGenOn = false
            vehicle:transmitPartItem(part)
            return
        end
        md.SCGenFuel = e.gen:getFuel()
        if md.SCGenFuel <= 0 or not e.gen:isActivated() then
            teardownGen(vehicle, part, item)
            md.SCGenOn = false
            vehicle:transmitPartItem(part)
        end
    elseif e then
        teardownGen(vehicle, part, item)
    end
end

-- Test seed: fill generator fuel once. part GeneratorSC { lua { create = SCKCO.Create.GeneratorFuelFull } }
function SCKCO.Create.GeneratorFuelFull(vehicle, part)
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
    local part, item = Stations.marker(vehicle, GEN_PART)
    if not part then return end
    local on = item:getModData().SCGenOn == true
    local fuel = genFuel(item)
    context:addOption(string.format("Generator: %s, fuel %d%%", on and "on" or "off", math.floor(fuel)), nil, nil)
    if on then
        context:addOption("Stop generator", player, stopGen, vehicle)
    elseif fuel > 0 then
        context:addOption("Start generator", player, startGen, vehicle)
    end
    if fuel < 100 then
        local cans = Stations.inventoryMatching(player, function(it)
            local fc = it:getFluidContainer()
            return fc ~= nil and fc:isPrimaryFluidType("Petrol") and fc:getPrimaryFluidAmount() > 0
        end)
        if #cans > 0 then
            Stations.addSub(context, "Add petrol to generator", cans, player, vehicle, refuelGen)
        end
    end
end

Stations.register(generatorContext)
