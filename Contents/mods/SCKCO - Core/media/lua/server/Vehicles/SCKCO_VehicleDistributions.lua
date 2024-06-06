local distributionTable = VehicleDistributions[1]

VehicleDistributions.SC_StandardGlovebox = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
        "Bandaid", 0.5,
        "Battery", 0.5,
        "BluePen", 0.5,
        "Cigarettes", 0.5,
        "Cologne", 0.5,
        "Comb", 0.5,
        "CreditCard", 0.5,
        "Disc_Retail", 0.5,
        "DuctTape", 0.5,
        "Earbuds", 0.5,
        "Eraser", 0.5,
        "Lighter", 0.5,
        "Lipstick", 0.5,
        "Magazine", 0.5,
        "MakeupEyeshadow", 0.5,
        "MakeupFoundation", 0.5,
        "Matches", 0.5,
        "Mirror", 0.5,
        "Notebook", 0.5,
        "Paperclip", 0.5,
        "Pen", 0.5,
        "Pencil", 0.5,
        "Perfume", 0.5,
        "Razor", 0.5,
        "RedPen", 0.5,
        "RubberBand", 0.5,
        "SewingKit", 0.5,
        "Scotchtape", 0.5,
        "Tissue", 0.5,
        "Twine", 0.5,
    },
}

VehicleDistributions.SC_StandardFootwellSpace = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
        "Bandaid", 0.5,
        "Battery", 0.5,
        "BluePen", 0.5,
        "Cigarettes", 0.5,
        "Cologne", 0.5,
        "Comb", 0.5,
        "CreditCard", 0.5,
        "Disc_Retail", 0.5,
        "DuctTape", 0.5,
        "Earbuds", 0.5,
        "Eraser", 0.5,
        "Lighter", 0.5,
        "Lipstick", 0.5,
        "Magazine", 0.5,
        "MakeupEyeshadow", 0.5,
        "MakeupFoundation", 0.5,
        "Matches", 0.5,
        "Mirror", 0.5,
        "Notebook", 0.5,
        "Paperclip", 0.5,
        "Pen", 0.5,
        "Pencil", 0.5,
        "Perfume", 0.5,
        "Razor", 0.5,
        "RedPen", 0.5,
        "RubberBand", 0.5,
        "SewingKit", 0.5,
        "Scotchtape", 0.5,
        "Tissue", 0.5,
        "Twine", 0.5,
    }
}

VehicleDistributions.SC_StandardTruckBed = {
    rolls = 10,
    items = {
        "DuctTape", 0.5,
        "EmptyPetrolCan", 0.5,
        "EmptySandbag", 0.5,
        "Garbagebag", 0.5,
        "Plasticbag", 0.5,
        "PopBottleEmpty", 0.5,
        "PopEmpty", 0.5,
        "RubberBand", 0.5,
        "Tarp", 0.5,
        "Tissue", 0.5,
        "ToiletPaper", 0.5,
        "Tote", 0.5,
        "Twine", 0.5,
        "WaterBottleEmpty", 0.5,
        "WhiskeyEmpty", 0.5,
    },
    junk = {
        rolls = 1,
        items = {
            "BaseballBat", 0.5,
            "CarBattery1", 0.5,
            "FirstAidKit", 0.5,
            "Jack", 0.5,
            "LugWrench", 0.5,
            "NormalTire1", 0.5,
            "Screwdriver", 0.5,
            "TirePump", 0.5,
            "Wrench", 0.5,
        }
    }
}

