-- Dashboard 12V lighter.
--
-- B42 already supports lighting a smokeable from a car lighter: the inventory Smoke option and
-- ISEatFoodAction both ask vehicle:canLightSmoke(character), and when it says yes no lighter or
-- matches are needed or used up. SCKCO plugs its rules into that one check instead of running a
-- parallel menu, so the vanilla Smoke option, the eat action and the server all agree.
--
-- Vehicles that carry the SCLighter part follow SCKCO's rules: the lighter item must be
-- installed (surplus vehicles spawn with an empty socket), the battery must hold at least
-- LighterMinCharge percent, and the smoker must be in a front seat. Vehicles without the part
-- keep vanilla's answer. Shared because ISEatFoodAction:new also runs on the server in MP.

local LIGHTER_PART = "SCLighter"

-- charge as a percentage (0-100); a broken battery or an empty slot reads as 0
local function batteryCharge(vehicle)
    local b = vehicle:getPartById("Battery")
    local item = b and b:getInventoryItem()
    if not item or b:getCondition() <= 0 then return 0 end
    return item:getCurrentUsesFloat() * 100
end

local methods = __classmetatables[BaseVehicle.class].__index
local vanillaCanLightSmoke = methods.canLightSmoke
if not vanillaCanLightSmoke then
    error("SCKCO: BaseVehicle.canLightSmoke not found; dashboard lighter hook not installed")
end

methods.canLightSmoke = function(vehicle, character)
    local part = vehicle:getPartById(LIGHTER_PART)
    if not part then return vanillaCanLightSmoke(vehicle, character) end

    local s = SandboxVars.SCKCO or {}
    if s.LighterEnabled == false then return false end
    if not part:getInventoryItem() or part:getCondition() <= 0 then return false end
    if not character or character:getVehicle() ~= vehicle then return false end
    -- seats 0 and 1 are driver and front passenger; the dashboard is out of reach from the back
    if vehicle:getSeat(character) > 1 then return false end
    return batteryCharge(vehicle) >= (s.LighterMinCharge or 5)
end
