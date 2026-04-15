-- Converts vanilla vehicles into SCKCO custom vehicles

SCKCO = SCKCO or {}
SCKCO.Replace = {}

local function vehicle(name, chance)
	return { vehicleName = name, chance = chance }
end

SCKCO.Data = {

	["Base.CarNormal"] = {
		vehicle("Base.SC_FordCrownVictoria85", 50),
		vehicle("Base.SC_ChevroletCaprice85", 50),
	},

	["Base.ModernCar"] = {
		vehicle("Base.SC_FordTaurus", 30),
		vehicle("Base.SC_ToyotaCamry", 30),
		vehicle("Base.SC_ChevroletCavalier", 30),
	},
	["Base.ModernCar02"] = {
		vehicle("Base.SC_FordTaurus", 30),
		vehicle("Base.SC_ToyotaCamry", 30),
		vehicle("Base.SC_ChevroletCavalier", 30),
	},

	["Base.SmallCar"] = {
		vehicle("Base.SC_HondaAccord", 30),
		vehicle("Base.SC_VWRabbit", 30),
		vehicle("Base.SC_VWRabbit_Pizza", 30),
	},
	["Base.SmallCar02"] = {
		vehicle("Base.SC_HondaAccord", 30),
		vehicle("Base.SC_VWRabbit", 30),
		vehicle("Base.SC_VWRabbit_Pizza", 30),
	},

	["Base.CarTaxi"]  = { vehicle("Base.SC_FordCrownVictoria85_Taxi", 100) },
	["Base.CarTaxi2"] = { vehicle("Base.SC_FordCrownVictoria85_Taxi", 100) },

	["Base.CarStationWagon"]  = { vehicle("Base.SC_FordCountrySquire", 100) },
	["Base.CarStationWagon2"] = { vehicle("Base.SC_FordCountrySquire", 100) },

	["Base.CarLuxury"] = {
		vehicle("Base.SC_Mercedes280", 30),
		vehicle("Base.SC_CadillacFleetwoodBrougham", 30),
		vehicle("Base.SC_CadillacLimo", 5),
		vehicle("Base.SC_Porsche911", 30),
		vehicle("Base.SC_BMW520i", 30),
	},

	["Base.PickUpTruck"] = {
		vehicle("Base.SC_ChevroletK10", 30),
		vehicle("Base.SC_FordF15092", 30),
		vehicle("Base.SC_DodgePowerWagon", 30),
		vehicle("Base.SC_MazdaB2000", 30),
	},

	["Base.PickUpTruck_Camo"]        = { vehicle("Base.SC_DodgeM880_Bubba", 100) },
	["Base.PickUpTruckLightsRanger"] = { vehicle("Base.SC_ChevroletK10_ParkRanger", 100) },

	["Base.Van"] = { vehicle("Base.SC_ChevroletG30", 100) },

	["Base.VanSpiffo"] = { vehicle("Base.SC_ChevroletG30_Spiffo", 100) },
		
	["Base.VanSeats"] = {
		vehicle("Base.SC_ChevroletG30_PassengerVan", 80),
		vehicle("Base.SC_ChevroletG30_ChurchVan", 5),
		vehicle("Base.SC_ChevroletG30_ChurchBus", 5),
		vehicle("Base.SC_PlymouthVoyager", 30),
	},

	["Base.VanAmbulance"] = {
		vehicle("Base.SC_ChevroletG30_Ambulance", 30),
		vehicle("Base.SC_FordF350Ambulance_Life", 30),
		vehicle("Base.SC_FordF350Ambulance_Meade", 30),
		vehicle("Base.SC_FordF350Ambulance_Peregrin", 30),
	},

	["Base.VanRadio"] = {
		vehicle("Base.SC_ChevroletG30_LBMW", 50),
		vehicle("Base.SC_ChevroletG30_3N", 50),
	},

	["Base.PickUpVan"] = {
		vehicle("Base.SC_NissanPathfinder", 30),
		vehicle("Base.SC_ChevroletK5Blazer", 30),
		vehicle("Base.SC_ChevroletSuburban", 30),
		vehicle("Base.SC_GMCJimmyS15", 30),
	},

	["Base.PickUpVanLightsRanger"]      = { vehicle("Base.SC_ChevroletK5Blazer_ParkRanger", 100) },
	["Base.PickUpVanLightsPolice"]      = { vehicle("Base.SC_ChevroletSuburban_StatePolice", 100) },
	["Base.PickUpVanLightsStatePolice"] = { vehicle("Base.SC_ChevroletSuburban_StatePolice", 100) },
	["Base.PickUpVan_Camo"]             = { vehicle("Base.SC_DodgeM880_Bubba", 100) },

	["Base.SUV"] = {
		vehicle("Base.SC_FordBronco", 50),
		vehicle("Base.SC_FordExplorer", 30),
		vehicle("Base.SC_NissanPathfinder", 30),
		vehicle("Base.SC_JeepCherokee", 30),
		vehicle("Base.SC_ChevroletK5Blazer", 30),
		vehicle("Base.SC_ChevroletSuburban", 30),
	},

	["Base.OffRoad"] = {
		vehicle("Base.SC_JeepCJ7", 50),
		vehicle("Base.SC_GeoTracker", 50),
	},

	["Base.StepVan"] = { vehicle("Base.SC_ChevroletP30", 100) },

	["Base.StepVan_LouisvilleSWAT"] = {
		vehicle("Base.SC_ChevroletP30_SWAT", 50),
		vehicle("Base.SC_ChevroletG30_JeffersonPD", 50),
	},

	-- Park Rangers
	["Base.CarLightsRanger"] = { vehicle("Base.SC_ChevroletCaprice85_ParkRanger", 100) },

	-- State Police / Generic Cops
	["Base.CarLightsKST"] = {
		vehicle("Base.SC_FordCrownVictoria85_StatePolice", 50),
		vehicle("Base.SC_FordCrownVictoria92_StatePolice", 50),
	},
	["Base.CarLightsPolice"] = {
		vehicle("Base.SC_FordCrownVictoria85_StatePolice", 50),
		vehicle("Base.SC_FordCrownVictoria92_StatePolice", 50),
	},

	-- Muldraugh Cops
	["Base.CarLightsMuldraughPolice"] = {
		vehicle("Base.SC_FordCrownVictoria85_StatePolice", 50),
		vehicle("Base.SC_FordCrownVictoria92_StatePolice", 50),
		vehicle("Base.SC_FordCrownVictoria92_MeadeSheriff", 50),
	},

	-- West Point Cops
	["Base.ModernCarLightsWestPoint"] = {
		vehicle("Base.SC_FordCrownVictoria85_StatePolice", 50),
		vehicle("Base.SC_FordCrownVictoria92_StatePolice", 50),
		vehicle("Base.SC_FordCrownVictoria92_BullittSheriff", 50),
	},

	-- Jefferson County & Audubon PD
	["Base.CarLightsLouisvilleCounty"] = {
		vehicle("Base.SC_FordCrownVictoria92_JeffersonPD", 90),
		vehicle("Base.SC_FordMustang90_JeffersonPD", 10),
		vehicle("Base.SC_JeepCherokee_AudubonPD", 5),
	},

	-- Louisville PD
	["Base.ModernCarLightsCityLouisvillePD"] = {
		vehicle("Base.SC_FordCrownVictoria85_LouisvillePolice", 50),
		vehicle("Base.SC_FordCrownVictoria92_LouisvillePD", 50),
	},

	-- Bullitt County
	["Base.CarLightsBulletinSheriff"] = {
		vehicle("Base.SC_FordCrownVictoria92_BullittSheriff", 50),
	},

	-- Meade County
	["Base.ModernCarLightsMeadeSheriff"] = {
		vehicle("Base.SC_FordCrownVictoria92_MeadeSheriff", 50),
		vehicle("Base.SC_FordCrownVictoria92_BrandenburgPD", 50),
	},
}

