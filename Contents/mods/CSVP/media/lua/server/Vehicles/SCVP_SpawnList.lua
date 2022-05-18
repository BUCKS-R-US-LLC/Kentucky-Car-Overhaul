if VehicleZoneDistribution then

    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_K5BlazerStatePolice"] = {index = -1, spawnChance = 40};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_Caprice9C1StatePolice"] = {index = -1, spawnChance = 30};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_CrownVictoriaStatePolice"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.trafficjamw.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.trafficjamw.spawnRate = 10;
    
    VehicleZoneDistribution.police.vehicles["Base.SC_K5BlazerStatePolice"] = {index = -1, spawnChance = 70};
    VehicleZoneDistribution.police.vehicles["Base.SC_Caprice9C1StatePolice"] = {index = -1, spawnChance = 60};
    VehicleZoneDistribution.police.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.police.vehicles["Base.SC_CrownVictoriaStatePolice"] = {index = -1, spawnChance = 60};
    VehicleZoneDistribution.police.spawnRate = 30;
    VehicleZoneDistribution.police.chanceToPartDamage = 5;

    VehicleZoneDistribution.ranger.vehicles["Base.SC_K5BlazerParkRanger"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.ranger.vehicles["Base.SC_Caprice9C1ParkRanger"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.ranger.vehicles["Base.SC_StepVanP30ParkRanger"] = {index = -1, spawnChance = 1};
    VehicleZoneDistribution.ranger.vehicles["Base.SC_CrownVictoriaParkRanger"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.ranger.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.ranger.chanceToPartDamage = 5;
    
    VehicleZoneDistribution.medium.vehicles["Base.SC_K5BlazerStatePolice"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.medium.vehicles["Base.SC_Caprice9C1StatePolice"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.medium.vehicles["Base.SC_K5BlazerParkRanger"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.medium.vehicles["Base.SC_CrownVictoriaParkRanger"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.medium.vehicles["Base.SC_CrownVictoriaLVPD"] = {index = -1, spawnChance = 1};

    VehicleZoneDistribution.good.vehicles["Base.SC_K5BlazerParkRanger"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.good.vehicles["Base.SC_Caprice9C1ParkRanger"] = {index = -1, spawnChance = 5};    
    VehicleZoneDistribution.good.vehicles["Base.SC_CrownVictoriaStatePolice"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.good.vehicles["Base.SC_Crown9C1StatePolice"] = {index = -1, spawnChance = 10};
    VehicleZoneDistribution.good.vehicles["Base.SC_K5BlazerParkRanger"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.good.vehicles["Base.SC_Caprice9C1ParkRanger"] = {index = -1, spawnChance = 5};
    VehicleZoneDistribution.good.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 1};

    VehicleZoneDistribution.military = VehicleZoneDistribution.military or {}
    VehicleZoneDistribution.military.vehicles = VehicleZoneDistribution.military.vehicles or {}
    VehicleZoneDistribution.military.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 20};
    VehicleZoneDistribution.military.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 30};
    VehicleZoneDistribution.military.spawnRate = 10;

end