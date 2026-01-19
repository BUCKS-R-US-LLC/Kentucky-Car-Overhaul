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
    RearVanSpace = VehicleDistributions.SC_StandardTruckBed,
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
    GloveBox = VehicleDistributions.SC_SportGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.MassGenFacGloveBox = {
    rolls = 4,
    items = {
        "AlcoholWipes", 8,
        "Bandage", 4,
        "Bandaid", 10,
        "Battery", 10,
        "BluePen", 8,
        "Cigarettes", 8,
        "Cologne", 4,
        "Comb", 4,
        "CreditCard", 4,
        "Disc_Retail", 2,
        "DuctTape", 2,
        "Earbuds", 2,
        "Eraser", 6,
        "Lighter", 4,
        "Lipstick", 6,
        "Magazine", 10,
        "MakeupEyeshadow", 6,
        "MakeupFoundation", 6,
        "Matches", 8,
        "Mirror", 4,
        "Notebook", 10,
        "Paperclip", 4,
        "Pen", 8,
        "Pencil", 10,
        "Perfume", 4,
        "Razor", 4,
        "RedPen", 8,
        "RubberBand", 6,
        "Scotchtape", 8,
        "Tissue", 10,
        "Twine", 10,
    },
    junk = {
        rolls = 1,
        items = {
            "Camera", 0.03,
            "CameraDisposable", 0.05,
            "CameraExpensive", 0.001,
            "Glasses_Aviators", 0.05,
            "Glasses_SafetyGoggles", 20,
            "Glasses_Sun", 0.1,
            "Gloves_LeatherGloves", 20,
            "Gloves_LeatherGlovesBlack", 0.05,
            "HandTorch", 4,
            "HuntingKnife", 0.1,
            "LouisvilleMap1", 4,
            "LouisvilleMap2", 4,
            "LouisvilleMap3", 4,
            "LouisvilleMap4", 4,
            "LouisvilleMap5", 4,
            "LouisvilleMap6", 4,
            "LouisvilleMap7", 4,
            "LouisvilleMap8", 4,
            "LouisvilleMap9", 4,
            "MarchRidgeMap", 4,
            "MuldraughMap", 4,
            "Pistol", 0.8,
            "Pistol2", 0.6,
            "Radio.CDplayer", 2,
            "Radio.WalkieTalkie2", 2,
            "Radio.WalkieTalkie3", 1,
            "Revolver_Short", 0.8,
            "RiversideMap", 4,
            "RosewoodMap", 4,
            "ToiletPaper", 4,
            "Wallet", 4,
            "Wallet2", 4,
            "Wallet3", 4,
            "Wallet4", 4,
            "WestpointMap", 4,
            "WhiskeyFull", 0.5,
        }
    }
}

VehicleDistributions.MassGenFacTruckBed = {
    rolls = 4,
    items = {
        "BallPeenHammer", 10,
        "BlowTorch", 10,
        "DuctTape", 8,
        "EmptyPetrolCan", 10,
        "EmptySandbag", 4,
        "Garbagebag", 6,
        "Glasses_SafetyGoggles", 10,
        "Hat_DustMask", 10,
        "Hat_DustMask", 10,
        "Hat_HardHat", 10,
        "MetalBar", 20,
        "MetalBar", 10,
        "MetalPipe", 20,
        "MetalPipe", 10,
        "Plasticbag", 10,
        "PopBottleEmpty", 4,
        "PopEmpty", 4,
        "PropaneTank", 10,
        "RubberBand", 6,
        "ScrapMetal", 20,
        "ScrapMetal", 10,
        "Screwdriver", 10,
        "SheetMetal", 20,
        "SheetMetal", 10,
        "SmallSheetMetal", 20,
        "SmallSheetMetal", 10,
        "Tarp", 10,
        "Tissue", 10,
        "ToiletPaper", 6,
        "Tote", 6,
        "Twine", 10,
        "Vest_Foreman", 1,
        "Vest_HighViz", 4,
        "WaterBottleEmpty", 4,
        "WeldingMask", 10,
        "WeldingRods", 20,
        "WhiskeyEmpty", 1,
        "Wire", 20,
        "Wire", 10,
    },
    junk = {
        rolls = 1,
        items = {
            "BaseballBat", 1,
            "CarBattery2", 4,
            "FirstAidKit", 4,
            "Jack", 2,
            "LugWrench", 8,
            "NormalTire2", 10,
            "PropaneTank", 50,
            "Screwdriver", 10,
            "TirePump", 8,
            "Wrench", 8,
        }
    }
}

VehicleDistributions.MassGenFac = {
    TruckBed = VehicleDistributions.MassGenFacTruckBed;

    GloveBox = VehicleDistributions.MassGenFacGloveBox;

    SeatRearLeft = VehicleDistributions.Seat;
    SeatRearRight = VehicleDistributions.Seat;
}

--------------------------------------------------------------------

VehicleDistributions.SC_Military = {
    TruckBed = VehicleDistributions.SC_MilitaryTruckBed,
    TruckBedOpen = VehicleDistributions.SC_MilitaryTruckBed,
    GunRackSC = VehicleDistributions.SC_MilitaryGunRack,
    BackOfTruck = VehicleDistributions.SC_MilitaryBackTruck,
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
    GloveBox = VehicleDistributions.SC_MilitiaGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_StatePoliceGlovebox = {
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

VehicleDistributions.SC_StatePoliceFootwellSpace = {
    rolls = 1,
    items = {
        "Pen", 1,
        "RedPen", 1,
        "RubberBand", 1,
    }
}

VehicleDistributions.SC_StatePoliceTruckBed = {
    rolls = 4,
    items = {
        "Mov_RoadCone", 10,
    }
}

VehicleDistributions.SC_StatePoliceGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle2", 100,
        "Shotgun", 100,
    }
}

VehicleDistributions.SC_StatePolice = {
    TruckBed = VehicleDistributions.SC_StatePoliceTruckBed,
    TruckBedOpen = VehicleDistributions.SC_StatePoliceTruckBed,
    GunRackSC = VehicleDistributions.SC_StatePoliceGunRack,
    GloveBox = VehicleDistributions.SC_StatePoliceGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}


--------------------------------------------------------------------

VehicleDistributions.SC_DeputySheriffGlovebox = {
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

VehicleDistributions.SC_DeputySheriffTruckBed = {
    rolls = 4,
    items = {
        "Mov_RoadCone", 10,
    }
}

VehicleDistributions.SC_DeputySheriffGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle2", 100,
        "Shotgun", 100,
    }
}

VehicleDistributions.SC_DeputySheriff = {
    TruckBed = VehicleDistributions.SC_DeputySheriffTruckBed,
    TruckBedOpen = VehicleDistributions.SC_DeputySheriffTruckBed,
    GunRackSC = VehicleDistributions.SC_DeputySheriffGunRack,
    GloveBox = VehicleDistributions.SC_DeputySheriffGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_CityPoliceGlovebox = {
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

VehicleDistributions.SC_CityPoliceTruckBed = {
    rolls = 4,
    items = {
        "Mov_RoadCone", 10,
    }
}

VehicleDistributions.SC_CityPoliceGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle2", 100,
        "Shotgun", 100,
    }
}

VehicleDistributions.SC_CityPolice = {
    TruckBed = VehicleDistributions.SC_CityPoliceTruckBed,
    TruckBedOpen = VehicleDistributions.SC_CityPoliceTruckBed,
    GunRackSC = VehicleDistributions.SC_CityPoliceGunRack,
    GloveBox = VehicleDistributions.SC_CityPoliceGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_ParkRangerGlovebox = {
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

VehicleDistributions.SC_ParkRangerTruckBed = {
    rolls = 4,
    items = {
        "Mov_RoadCone", 10,
    }
}

VehicleDistributions.SC_ParkRangerGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle2", 100,
        "Shotgun", 100,
    }
}

