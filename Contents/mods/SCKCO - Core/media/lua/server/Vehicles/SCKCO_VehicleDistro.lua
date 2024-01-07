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

                "SCA.MREWrapper_SCA", 4,
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

                -- Accessories --

                "SCA.MealReadytoEat_SCA", 5,
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

                "SCA.MREWrapper_SCA", 4,
            }
        }
    },

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

VehicleDistributions.SC_M35 = {
    TruckBed = {
        rolls = 50,
        items = {

            "Base.M35SoftTop", 50,
            "MEA.GIJerryCan", 10,
            "MEA.AmmoCan556X45", 50,
            "MEA.AmmoCan762X51", 50,
            "MEA.AmmoCan50BMG", 10,

        },
    }
}

VehicleDistributions.SC_Police = {
    TruckBed = {
        rolls = 20,
        items = {
            "HandTorch", 1,
            "Radio.WalkieTalkie4", 10,

            -- SCGL. --

            "Base.Shotgun", 2,
            "Base.ShotgunShellsBox", 5,
            "Vest_BulletPolice", 10,

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

VehicleDistributions.SC_Civilian = {
    TruckBed = {
        rolls = 20,
        items = {
            "HottieZ", 5,
            "Cigarettes", 8,
            "Glasses_Aviators", 0.5,
            "HandTorch", 4,
            "Lighter", 4,

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

distributionTable["SC_K5BlazerFossoil"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_K5BlazerMcCoys"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_MazdaB"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_PlymouthVoyager"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_Porsche911G50"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_BMW520i"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_CadillacBrougham"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_CadillacLimo"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_JaguarXJ6"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_CadillacFleetwood"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_ChevroletCavalier"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordBronco"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordF150"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordMustang"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_JeepCJ7"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_JeepCherokee"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_CrownVictoria92"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_GeoTracker"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_M880Bubba"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_ChevroletC70GrainTruck"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordF700PanelTruck"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordF700DumpTruck"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordF700BoxTruck"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordF700Greenes"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordF700GigaMart"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordF700MacTools"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_CapriceCiv"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_StepVanP30Civ"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_FordCountrySquire"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_G30Windowless"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_G30VanNormal"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_CamaroTTop"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_Mercedes280"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_CrownVictoria92"] = { Normal = VehicleDistributions.SC_Civilian; }
distributionTable["SC_ChevroletSuburban"] = { Normal = VehicleDistributions.SC_Civilian; }

distributionTable["SC_Caprice9C1StatePolice"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_Caprice9C1LVPD"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_Caprice9C1ParkRanger"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_FordMustangStatePolice"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_FordMustangJeffersonCounty"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_FordMustangUndercover"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_CrownVictoriaLVPD"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_CrownVictoriaLouisville92"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_CrownVictoriaJefferson92"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_CrownVictoriaWarrena92"] = { Normal = VehicleDistributions.SC_Police; }
distributionTable["SC_CrownVictoriaMuhlenberg92"] = { Normal = VehicleDistributions.SC_Police; }

distributionTable["SC_M1008"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1009"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1009MilitaryPolice"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1010Ambulance"] = { Normal = VehicleDistributions.SC_CUCV; }

distributionTable["SC_M151A2"] = { Normal = VehicleDistributions.SC_M151; }
distributionTable["SC_M151A2Cleaners"] = { Normal = VehicleDistributions.SC_M151; }

distributionTable["SC_M1025"] = { Normal = VehicleDistributions.SC_Humvee; }
distributionTable["SC_M998"] = { Normal = VehicleDistributions.SC_Humvee; }

distributionTable["SC_M35A1"] = { Normal = VehicleDistributions.SC_M35; }