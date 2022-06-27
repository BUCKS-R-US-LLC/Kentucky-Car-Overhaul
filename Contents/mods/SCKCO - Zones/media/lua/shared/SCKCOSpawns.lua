require "SCKCO"

if VehicleZoneDistribution then
	---------------------------------Vanilla Fixes---------------------------------

	---SCKMilitary: Military spawns of course---

	VehicleZoneDistribution.SCKMilitary = VehicleZoneDistribution.SCKMilitary or {};
	VehicleZoneDistribution.SCKMilitary.vehicles = VehicleZoneDistribution.SCKMilitary.vehicles or {};

	VehicleZoneDistribution.SCKMilitary.vehicles["Base.M1009MilitaryPolice"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKMilitary.vehicles["Base.M1009"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKMilitary.vehicles["Base.M1008"] = {index = -1, spawnChance = 25};
	
	VehicleZoneDistribution.SCKMilitary.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.SCKMilitary.spawnRate = 25;
	
end