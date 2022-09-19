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


local vehicleToSeatAnimations = {

	["Base.SC_K5BlazerCiv"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_K5BlazerStatePolice"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_K5BlazerParkRanger"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },
	
	["Base.SC_K5BlazerFossoil"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpVanMccoy"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpVanLights"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpVanLightsFire"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpVanLightsPolice"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpTruck"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpTruckMccoy"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpTruckLights"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpTruckLightsFire"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.PickUpTruck"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_K10"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_M1008"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_M1009"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_M1009MilitaryPolice"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_M1008TroopCarrier"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
		["seat4"]="Shark_Idle_SidePassenger",
		["seat5"]="Shark_Idle_SidePassenger2",
	},

	["Base.SC_M1010Ambulance"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
		["seat4"]="Shark_Idle_SidePassenger",
		["seat5"]="Shark_Idle_SidePassenger2",
	},

	["Base.SC_M35A1"] = {
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
	},
	
	["Base.ModernCar"] = {
        ["seat0"]="Shark_Idle_SmallCarDriver",
		["seat1"]="Shark_Idle_PassengerRelaxed",
        ["passenger"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_VWRabbit"] = {
        ["seat0"]="Shark_Idle_SmallCarDriver",
		["seat1"]="Shark_Idle_PassengerRelaxed",
        ["passenger"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_FordCountrySquire"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.CarStationWagon"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]="Shark_Idle_Passenger",
		["passenger"]="Shark_Idle_Passenger",
    },

	["Base.CarStationWagon2"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.CarLights"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.CarLightsPolice"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_CrownVictoriaCiv"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_CrownVictoriaStatePolice"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_CrownVictoriaParkRanger"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_CrownVictoriaLVPD"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_CrownVictoriaTaxi"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_CapriceCiv"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },	

	["Base.SC_Caprice9C1StatePolice"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },	

	["Base.SC_Caprice9C1ParkRanger"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SC_CapriceLVPD"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },	
	
	["Base.CarNormal"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.CarTaxi"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.CarTaxi02"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger",},
		["passenger"]={"Shark_Idle_Passenger",},
    },

	["Base.SportsCar"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
		["passenger"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
	},

	["Base.SC_CamaroTTop"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
		["passenger"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
	},

	["Base.SC_Mercedes280"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",50},
		["passenger"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
	},

	["Base.CarLuxury"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
		["passenger"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
	},

	["Base.SC_VWRabbit"] = {
        ["seat0"]="Shark_Idle_SmallCarDriver",
		["seat1"]="Shark_Idle_PassengerRelaxed",
        ["passenger"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_HondaAccord"] = {
        ["seat0"]="Shark_Idle_SmallCarDriver",
		["seat1"]="Shark_Idle_PassengerRelaxed",
        ["passenger"]="Shark_Idle_RearPassenger",
	},

	["Base.SmallCar"] = {
        ["seat0"]="Shark_Idle_SmallCarDriver",
		["seat1"]="Shark_Idle_PassengerRelaxed",
        ["passenger"]="Shark_Idle_RearPassenger",
	},

	["Base.SmallCar02"] = {
        ["seat0"]="Shark_Idle_SmallCarDriver",
		["seat1"]="Shark_Idle_PassengerRelaxed",
        ["passenger"]="Shark_Idle_RearPassenger",
	},

	["Base.SC_StepVanP30Civ"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.SC_StepVanP30Police"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.SC_StepVanP30ParkRanger"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.StepVan"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.StepVan_Scarlet"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.StepVan_Heralds"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.StepVanMail"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassenger",
		["seat3"]="Shark_Idle_SidePassenger2",
	},
	
	["Base.SC_G30Ambulance"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassengerAmbulance",
		["seat3"]="Shark_Idle_SidePassenger2",
	},

	["Base.VanAmbulance"] = {
        ["seat0"]="Bob_Idle_Driver",
		["seat1"]={"Shark_Idle_Passenger","Shark_Idle_PassengerAlternate",20},
        ["seat2"]="Shark_Idle_SidePassengerAmbulance",
		["seat3"]="Shark_Idle_SidePassenger2",
	},
	

}

---@param player IsoPlayer|IsoGameCharacter
local function Vehicle_Enter(player)
    ---@type BaseVehicle
    local vehicle = player:getVehicle()
    if not vehicle then return end

    local vehicleName = vehicle:getScriptName()
    print("SC_ANIM: DEBUG: "..vehicleName)

    local seat = vehicle:getSeat(player)
    print(" -- Seat: "..seat)
    if not seat then return end

    local vehicleAnimation = vehicleToSeatAnimations[vehicleName]
    if not vehicleAnimation then return end

    local fetchedAnimation = vehicleAnimation["seat"..seat] or vehicleAnimation["passenger"]
    if not fetchedAnimation then return end

    fetchedAnimation = parseSeatAnimationSelection(fetchedAnimation)
    print(" ---- Anim Selected: "..fetchedAnimation)

    if fetchedAnimation then
        player:SetVariable("VehicleScriptName", fetchedAnimation)
    end
end


Events.OnEnterVehicle.Add(Vehicle_Enter)
Events.OnSwitchVehicleSeat.Add(Vehicle_Enter)


local function Vehicle_Exit(player)
    --sendClientCommand(player, "SC_VehicleAnim", "PlayerExit", {})
    player:SetVariable("VehicleScriptName", "")
end
Events.OnExitVehicle.Add(Vehicle_Exit)
