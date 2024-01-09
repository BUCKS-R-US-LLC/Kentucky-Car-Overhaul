local distributionTable = VehicleDistributions[1]

VehicleDistributions.SC_CUCV = {
    TruckBed = {
        rolls = 50,
        items = {

            "MEA.GIJerryCan", 10,
            "MEA.AmmoCan556X45", 50,
            "MEA.AmmoCan762X51", 50,
            "MEA.AmmoCan50BMG", 10,

        },
        junk = {
            rolls = 1,
            items = {

                "FirstAidKit", 1,
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
            }
        }
    },

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

VehicleDistributions.SC_M151 = {
    TruckBed = {
        rolls = 50,
        items = {

            "MEA.GIJerryCan", 10,
            "MEA.AmmoCan556X45", 50,
            "MEA.AmmoCan762X51", 50,
            "MEA.AmmoCan50BMG", 10,

        },
        junk = {
            rolls = 1,
            items = {

                "FirstAidKit", 1,
            }
        }
    },

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

VehicleDistributions.SC_Humvee = {
    TruckBed = {
        rolls = 50,
        items = {

            "MEA.GIJerryCan", 10,
            "MEA.AmmoCan556X45", 50,
            "MEA.AmmoCan762X51", 50,
            "MEA.AmmoCan50BMG", 10,

        },
        junk = {
            rolls = 1,
            items = {

                "FirstAidKit", 1,
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

                "SCA.MREWrapper_SCA", 4,
            }
        }
    },

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

distributionTable["SC_K5BlazerFossoil"] = distributionTable["CarNormal"]
distributionTable["SC_K5BlazerMcCoys"] = distributionTable["CarNormal"]
distributionTable["SC_MazdaB"] = distributionTable["CarNormal"]
distributionTable["SC_PlymouthVoyager"] = distributionTable["CarNormal"]
distributionTable["SC_CadillacBrougham"] = distributionTable["CarNormal"]
distributionTable["SC_CadillacLimo"] = distributionTable["CarNormal"]
distributionTable["SC_CadillacFleetwood"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletCavalier"] = distributionTable["CarNormal"]
distributionTable["SC_FordBronco"] = distributionTable["CarNormal"]
distributionTable["SC_FordF150"] = distributionTable["CarNormal"]
distributionTable["SC_FordMustang"] = distributionTable["CarNormal"]
distributionTable["SC_JeepCJ7"] = distributionTable["CarNormal"]
distributionTable["SC_JeepCherokee"] = distributionTable["CarNormal"]
distributionTable["SC_CrownVictoria92"] = distributionTable["CarNormal"]
distributionTable["SC_GeoTracker"] = distributionTable["CarNormal"]
distributionTable["SC_M880Bubba"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletC70GrainTruck"] = distributionTable["CarNormal"]
distributionTable["SC_CapriceCiv"] = distributionTable["CarNormal"]
distributionTable["SC_StepVanP30Civ"] = distributionTable["CarNormal"]
distributionTable["SC_FordCountrySquire"] = distributionTable["CarNormal"]
distributionTable["SC_G30Windowless"] = distributionTable["CarNormal"]
distributionTable["SC_G30VanNormal"] = distributionTable["CarNormal"]
distributionTable["SC_CrownVictoria92"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletSuburban"] = distributionTable["CarNormal"]

distributionTable["SC_FordF350Ambulance"] = distributionTable["Ambulance"]
distributionTable["SC_M1010Ambulance"] = distributionTable["Ambulance"]

distributionTable["SC_Porsche911G50"] = distributionTable["SportsCar"]
distributionTable["SC_BMW520i"] = distributionTable["SportsCar"]
distributionTable["SC_CadillacBrougham"] = distributionTable["SportsCar"]
distributionTable["SC_CadillacFleetwood"] = distributionTable["SportsCar"]
distributionTable["SC_CadillacLimo"] = distributionTable["SportsCar"]

distributionTable["SC_Caprice9C1StatePolice"] = distributionTable["CarLightsPolice"]
distributionTable["SC_Caprice9C1LVPD"] = distributionTable["CarLightsPolice"]
distributionTable["SC_Caprice9C1ParkRanger"] = distributionTable["CarLightsPolice"]
distributionTable["SC_FordMustangStatePolice"] = distributionTable["CarLightsPolice"]
distributionTable["SC_FordMustangJeffersonCounty"] = distributionTable["CarLightsPolice"]
distributionTable["SC_FordMustangUndercover"] = distributionTable["CarLightsPolice"]
distributionTable["SC_CrownVictoriaLVPD"] = distributionTable["CarLightsPolice"]
distributionTable["SC_CrownVictoriaLouisville92"] = distributionTable["CarLightsPolice"]
distributionTable["SC_CrownVictoriaJefferson92"] = distributionTable["CarLightsPolice"]
distributionTable["SC_CrownVictoriaWarrena92"] = distributionTable["CarLightsPolice"]
distributionTable["SC_CrownVictoriaMuhlenberg92"] = distributionTable["CarLightsPolice"]

distributionTable["SC_M1008"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1009"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1009MilitaryPolice"] = { Normal = VehicleDistributions.SC_CUCV; }

distributionTable["SC_M151A2"] = { Normal = VehicleDistributions.SC_M151; }
distributionTable["SC_M151A2Cleaners"] = { Normal = VehicleDistributions.SC_M151; }

distributionTable["SC_M1025"] = { Normal = VehicleDistributions.SC_Humvee; }
distributionTable["SC_M998"] = { Normal = VehicleDistributions.SC_Humvee; }

distributionTable["SC_M35A1"] = { Normal = VehicleDistributions.SC_M35; }