VehicleDistributions.SC_Standard = {
    TruckBed = VehicleDistributions.SC_StandardTruckBed,
    TruckBedOpen = VehicleDistributions.SC_StandardTruckBed,
    FrontFootwellSpace = VehicleDistributions.SC_StandardFootwellSpace,
    RearFootwellSpace = VehicleDistributions.SC_StandardFootwellSpace,
    GloveBox = VehicleDistributions.SC_StandardGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_LuxuryGlovebox = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
        "Bandaid", 0.5,
        "Battery", 0.5,
        "BluePen", 0.5,
        "Cigarettes", 0.5,
        "Cologne", 0.5,
        "Comb", 0.5,
        "CreditCard", 0.5,
        "Disc_Retail", 0.5,
        "DuctTape", 0.5,
        "Earbuds", 0.5,
        "Eraser", 0.5,
        "Lighter", 0.5,
        "Lipstick", 0.5,
        "Magazine", 0.5,
        "MakeupEyeshadow", 0.5,
        "MakeupFoundation", 0.5,
        "Matches", 0.5,
        "Mirror", 0.5,
        "Notebook", 0.5,
        "Paperclip", 0.5,
        "Pen", 0.5,
        "Pencil", 0.5,
        "Perfume", 0.5,
        "Razor", 0.5,
        "RedPen", 0.5,
        "RubberBand", 0.5,
        "SewingKit", 0.5,
        "Scotchtape", 0.5,
        "Tissue", 0.5,
        "Twine", 0.5,
    },
}

VehicleDistributions.SC_LuxuryFootwellSpace = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
        "Bandaid", 0.5,
        "Battery", 0.5,
        "BluePen", 0.5,
        "Cigarettes", 0.5,
        "Cologne", 0.5,
        "Comb", 0.5,
        "CreditCard", 0.5,
        "Disc_Retail", 0.5,
        "DuctTape", 0.5,
        "Earbuds", 0.5,
        "Eraser", 0.5,
        "Lighter", 0.5,
        "Lipstick", 0.5,
        "Magazine", 0.5,
        "MakeupEyeshadow", 0.5,
        "MakeupFoundation", 0.5,
        "Matches", 0.5,
        "Mirror", 0.5,
        "Notebook", 0.5,
        "Paperclip", 0.5,
        "Pen", 0.5,
        "Pencil", 0.5,
        "Perfume", 0.5,
        "Razor", 0.5,
        "RedPen", 0.5,
        "RubberBand", 0.5,
        "SewingKit", 0.5,
        "Scotchtape", 0.5,
        "Tissue", 0.5,
        "Twine", 0.5,
    }
}

VehicleDistributions.SC_LuxuryTruckBed = {
    rolls = 10,
    items = {
        "DuctTape", 0.5,
        "EmptyPetrolCan", 0.5,
        "EmptySandbag", 0.5,
        "Garbagebag", 0.5,
        "Plasticbag", 0.5,
        "PopBottleEmpty", 0.5,
        "PopEmpty", 0.5,
        "RubberBand", 0.5,
        "Tarp", 0.5,
        "Tissue", 0.5,
        "ToiletPaper", 0.5,
        "Tote", 0.5,
        "Twine", 0.5,
        "WaterBottleEmpty", 0.5,
        "WhiskeyEmpty", 0.5,
    },
    junk = {
        rolls = 1,
        items = {
            "BaseballBat", 0.5,
            "CarBattery1", 0.5,
            "FirstAidKit", 0.5,
            "Jack", 0.5,
            "LugWrench", 0.5,
            "NormalTire3", 0.5,
            "Screwdriver", 0.5,
            "TirePump", 0.5,
            "Wrench", 0.5,
        }
    }
}

