if VehicleZoneDistribution then -- check if the table exists for backwards compatibility
-- Parking Stall, common parking stall with random cars, the most used one (shop parking lots, houses etc.)

-- Kentucky State Police
VehicleZoneDistribution.policeksp = VehicleZoneDistribution.policeksp or {}
VehicleZoneDistribution.policeksp.vehicles = VehicleZoneDistribution.policeksp.vehicles or {}
VehicleZoneDistribution.policeksp.vehicles["Base.85crownvic_kentuckystate"] = {index = -1, spawnChance = 100};
VehicleZoneDistribution.policeksp.vehicles["Base.92crownvic_kentuckystate"] = {index = -1, spawnChance = 100};
VehicleZoneDistribution.policeksp.chanceToSpawnNormal = 0;

-- Louisville Police
VehicleZoneDistribution.policelouisvillepd = VehicleZoneDistribution.policelouisvillepd or {}
VehicleZoneDistribution.policelouisvillepd.vehicles = VehicleZoneDistribution.policelouisvillepd.vehicles or {}
VehicleZoneDistribution.policelouisvillepd.vehicles["Base.92crownvic_louisvillepolice"] = {index = -1, spawnChance = 100};
VehicleZoneDistribution.policelouisvillepd.chanceToSpawnNormal = 0;


end
