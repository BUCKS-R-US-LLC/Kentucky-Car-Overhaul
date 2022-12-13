
require "Vehicles/TimedActions/ISEnterVehicle"
require "Vehicles/TimedActions/ISExitVehicle"
require "Vehicles/TimedActions/ISSwitchVehicleSeat"

-- Credit: Chuck
-- This is free for anyone to use that needs it for a project but do credit Chuck.

---If the provided 'input' is not a table then that is returned (string expected).
---Otherwise; then parse every other value as a acceptable value and it's weight.
local function parseSeatAnimationSelection(input)
	if type(input) == "table" then
		---If input is a table parse each value and check if it's a string
		local parsedWeightedInput = {}
		for key,value in pairs(input) do
			if type(value) == "string" then
				---If the value is a string then check the next value
				---If it's a number use as an iterator; otherwise use 1
				local iterations = input[key+1]
				if type(iterations) ~= "number" then
					iterations = 1
				end
				---Add as many iterations as selected for value
				for i=1, iterations do
					table.insert(parsedWeightedInput, value)
				end
			end
		end

		if #parsedWeightedInput>0 then
			local selection = parsedWeightedInput[ZombRand(#parsedWeightedInput)+1]
			return selection
		else
			print("SC_ANIM: DEBUG ERROR: parsedWeightedInput not populated. (input:"..tostring(input)..")")
		end
	else
		return input
	end
end


local seatAnimationsProfiles = {
	["Default"] = {
		["seat0"]="Bob_Idle_Driver",
		["seatDefault"]="Shark_Idle_Passenger",
		---Uses current seat animation from above if none of these are set:
	},

	["16SideSeater"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
		["seat4"]="Shark_Idle_SidePassenger",
		["seat5"]="Shark_Idle_SidePassenger2",
		["seat6"]="Shark_Idle_SidePassenger",
		["seat7"]="Shark_Idle_SidePassenger2",
		["seat8"]="Shark_Idle_SidePassenger",
		["seat9"]="Shark_Idle_SidePassenger2",
		["seat10"]="Shark_Idle_SidePassenger",
		["seat11"]="Shark_Idle_SidePassenger2",
		["seat12"]="Shark_Idle_SidePassenger",
		["seat13"]="Shark_Idle_SidePassenger2",
		["seat14"]="Shark_Idle_SidePassenger",
		["seat15"]="Shark_Idle_SidePassenger2",
	},

	["6SideSeater"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
		["seat4"]="Shark_Idle_SidePassenger",
		["seat5"]="Shark_Idle_SidePassenger2",
	},

	["6Seater"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
		["seat4"]="Shark_Idle_SidePassenger",
		["seat5"]="Shark_Idle_SidePassenger2",
	},

	["SmallCar"] = {
		["seat0"]="Shark_Idle_SmallCarDriver",
		["seat1"]="Shark_Idle_PassengerRelaxed",
		["seatDefault"]="Shark_Idle_RearPassenger",
	},

	["4Seater"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",4,"Shark_Idle_PassengerAlternate"}, -- 4:1 = 4/5 = 20%
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["midSized"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",4,"Shark_Idle_PassengerAlternate"},
		["seatDefault"]={"Shark_Idle_Passenger",4,"Shark_Idle_PassengerAlternate"},
	},

	["Ambulance"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",4,"Shark_Idle_PassengerAlternate"},
		["seat2"]="Shark_Idle_SidePassengerAmbulance",
		["seat3"]="Shark_Idle_SidePassenger2",
	},
}

local vehicleToSeatAnimations = {

	["Base.SC_K5BlazerCiv"] = "Default",
	["Base.SC_K5BlazerStatePolice"] = "Default",
	["Base.SC_K5BlazerParkRanger"] = "Default",
	["Base.SC_K5BlazerFossoil"] = "Default",
	["Base.PickUpVanMccoy"] = "Default",
	["Base.PickUpVanLights"] = "Default",
	["Base.PickUpVanLightsFire"] = "Default",
	["Base.PickUpVanLightsPolice"] = "Default",
	["Base.PickUpTruck"] = "Default",
	["Base.PickUpTruckMccoy"] = "Default",
	["Base.PickUpTruckLights"] = "Default",
	["Base.PickUpTruckLightsFire"] = "Default",
	["Base.PickUpTruck"] = "Default",
	["Base.SC_K10"] = "Default",
	["Base.SC_M1008"] = "Default",
	["Base.SC_M1009"] = "Default",
	["Base.SC_M1009MilitaryPolice"] = "Default",
	["Base.SC_FordCountrySquire"] = "Default",
	["Base.CarStationWagon"] = "Default",
	["Base.CarStationWagon2"] = "Default",
	["Base.CarLights"] = "Default",
	["Base.CarLightsPolice"] = "Default",
	["Base.SC_CrownVictoriaCiv"] = "Default",
	["Base.SC_CrownVictoriaStatePolice"] = "Default",
	["Base.SC_CrownVictoriaParkRanger"] = "Default",
	["Base.SC_CrownVictoriaLVPD"] = "Default",
	["Base.SC_CrownVictoriaTaxi"] = "Default",
	["Base.SC_CapriceCiv"] = "Default",
	["Base.SC_Caprice9C1StatePolice"] = "Default",
	["Base.SC_Caprice9C1ParkRanger"] = "Default",
	["Base.SC_CapriceLVPD"] = "Default",
	["Base.CarNormal"] = "Default",
	["Base.CarTaxi"] = "Default",
	["Base.CarTaxi02"] = "Default",

	["Base.SC_M1008TroopCarrier"] = "6SideSeater",
	["Base.SC_M1010Ambulance"] = "6SideSeater",
	["Base.SC_M35A1"] = "16SideSeater",
	
	["Base.ModernCar"] = "Default",
	["Base.SC_VWRabbit"] = "SmallCar",
	["Base.SC_HondaAccord"] = "SmallCar",
	["Base.SmallCar"] = "SmallCar",
	["Base.SmallCar02"] = "SmallCar",

	["Base.SportsCar"] = "midSized",
	["Base.SC_CamaroTTop"] = "midSized",
	["Base.SC_Mercedes280"] = "midSized",
	["Base.CarLuxury"] = "midSized",

	["Base.SC_StepVanP30Civ"] = "4Seater",
	["Base.SC_StepVanP30Police"] = "4Seater",
	["Base.SC_StepVanP30ParkRanger"] = "4Seater",
	["Base.StepVan"] = "4Seater",
	["Base.StepVan_Scarlet"] = "4Seater",
	["Base.StepVan_Heralds"] = "4Seater",
	["Base.StepVanMail"] = "4Seater",

	["Base.SC_G30Ambulance"] = "Ambulance",
	["Base.VanAmbulance"] = "Ambulance",

	["Base.SC_CadillacFuneralCoach"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
        ["seat2"]="Bob_SitGround_Idle",
		["seat3"]="Bob_SitGround_Idle",
	},

	["Base.SC_FordBronco"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
	},

	["Base.SC_FordF150"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
	},

	["Base.SC_PlymouthVoyager"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_Passenger",
		["seat3"]="Shark_Idle_Passenger",
		["seat4"]="Shark_Idle_Passenger",
		["seat5"]="Shark_Idle_Passenger",
	},

	["Base.SC_FordF700BoxTruck"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
	},

	["Base.SC_FordF700PanelTruck"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
	},

	["Base.SC_FordF700ArmoredPolice"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.SC_FordF700ArmoredBank"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.SC_ChevroletC70GrainTruck"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
	},

	["Base.SC_ChevroletC70Survivalist"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
	},

	["Base.SC_GeoTracker"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_Passenger",
		["seat3"]="Shark_Idle_Passenger",
	},

	["Base.SC_FordTaurus"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_Passenger",
		["seat3"]="Shark_Idle_Passenger",
	},
}


local function fetchAnimForVehicle(vehicle, player)
	local vehicleName = vehicle:getScriptName()
	local seat = vehicle:getSeat(player)
	if not seat then return end

	local vehicleAnimationSet = vehicleToSeatAnimations[vehicleName]
	--use the `vehicleAnimationSet` as a profile ID if it's not a table
	if getDebug() then print(" -- vehicleAnimationSet: "..type(vehicleAnimationSet).." "..tostring(vehicleAnimationSet)) end
	if type(vehicleAnimationSet) == "string" then
		vehicleAnimationSet = seatAnimationsProfiles[vehicleAnimationSet]
		if getDebug() then print(" ---- changedTo: "..type(vehicleAnimationSet).." "..tostring(vehicleAnimationSet)) end
	end

	if not vehicleAnimationSet then return end
	local fetchedAnimation = vehicleAnimationSet["seat"..seat] or vehicleAnimationSet["seatDefault"]
	return fetchedAnimation, seat
end


local enter_start = ISEnterVehicle.start
function ISEnterVehicle:start()
    enter_start(self)
    self.character:SetVariable("SCUCK_Anim", "True")
	self.character:SetVariable("SCUCK_AnimTransition", "Default")
end


local function applySeatAnim(player)
    local vehicle = player:getVehicle()
    if not vehicle then
		print("ERROR: SCKCO(SCUCK) -applySeatAnim: No Vehicle??")
		return
	end

    local vehicleName = vehicle:getScriptName()
	if getDebug() then print(" -- ScriptName: "..vehicleName) end
    local vehicleAnimationSet = vehicleToSeatAnimations[vehicleName]

    if not vehicleAnimationSet then return end

    local fetchedAnim, seat = fetchAnimForVehicle(vehicle, player)
    if not fetchedAnim or not seat then print("ERROR: SCKCO(SCUCK) -applySeatAnim -No fetchedAnimation or no seat!") return end

    if fetchedAnim then
        fetchedAnim = parseSeatAnimationSelection(fetchedAnim)
		if getDebug() then print(" ---- Anim Selected for applySeatAnim: "..tostring(fetchedAnim)) end
        if fetchedAnim then
            player:SetVariable("SCUCK_AnimSeated", fetchedAnim)
        end
    end
end
Events.OnEnterVehicle.Add(applySeatAnim)
Events.OnSwitchVehicleSeat.Add(applySeatAnim)


local function exitVehicle(player)
    player:SetVariable("SCUCK_AnimSeated", "")
    player:SetVariable("SCUCK_Anim", "False")
	player:SetVariable("SCUCK_AnimTransition", "Default")
end
Events.OnExitVehicle.Add(exitVehicle)