local distributionTable = VehicleDistributions[1]

VehicleDistributions.SC_MilitaryGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    },
    junk = {
        rolls = 1,
        items = {
            "Pistol", 8,
        }
    }
}

VehicleDistributions.SC_MilitaryFootwellSpace = {
    rolls = 1,
    items = {
        "HandTorch", 1,
        "556Clip", 1,
        "556Bullets", 1,
    }
}

VehicleDistributions.SC_MilitaryTruckBed = {
    rolls = 4,
    items = {
        "SCGLClothing.Bag_SmallALICEPack", 10,
        "SCGLClothing.Bag_MediumALICEPack", 10,
        "SCGLClothing.Bag_LargeALICEPack", 10,
        "MEA.GIJerryCan", 10,
        "MEA.AmmoCan556X45", 50,
        "MEA.AmmoCan762X51", 50,
        "MEA.AmmoCan50BMG", 10,
    }
}

VehicleDistributions.SC_MilitaryGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle", 100,
    }
}

VehicleDistributions.SC_MilitaryBackTruck = {
    rolls = 4,
    items = {
        "SCGLClothing.Hat_PASGTHelmetWoodland", 1,
        "Vest_BulletArmy", 1,
        "AssaultRifle", 1,
    }
}

VehicleDistributions.SC_Military = {
    TruckBed = VehicleDistributions.SC_MilitaryTruckBed,
    TruckBedOpen = VehicleDistributions.SC_MilitaryTruckBed,
    GunRackSC = VehicleDistributions.SC_MilitaryGunRack,
    BackOfTruck = VehicleDistributions.SC_MilitaryBackTruck,
    FrontFootwellSpace = VehicleDistributions.SC_MilitaryFootwellSpace,
    RearFootwellSpace = VehicleDistributions.SC_MilitaryFootwellSpace,
    GloveBox = VehicleDistributions.SC_MilitaryGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_MilitiaGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    },
    junk = {
        rolls = 1,
        items = {
            "Pistol", 8,
        }
    }
}

VehicleDistributions.SC_MilitiaFootwellSpace = {
    rolls = 1,
    items = {
        "HandTorch", 1,
        "Bag_ShotgunBag", 1,
        "Bag_MedicalBag", 1,
    }
}

VehicleDistributions.SC_MilitiaTruckBed = {
    rolls = 4,
    items = {
        "MEA.GIJerryCan", 10,
        "MEA.AmmoCan556X45", 50,
        "MEA.AmmoCan762X51", 50,
        "MEA.AmmoCan50BMG", 10,
    }
}

VehicleDistributions.SC_MilitiaGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle2", 100,
        "Shotgun", 100,
    }
}

VehicleDistributions.SC_Militia = {
    TruckBed = VehicleDistributions.SC_MilitiaTruckBed,
    TruckBedOpen = VehicleDistributions.SC_MilitiaTruckBed,
    GunRackSC = VehicleDistributions.SC_MilitiaGunRack,
    FrontFootwellSpace = VehicleDistributions.SC_MilitiaFootwellSpace,
    RearFootwellSpace = VehicleDistributions.SC_MilitiaFootwellSpace,
    GloveBox = VehicleDistributions.SC_MilitiaGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_PoliceGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    },
    junk = {
        rolls = 1,
        items = {
            "Pistol", 8,
        }
    }
}

VehicleDistributions.SC_PoliceFootwellSpace = {
    rolls = 1,
    items = {
        "Pen", 1,
        "RedPen", 1,
        "RubberBand", 1,
    }
}

VehicleDistributions.SC_PoliceTruckBed = {
    rolls = 4,
    items = {
        "Mov_RoadCone", 10,
    }
}

VehicleDistributions.SC_PoliceGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle2", 100,
        "Shotgun", 100,
    }
}

VehicleDistributions.SC_Police = {
    TruckBed = VehicleDistributions.SC_PoliceTruckBed,
    TruckBedOpen = VehicleDistributions.SC_PoliceTruckBed,
    GunRackSC = VehicleDistributions.SC_PoliceGunRack,
    FrontFootwellSpace = VehicleDistributions.SC_PoliceFootwellSpace,
    RearFootwellSpace = VehicleDistributions.SC_PoliceFootwellSpace,
    GloveBox = VehicleDistributions.SC_PoliceGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_BubbaGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    },
    junk = {
        rolls = 1,
        items = {
            "Pistol", 8,
        }
    }
}

