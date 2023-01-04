if VehicleZoneDistribution then

	VehicleZoneDistribution.military_general = VehicleZoneDistribution.military_general or {};
	VehicleZoneDistribution.military_general.vehicles = VehicleZoneDistribution.military_general.vehicles or {};

	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1009"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 70};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1028A3"] = {index = -1, spawnChance = 70};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1008TroopCarrier"] = {index = -1, spawnChance = 70};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1010Ambulance"] = {index = -1, spawnChance = 50};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M35A1"] = {index = -1, spawnChance = 60};

	VehicleZoneDistribution.military_general.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_general.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_general.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_general.spawnRate = 100;

	VehicleZoneDistribution.military_heavyvehicles = VehicleZoneDistribution.military_heavyvehicles or {};
	VehicleZoneDistribution.military_heavyvehicles.vehicles = VehicleZoneDistribution.military_heavyvehicles.vehicles or {};

	VehicleZoneDistribution.military_heavyvehicles.vehicles["Base.SC_M35A1"] = {index = -1, spawnChance = 100};

	VehicleZoneDistribution.military_heavyvehicles.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_heavyvehicles.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_heavyvehicles.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_heavyvehicles.spawnRate = 100;

	VehicleZoneDistribution.military_police = VehicleZoneDistribution.military_police or {};
	VehicleZoneDistribution.military_police.vehicles = VehicleZoneDistribution.military_police.vehicles or {};

	VehicleZoneDistribution.military_police.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 70};

	VehicleZoneDistribution.military_police.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_police.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_police.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_police.spawnRate = 100;

	VehicleZoneDistribution.louisville_police = VehicleZoneDistribution.louisville_police or {};
	VehicleZoneDistribution.louisville_police.vehicles = VehicleZoneDistribution.louisville_police.vehicles or {};

	VehicleZoneDistribution.louisville_police.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 80};
	VehicleZoneDistribution.louisville_police.vehicles["Base.SC_CrownVictoriaLVPD"] = {index = -1, spawnChance = 90};
	VehicleZoneDistribution.louisville_police.vehicles["Base.SC_JeepCherokeeAudubon"] = {index = -1, spawnChance = 20};

	VehicleZoneDistribution.louisville_police.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.louisville_police.spawnRate = 75;
	
	VehicleZoneDistribution.louisville_fire_engines = VehicleZoneDistribution.louisville_fire_engines or {};
	VehicleZoneDistribution.louisville_fire_engines.vehicles = VehicleZoneDistribution.louisville_fire_engines.vehicles or {};

	VehicleZoneDistribution.louisville_fire_engines.vehicles["Base.SC_CrownFireCoach"] = {index = -1, spawnChance = 80};

	VehicleZoneDistribution.louisville_fire_engines.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.louisville_fire_engines.chanceToSpawnKey = 80;
	VehicleZoneDistribution.louisville_fire_engines.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.louisville_fire_engines.spawnRate = 75;

	VehicleZoneDistribution.national_park_service = VehicleZoneDistribution.national_park_service or {};
	VehicleZoneDistribution.national_park_service.vehicles = VehicleZoneDistribution.national_park_service.vehicles or {};

	VehicleZoneDistribution.national_park_service.vehicles["Base.PickUpVanLights"] = {index = -1, spawnChance = 80};
	VehicleZoneDistribution.national_park_service.vehicles["Base.CarLights"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.national_park_service.vehicles["Base.SC_Caprice9C1ParkRanger"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.national_park_service.vehicles["Base.PickUpTruckLights"] = {index = -1, spawnChance = 80};
	VehicleZoneDistribution.national_park_service.vehicles["Base.SC_StepVanP30ParkRanger"] = {index = -1, spawnChance = 5};

	VehicleZoneDistribution.national_park_service.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.national_park_service.chanceToSpawnKey = 80;
	VehicleZoneDistribution.national_park_service.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.national_park_service.spawnRate = 75;

	VehicleZoneDistribution.construction_site = VehicleZoneDistribution.construction_site or {};
	VehicleZoneDistribution.construction_site.vehicles = VehicleZoneDistribution.construction_site.vehicles or {};

	VehicleZoneDistribution.construction_site.vehicles["Base.PickUpTruckMccoy"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.construction_site.vehicles["Base.PickUpVanMccoy"] = {index = -1, spawnChance = 40};
	VehicleZoneDistribution.construction_site.vehicles["Base.G30Mccoy"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.construction_site.vehicles["Base.G30BoxVan"] = {index = -1, spawnChance = 80};

	VehicleZoneDistribution.construction_site.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.construction_site.chanceToSpawnKey = 80;
	VehicleZoneDistribution.construction_site.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.construction_site.spawnRate = 75;

	VehicleZoneDistribution.designated_bubba_zone = VehicleZoneDistribution.designated_bubba_zone or {};
	VehicleZoneDistribution.designated_bubba_zone.vehicles = VehicleZoneDistribution.designated_bubba_zone.vehicles or {};

	VehicleZoneDistribution.designated_bubba_zone.vehicles["Base.PickUpTruck"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.designated_bubba_zone.vehicles["Base.PickUpVan"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.designated_bubba_zone.vehicles["Base.SC_FordBronco"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.designated_bubba_zone.vehicles["Base.SC_FordF150"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.designated_bubba_zone.vehicles["Base.ChevroletC70Survivalist"] = {index = -1, spawnChance = 5};
	VehicleZoneDistribution.designated_bubba_zone.vehicles["Base.CUCVZhenjaEdition"] = {index = -1, spawnChance = 5};

	VehicleZoneDistribution.designated_bubba_zone.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.designated_bubba_zone.chanceToSpawnKey = 80;
	VehicleZoneDistribution.designated_bubba_zone.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.designated_bubba_zone.spawnRate = 55;
	
	VehicleZoneDistribution.cemetery = VehicleZoneDistribution.cemetery or {};
	VehicleZoneDistribution.cemetery.vehicles = VehicleZoneDistribution.cemetery.vehicles or {};

	VehicleZoneDistribution.cemetery.vehicles["Base.SC_CadillacFuneralCoach"] = {index = -1, spawnChance = 80};

	VehicleZoneDistribution.cemetery.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.cemetery.chanceToSpawnKey = 80;
	VehicleZoneDistribution.cemetery.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.cemetery.spawnRate = 75;

	VehicleZoneDistribution.military_police_medical = VehicleZoneDistribution.military_police_medical or {};
	VehicleZoneDistribution.military_police_medical.vehicles = VehicleZoneDistribution.military_police_medical.vehicles or {};

	VehicleZoneDistribution.military_police_medical.vehicles["Base.VanAmbulance"] = {index = -1, spawnChance = 10};
	VehicleZoneDistribution.military_police_medical.vehicles["Base.SC_K5BlazerStatePolice"] = {index = -1, spawnChance = 40};
	VehicleZoneDistribution.military_police_medical.vehicles["Base.SC_Caprice9C1StatePolice"] = {index = -1, spawnChance = 40};
	VehicleZoneDistribution.military_police_medical.vehicles["Base.SC_M1009"] = {index = -1, spawnChance = 30};
	VehicleZoneDistribution.military_police_medical.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.military_police_medical.vehicles["Base.SC_M1010Ambulance"] = {index = -1, spawnChance = 40};
	VehicleZoneDistribution.military_police_medical.vehicles["Base.SC_M35A1"] = {index = -1, spawnChance = 15};

	VehicleZoneDistribution.military_police_medical.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_police_medical.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_police_medical.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_police_medical.spawnRate = 75;
	
	VehicleZoneDistribution.police_tactical_vehicles = VehicleZoneDistribution.police_tactical_vehicles or {};
	VehicleZoneDistribution.police_tactical_vehicles.vehicles = VehicleZoneDistribution.police_tactical_vehicles.vehicles or {};

	VehicleZoneDistribution.police_tactical_vehicles.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 50};
	VehicleZoneDistribution.police_tactical_vehicles.vehicles["Base.SC_FordF700Police"] = {index = -1, spawnChance = 50};

	VehicleZoneDistribution.police_tactical_vehicles.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.police_tactical_vehicles.chanceToSpawnKey = 80;
	VehicleZoneDistribution.police_tactical_vehicles.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.police_tactical_vehicles.spawnRate = 70;

	VehicleZoneDistribution.large_utility_vehicles = VehicleZoneDistribution.large_utility_vehicles or {};
    VehicleZoneDistribution.large_utility_vehicles.vehicles = VehicleZoneDistribution.large_utility_vehicles.vehicles or {};

    VehicleZoneDistribution.large_utility_vehicles.vehicles["Base.SC_FordF700BoxTruck"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.large_utility_vehicles.vehicles["Base.SC_FordF700PanelTruck"] = {index = -1, spawnChance = 60};

    VehicleZoneDistribution.large_utility_vehicles.baseVehicleQuality = 1.1;
    VehicleZoneDistribution.large_utility_vehicles.chanceToSpawnKey = 80;
    VehicleZoneDistribution.large_utility_vehicles.chanceToSpawnSpecial = 0;
    VehicleZoneDistribution.large_utility_vehicles.spawnRate = 70;

end