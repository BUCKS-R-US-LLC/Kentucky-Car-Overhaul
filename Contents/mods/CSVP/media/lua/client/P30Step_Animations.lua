-- this method was copied from the excellent Skateboard mod by Dislaik https://steamcommunity.com/sharedfiles/filedetails/?id=2728300240
-- require "Vehicles/ISUI/ISVehicleMenu"
-- require "Vehicles/TimedActions/ISStartVehicleEngine"

local function StepVanP30Police_enter(player)
	local vehicle = player:getVehicle()
	if not vehicle then return end
    local vehicleName = vehicle:getScriptName()
    local seat = vehicle:getSeat(player)
    if not seat then return end
	if seat == 0 and vehicleName:contains("Base.SC_StepVanP30Police") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearVan")
		return
	end
	if seat == 1 and vehicleName:contains("Base.SC_StepVanP30Police") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Passenger")
		return
	end
	if seat == 2 and vehicleName:contains("Base.SC_StepVanP30Police") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearVan")
		return
	end
	if seat == 3 and vehicleName:contains("Base.SC_StepVanP30Police") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearVan")
		return
	end
	if seat == 4 and vehicleName:contains("Base.SC_StepVanP30Police") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearVan")
		return
	end
	if seat == 5 and vehicleName:contains("Base.SC_StepVanP30Police") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearVan")
		return
	end
	if seat == 6 and vehicleName:contains("Base.SC_StepVanP30Police") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_RearVan")
		return
	end
end

function SC_StepVanP30Police_Enter_Server(player)
	SC_StepVanP30Police_Enter(player)
end

local function SC_StepVanP30Police_Exit(player)
    sendClientCommand(player, "SC_StepVanP30Police", "PlayerExit", {})
    player:SetVariable("VehicleScriptName", "")
end

Events.OnEnterVehicle.Add(SC_StepVanP30Police_Enter)
Events.OnExitVehicle.Add(SC_StepVanP30Police_Exit)
Events.OnSwitchVehicleSeat.Add(SC_StepVanP30Police_Enter)