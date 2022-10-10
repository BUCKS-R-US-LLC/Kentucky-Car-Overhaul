if VehicleZoneDistribution then

	VehicleZoneDistribution.military_general = VehicleZoneDistribution.military_general or {};
	VehicleZoneDistribution.military_general.vehicles = VehicleZoneDistribution.military_general.vehicles or {};

	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1009"] = {index = -1, spawnChance = 60};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 70};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1008TroopCarrier"] = {index = -1, spawnChance = 70};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M1010Ambulance"] = {index = -1, spawnChance = 50};
	VehicleZoneDistribution.military_general.vehicles["Base.SC_M35A1"] = {index = -1, spawnChance = 60};

	VehicleZoneDistribution.military_general.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_general.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_general.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_general.spawnRate = 100;

	VehicleZoneDistribution.military_police = VehicleZoneDistribution.military_police or {};
	VehicleZoneDistribution.military_police.vehicles = VehicleZoneDistribution.military_police.vehicles or {};

	VehicleZoneDistribution.military_police.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 70};

	VehicleZoneDistribution.military_police.baseVehicleQuality = 1.1;
	VehicleZoneDistribution.military_police.chanceToSpawnKey = 80;
	VehicleZoneDistribution.military_police.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.military_police.spawnRate = 100;

end