VehicleDistributions.SC_BubbaFootwellSpace = {
    rolls = 1,
    items = {
        "Bag_ShotgunBag", 1,
    }
}

VehicleDistributions.SC_BubbaTruckBed = {
    rolls = 4,
    items = {
        "HuntingRifle", 100,
    }
}

VehicleDistributions.SC_BubbaGunRack = {
    rolls = 100,
    items = {
        "HuntingRifle", 100,
        "Shotgun", 100,
    }
}

VehicleDistributions.SC_Bubba = {
    TruckBed = VehicleDistributions.SC_BubbaTruckBed,
    TruckBedOpen = VehicleDistributions.SC_BubbaTruckBed,
    GunRackSC = VehicleDistributions.SC_BubbaGunRack,
    FrontFootwellSpace = VehicleDistributions.SC_BubbaFootwellSpace,
    RearFootwellSpace = VehicleDistributions.SC_BubbaFootwellSpace,
    GloveBox = VehicleDistributions.SC_BubbaGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_BankCarGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_BankCarFootwellSpace = {
    rolls = 1,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
    }
}

VehicleDistributions.SC_BankCarTruckBed = {
    rolls = 500,
    items = {
        "Bag_MoneyBag", 500,
        "Bag_MoneyBag", 500,
        "Bag_MoneyBag", 500,
        "Bag_MoneyBag", 500,
        "Bag_MoneyBag", 500,
        "Bag_MoneyBag", 500,
    }
}

VehicleDistributions.SC_BankCar = {
    BackOfTruck = VehicleDistributions.SC_BankCarTruckBed,
    FrontFootwellSpace = VehicleDistributions.SC_BankCarFootwellSpace,
    GloveBox = VehicleDistributions.SC_BankCarGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_MailCarGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_MailCarFootwellSpace = {
    rolls = 1,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
    }
}

VehicleDistributions.SC_MailCarTruckBed = {
    rolls = 50,
    items = {
        "HottieZ", 00.01,
        "Magazine", 50,
        "TVMagazine", 50,
        "FarmingMag1", 1,
        "EngineerMagazine1", 1,
        "EngineerMagazine2", 1,
        "MagazineCrossword1", 5,
        "MagazineCrossword2", 5,
        "MagazineCrossword3", 5,
        "MagazineWordsearch1", 5,
        "MagazineWordsearch2", 5,
        "MagazineWordsearch3", 5,
        "HuntingMag01", 1,
        "HuntingMag02", 1,
        "HuntingMag03", 1,
        "HuntingMag04", 1,
    }
}

VehicleDistributions.SC_MailCar = {
    TruckBed = VehicleDistributions.SC_MailCarTruckBed,
    BackOfTruck = VehicleDistributions.SC_MailCarTruckBed,
    FrontFootwellSpace = VehicleDistributions.SC_MailCarFootwellSpace,
    GloveBox = VehicleDistributions.SC_MailCarGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_PaperCarGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_PaperCarFootwellSpace = {
    rolls = 1,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
    }
}

VehicleDistributions.SC_PaperCarTruckBed = {
    rolls = 50,
    items = {
        "Newspaper", 50,
        "Newspaper", 50,
        "Newspaper", 50,
        "Newspaper", 50,
        "Newspaper", 50,
        "Newspaper", 50,
    }
}