VehicleDistributions.SC_Luxury = {
    TruckBed = VehicleDistributions.SC_LuxuryTruckBed,
    TruckBedOpen = VehicleDistributions.SC_LuxuryTruckBed,
    FrontFootwellSpace = VehicleDistributions.SC_LuxuryFootwellSpace,
    RearFootwellSpace = VehicleDistributions.SC_LuxuryFootwellSpace,
    GloveBox = VehicleDistributions.SC_LuxuryGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_SportGlovebox = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
        "Bandaid", 0.5,
        "Battery", 0.5,
        "BluePen", 0.5,
        "Cigarettes", 0.5,
        "Cologne", 0.5,
        "Comb", 0.5,
        "CreditCard", 0.5,
        "Disc_Retail", 0.5,
        "DuctTape", 0.5,
        "Earbuds", 0.5,
        "Eraser", 0.5,
        "Lighter", 0.5,
        "Lipstick", 0.5,
        "Magazine", 0.5,
        "MakeupEyeshadow", 0.5,
        "MakeupFoundation", 0.5,
        "Matches", 0.5,
        "Mirror", 0.5,
        "Notebook", 0.5,
        "Paperclip", 0.5,
        "Pen", 0.5,
        "Pencil", 0.5,
        "Perfume", 0.5,
        "Razor", 0.5,
        "RedPen", 0.5,
        "RubberBand", 0.5,
        "SewingKit", 0.5,
        "Scotchtape", 0.5,
        "Tissue", 0.5,
        "Twine", 0.5,
    },
}

VehicleDistributions.SC_SportFootwellSpace = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
        "Bandaid", 0.5,
        "Battery", 0.5,
        "BluePen", 0.5,
        "Cigarettes", 0.5,
        "Cologne", 0.5,
        "Comb", 0.5,
        "CreditCard", 0.5,
        "Disc_Retail", 0.5,
        "DuctTape", 0.5,
        "Earbuds", 0.5,
        "Eraser", 0.5,
        "Lighter", 0.5,
        "Lipstick", 0.5,
        "Magazine", 0.5,
        "MakeupEyeshadow", 0.5,
        "MakeupFoundation", 0.5,
        "Matches", 0.5,
        "Mirror", 0.5,
        "Notebook", 0.5,
        "Paperclip", 0.5,
        "Pen", 0.5,
        "Pencil", 0.5,
        "Perfume", 0.5,
        "Razor", 0.5,
        "RedPen", 0.5,
        "RubberBand", 0.5,
        "SewingKit", 0.5,
        "Scotchtape", 0.5,
        "Tissue", 0.5,
        "Twine", 0.5,
    }
}

VehicleDistributions.SC_SportTruckBed = {
    rolls = 10,
    items = {
        "DuctTape", 0.5,
        "EmptyPetrolCan", 0.5,
        "EmptySandbag", 0.5,
        "Garbagebag", 0.5,
        "Plasticbag", 0.5,
        "PopBottleEmpty", 0.5,
        "PopEmpty", 0.5,
        "RubberBand", 0.5,
        "Tarp", 0.5,
        "Tissue", 0.5,
        "ToiletPaper", 0.5,
        "Tote", 0.5,
        "Twine", 0.5,
        "WaterBottleEmpty", 0.5,
        "WhiskeyEmpty", 0.5,
    },
    junk = {
        rolls = 1,
        items = {
            "BaseballBat", 0.5,
            "CarBattery1", 0.5,
            "FirstAidKit", 0.5,
            "Jack", 0.5,
            "LugWrench", 0.5,
            "NormalTire3", 0.5,
            "Screwdriver", 0.5,
            "TirePump", 0.5,
            "Wrench", 0.5,
        }
    }
}

VehicleDistributions.SC_Sport = {
    TruckBed = VehicleDistributions.SC_SportTruckBed,
    TruckBedOpen = VehicleDistributions.SC_SportTruckBed,
    FrontFootwellSpace = VehicleDistributions.SC_SportFootwellSpace,
    RearFootwellSpace = VehicleDistributions.SC_SportFootwellSpace,
    GloveBox = VehicleDistributions.SC_SportGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

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


--------------------------------------------------------------------

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

--------------------------------------------------------------------

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

--------------------------------------------------------------------

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

--------------------------------------------------------------------

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

--------------------------------------------------------------------

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

--------------------------------------------------------------------

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

--------------------------------------------------------------------

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

--------------------------------------------------------------------

VehicleDistributions.SC_AmbulanceGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_AmbulanceFootwellSpace = {
    rolls = 1,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
    }
}

