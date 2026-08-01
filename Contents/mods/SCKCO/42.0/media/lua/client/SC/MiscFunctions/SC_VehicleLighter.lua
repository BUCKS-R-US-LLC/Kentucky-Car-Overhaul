-- Dashboard 12V lighter: while seated in a vehicle that carries an SCLighter part and has a
-- charged battery, heat the coil and light a smokeable from the player's inventory.
-- Client-only; a lighter's draw is negligible so no charge is consumed. Consumption is
-- delegated to ISEatFoodAction, so the item's OnEat
-- hook (consumeNicotine), charges and sync are handled by the base game (MP-safe). This
-- deliberately bypasses the item's RequireInHandOrInventory fire-source list: the coil is
-- the ignition source.
require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISEatFoodAction"
require "TimedActions/ISInventoryTransferAction"

local HEAT_TICKS = 60

-- Vehicles opt in by including the SCLighter template. The part must also hold its item:
-- surplus vehicles spawn with an empty socket until a CigaretteLighterSC is retrofitted.
local LIGHTER_PART = "SCLighter"

local function hasLighter(vehicle)
    local p = vehicle:getPartById(LIGHTER_PART)
    return p ~= nil and p:getInventoryItem() ~= nil and p:getCondition() > 0
end

local function batteryCharge(vehicle)
    local b = vehicle:getPartById("Battery")
    return b and b:getCondition() or 0
end

-- EatType rather than a tag query: InventoryItem:hasTag is not exposed to Lua in B42.
-- Every smokeable shares EatType = Cigarettes, so this covers modded tobacco with no list
-- to maintain. Food gate skips the getEatType call on the rest of the inventory.
local function isSmokeable(item)
    return instanceof(item, "Food") and item:getEatType() == "Cigarettes"
end

-- One entry per distinct full type so twenty identical cigarettes don't fill the submenu.
local function findSmokes(player)
    local list = player:getInventory():getAllEvalRecurse(isSmokeable, ArrayList.new())
    local found, seen = {}, {}
    for i = 0, list:size() - 1 do
        local item = list:get(i)
        local t = item:getFullType()
        if not seen[t] then
            seen[t] = true
            found[#found + 1] = item
        end
    end
    return found
end

SCKCO_HeatLighter = ISBaseTimedAction:derive("SCKCO_HeatLighter")

function SCKCO_HeatLighter:isValid()
    return self.character:getVehicle() == self.vehicle
        and batteryCharge(self.vehicle) >= self.minCharge
        and self.character:getInventory():contains(self.item)
end

function SCKCO_HeatLighter:update() end

function SCKCO_HeatLighter:perform()
    ISTimedActionQueue.add(ISEatFoodAction:new(self.character, self.item, 1))
    ISBaseTimedAction.perform(self)
end

function SCKCO_HeatLighter:new(character, vehicle, item, minCharge)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle          = vehicle
    o.item             = item
    o.minCharge        = minCharge
    o.maxTime          = HEAT_TICKS
    o.stopOnWalk       = false   -- seated, so movement stops aren't relevant
    o.stopOnRun        = false
    o.forceProgressBar = true
    return o
end

local function onUseLighter(player, vehicle, item, minCharge)
    -- ISEatFoodAction expects the item in the main inventory, not a nested bag.
    if item:getContainer() ~= player:getInventory() then
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory()))
    end
    ISTimedActionQueue.add(SCKCO_HeatLighter:new(player, vehicle, item, minCharge))
end

local function onContext(playerNum, context, worldObjects, test)
    if test then return end
    local s = SandboxVars.SCKCO or {}
    if s.LighterEnabled == false then return end
    local player = getSpecificPlayer(playerNum)
    local vehicle = player and player:getVehicle()
    if not vehicle or not hasLighter(vehicle) then return end
    local minCharge = s.LighterMinCharge or 5
    if batteryCharge(vehicle) < minCharge then return end
    local smokes = findSmokes(player)
    if #smokes == 0 then return end

    if #smokes == 1 then
        context:addOption("Light " .. smokes[1]:getName() .. " with dashboard lighter", player,
            onUseLighter, vehicle, smokes[1], minCharge)
        return
    end

    local option = context:addOption("Use dashboard lighter", nil, nil)
    local sub = ISContextMenu:getNew(context)
    context:addSubMenu(option, sub)
    for i = 1, #smokes do
        sub:addOption(smokes[i]:getName(), player, onUseLighter, vehicle, smokes[i], minCharge)
    end
end

Events.OnFillWorldObjectContextMenu.Add(onContext)
