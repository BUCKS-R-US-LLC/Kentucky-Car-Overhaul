-- Converts vanilla vehicles into SCKCO custom vehicles

SCKCO = SCKCO or {}
SCKCO.Replace = {}
SCKCO.Data = {}

-- ========================================
-- DATA TABLE
-- ========================================

SCKCO.Data.Tab = {
	-- Refer to core functions vehicle list
	["Base.CarNormal"] = {
		General = {  -- Default for all regions
			{ vehicleName = "Base.SC_FordCrownVictoria85", chance = 50 },
			{ vehicleName = "Base.SC_ChevroletCaprice85", chance = 50 },
		}
	},

	["Base.ModernCar"] = {
		General = {  
			{ vehicleName = "Base.SC_FordTaurus", chance = 30 },
			{ vehicleName = "Base.SC_ToyotaCamry", chance = 30 },
			{ vehicleName = "Base.SC_ChevroletCavalier", chance = 30 },
		}
	},

	["Base.ModernCar02"] = {
		General = {  
			{ vehicleName = "Base.SC_FordTaurus", chance = 30 },
			{ vehicleName = "Base.SC_ToyotaCamry", chance = 30 },
			{ vehicleName = "Base.SC_ChevroletCavalier", chance = 30 },
		}
	},

	["Base.SmallCar"] = {
		General = {  
			{ vehicleName = "Base.SC_HondaAccord", chance = 30 },
			{ vehicleName = "Base.SC_VWRabbit", chance = 30 },
			{ vehicleName = "Base.SC_VWRabbit_Pizza", chance = 30 },
		}
	},

	["Base.SmallCar02"] = {
		General = {  
			{ vehicleName = "Base.SC_HondaAccord", chance = 30 },
			{ vehicleName = "Base.SC_VWRabbit", chance = 30 },
			{ vehicleName = "Base.SC_VWRabbit_Pizza", chance = 30 },
		}
	},

	["Base.CarTaxi"] = {
		General = {  
			{ vehicleName = "Base.SC_FordCrownVictoria85_Taxi", chance = 100 },
		}
	},
	
	["Base.CarTaxi2"] = {
		General = {  
			{ vehicleName = "Base.SC_FordCrownVictoria85_Taxi", chance = 100 },
		}
	},

	["Base.CarStationWagon"] = {
		General = {  
			{ vehicleName = "Base.SC_FordCountrySquire", chance = 100 },
		}
	},
	
	["Base.CarStationWagon2"] = {
		General = {  
			{ vehicleName = "Base.SC_FordCountrySquire", chance = 100 },
		}
	},

	["Base.CarLuxury"] = {
		General = {  
			{ vehicleName = "Base.SC_Mercedes280", chance = 30 },
			{ vehicleName = "Base.SC_CadillacFleetwoodBrougham", chance = 30 },
			{ vehicleName = "Base.SC_CadillacLimo", chance = 5 },
			{ vehicleName = "Base.SC_Porsche911", chance = 30 },
			{ vehicleName = "Base.SC_BMW520i", chance = 30 },
		}
	},

	["Base.PickUpTruck"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletK10", chance = 30 },
			{ vehicleName = "Base.SC_FordF15092", chance = 30 },
			{ vehicleName = "Base.SC_DodgePowerWagon", chance = 30 },
			{ vehicleName = "Base.SC_MazdaB2000", chance = 30 },
		}
	},

	["Base.PickUpTruck_Camo"] = {
		General = {
			{ vehicleName = "Base.SC_DodgeM880_Bubba", chance = 100 },
		}
	},

	["Base.PickUpTruckLightsRanger"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletK10_ParkRanger", chance = 100 },
		}
	},

	["Base.Van"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletG30", chance = 100 },
		}
	},

	["Base.VanSeats"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletG30_PassengerVan", chance = 80 },
			{ vehicleName = "Base.SC_ChevroletG30_ChurchVan", chance = 5 },
			{ vehicleName = "Base.SC_ChevroletG30_ChurchBus", chance = 5 },
			{ vehicleName = "Base.SC_PlymouthVoyager", chance = 30 },
		}
	},

	["Base.VanAmbulance"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletG30_Ambulance", chance = 30 },
			{ vehicleName = "Base.SC_FordF350Ambulance_Life", chance = 30 },
			{ vehicleName = "Base.SC_FordF350Ambulance_Meade", chance = 30 },
			{ vehicleName = "Base.SC_FordF350Ambulance_Peregrin", chance = 30 },
		}
	},

	["Base.VanRadio"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletG30_LBMW", chance = 50 },
			{ vehicleName = "Base.SC_ChevroletG30_3N", chance = 50 },
		}
	},

	["Base.PickUpVan"] = {
		General = {
			{ vehicleName = "Base.SC_NissanPathfinder", chance = 30 },
			{ vehicleName = "Base.SC_ChevroletK5Blazer", chance = 30 },
			{ vehicleName = "Base.SC_ChevroletSuburban", chance = 30 },
			{ vehicleName = "Base.SC_GMCJimmyS15", chance = 30 },
		}
	},

	["Base.PickUpVanLightsRanger"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletK5Blazer_ParkRanger", chance = 100 },
		}
	},

	["Base.PickUpVanLightsPolice"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletSuburban_StatePolice", chance = 100 },
		}
	},

	["Base.PickUpVanLightsStatePolice"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletSuburban_StatePolice", chance = 100 },
		}
	},

	["Base.PickUpVan_Camo"] = {
		General = {
			{ vehicleName = "Base.SC_DodgeM880_Bubba", chance = 100 },
		}
	},

	["Base.SUV"] = {
		General = {
			{ vehicleName = "Base.SC_FordBronco", chance = 50 },
			{ vehicleName = "Base.SC_FordExplorer", chance = 30 },
			{ vehicleName = "Base.SC_NissanPathfinder", chance = 30 },
			{ vehicleName = "Base.SC_JeepCherokee", chance = 30 },
			{ vehicleName = "Base.SC_ChevroletK5Blazer", chance = 30 },
			{ vehicleName = "Base.SC_ChevroletSuburban", chance = 30 },
		}
	},

	["Base.OffRoad"] = {
		General = {
			{ vehicleName = "Base.SC_JeepCJ7", chance = 50 },
			{ vehicleName = "Base.SC_GeoTracker", chance = 50 },
		}
	},

	["Base.StepVan"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletP30", chance = 100 },
		}
	},

	["Base.StepVan_LouisvilleSWAT"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletP30_SWAT", chance = 50 },
			{ vehicleName = "Base.SC_ChevroletG30_JeffersonPD", chance = 50 },
		}
	},
	-- Park Rangers
	["Base.CarLightsRanger"] = {
		General = {
			{ vehicleName = "Base.SC_ChevroletCaprice85_ParkRanger", chance = 100 },
		}
	},
	-- State Police
	["Base.CarLightsKST"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria85_StatePolice", chance = 50 },
			{ vehicleName = "Base.SC_FordCrownVictoria92_StatePolice", chance = 50 },
		}
	},
	-- Generic Cops (usually KY State Police)
	["Base.CarLightsPolice"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria85_StatePolice", chance = 50 },
			{ vehicleName = "Base.SC_FordCrownVictoria92_StatePolice", chance = 50 },
		}
	},
	-- Muldraugh Cops (Can't find the real liveries)
	["Base.CarLightsMuldraughPolice"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria85_StatePolice", chance = 50 },
			{ vehicleName = "Base.SC_FordCrownVictoria92_StatePolice", chance = 50 },
		}
	},
	-- West Point Cops (Can't find the real liveries)
	["Base.ModernCarLightsWestPoint"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria85_StatePolice", chance = 50 },
			{ vehicleName = "Base.SC_FordCrownVictoria92_StatePolice", chance = 50 },
		}
	},
	-- Jefferson County & Audubon PD 
	["Base.CarLightsLouisvilleCounty"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria92_JeffersonPD", chance = 90 },
			{ vehicleName = "Base.SC_FordMustang90_JeffersonPD", chance = 10 },
			{ vehicleName = "Base.SC_JeepCherokee_AudubonPD", chance = 5 },
		}
	},
	-- Louisville PD
	["Base.ModernCarLightsCityLouisvillePD"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria85_LouisvillePolice", chance = 50 },
			{ vehicleName = "Base.SC_FordCrownVictoria92_LouisvillePD", chance = 50 },
		}
	},
	-- Bullitt County
	["Base.CarLightsBulletinSheriff"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria92_BullittSheriff", chance = 50 },
		}
	},
	-- Meade County
	["Base.ModernCarLightsMeadeSheriff"] = {
		General = {
			{ vehicleName = "Base.SC_FordCrownVictoria92_MeadeSheriff", chance = 50 },
			{ vehicleName = "Base.SC_FordCrownVictoria92_BrandenburgPD", chance = 50 },
		}
	},
}

