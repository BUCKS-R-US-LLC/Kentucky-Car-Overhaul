require "SCKCO"

if VehicleZoneDistribution then
	---------------------------------Vanilla Fixes---------------------------------

	--- SCKMilitary: Military spawns in the Exclusion zone and out---

	VehicleZoneDistribution.SCKMilitary = VehicleZoneDistribution.SCKMilitary or {};
	VehicleZoneDistribution.SCKMilitary.vehicles = VehicleZoneDistribution.SCKMilitary.vehicles or {};

	VehicleZoneDistribution.SCKMilitary.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKMilitary.vehicles["Base.SC_M1009"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKMilitary.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 25};
	
	VehicleZoneDistribution.SCKMilitary.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.SCKMilitary.spawnRate = 25;

	-- SCKLVPD: Louisville police only spawns
	
	VehicleZoneDistribution.SCKLVPD = VehicleZoneDistribution.SCKMilitary or {};
	VehicleZoneDistribution.SCKLVPD.vehicles = VehicleZoneDistribution.SCKMilitary.vehicles or {};

	VehicleZoneDistribution.SCKLVPD.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKLVPD.vehicles["Base.CrownVictoriaLVPD"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKLVPD.vehicles["Base.StepVanP30Police"] = {index = -1, spawnChance = 25};
	
	VehicleZoneDistribution.SCKLVPD.chanceToSpawnSpecial = 0;
	VehicleZoneDistribution.SCKLVPD.spawnRate = 25;

	-- SCKLVEmergency: Mix of LVPD and Fire Department--

	VehicleZoneDistribution.SCKLVEmergency = VehicleZoneDistribution.SCKLVEmergency or {};
	VehicleZoneDistribution.SCKLVEmergency.vehicles = VehicleZoneDistribution.SCKLVEmergency.vehicles or {};

	VehicleZoneDistribution.SCKLVEmergency.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKLVEmergency.vehicles["Base.SC_CrownVictoriaLVPD"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKLVEmergency.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 25};
	VehicleZoneDistribution.SCKLVEmergency.vehicles["Base.SC_CrownFireCoach"] = {index = -1, spawnChance = 25};
	VehicleZoneDistribution.SCKLVEmergency.vehicles["Base.SC_G30Ambulance"] = {index = -1, spawnChance = 25};
	
	-- SCKFarmers: Farmer trucks and trailers --

	VehicleZoneDistribution.SCKFarmers = VehicleZoneDistribution.SCKFarmers or {};
	VehicleZoneDistribution.SCKFarmers.vehicles = VehicleZoneDistribution.SCKFarmers.vehicles or {};

	VehicleZoneDistribution.SCKFarmers.vehicles["Base.SC_K10"] = {index = -1, spawnChance = 20};
	VehicleZoneDistribution.SCKFarmers.vehicles["Base.SC_K5BlazerCiv"] = {index = -1, spawnChance = 20};
	
end