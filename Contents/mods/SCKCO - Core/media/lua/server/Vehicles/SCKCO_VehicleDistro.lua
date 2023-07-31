local distributionTable = VehicleDistributions[1]



VehicleDistributions.SCMilitary = {
    TruckBed = {
        rolls = 20,
        items = {
            "HandTorch", 1,
            "Radio.WalkieTalkie4", 10,

            -- SPGO. --

            "SPGOClothing.Hat_PatrolCapWoodland", 10,
            "SPGOClothing.Hat.PASGTHelmetWoodland", 10,
            "Vest_BulletArmy", 10,

            -- MEA -- 
            
            "MEA.GIJerryCan", 10,
            "MEA.AmmoCan762X51", 10,
            "MEA.AmmoCan50BMG", 10,
            "MEA.ANPRC113", 5,
            "MEA.ANPRC119", 5,

        },
        junk = {
            rolls = 1,
            items = {
                "FirstAidKit", 1,

                -- Accessories --

                "SCA.MealReadytoEat_SCA", 5,
            }
        }
    },

    GloveBox = {
        rolls = 5,
        items = {
            "Battery", 10,
            "HandTorch", 4,

            -- SPGO. -- 

            "SPGOClothing.Hat_WatchCap", 10,
            "SPGOClothing.Glasses_GIGlasses", 10,


        },
        junk = {
            rolls = 1,
            items = {
                "HottieZ", 5,
                "Cigarettes", 8,
                "Glasses_Aviators", 0.5,
                "HandTorch", 4,
                "Lighter", 4,

                -- Accessories -- 

                "SCA.MREWrapper_SCA", 4,
            }
        }
    },

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

VehicleDistributions.SCMilitaryPolice = {
    TruckBed = {
        rolls = 4,
        items = {
            "HandTorch", 4,
            "Radio.WalkieTalkie4", 10,

            -- SPGO. --

            "SPGOClothing.MPBrassard", 10,
            "Vest_BulletArmy", 10,
        },
        junk = {
            rolls = 1,
            items = {
                "FirstAidKit", 20,

                -- Accessories --

                "SCA.MealReadytoEat_SCA", 10,
            }
        }
    },

    GloveBox = {
        rolls = 4,
        items = {
            "Battery", 10,
            "HandTorch", 4,
        },
        junk = {
            rolls = 1,
            items = {
                "HottieZ", 5,
                "Cigarettes", 8,
                "Glasses_Aviators", 0.5,
                "HandTorch", 4,
                "Lighter", 4,

                -- Accessories -- 

                "SCA.MREWrapper_SCA", 4,
                
            }
        }
    },

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

VehicleDistributions.SCPolicePatrol = {
    TruckBed = {
        rolls = 20,
        items = {
            "HandTorch", 1,
            "Radio.WalkieTalkie4", 10,

            -- SPGO. --

            "Base.Shotgun", 2,
            "Base.ShotgunShells", 5,
            "Vest_Police", 10,

        },
        junk = {
            rolls = 1,
            items = {
                "FirstAidKit", 1,

                -- Accessories --

                "SCA.MealReadytoEat_SCA", 5,
            }
        }
    },

    GloveBox = {
        rolls = 5,
        items = {
            "Battery", 10,
            "HandTorch", 4,

        },
        junk = {
            rolls = 1,
            items = {
                "HottieZ", 5,
                "Cigarettes", 8,
                "Glasses_Aviators", 0.5,
                "HandTorch", 4,
                "Lighter", 4,

                -- Accessories -- 

                "SCA.CitationPad_SCA", 15,
            }
        }
    },

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

VehicleDistributions.SCCivilianGloveBox = {
    rolls = 15,
    items ={
        "Base.MarchRidgeMap", 1,
        "Base.MuldraughMap", 1,
        "Base.RiversideMap", 1,
        "Base.RosewoodMap", 1,
        "Base.WestpointMap", 1,
        "Magazine", 10,
        "Notebook", 10,
        "Pistol", 0.3,
        "Glasses_Aviators", 2,
        "Bandaid", 10,
        "Battery", 10,
        "RedPen", 8,
        "HandTorch", 1,
        "RubberBand", 6,
    }
}

VehicleDistributions.SCCivilianMisc = {
    rolls = 10,
    items ={

        "FirstAidKit", 0.3,
    }
}

VehicleDistributions.SCCivilian = {

	GloveBox = VehicleDistributions.SCCivilianGloveBox;
	TruckBed = VehicleDistributions.SCCivilianMisc;
}

distributionTable["SC_K5BlazerFossoil"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_K5BlazerMcCoys"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_MazdaB"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_PlymouthVoyager"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_Porsche911G50"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_BMW520i"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CadillacBrougham"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_JaguarXJ6"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CadillacFleetwood"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_ChevroletCavalier"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordBronco"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordF150"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordMustang"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_JeepCJ7"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_JeepCherokee"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CrownVictoria92"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_GeoTracker"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_M880Bubba"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_ChevroletC70GrainTruck"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordF700PanelTruck"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordF700DumpTruck"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordF700BoxTruck"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordF700Greenes"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordF700GigaMart"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordF700MacTools"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CapriceCiv"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_StepVanP30Civ"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordCountrySquire"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_G30Windowless"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_G30VanNormal"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CamaroTTop"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_Mercedes280"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_MercedesSL500"] = { Normal = VehicleDistributions.SCCivilian; }

distributionTable["SC_Caprice9C1StatePolice"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_Caprice9C1LVPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_Caprice9C1ParkRanger"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_FordMustangStatePolice"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_FordMustangJeffersonCounty"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_FordMustangUndercover"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_CrownVictoriaLVPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_CrownVictoria92LVPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_CrownVictoria92JeffersonPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_CrownVictoria92WarrenPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_CrownVictoria92MuhlenbergPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_CrownVictoria92StatePolice"] = { Normal = VehicleDistributions.SCPolicePatrol; }

distributionTable["SC_M1009MilitaryPolice"] = { Normal = VehicleDistributions.SCMilitaryPolice; }
distributionTable["SC_CadillacGageRanger"] = { Normal = VehicleDistributions.SCMilitaryPolice; }
distributionTable["SC_CadillacGageRangerLights"] = { Normal = VehicleDistributions.SCMilitaryPolice; }
distributionTable["SC_M1009"] = { Normal = VehicleDistributions.SCMilitary; }
distributionTable["SC_M1008"] = { Normal = VehicleDistributions.SCMilitary; }
distributionTable["SC_M1028A3"] = { Normal = VehicleDistributions.SCMilitary; }
distributionTable["SC_M1025"] = { Normal = VehicleDistributions.SCMilitary; }
distributionTable["SC_M998"] = { Normal = VehicleDistributions.SCMilitary; }
distributionTable["SC_M151A2"] = { Normal = VehicleDistributions.SCMilitary; }
distributionTable["SC_M151A2Cleaners"] = { Normal = VehicleDistributions.SCMilitary; }