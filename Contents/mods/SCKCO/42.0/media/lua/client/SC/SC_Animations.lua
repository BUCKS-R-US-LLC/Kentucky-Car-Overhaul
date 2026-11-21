
require "Vehicles/TimedActions/ISEnterVehicle"
require "Vehicles/TimedActions/ISExitVehicle"
require "Vehicles/TimedActions/ISSwitchVehicleSeat"

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

	["2Seater"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
	},

	["4SeatUtility"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
        ["seat2"]="Bob_SitGround_Idle",
		["seat3"]="Bob_SitGround_Idle",
	},

	["4SeatSport"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
		["seat4"]="Shark_Idle_SidePassenger",
		["seat5"]="Shark_Idle_SidePassenger2",
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
		["seat16"]="Shark_Idle_SidePassenger",
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
		["seat0"]="Bob_Idle_Driver",
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

	["Base.PickUpVanMccoy"] = "Default",
	["Base.PickUpVanLights"] = "Default",
	["Base.PickUpVanLightsFire"] = "Default",
	["Base.PickUpVanLightsPolice"] = "Default",
	["Base.PickUpTruck"] = "Default",
	["Base.PickUpTruckMccoy"] = "Default",
	["Base.PickUpTruckLights"] = "Default",
	["Base.PickUpTruckLightsFire"] = "Default",
	["Base.ModernCar"] = "Default",	
	["Base.CarNormal"] = "Default",
	["Base.CarTaxi"] = "Default",
	["Base.CarTaxi02"] = "Default",
	["Base.CarStationWagon"] = "Default",
	["Base.CarStationWagon2"] = "Default",
	["Base.CarLights"] = "Default",
	["Base.CarLightsPolice"] = "Default",
	["Base.SC_ChevroletK10"] = "Default",
	["Base.SC_ChevroletK10_Dixie"] = "Default",
	["Base.SC_ChevroletK10_McCoy"] = "Default",
	["Base.SC_ChevroletK5Blazer_Fossoil"] = "Default",
	["Base.SC_ChevroletK10_ParkRanger"] = "Default",
	["Base.SC_ChevroletM1008_3Tone"] = "Default",
	["Base.SC_ChevroletM1008_OD"] = "Default",
	["Base.SC_ChevroletM1008_DesertMERDC"] = "Default",
	["Base.SC_ChevroletM1009_3Tone"] = "Default",
	["Base.SC_ChevroletM1009_OD"] = "Default",
	["Base.SC_ChevroletM1009_DesertMERDC"] = "Default",
	["Base.SC_ChevroletM1009MP_3Tone"] = "Default",
	["Base.SC_ChevroletM1009MP_OD"] = "Default",
	["Base.SC_ChevroletM1009MP_DesertMERDC"] = "Default",
	["Base.SC_FordCountrySquire"] = "Default",
	
	["Base.SC_FordCrownVictoria85"] = "Default",
	["Base.SC_FordCrownVictoria85_StatePolice"] = "Default",
	["Base.SC_FordCrownVictoria85_LouisvillePD"] = "Default",
	["Base.SC_FordCrownVictoria85_Taxi"] = "Default",
	["Base.SC_FordCrownVictoria85_ParkRanger"] = "Default",
	["Base.SC_ChevroletCaprice85"] = "Default",
	["Base.SC_ChevroletCaprice85_ParkRanger"] = "Default",

	["Base.SC_CadillacFleetwoodBrougham"] = "Default",
	["Base.SC_CadillacLimo"] = "Default",
	["Base.SC_ChevroletCavalier"] = "Default",

	["Base.SC_AMGeneralM997Ambulance_3Tone"] = "Default",
	["Base.SC_AMGeneralM997Ambulance_OD"] = "Default",
	["Base.SC_AMGeneralM997Ambulance_Tan"] = "Default",
	["Base.SC_AMGeneralM998Soft_3Tone"] = "Default",
	["Base.SC_AMGeneralM998Soft_OD"] = "Default",
	["Base.SC_AMGeneralM998Soft_Tan"] = "Default",
	["Base.SC_AMGeneralM998Hard_3Tone"] = "Default",
	["Base.SC_AMGeneralM998Hard_OD"] = "Default",
	["Base.SC_AMGeneralM1025_3Tone"] = "Default",
	["Base.SC_AMGeneralM1025_OD"] = "Default",
	["Base.SC_AMGeneralM1025_Tan"] = "Default",
	["Base.SC_AMGeneralM1025MP_3Tone"] = "Default",
	["Base.SC_AMGeneralM1025MP_OD"] = "Default",
	["Base.SC_AMGeneralM1025MP_Tan"] = "Default",

	["Base.SC_FordTaurus"] = "Default",
	["Base.SC_GeoTracker"] = "Default",
	["Base.SC_BMW520i"] = "Default",
    ["Base.SC_FordCrownVictoria92"] = "Default",
    ["Base.SC_FordCrownVictoria92_JeffersonPD"] = "Default",
    ["Base.SC_FordCrownVictoria92_JeffersonSheriff"] = "Default",
	["Base.SC_FordCrownVictoria92_LouisvillePD"] = "Default",
	["Base.SC_FordCrownVictoria92_MeadeSheriff"] = "Default",
	["Base.SC_FordCrownVictoria92_WarrenSheriff"] = "Default",
	["Base.SC_FordCrownVictoria92_MuhlenSheriff"] = "Default",
	["Base.SUV"] = "Default",
	["Base.SC_FordExplorer"] = "Default",
	["Base.SC_JeepCherokee"] = "Default",
	["Base.SC_JeepCherokee_AudubonPD"] = "Default",
	["Base.SC_JeepGrandWagoneer"] = "Default",

	["Base.SC_AMGeneralM1097TroopCarrier_3Tone"] = "16SideSeater",
	["Base.SC_AMGeneralM1097TroopCarrier_OD"] = "16SideSeater",
	["Base.SC_ChevroletM1008TroopCarrier_3Tone"] = "16SideSeater",
	["Base.SC_ChevroletM1008TroopCarrier_OD"] = "16SideSeater",
	["Base.SC_ChevroletM1008TroopCarrier_DesertMERDC"] = "16SideSeater",
	["Base.SC_ChevroletM1010Ambulance_3Tone"] = "Default",
	["Base.SC_ChevroletM1010Ambulance_OD"] = "Default",
	["Base.SC_ChevroletM1010Ambulance_DesertMERDC"] = "Default",
	["Base.SC_AMGeneralM35A2"] = "16SideSeater",
	["Base.SC_AMGeneralM35A2_MERDC"] = "16SideSeater",

	["Base.SmallCar"] = "SmallCar",
	["Base.SmallCar02"] = "SmallCar",
	["Base.SC_VWRabbit"] = "SmallCar",
	["Base.SC_VWRabbit_Pizza"] = "SmallCar",
	["Base.SC_HondaAccord"] = "SmallCar",
	["Base.SC_Porsche911"] = "SmallCar",

	["Base.SportsCar"] = "midSized",
	["Base.SC_ChevroletCamaro87"] = "midSized",
	["Base.SC_Mercedes280"] = "midSized",
	["Base.CarLuxury"] = "midSized",

	["Base.SC_ChevroletC70GrainTruck"] = "2Seater",
	["Base.SC_ChevroletC70Survivalist"] = "2Seater",
	["Base.SC_FordF700BoxTruck"] = "2Seater",
	["Base.SC_FordF700PanelTruck"] = "2Seater",
	["Base.SC_FordF15092"] = "2Seater",
	["Base.SC_FordBronco"] = "2Seater",
	["Base.SC_GrummanLLV"] = "2Seater",
	["Base.SC_MackDM800_Garbage"] = "2Seater",
	["Base.SC_CrownFireCoach_Red"] = "2Seater",
	["Base.SC_CrownFireCoach_White"] = "2Seater",
	["Base.SC_DodgeM880"] = "2Seater",
	["Base.SC_DodgePowerWagon"] = "2Seater",

	["Base.SC_ChevroletP30"] = "4Seater",
	["Base.SC_ChevroletP30_Heralds"] = "4Seater",
	["Base.SC_ChevroletP30_Mail"] = "4Seater",
	["Base.SC_ChevroletP30_Scarlet"] = "4Seater",
	["Base.SC_ChevroletP30_SWAT"] = "4Seater",
	["Base.SC_ChevroletP30_BunnyBread"] = "4Seater",
	["Base.SC_ChevroletP30_Greenes"] = "4Seater",
	["Base.StepVan"] = "4Seater",
	["Base.StepVan_Scarlet"] = "4Seater",
	["Base.StepVan_Heralds"] = "4Seater",
	["Base.StepVanMail"] = "4Seater",

	["Base.SC_CadillacFuneralCoach"] = "4SeatUtility",

	["Base.SC_FordF350Ambulance_StPeregrin"] = "4SeatSport",
	["Base.SC_FordF350Ambulance_Meade"] = "4SeatSport",
	["Base.SC_FordF350Ambulance_Life"] = "4SeatSport",
	["Base.SC_FordMustang90_Undercover"] = "4SeatSport",
	["Base.SC_FordMustang90_JeffersonPD"] = "4SeatSport",
	["Base.SC_FordMustang90"] = "4SeatSport",
	["Base.SC_FordMustang90_StatePolice"] = "4SeatSport",

	["Base.SC_HahnPumper_Red"] = "6Seater",
	["Base.SC_HahnPumper_Yellow"] = "6Seater",
	["Base.SC_PlymouthVoyager"] = "6Seater",

	["Base.SC_ChevroletG30_Ambulance"] = "Ambulance",
	["Base.SC_DodgeM880Ambulance"] = "Ambulance",
	["Base.VanAmbulance"] = "Ambulance",

	["Base.SC_AMGeneralM151A2_3Tone"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seatDefault"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_AMGeneralM151A2_Tan"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seatDefault"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_AMGeneralM151A2_MERDC"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seatDefault"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_AMGeneralM151A2_Cleaners"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seatDefault"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_CadillacGageRanger"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Bob_SitGround_Idle",
        ["seat2"]="Bob_SitGround_Idle",
		["seat3"]="Bob_SitGround_Idle",
	},

	["Base.SC_CadillacGageRangerLights"] = {
		["seat0"]="Bob_Idle_Driver",
		["seat1"]="Bob_SitGround_Idle",
        ["seat2"]="Bob_SitGround_Idle",
		["seat3"]="Bob_SitGround_Idle",
	},

	["Base.SC_FordF700Armored_Brinks"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},


	["Base.SC_FordF700Armored_Dunbar"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.SC_FordF700Armored_Transport"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},


	-- Previously unmapped
	["Base.SC_ChevroletK5Blazer"] = "Default",
	["Base.SC_ChevroletK5Blazer_McCoy"] = "Default",
	["Base.SC_ChevroletK5Blazer_ParkRanger"] = "Default",
	["Base.SC_ChevroletK5Blazer_StatePolice"] = "Default",
	["Base.SC_ChevroletSuburban"] = "Default",
	["Base.SC_ChevroletSuburban_StatePolice"] = "Default",
	["Base.SC_NissanPathfinder"] = "Default",
	["Base.SC_ToyotaCamry"] = "Default",
	["Base.SC_GMCJimmyS15"] = "Default",
	["Base.SC_CUCVZhenjaEdition"] = "Default",
	["Base.SC_FordCrownVictoria92_BrandenburgPD"] = "Default",
	["Base.SC_FordCrownVictoria92_BullittSheriff"] = "Default",
	["Base.SC_FordCrownVictoria92_StatePolice"] = "Default",
	["Base.SC_ChevroletM1028A3_3Tone"] = "Default",
	["Base.SC_ChevroletM1028A3_OD"] = "Default",
	["Base.SC_ChevroletM1028A3_DesertMERDC"] = "Default",
	["Base.SC_AMGeneralM49A2C"] = "Default",
	["Base.SC_ChevroletG30"] = "Default",
	["Base.SC_ChevroletG30BoxVan"] = "Default",
	["Base.SC_ChevroletG30PassengerVan"] = "Default",
	["Base.SC_ChevroletG30_ChurchVan"] = "Default",
	["Base.SC_ChevroletG30_3N"] = "Default",
	["Base.SC_ChevroletG30_FedEx"] = "Default",
	["Base.SC_ChevroletG30_Fossoil"] = "Default",
	["Base.SC_ChevroletG30_JeffersonPD"] = "Default",
	["Base.SC_ChevroletG30_KnoxDisti"] = "Default",
	["Base.SC_ChevroletG30_LBMW"] = "Default",
	["Base.SC_ChevroletG30_LectroMax"] = "Default",
	["Base.SC_ChevroletG30_Mail"] = "Default",
	["Base.SC_ChevroletG30_MassGenFac"] = "Default",
	["Base.SC_ChevroletG30_McCoy"] = "Default",
	["Base.SC_ChevroletG30_PennHam"] = "Default",
	["Base.SC_ChevroletG30_SouthCentralBell"] = "Default",
	["Base.SC_ChevroletG30_Spiffo"] = "Default",
	["Base.SC_ChevroletG30_Transit"] = "Default",
	["Base.SC_JeepCJ7"] = "Default",
	["Base.SC_JeepCJ7_Bubba"] = "Default",
	["Base.SC_FordF700BoxTruck_Budget"] = "2Seater",
	["Base.SC_FordF700BoxTruck_BunnyBread"] = "2Seater",
	["Base.SC_FordF700BoxTruck_GigaMart"] = "2Seater",
	["Base.SC_FordF700BoxTruck_Greenes"] = "2Seater",
	["Base.SC_FordF700BoxTruck_MacTools"] = "2Seater",
	["Base.SC_FordF700BoxTruck_Mayflower"] = "2Seater",
	["Base.SC_FordF700BoxTruck_Ryder"] = "2Seater",
	["Base.SC_FordF700DumpTruck"] = "2Seater",
	["Base.SC_MazdaB2000"] = "2Seater",
	["Base.SC_ChevroletG30_ChurchBus"] = "6Seater",
	["Base.SC_ChevroletG30_SpecialForces"] = "6Seater",
	["Base.SC_DodgeM880TroopCarrier"] = "16SideSeater",

	["Base.SC_Oliver2050"] = {
        ["seat0"]="Bob_Idle_Driver",
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

	local default = seatAnimationsProfiles["Default"]
	vehicleAnimationSet = vehicleAnimationSet or default
	local fetchedAnimation = vehicleAnimationSet["seat"..seat] or vehicleAnimationSet["seatDefault"]
		or default["seat"..seat] or default["seatDefault"]
	return fetchedAnimation, seat
end


local CharVisuals = require "SC/SC_CharacterVisuals"

SCKCO = SCKCO or {}
SCKCO.FastEnter = SCKCO.FastEnter or {}
local FastCfg = SCKCO.FastEnter
FastCfg.instantEnter = true
FastCfg.instantExit = true
FastCfg.enterTransition = "Default"

local enter_start = ISEnterVehicle.start
function ISEnterVehicle:start()
    enter_start(self)
    self.character:SetVariable("SCUCK_Anim", "True")
	self.character:SetVariable("SCUCK_AnimTransition", FastCfg.enterTransition)
end

-- Vanilla update() spins on EnterAnimationFinished before forceComplete. The seat is already
-- taken by vehicle:enter() in start(), so completing early is safe once getCharacter confirms
-- it. Falls through to vanilla when start() hit its 2-tile early return and never entered.
local enter_update = ISEnterVehicle.update
function ISEnterVehicle:update()
	if FastCfg.instantEnter and self.vehicle:getCharacter(self.seat) == self.character then
		self.character:ClearVariable("EnterAnimationFinished")
		self.character:ClearVariable("bEnteringVehicle")
		self:forceComplete()
		return
	end
	enter_update(self)
end

-- Exit is symmetric but vehicle:exit() lives in perform(), not start(), so the character is
-- still seated for the whole action. isValid already asserts a vehicle and a stopped one.
local exit_update = ISExitVehicle.update
function ISExitVehicle:update()
	if FastCfg.instantExit and self.character:getVehicle() then
		self.character:ClearVariable("ExitAnimationFinished")
		self.character:ClearVariable("bExitingVehicle")
		self:forceComplete()
		return
	end
	exit_update(self)
end


local function applySeatAnim(player)
    local vehicle = player:getVehicle()
    if not vehicle then
		print("ERROR: SCKCO(SCUCK) -applySeatAnim: No Vehicle??")
		return
	end

    local vehicleName = vehicle:getScriptName()
	if getDebug() then print(" -- ScriptName: "..vehicleName) end
    local fetchedAnim, seat = fetchAnimForVehicle(vehicle, player)
    if not fetchedAnim or not seat then print("ERROR: SCKCO(SCUCK) -applySeatAnim -No fetchedAnimation or no seat!") return end

    if fetchedAnim then
        fetchedAnim = parseSeatAnimationSelection(fetchedAnim)
		if getDebug() then print(" ---- Anim Selected for applySeatAnim: "..tostring(fetchedAnim)) end
        if fetchedAnim then
            player:SetVariable("SCUCK_AnimSeated", fetchedAnim)
        end
    end
	CharVisuals.process(player)
end
Events.OnEnterVehicle.Add(applySeatAnim)
Events.OnSwitchVehicleSeat.Add(applySeatAnim)


local function exitVehicle(player)
    player:SetVariable("SCUCK_AnimSeated", "")
    player:SetVariable("SCUCK_Anim", "False")
	player:SetVariable("SCUCK_AnimTransition", "Default")
	CharVisuals.process(player)
end
Events.OnExitVehicle.Add(exitVehicle)