local distributionTable = VehicleDistributions[1]

VehicleDistributions.SC_CUCV = {
    GunRack = {
        rolls = 50,
        items = {
            "Base.AssaultRifle", 100,
        }
    },
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
    SeatRearLeft = VehicleDistributions.Seat,
    SeatRearRight = VehicleDistributions.Seat,
}

VehicleDistributions.SC_CUCVMed = {
    AmbulanceContainers = {
        rolls = 5,
        items = {
            "Bag_MedicalBag", 10,
            "FirstAidKit", 10,
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
                "HandTorch", 4,
                "Lighter", 4,
            }
        }
    },
    SeatRearLeft = VehicleDistributions.Seat,
    SeatRearRight = VehicleDistributions.Seat,
}

VehicleDistributions.SC_CityPoliceCar = {
    GunRack = {
        rolls = 50,
        items = {
            "Base.Shotgun", 100,
        }
    },
    TruckBed = {
        rolls = 50,
        items = {
            "Mov_RoadCone", 10,
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
                "HandTorch", 4,
                "Lighter", 4,
            }
        }
    },
    SeatRearLeft = VehicleDistributions.Seat,
    SeatRearRight = VehicleDistributions.Seat,
}

VehicleDistributions.SC_StatePoliceCar = {
    GunRack = {
        rolls = 50,
        items = {
            "Base.Shotgun", 100,
        }
    },
    TruckBed = {
        rolls = 50,
        items = {
            "Mov_RoadCone", 10,
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
                "HandTorch", 4,
                "Lighter", 4,
            }
        }
    },
    SeatRearLeft = VehicleDistributions.Seat,
    SeatRearRight = VehicleDistributions.Seat,
}

distributionTable["SC_HondaAccord"] = distributionTable["CarNormal"]
distributionTable["SC_VWRabbit"] = distributionTable["CarNormal"]
distributionTable["SC_VWRabbitPizza"] = distributionTable["CarNormal"]
distributionTable["SC_K5BlazerFossoil"] = distributionTable["CarNormal"]
distributionTable["SC_K5BlazerMcCoys"] = distributionTable["CarNormal"]
distributionTable["SC_MazdaB2000"] = distributionTable["CarNormal"]
distributionTable["SC_PlymouthVoyager"] = distributionTable["CarNormal"]
distributionTable["SC_CadillacBrougham"] = distributionTable["CarNormal"]
distributionTable["SC_CadillacLimo"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletCavalier"] = distributionTable["CarNormal"]
distributionTable["SC_FordBronco"] = distributionTable["CarNormal"]
distributionTable["SC_FordF150"] = distributionTable["CarNormal"]
distributionTable["SC_FordMustang"] = distributionTable["CarNormal"]
distributionTable["SC_JeepCJ7"] = distributionTable["CarNormal"]
distributionTable["SC_JeepCherokee"] = distributionTable["CarNormal"]
distributionTable["SC_FordCrownVictoria92"] = distributionTable["CarNormal"]
distributionTable["SC_GeoTracker"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletC70GrainTruck"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletCaprice85"] = distributionTable["CarNormal"]
distributionTable["SC_FordCountrySquire"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletG30Windowless"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletG30VanNormal"] = distributionTable["CarNormal"]
distributionTable["SC_FordCrownVictoria85"] = distributionTable["CarNormal"]
distributionTable["SC_FordCrownVictoria92"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletSuburban"] = distributionTable["CarNormal"]
distributionTable["SC_FordExplorer"] = distributionTable["CarNormal"]
distributionTable["SC_Mercedes280"] = distributionTable["CarNormal"]
distributionTable["SC_CamaroTTop"] = distributionTable["CarNormal"]
distributionTable["SC_GeoTracker"] = distributionTable["CarNormal"]

distributionTable["SC_FordF350Ambulance"] = distributionTable["Ambulance"]
distributionTable["SC_M1010Ambulance"] = distributionTable["Ambulance"]

distributionTable["SC_Porsche911G50"] = distributionTable["SportsCar"]
distributionTable["SC_BMW520i"] = distributionTable["SportsCar"]
distributionTable["SC_CadillacBrougham"] = distributionTable["SportsCar"]
distributionTable["SC_CadillacFleetwood"] = distributionTable["SportsCar"]

distributionTable["SC_FordF700ArmoredBank"] = { Normal = VehicleDistributions.SC_BankCar }
distributionTable["SC_FordF700ArmoredPolice"] = { Normal = VehicleDistributions.SC_SWATTruck }
distributionTable["SC_P30SWAT"] = { Normal = VehicleDistributions.SC_SWATTruck }
distributionTable["SC_FordCrownVictoriaStatePolice85"] = { Normal = VehicleDistributions.SC_StatePoliceCar }
distributionTable["SC_FordCrownVictoriaParkRanger85"] = { Normal = VehicleDistributions.SC_StatePoliceCar }
distributionTable["SC_FordCrownVictoriaLVPD85"] = { Normal = VehicleDistributions.SC_StatePoliceCar }
distributionTable["SC_ChevroletCapriceStatePolice85"] = { Normal = VehicleDistributions.SC_StatePoliceCar }
distributionTable["SC_ChevroletCapriceParkRanger85"] = { Normal = VehicleDistributions.SC_StatePoliceCar }
distributionTable["SC_ChevroletCapriceLVPD85"] = { Normal = VehicleDistributions.SC_StatePoliceCar }

distributionTable["SC_HahnPumperRed"] = { Normal = VehicleDistributions.SC_HahnPumper; }
distributionTable["SC_HahnPumperYellow"] = { Normal = VehicleDistributions.SC_HahnPumper; }

distributionTable["SC_M880Bubba"] = { Normal = VehicleDistributions.SC_Bubba; }
distributionTable["SC_M880Militia"] = { Normal = VehicleDistributions.SC_Militia; }

distributionTable["SC_M1008"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1009"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1009MilitaryPolice"] = { Normal = VehicleDistributions.SC_CUCV; }
distributionTable["SC_M1010Ambulance"] = { Normal = VehicleDistributions.SC_CUCVMed; }

distributionTable["SC_CadillacLimo"] = { Normal = VehicleDistributions.SC_Limo; }

distributionTable["SC_M151A2"] = { Normal = VehicleDistributions.SC_M151; }
distributionTable["SC_M151A2Cleaners"] = { Normal = VehicleDistributions.SC_Cleaners; }

distributionTable["SC_M1025"] = { Normal = VehicleDistributions.SC_Humvee; }
distributionTable["SC_M998"] = { Normal = VehicleDistributions.SC_Humvee; }

distributionTable["SC_M35A1"] = { Normal = VehicleDistributions.SC_M35; }

distributionTable["SC_ChevroletG30BoxVan"] = { Normal = VehicleDistributions.SC_WorkingVan; }
distributionTable["SC_ChevroletG30McCoy"] = { Normal = VehicleDistributions.SC_McCoy; }

distributionTable["SC_ChevroletK10Dixie"] = { Normal = VehicleDistributions.SC_DrunkDriver; }

distributionTable["SC_GrummanLLV"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVanMail"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVan_Heralds"] = { Normal = VehicleDistributions.SC_P30Heralds }