-- ========================================
-- CORE FUNCTIONS
-- ========================================

-- Check if vehicle is vanilla
SCKCO.Replace.IsVanilla = function(vehicle)
	if not vehicle then return false end
	local scriptName = vehicle:getScriptName()
	if not scriptName then return false end
	
	local vanillaVehicles = {
		["Base.CarNormal"] = true,
		["Base.CarTaxi"] = true,
		["Base.CarTaxi2"] = true,
		["Base.SmallCar"] = true,
		["Base.SmallCar02"] = true,
		["Base.CarStationWagon"] = true,
		["Base.CarStationWagon2"] = true,
		["Base.CarLuxury"] = true,
		["Base.PickUpTruck"] = true,
		["Base.PickUpTruck_Camo"] = true,
		["Base.PickUpTruckLightsRanger"] = true,
		["Base.Van"] = true,
		["Base.VanSeats"] = true,
		["Base.VanRadio"] = true,
		["Base.VanAmbulance"] = true,
		["Base.SUV"] = true,
		["Base.OffRoad"] = true,
		["Base.StepVan"] = true,
		["Base.StepVan_LouisvilleSWAT"] = true,
		["Base.PickUpVan"] = true,
		["Base.PickUpVanLightsRanger"] = true,
		["Base.PickUpVanLightsPolice"] = true,
		["Base.PickUpVanLightsStatePolice"] = true,
		["Base.PickUpVan_Camo"] = true,
		["Base.CarLightsRanger"] = true,
		["Base.CarLightsKST"] = true,
		["Base.CarLightsPolice"] = true,
		["Base.CarLightsMuldraughPolice"] = true,
		["Base.CarLightsLouisvilleCounty"] = true,
		["Base.CarLightsBulletinSheriff"] = true,
		["Base.ModernCarLightsWestPoint"] = true,
		["Base.ModernCarLightsCityLouisvillePD"] = true,
		["Base.ModernCarLightsMeadeSheriff"] = true,
		-- Add more vanilla vehicles as needed
	}
	
	return vanillaVehicles[scriptName] == true