VehicleDistributions.SC_AmbulanceTruckBed = {
    rolls = 10,
    items = {
        "Bag_MedicalBag", 5,
        "Bag_MedicalBag", 5,
        "FirstAidKit", 10,
        "FirstAidKit", 10,
        "Gloves_Surgical", 10,
        "Gloves_Surgical", 10,
    }
}

VehicleDistributions.SC_Ambulance = {
    TruckBed = VehicleDistributions.SC_AmbulanceTruckBed,
    BackOfTruck = VehicleDistributions.SC_AmbulanceTruckBed,
    FrontFootwellSpace = VehicleDistributions.SC_AmbulanceFootwellSpace,
    GloveBox = VehicleDistributions.SC_AmbulanceGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

distributionTable["SC_HondaAccord"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_VWRabbit"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_VWRabbitPizza"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletK5Blazer"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletK5BlazerFossoil"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletK5BlazerMcCoys"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_MazdaB2000"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_PlymouthVoyager"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletCavalier"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordBronco"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF150"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_JeepCJ7"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["OffRoad"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_JeepCherokee"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCrownVictoria92"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_GeoTracker"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletC70GrainTruck"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletCaprice85"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCountrySquire"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletG30Windowless"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletG30Seats"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCrownVictoria85"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCrownVictoria92"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletSuburban"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordExplorer"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordTaurus"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["ModernCar"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["ModernCar02"] = { Normal = VehicleDistributions.SC_Standard}

distributionTable["SC_ChevroletK10Dixie"] = { Normal = VehicleDistributions.SC_Bubba }
distributionTable["SC_M880Bubba"] = { Normal = VehicleDistributions.SC_Bubba }

distributionTable["SC_M880Militia"] = { Normal = VehicleDistributions.SC_Militia }
distributionTable["SC_CUCVZhenjaEdition"] = { Normal = VehicleDistributions.SC_Militia }
distributionTable["SC_ChevroletC70Survivalist"] = { Normal = VehicleDistributions.SC_Militia }

distributionTable["VanAmbulance"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_ChevroletG30Ambulance"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_FordF350Ambulance"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_M1010Ambulance"] = { Normal = VehicleDistributions.SC_Ambulance }

distributionTable["SportsCar"] = { Normal = VehicleDistributions.SC_Sport}
distributionTable["SC_ChevroletCamaro87"] = { Normal = VehicleDistributions.SC_Sport}
distributionTable["SC_FordMustang90"] = { Normal = VehicleDistributions.SC_Sport}

distributionTable["SC_Porsche911G50"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_BMW520i"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_CadillacBrougham"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_CadillacLimo"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_Mercedes280"] = { Normal = VehicleDistributions.SC_Luxury}

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
distributionTable["CarLights"] = { Normal = VehicleDistributions.SC_Police } 
distributionTable["PickUpTruckLIghts"] = { Normal = VehicleDistributions.SC_Police } 
distributionTable["SC_ChevroletK10ParkRanger"] = { Normal = VehicleDistributions.SC_Police } 
distributionTable["SC_ChevroletK5ParkRanger"] = { Normal = VehicleDistributions.SC_Police } 

distributionTable["SC_HahnPumperRed"] = { Normal = VehicleDistributions.SC_HahnPumper }
distributionTable["SC_HahnPumperYellow"] = { Normal = VehicleDistributions.SC_HahnPumper }

distributionTable["SC_M880"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1008"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1008TroopCarrier"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1009"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1009MilitaryPolice"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_M1010Ambulance"] = { Normal = VehicleDistributions.SC_Ambulance }

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
distributionTable["SC_ChevroletG30Ambulance"] = { Normal = VehicleDistributions.SC_Ambulance }

distributionTable["SC_GrummanLLV"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVanMail"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVan_Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletP30Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletG30Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }