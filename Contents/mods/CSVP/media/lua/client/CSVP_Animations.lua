-- Huge thanks to Dislaik for creating this method, you should him out: https://steamcommunity.com/sharedfiles/filedetails/?id=2728300240

local function CapricePolice_Enter(player)
	local vehicle = player:getVehicle()
	if not vehicle then return end
    local vehicleName = vehicle:getScriptName()
    local seat = vehicle:getSeat(player)
    if not seat then return end
	if seat == 0 and vehicleName:contains("Base.SC_Caprice9C1") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Driver")
		return
	end
	if seat == 1 and vehicleName:contains("Base.SC_Caprice9C1") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Passenger")
		return
	end
	if seat == 2 and vehicleName:contains("Base.Base.SC_Caprice9C1") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Passenger")
		return
	end
	if seat == 3 and vehicleName:contains("Base.Base.SC_Caprice9C1") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Passenger")
		return
	end
	if seat == 4 and vehicleName:contains("Base.Base.SC_Caprice9C1") then		
		player:SetVariable("VehicleScriptName", "Shark_Idle_Passenger")
		return
	end
end

function CapricePolice_Enter_Server(player)
	IFAV_Enter(player)
end

local function CapricePolice_Exit(player)
    sendClientCommand(player, "SC_Caprice9C1", "PlayerExit", {})
    player:SetVariable("VehicleScriptName", "")
end

Events.OnEnterVehicle.Add(CapricePolice_Enter)
Events.OnExitVehicle.Add(CapricePolice_Exit)
Events.OnSwitchVehicleSeat.Add(CapricePolice_Enter)


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