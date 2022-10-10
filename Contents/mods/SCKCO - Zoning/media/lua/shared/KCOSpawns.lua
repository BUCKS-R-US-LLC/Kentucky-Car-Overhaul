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
	VehicleZoneDistribution.louisville_police.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 1};
	VehicleZoneDistribution.louisville_police.vehicles["Base.SC_JeepCherokeeAudubon"] = {index = -1, spawnChance = 1};

	VehicleZoneDistribution.louisville_police.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.louisville_police.spawnRate = 75;
	
	VehicleZoneDistribution.louisville_fire = VehicleZoneDistribution.louisville_fire or {};
	VehicleZoneDistribution.louisville_fire.vehicles = VehicleZoneDistribution.louisville_fire.vehicles or {};

	VehicleZoneDistribution.louisville_fire.vehicles["Base.SC_CrownFireCoach"] = {index = -1, spawnChance = 80};

	VehicleZoneDistribution.louisville_fire.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.louisville_fire.chanceToSpawnKey = 80;
	VehicleZoneDistribution.louisville_fire.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.louisville_fire.spawnRate = 75;

	VehicleZoneDistribution.rosewood_fire = VehicleZoneDistribution.rosewood_fire or {};
	VehicleZoneDistribution.rosewood_fire.vehicles = VehicleZoneDistribution.rosewood_fire.vehicles or {};

	VehicleZoneDistribution.rosewood_fire.vehicles["Base.SC_CrownFireCoach"] = {index = -1, spawnChance = 80};

	VehicleZoneDistribution.rosewood_fire.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.rosewood_fire.chanceToSpawnKey = 80;
	VehicleZoneDistribution.rosewood_fire.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.rosewood_fire.spawnRate = 75;

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

	VehicleZoneDistribution.designated_bubba_zone.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.designated_bubba_zone.chanceToSpawnKey = 80;
	VehicleZoneDistribution.designated_bubba_zone.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.designated_bubba_zone.spawnRate = 55;
	
	VehicleZoneDistribution.cemetery = VehicleZoneDistribution.cemetery or {};
	VehicleZoneDistribution.cemetery.vehicles = VehicleZoneDistribution.cemetery.vehicles or {};

	VehicleZoneDistribution.cemetery.vehicles["Base.PickUpTruckMccoy"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.cemetery.vehicles["Base.CarLuxury"] = {index = -1, spawnChance = 10};

	VehicleZoneDistribution.cemetery.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.cemetery.chanceToSpawnKey = 80;
	VehicleZoneDistribution.cemetery.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.cemetery.spawnRate = 75;

end