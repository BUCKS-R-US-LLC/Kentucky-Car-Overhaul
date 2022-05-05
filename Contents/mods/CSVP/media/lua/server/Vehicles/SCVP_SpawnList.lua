if VehicleZoneDistribution then

    
    VehicleZoneDistribution.trafficjamw.vehicles["Base.IFAV"] = {index = -1, spawnChance = 1};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.IFAV"] = {index = -1, spawnChance = 1};
    VehicleZoneDistribution.junkyard.chanceToPartDamage = 45;
    
    -- I really wish I could spawn these via events

    VehicleZoneDistribution.farm = VehicleZoneDistribution.farm or {}
    VehicleZoneDistribution.farm.vehicles = VehicleZoneDistribution.farm.vehicles or {}
    VehicleZoneDistribution.farm.vehicles["Base.IFAV"] = {index = -1, spawnChance = 3};
    VehicleZoneDistribution.farm.vehicles["Base.IFAV"] = {index = -1, spawnChance = 3};
    VehicleZoneDistribution.farm.spawnRate = 5;

    VehicleZoneDistribution.military = VehicleZoneDistribution.military or {}
    VehicleZoneDistribution.military.vehicles = VehicleZoneDistribution.military.vehicles or {}
    VehicleZoneDistribution.military.vehicles["Base.IFAV"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.military.vehicles["Base.IFAV"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.military.spawnRate = 10;

end