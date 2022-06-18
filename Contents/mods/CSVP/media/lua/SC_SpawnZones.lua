if getActivatedMods():contains("SCKCO") and VehicleZoneDistribution then

    --- Military: Spawn zones for military vehicles in ---

    VehicleZoneDistribution.Military = VehicleZoneDistribution.Military or {};
    VehicleZoneDistribution.Military.vehicles = VehicleZoneDistribution.Military.vehicles or {};

    VehicleZoneDistribution.Military.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 40};
    VehicleZoneDistribution.Military.vehicles["Base.SC_M1009"] = {index = -1, spawnChance = 40};
    VehicleZoneDistribution.Military.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 40};

    --- LouisvillePolice: Spawn zones for Louisville police vehicles (such as LVPD cruisers) ---

    VehicleZoneDistribution.LouisvillePolice = VehicleZoneDistribution.LouisvillePolice or {};
    VehicleZoneDistribution.LouisvillePolice.vehicles = VehicleZoneDistribution.LouisvillePolice.vehicles or {};

    VehicleZoneDistribution.LouisvillePolice.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.LouisvillePolice.vehicles["Base.SC_CrownVictoriaLVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.LouisvillePolice.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 50};

    --- LouisvilleEmergency: Spawn zones for emergency vehicles in Louisville ---

    VehicleZoneDistribution.LouisvilleEmergency = VehicleZoneDistribution.LouisvillePolice or {};
    VehicleZoneDistribution.LouisvilleEmergency.vehicles = VehicleZoneDistribution.LouisvillePolice.vehicles or {};

    VehicleZoneDistribution.LouisvilleEmergency.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.LouisvilleEmergency.vehicles["Base.SC_CrownVictoriaLVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.LouisvilleEmergency.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.LouisvilleEmergency.vehicles["Base.SC_G30Ambulance"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.LouisvilleEmergency.vehicles["Base.SC_CrownFireCoach"] = {index = -1, spawnChance = 10};

    --- SurvivalistHunter: Spawn zones for hunter/survivalist vehicles in the middle of nowhere ---

    VehicleZoneDistribution.SurvivalistHunter = VehicleZoneDistribution.Military or {};
    VehicleZoneDistribution.SurvivalistHunter.vehicles = VehicleZoneDistribution.Military.vehicles or {};

    VehicleZoneDistribution.SurvivalistHunter.vehicles["Base.SC_K10"] = {index = -1, spawnChance = 40};
    VehicleZoneDistribution.SurvivalistHunter.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 40};
    VehicleZoneDistribution.SurvivalistHunter.vehicles["Base.SC_JeepCJ7"] = {index = -1, spawnChance = 40};

end