VehicleDistributions.SC_PaperCar = {
    BackOfTruck = VehicleDistributions.SC_PaperCarTruckBed,
    FrontFootwellSpace = VehicleDistributions.SC_PaperCarFootwellSpace,
    GloveBox = VehicleDistributions.SC_PaperCarGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

distributionTable["SC_HondaAccord"] = distributionTable["CarNormal"]
distributionTable["SC_VWRabbit"] = distributionTable["CarNormal"]
distributionTable["SC_VWRabbitPizza"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletK5Blazer"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletK5BlazerFossoil"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletK5BlazerMcCoys"] = distributionTable["CarNormal"]
distributionTable["SC_MazdaB2000"] = distributionTable["CarNormal"]
distributionTable["SC_PlymouthVoyager"] = distributionTable["CarNormal"]
distributionTable["SC_CadillacLimo"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletCavalier"] = distributionTable["CarNormal"]
distributionTable["SC_FordBronco"] = distributionTable["CarNormal"]
distributionTable["SC_FordF150"] = distributionTable["CarNormal"]
distributionTable["SC_JeepCJ7"] = distributionTable["CarNormal"]
distributionTable["SC_JeepCherokee"] = distributionTable["CarNormal"]
distributionTable["SC_FordCrownVictoria92"] = distributionTable["CarNormal"]
distributionTable["SC_GeoTracker"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletC70GrainTruck"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletCaprice85"] = distributionTable["CarNormal"]
distributionTable["SC_FordCountrySquire"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletG30Windowless"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletG30Seats"] = distributionTable["CarNormal"]
distributionTable["SC_FordCrownVictoria85"] = distributionTable["CarNormal"]
distributionTable["SC_FordCrownVictoria92"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletSuburban"] = distributionTable["CarNormal"]
distributionTable["SC_FordExplorer"] = distributionTable["CarNormal"]
distributionTable["SC_Mercedes280"] = distributionTable["CarNormal"]
distributionTable["SC_ChevroletK10Dixie"] = { Normal = VehicleDistributions.SC_Bubba }
distributionTable["SC_M880Bubba"] = { Normal = VehicleDistributions.SC_Bubba }
distributionTable["SC_M880Militia"] = { Normal = VehicleDistributions.SC_Militia }
distributionTable["SC_CUCVZhenjaEdition"] = { Normal = VehicleDistributions.SC_Militia }
distributionTable["SC_ChevroletC70Survivalist"] = { Normal = VehicleDistributions.SC_Militia }

distributionTable["SC_FordF350Ambulance"] = distributionTable["Ambulance"]
distributionTable["SC_M1010Ambulance"] = distributionTable["Ambulance"]

distributionTable["SC_ChevroletCamaro87"] = distributionTable["SportsCar"]
distributionTable["SC_Porsche911G50"] = distributionTable["SportsCar"]
distributionTable["SC_BMW520i"] = distributionTable["SportsCar"]
distributionTable["SC_FordMustang90"] = distributionTable["SportsCar"]
distributionTable["SC_CadillacBrougham"] = distributionTable["SportsCar"]

distributionTable["SC_FordMustang90Undercover"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_FordMustang90StatePolice"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_FordMustang90Jefferson"] = { Normal = VehicleDistributions.SC_Police }

distributionTable["SC_FordF700ArmoredBank"] = { Normal = VehicleDistributions.SC_BankCar}
distributionTable["SC_FordF700ArmoredPolice"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_ChevroletP30SWAT"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_FordCrownVictoriaStatePolice85"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_FordCrownVictoriaParkRanger85"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_FordCrownVictoriaLVPD85"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_ChevroletCapriceStatePolice85"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_ChevroletCapriceParkRanger85"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_ChevroletCapriceLVPD85"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["SC_ChevroletSuburbanStatePolice"] = { Normal = VehicleDistributions.SC_Police }
distributionTable["PickUpVanLightsPolice"] = { Normal = VehicleDistributions.SC_Police } 
distributionTable["CarLightsPolice"] = { Normal = VehicleDistributions.SC_Police } 
distributionTable["CarLights "] = { Normal = VehicleDistributions.SC_Police } 

distributionTable["SC_HahnPumperRed"] = { Normal = VehicleDistributions.SC_HahnPumper }
distributionTable["SC_HahnPumperYellow"] = { Normal = VehicleDistributions.SC_HahnPumper }

distributionTable["SC_M880"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1008"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1008TroopCarrier"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1009"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1009MilitaryPolice"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1010Ambulance"] = { Normal = VehicleDistributions.SC_CUCVMed }

distributionTable["SC_CadillacLimo"] = { Normal = VehicleDistributions.SC_Limo }

distributionTable["SC_M151A2"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M151A2Desert"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M151A2Cleaners"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1025"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1025Desert"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M998"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M998Desert"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M35A1"] = { Normal = VehicleDistributions.SC_Military }

distributionTable["SC_ChevroletG30BoxVan"] = { Normal = VehicleDistributions.SC_WorkingVan }
distributionTable["SC_ChevroletG30McCoy"] = { Normal = VehicleDistributions.SC_McCoy }

distributionTable["SC_GrummanLLV"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVanMail"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVan_Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletP30Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletG30Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }