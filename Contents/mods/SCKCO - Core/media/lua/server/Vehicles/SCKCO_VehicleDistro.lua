local distributionTable = VehicleDistributions[1]



VehicleDistributions.SCMilitary = {
    TruckBed = {
        rolls = 20,
        items = {
            "HandTorch", 1,
            "Radio.WalkieTalkie4", 10,

            -- SMUI --

            "SMUIClothing.Hat_PatrolCap", 10,
            "SMUIClothing.Hat.MilitaryHelmet", 10,
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

            -- SMUI -- 

            "SMUIClothing.Hat_WatchCap", 10,
            "SMUIClothing.Glasses_GIGlasses", 10,


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

            -- SMUI --

            "SMUIClothing.MPBrassard", 10,
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


distributionTable["SC_Caprice9C1StatePolice"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_Caprice9C1LVPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_Caprice9C1ParkRanger"] = { Normal = VehicleDistributions.SCPolicePatrol; }

distributionTable["SC_FordMustangStatePolice"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_FordMustangJeffersonCounty"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_FordMustangUndercover"] = { Normal = VehicleDistributions.SCPolicePatrol; }
distributionTable["SC_CrownVictoriaLVPD"] = { Normal = VehicleDistributions.SCPolicePatrol; }

distributionTable["SC_CapriceCiv"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_StepVanP30Civ"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordCountrySquire"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_G30Windowless"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_G30VanNormal"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CamaroTTop"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_Mercedes280"] = { Normal = VehicleDistributions.SCCivilian; }

distributionTable["SC_M1009MilitaryPolice"] = { Normal = VehicleDistributions.SCMilitaryPolice; }
distributionTable["SC_CadillacGageRangerLights"] = { Normal = VehicleDistributions.SCMilitaryPolice; }
distributionTable["SC_M1009"] = { Normal = VehicleDistributions.SCMilitary; }
distributionTable["SC_M1008"] = { Normal = VehicleDistributions.SCMilitary; }