VehicleDistributions.SC_ParkRanger = {
    TruckBed = VehicleDistributions.SC_ParkRangerTruckBed,
    TruckBedOpen = VehicleDistributions.SC_ParkRangerTruckBed,
    GunRackSC = VehicleDistributions.SC_ParkRangerGunRack,
    GloveBox = VehicleDistributions.SC_ParkRangerGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_FireDepartmentGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_FireDepartmentTruckBed = {
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

VehicleDistributions.SC_FireDepartment = {
    TruckBed = VehicleDistributions.SC_FireDepartmentTruckBed,
    BackOfTruck = VehicleDistributions.SC_FireDepartmentTruckBed,
    GloveBox = VehicleDistributions.SC_FireDepartmentGlovebox,
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
    GloveBox = VehicleDistributions.SC_MailCarGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_PowerCompanyGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_PowerCompanyTruckBed = {
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

VehicleDistributions.SC_PowerCompany = {
    TruckBed = VehicleDistributions.SC_PowerCompanyTruckBed,
    BackOfTruck = VehicleDistributions.SC_PowerCompanyTruckBed,
    GloveBox = VehicleDistributions.SC_PowerCompanyGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_McCoyGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_McCoyTruckBed = {
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

VehicleDistributions.SC_McCoy = {
    TruckBed = VehicleDistributions.SC_McCoyTruckBed,
    BackOfTruck = VehicleDistributions.SC_McCoyTruckBed,
    GloveBox = VehicleDistributions.SC_McCoyGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

--------------------------------------------------------------------

VehicleDistributions.SC_WorkTruckGlovebox = {
    rolls = 4,
    items = {
        "Pen", 8,
        "RedPen", 8,
        "RubberBand", 6,
        "WaterBottleFull", 10,
    }
}

VehicleDistributions.SC_WorkTruckTruckBed = {
    rolls = 50,
    items = {
        "Sledgehammer", 0.5,
        "Hammer", 2,
        "ClubHammer", 1,
        "Plank", 5,
        "Tarp", 1,
        "Hat_Hardhat", 1,
        "Bag_Toolbag", 1,
        "NailsBox", 10,
        "ScrewsBox", 10,
        "MetalPipe", 10,
        "Saw", 3,
    }
}

VehicleDistributions.SC_WorkTruck = {
    TruckBed = VehicleDistributions.SC_WorkTruckTruckBed,
    BackOfTruck = VehicleDistributions.SC_WorkTruckTruckBed,
    GloveBox = VehicleDistributions.SC_WorkTruckGlovebox,
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
    GloveBox = VehicleDistributions.SC_AmbulanceGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_FireDepartmentGlovebox = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
    },
}

VehicleDistributions.SC_FireDepartmentTruckBed = {
    rolls = 50,
    items = {
        "Bag_MedicalBag", 1,
        "Axe", 5,
        "Hat_Fireman", 5,
        "Jacket_Fireman", 5,
        "Trousers_Fireman", 5,
    }
}

VehicleDistributions.SC_FireDepartment = {
    
    SideContainer1 = VehicleDistributions.SC_FireDepartmentTruckBed,
    SideContainer2 = VehicleDistributions.SC_FireDepartmentTruckBed,
    SideContainer3 = VehicleDistributions.SC_FireDepartmentTruckBed,
    SideContainer4 = VehicleDistributions.SC_FireDepartmentTruckBed,
    SideContainer5 = VehicleDistributions.SC_FireDepartmentTruckBed,
    SideContainer6 = VehicleDistributions.SC_FireDepartmentTruckBed,
    SideContainer7 = VehicleDistributions.SC_FireDepartmentTruckBed,
    SideContainer8 = VehicleDistributions.SC_FireDepartmentTruckBed,

    TruckBed = VehicleDistributions.SC_FireDepartmentTruckBed,
    TruckBedOpen = VehicleDistributions.SC_FireDepartmentTruckBed,
    RearVanSpace = VehicleDistributions.SC_FireDepartmentTruckBed,
    GloveBox = VehicleDistributions.SC_FireDepartmentGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

VehicleDistributions.SC_SpiffoGlovebox = {
    rolls = 10,
    items = {
        "AlcoholWipes", 0.5,
        "Bandage", 0.5,
    },
}

VehicleDistributions.SC_SpiffoTruckBed = {
    rolls = 1,
    items = {
        "SpiffoBig", 1,
    }
}

VehicleDistributions.SC_Spiffo = {
    
    TruckBed = VehicleDistributions.SC_SpiffoTruckBed,
    TruckBedOpen = VehicleDistributions.SC_SpiffoTruckBed,
    RearVanSpace = VehicleDistributions.SC_SpiffoTruckBed,
    GloveBox = VehicleDistributions.SC_SpiffoGlovebox,
    SeatRearLeft = VehicleDistributions.Seat,  
    SeatRearRight = VehicleDistributions.Seat, 
}

distributionTable["SC_HondaAccord"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_VWRabbit"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_VWRabbitPizza"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["PickupVan"] = { Normal = VehicleDistributions.SC_Standard} 
distributionTable["SC_ChevroletK5Blazer"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletP30"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletP30_Greenes"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletP30_BunnyBread"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF700BoxTruck"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF700BoxTruck_BunnyBread"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF700BoxTruck_Greenes"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF700BoxTruck_GigaMart"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF700BoxTruck_Budget"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF700BoxTruck_Ryder"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF700BoxTruck_MacTools"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_MazdaB2000"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_PlymouthVoyager"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletCavalier"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordBronco"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordF15092"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_JeepCJ7"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["OffRoad"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_JeepCherokee"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCrownVictoria92"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_GeoTracker"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletC70GrainTruck"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletCaprice85"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCountrySquire"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletG30"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletG30Seats"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["CarNormal"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCrownVictoria85"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCrownVictoria85_Taxi"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordCrownVictoria92"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletSuburban"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordExplorer"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_FordTaurus"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["ModernCar"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["ModernCar02"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["Van_Transit"] = { Normal = VehicleDistributions.SC_Standard}

distributionTable["SC_ChevroletK10_Dixie"] = { Normal = VehicleDistributions.SC_Bubba }
distributionTable["SC_DodgeM880_Bubba"] = { Normal = VehicleDistributions.SC_Bubba }

distributionTable["SC_DodgeM880Militia"] = { Normal = VehicleDistributions.SC_Militia }
distributionTable["SC_CUCVZhenjaEdition"] = { Normal = VehicleDistributions.SC_Militia }
distributionTable["SC_ChevroletC70Survivalist"] = { Normal = VehicleDistributions.SC_Militia }

distributionTable["VanAmbulance"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_ChevroletG30Ambulance"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_FordF350Ambulance_StPeregrin"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_FordF350Ambulance_Meade"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_FordF350Ambulance_Life"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_ChevroletM1010Ambulance_3Tone"] = { Normal = VehicleDistributions.SC_Ambulance }

distributionTable["SportsCar"] = { Normal = VehicleDistributions.SC_Sport}
distributionTable["SC_ChevroletCamaro87"] = { Normal = VehicleDistributions.SC_Sport}
distributionTable["SC_FordMustang90"] = { Normal = VehicleDistributions.SC_Sport}

distributionTable["SC_Porsche911"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_BMW520i"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_CadillacBrougham"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_CadillacLimo"] = { Normal = VehicleDistributions.SC_Luxury}
distributionTable["SC_Mercedes280"] = { Normal = VehicleDistributions.SC_Luxury}

distributionTable["SC_FordF700Armored_Dunbar"] = { Normal = VehicleDistributions.SC_BankCar}
distributionTable["SC_FordF700Armored_Brinks"] = { Normal = VehicleDistributions.SC_BankCar}
distributionTable["SC_FordF700Armored_Transport"] = { Normal = VehicleDistributions.SC_BankCar}

distributionTable["SC_FordF700Armored_Police"] = { Normal = VehicleDistributions.SC_SWAT }
distributionTable["SC_ChevroletP30_SWAT"] = { Normal = VehicleDistributions.SC_SWAT }

distributionTable["SC_FordCrownVictoria85_StatePolice"] = { Normal = VehicleDistributions.SC_StatePolice }
distributionTable["SC_ChevroletSuburban_StatePolice"] = { Normal = VehicleDistributions.SC_StatePolice }
distributionTable["PickUpVanLightsPolice"] = { Normal = VehicleDistributions.SC_StatePolice } 
distributionTable["CarLightsPolice"] = { Normal = VehicleDistributions.SC_StatePolice } 
distributionTable["SC_FordMustang90_StatePolice"] = { Normal = VehicleDistributions.SC_StatePolice }

distributionTable["SC_FordCrownVictoria85_ParkRanger"] = { Normal = VehicleDistributions.SC_ParkRanger }
distributionTable["SC_ChevroletCaprice85_ParkRanger"] = { Normal = VehicleDistributions.SC_ParkRanger }
distributionTable["CarLights"] = { Normal = VehicleDistributions.SC_ParkRanger } 
distributionTable["PickUpTruckLights"] = { Normal = VehicleDistributions.SC_ParkRanger } 
distributionTable["SC_ChevroletK10_ParkRanger"] = { Normal = VehicleDistributions.SC_ParkRanger } 
distributionTable["SC_ChevroletK5Blazer_ParkRanger"] = { Normal = VehicleDistributions.SC_ParkRanger }

distributionTable["SC_FordCrownVictoria85LouisvillePolice"] = { Normal = VehicleDistributions.SC_CityPolice }
distributionTable["SC_FordCrownVictoria92LouisvillePolice"] = { Normal = VehicleDistributions.SC_CityPolice }
distributionTable["SC_FordCrownVictoria92JeffersonPolice"] = { Normal = VehicleDistributions.SC_CityPolice }

distributionTable["SC_FordCrownVictoria92JeffersonSheriff"] = { Normal = VehicleDistributions.SC_DeputySheriff }
distributionTable["SC_FordCrownVictoria92MuhlenSheriff"] = { Normal = VehicleDistributions.SC_DeputySheriff }
distributionTable["SC_FordCrownVictoria92WarrenSheriff"] = { Normal = VehicleDistributions.SC_DeputySheriff }
distributionTable["SC_FordCrownVictoria92MeadeSheriff"] = { Normal = VehicleDistributions.SC_DeputySheriff }

distributionTable["SC_DodgeM880"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008_DesertMERDC"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008TroopCarrier_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008TroopCarrier_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008TroopCarrier_DesertMERDC"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009_DesertMERDC"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009MP_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009MP_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009MP_DesertMERDC"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1010Ambulance_3Tone"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_ChevroletM1010Ambulance_OD"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_ChevroletM1010Ambulance_DesertMERDC"] = { Normal = VehicleDistributions.SC_Ambulance }

distributionTable["SC_CadillacLimo"] = { Normal = VehicleDistributions.SC_Limo }

distributionTable["SC_AMGeneralM151A2_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_Tan"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_MERDC"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_Cleaners"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097_Tan"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097TroopCarrier_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097TroopCarrier_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097TroopCarrier_Tan"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025_Tan"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025MP_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025MP_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025MP_Tan"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM997Ambulance_3Tone"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_AMGeneralM997Ambulance_OD"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_AMGeneralM997Ambulance_Tan"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_AMGeneralM998Soft_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Soft_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Soft_Tan"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Hard_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Hard_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Hard_Tan"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM35A2_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM35A2_OD"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM35A2_MERDC"] = { Normal = VehicleDistributions.SC_Military }

distributionTable["PickUpVanLightsFire"] = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_HahnPumper_Red"] = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_HahnPumper_Yellow"] = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_CrownFireCoach_Red"] = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_CrownFireCoach_White"] = { Normal = VehicleDistributions.SC_FireDepartment }

distributionTable["SC_ChevroletK5Blazer_McCoy"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletK5Blazer_Fossoil"] = { Normal = VehicleDistributions.SC_Standard}
distributionTable["SC_ChevroletG30_Fossoil"] = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["SC_ChevroletG30BoxVan"] = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["SC_ChevroletG30_MassGenFac"] = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["Van_MassGenFac"] = { Normal = VehicleDistributions.SC_WorkTruck}
distributionTable["SC_ChevroletG30_LectroMax"] = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["VanSpiffo"] = { Normal = VehicleDistributions.SC_Spiffo }
distributionTable["SC_ChevroletG30_Spiffo"] = { Normal = VehicleDistributions.SC_Spiffo }
distributionTable["SC_ChevroletG30_McCoy"] = { Normal = VehicleDistributions.SC_McCoy }

distributionTable["SC_ChevroletG30_LBMW"] = { Normal = VehicleDistributions.Radio }
distributionTable["SC_ChevroletG30_3N"] = { Normal = VehicleDistributions.Radio }

distributionTable["SC_ChevroletG30Ambulance"] = { Normal = VehicleDistributions.SC_Ambulance }

distributionTable["SC_GrummanLLV"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["SC_ChevroletG30_Mail"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["SC_ChevroletG30_FedEx"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVanMail"] = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVan_Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletP30_Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletG30_Heralds"] = { Normal = VehicleDistributions.SC_PaperCar }