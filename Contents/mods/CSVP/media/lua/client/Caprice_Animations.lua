-- this method was copied from the excellent Skateboard mod by Dislaik https://steamcommunity.com/sharedfiles/filedetails/?id=2728300240
-- require "Vehicles/ISUI/ISVehicleMenu"
-- require "Vehicles/TimedActions/ISStartVehicleEngine"

local function IFAV_Enter(player)
	local vehicle = player:getVehicle()
	if not vehicle then return end
    local vehicleName = vehicle:getScriptName()
    local seat = vehicle:getSeat(player)
    if not seat then return end
	if seat == 0 and vehicleName:contains("Base.IFAV") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Driver")
		return
	end
	if seat == 1 and vehicleName:contains("Base.IFAV") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Passenger")
		return
	end
	if seat == 2 and vehicleName:contains("Base.IFAV") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearPassenger")
		return
	end
	if seat == 3 and vehicleName:contains("Base.IFAV") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearPassenger")
		return
	end
end

function IFAV_Enter_Server(player)
	IFAV_Enter(player)
end

local function IFAV_Exit(player)
    sendClientCommand(player, "IFAV", "PlayerExit", {})
    player:SetVariable("VehicleScriptName", "")
end

Events.OnEnterVehicle.Add(IFAV_Enter)
Events.OnExitVehicle.Add(IFAV_Exit)
Events.OnSwitchVehicleSeat.Add(IFAV_Enter)