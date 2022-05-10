if VehicleZoneDistribution then

    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_K5BlazerStatePolice"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_Caprice9C1StatePolice"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_CrownP72StatePolice"] = {index = -1, spawnChance = 15};
    VehicleZoneDistribution.trafficjamw.spawnRate = 10;
    
    VehicleZoneDistribution.police.vehicles["Base.SC_K5BlazerStatePolice"] = {index = -1, spawnChance = 15};
    VehicleZoneDistribution.police.vehicles["Base.SC_Caprice9C1StatePolice"] = {index = -1, spawnChance = 15};
    VehicleZoneDistribution.police.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 1};
    VehicleZoneDistribution.police.vehicles["Base.SC_CrownP72StatePolice"] = {index = -1, spawnChance = 15};
    VehicleZoneDistribution.police.spawnRate = 10;

    VehicleZoneDistribution.military = VehicleZoneDistribution.military or {}
    VehicleZoneDistribution.military.vehicles = VehicleZoneDistribution.military.vehicles or {}
    VehicleZoneDistribution.military.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.military.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.military.spawnRate = 10;

end