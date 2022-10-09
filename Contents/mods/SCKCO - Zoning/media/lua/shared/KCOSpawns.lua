if VehicleZoneDistribution then

	VehicleZoneDistribution.military_light = VehicleZoneDistribution.military_light or {};
	VehicleZoneDistribution.military_light.vehicles = VehicleZoneDistribution.military_light.vehicles or {};

	VehicleZoneDistribution.military_light.vehicles["Base.SC_M1009"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.military_light.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 10};
	VehicleZoneDistribution.military_light.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 50};
	VehicleZoneDistribution.military_light.vehicles["Base.SC_M1008TroopCarrier"] = {index = -1, spawnChance = 30};
	VehicleZoneDistribution.military_light.vehicles["Base.SC_M1010Ambulance"] = {index = -1, spawnChance = 20};

	VehicleZoneDistribution.military_light.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_light.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_light.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_light.spawnRate = 30;

	VehicleZoneDistribution.military_heavy = VehicleZoneDistribution.military_light or {};
	VehicleZoneDistribution.military_heavy.vehicles = VehicleZoneDistribution.military_light.vehicles or {};

	VehicleZoneDistribution.military_heavy.vehicles["Base.SC_M35A1"] = {index = -1, spawnChance = 100};

	VehicleZoneDistribution.military_heavy.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_heavy.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_heavy.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_heavy.spawnRate = 30;
	
end