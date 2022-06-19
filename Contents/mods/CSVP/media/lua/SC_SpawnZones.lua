if getActivatedMods():contains("SCKCO") and VehicleZoneDistribution then

    --- SCKMilitary: Spawn zones for military vehicles in ---

    VehicleZoneDistribution.SCKMilitary = VehicleZoneDistribution.Military or {};
    VehicleZoneDistribution.SCKMilitary.vehicles = VehicleZoneDistribution.Military.vehicles or {};

    VehicleZoneDistribution.SCKMilitary.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 100};
    VehicleZoneDistribution.SCKMilitary.vehicles["Base.SC_M1009"] = {index = -1, spawnChance = 100};
    VehicleZoneDistribution.SCKMilitary.vehicles["Base.SC_M1009MilitaryPolice"] = {index = -1, spawnChance = 100};

    --- SCKLouisvillePolice: Spawn zones for Louisville police vehicles (such as LVPD cruisers) ---

    VehicleZoneDistribution. = VehicleZoneDistributi or {};
    VehicleZoneDistribution..vehicles = VehicleZoneDistributi.vehicles or {};

    VehicleZoneDistribution.SCKLouisvillePolice.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.SCKLouisvillePolice.vehicles["Base.SC_CrownVictoriaLVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.SCKLouisvillePolice.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 50};

    --- SCKLouisvilleEmergency: Spawn zones for emergency vehicles in Louisville ---

    VehicleZoneDistribution.SCKLouisvilleEmergency = VehicleZoneDistributi or {};
    VehicleZoneDistribution.SCKLouisvilleEmergency.vehicles = VehicleZoneDistributi.vehicles or {};

    VehicleZoneDistribution.SCKLouisvilleEmergency.vehicles["Base.SC_Caprice9C1LVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.SCKLouisvilleEmergency.vehicles["Base.SC_CrownVictoriaLVPD"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.SCKLouisvilleEmergency.vehicles["Base.SC_StepVanP30Police"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.SCKLouisvilleEmergency.vehicles["Base.SC_G30Ambulance"] = {index = -1, spawnChance = 50};
    VehicleZoneDistribution.SCKLouisvilleEmergency.vehicles["Base.SC_CrownFireCoach"] = {index = -1, spawnChance = 10};

    --- SCKSurvivalistHunter: Spawn zones for hunter/survivalist vehicles in the middle of nowhere ---

    VehicleZoneDistribution.SCKSurvivalistHunter = VehicleZoneDistribution.Military or {};
    VehicleZoneDistribution.SCKSurvivalistHunter.vehicles = VehicleZoneDistribution.Military.vehicles or {};

    VehicleZoneDistribution.SCKSurvivalistHunter.vehicles["Base.SC_K10"] = {index = -1, spawnChance = 40};
    VehicleZoneDistribution.SCKSurvivalistHunter.vehicles["Base.SC_M1008"] = {index = -1, spawnChance = 40};
    VehicleZoneDistribution.SCKSurvivalistHunter.vehicles["Base.SC_JeepCJ7"] = {index = -1, spawnChance = 40};

end