end

-- Get random replacement vehicle based on chance
SCKCO.Replace.GetRandomVehicle = function(scriptName, region)
	if not SCKCO.Data.Tab[scriptName] then return nil end
	
	local ReplaceData = SCKCO.Data.Tab[scriptName][region] or SCKCO.Data.Tab[scriptName].General
	if not ReplaceData then return nil end
	
	local randomChance = ZombRandFloat(0, 100)
	local cumulativeChance = 0
	
	for _, vehicleData in ipairs(ReplaceData) do
		cumulativeChance = cumulativeChance + (vehicleData.chance or 100)
		if randomChance <= cumulativeChance then
			return vehicleData
		end
	end
	
	return nil
end

-- Set random skin for vehicle
SCKCO.Replace.SetSkin = function(vehicle, VehicleData)
	if not VehicleData.skinIndexes then
		-- No specific skins defined, pick random from available
		local skinCount = ScriptManager.instance:getVehicle(VehicleData.vehicleName):getSkinCount()
		if skinCount > 1 then
			vehicle:setSkinIndex(ZombRand(skinCount))
		end
	else
		-- Use specified skins
		local skinIndex
		if type(VehicleData.skinIndexes) == "table" then
			skinIndex = VehicleData.skinIndexes[ZombRand(#VehicleData.skinIndexes) + 1]
		else
			skinIndex = VehicleData.skinIndexes
		end
		vehicle:setSkinIndex(skinIndex)
	end
	vehicle:transmitSkinIndex()
end

-- Main replacement function
SCKCO.Replace.DoReplace = function(vehicle)
	if isMultiplayer() and not isServer() then return end
	if not vehicle then return end
	if not SCKCO.Replace.IsVanilla(vehicle) then return end
	
	local square = vehicle:getSquare()
	if not square then return end
	
	local region = square:getSquareRegion() or "General"
	local scriptName = vehicle:getScriptName()
	if not scriptName then return end
	
	local VehicleData = SCKCO.Replace.GetRandomVehicle(scriptName, region)
	if not VehicleData then return end
	if not ScriptManager.instance:getVehicle(VehicleData.vehicleName) then return end
	
	-- Replace the vehicle
	vehicle:setScriptName(VehicleData.vehicleName)
	vehicle:scriptReloaded(true)
	SCKCO.Replace.SetSkin(vehicle, VehicleData)
end

-- ========================================
-- EVENT HOOKS
-- ========================================

Events.OnSpawnVehicleStart.Add(SCKCO.Replace.DoReplace)
