-- Dashboard 12V lighter: while seated in a vehicle with a charged battery, heat the coil and
-- pull a light. Client-only; a lighter's draw is negligible so no charge is consumed.
require "TimedActions/ISBaseTimedAction"

local HEAT_TICKS = 150   -- coil heat-up duration; tune against in-game action timing

-- Military vehicles have no civilian lighter socket. Superset of the diesel fleet plus the
-- gasoline M151A2. Stem substring covers camo variants and the optional Base. prefix.
local MILITARY = {
    "SC_AMGeneralM35A2",   -- M35A2
    "SC_AMGeneralM997",  -- HMMWV ambulance
    "SC_AMGeneralM998",  -- HMMWV
    "SC_AMGeneralM1025", -- HMMWV armament carrier
    "SC_AMGeneralM1097", -- HMMWV heavy troop carrier
    "SC_ChevroletM1008", -- CUCV pickup
    "SC_ChevroletM1009", -- CUCV Blazer
    "SC_ChevroletM1010", -- CUCV ambulance
    "SC_AMGeneralM151A2",  -- M151A2 MUTT
}

local function isMilitary(name)
    for i = 1, #MILITARY do
        if string.find(name, MILITARY[i], 1, true) then return true end
    end
    return false
end

local function batteryCharge(vehicle)
    local b = vehicle:getPartById("Battery")
    return b and b:getCondition() or 0
end

SCKCO_HeatLighter = ISBaseTimedAction:derive("SCKCO_HeatLighter")

function SCKCO_HeatLighter:isValid()
    local v = self.character:getVehicle()
    return v ~= nil and batteryCharge(v) >= self.minCharge
end

function SCKCO_HeatLighter:update() end

function SCKCO_HeatLighter:stop()
    ISBaseTimedAction.stop(self)
end

function SCKCO_HeatLighter:perform()
    self.character:getInventory():AddItem("Base.Lighter")
    ISBaseTimedAction.perform(self)
end

function SCKCO_HeatLighter:new(character, vehicle, minCharge)
    local o = ISBaseTimedAction.new(self, character)
    o.vehicle    = vehicle
    o.minCharge  = minCharge
    o.maxTime    = HEAT_TICKS
    o.stopOnWalk = false   -- seated, so movement stops aren't relevant
    o.stopOnRun  = false
    return o
end

local function onUseLighter(player, vehicle, minCharge)
    ISTimedActionQueue.add(SCKCO_HeatLighter:new(player, vehicle, minCharge))
end

local function onContext(playerNum, context, worldObjects, test)
    if test then return end
    local s = SandboxVars.SCKCO or {}
    if s.LighterEnabled == false then return end
    local player = getSpecificPlayer(playerNum)
    if not player then return end
    local vehicle = player:getVehicle()
    if not vehicle then return end
    if isMilitary(vehicle:getScriptName()) then return end
    local minCharge = s.LighterMinCharge or 5
    if batteryCharge(vehicle) < minCharge then return end
    context:addOption("Use dashboard lighter", player, onUseLighter, vehicle, minCharge)
end

Events.OnFillWorldObjectContextMenu.Add(onContext)