SCKCO.Replace.IsVanilla = function(v)
	if not v then return false end
	local scriptName = v:getScriptName()
	return scriptName and SCKCO.Data[scriptName] ~= nil
end

SCKCO.Replace.GetRandomVehicle = function(scriptName)
	local pool = SCKCO.Data[scriptName]
	if not pool then return nil end
	local roll = ZombRandFloat(0, 100)
	local cumulative = 0
	for _, entry in ipairs(pool) do
		cumulative = cumulative + (entry.chance or 100)
		if roll <= cumulative then return entry end
	end
end

SCKCO.Replace.SetSkin = function(v, entry)
	local skinIndex
	if entry.skinIndexes then
		local si = entry.skinIndexes
		skinIndex = type(si) == "table" and si[ZombRand(#si) + 1] or si
	else
		local count = ScriptManager.instance:getVehicle(entry.vehicleName):getSkinCount()
		if count > 1 then skinIndex = ZombRand(count) end
	end
	if skinIndex then v:setSkinIndex(skinIndex) end
	v:transmitSkinIndex()
end

SCKCO.Replace.DoReplace = function(v)
	if isMultiplayer() and not isServer() then return end
	if not v or not SCKCO.Replace.IsVanilla(v) then return end
	local scriptName = v:getScriptName()
	local entry = SCKCO.Replace.GetRandomVehicle(scriptName)
	if not entry or not ScriptManager.instance:getVehicle(entry.vehicleName) then return end
	v:setScriptName(entry.vehicleName)
	v:scriptReloaded(true)
	SCKCO.Replace.SetSkin(v, entry)
end

Events.OnSpawnVehicleStart.Add(SCKCO.Replace.DoReplace)