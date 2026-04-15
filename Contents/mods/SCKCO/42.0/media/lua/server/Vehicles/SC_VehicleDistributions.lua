local distributionTable = VehicleDistributions[1]

-- ============================================================
--  SHARED SLOT TABLES (reused across profiles)
-- ============================================================

VehicleDistributions.SC_GloveBoxBase = {
    rolls = 4,
    items = {
        "AlcoholWipes", 8,
        "Bandage", 8,
        "Bandaid", 8,
        "Battery", 8,
        "BluePen", 8,
        "CigarettePack", 8,
        "Cologne", 8,
        "Comb", 8,
        "CreditCard", 8,
        "Disc_Retail", 8,
        "DuctTape", 8,
        "Earbuds", 8,
        "Eraser", 8,
        "Lighter", 8,
        "Lipstick", 8,
        "Magazine", 8,
        "MakeupEyeshadow", 8,
        "MakeupFoundation", 8,
        "Matches", 8,
        "Mirror", 8,
        "Notebook", 8,
        "Paperclip", 8,
        "Pen", 8,
        "Pencil", 8,
        "Perfume", 8,
        "Razor", 8,
        "RedPen", 8,
        "RubberBand", 8,
        "SewingKit", 8,
        "Scotchtape", 8,
        "Tissue", 8,
        "Twine", 8,
    },
    junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.SC_TrunkBase = {
    rolls = 4,
    items = {
        "DuctTape", 8,
        "PetrolCan", 8,
        "EmptySandbag", 8,
        "Garbagebag", 8,
        "Plasticbag", 8,
        "PopBottleEmpty", 8,
        "PopEmpty", 8,
        "RubberBand", 8,
        "Tarp", 8,
        "Tissue", 8,
        "ToiletPaper", 8,
        "Tote", 8,
        "Twine", 8,
        "WaterBottleEmpty", 8,
        "WhiskeyEmpty", 8,
    },
    junk = {
        rolls = 1,
        items = {
            "BaseballBat", 8,
            "CarBattery1", 8,
            "FirstAidKit", 8,
            "Jack", 8,
            "LugWrench", 8,
            "NormalTire1", 8,
            "Screwdriver", 8,
            "TirePump", 8,
            "Wrench", 8,
        }
    }
}

-- ============================================================
--  STANDARD  (civilian everyday cars)
-- ============================================================

VehicleDistributions.SC_StandardGlovebox = VehicleDistributions.SC_GloveBoxBase

VehicleDistributions.SC_StandardTrunkBase = VehicleDistributions.SC_TrunkBase

-- Specific cycling variants --------------------------------

VehicleDistributions.SC_Standard_Commuter = {
    GloveBox  = VehicleDistributions.SC_StandardGlovebox,
    TruckBed  = {
        rolls = 4,
        items = {
            "Notebook",      2,
            "Paperwork",     4,
            "Pen",           4,
            "Briefcase", 8,
            "CreditCard",    2,
            "Earbuds",       1,
            "Magazine",      2,
            -- removed: no B42 equivalent
        },
        junk = ClutterTables.TrunkJunk,
    },
}

VehicleDistributions.SC_Standard_Outdoorsy = {
    GloveBox  = VehicleDistributions.SC_StandardGlovebox,
    TruckBed  = {
        rolls = 4,
        items = {
            "Bag_NormalHikingBag", 0.3,
            "Tarp",          1,
            "Twine",         2,
            "WaterBottleEmpty", 2,
            "PetrolCan", 1,
            "HuntingKnife", 8,
            "HandTorch",     1,
            "Matches",       2,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

VehicleDistributions.SC_Standard_DIY = {
    GloveBox  = VehicleDistributions.SC_StandardGlovebox,
    TruckBed  = {
        rolls = 4,
        items = {
            "Screwdriver",   2,
            "Wrench",        2,
            "DuctTape",      3,
            "Plasticbag",    2,
            "Hammer",        1,
            "NailsBox",      1,
            "Tarp",          1,
            "Wire",          1,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

VehicleDistributions.SC_Standard = {
    TruckBed    = VehicleDistributions.SC_StandardTrunkBase,
    TruckBedOpen = VehicleDistributions.SC_StandardTrunkBase,
    RearVanSpace = VehicleDistributions.SC_StandardTrunkBase,
    GloveBox    = VehicleDistributions.SC_StandardGlovebox,
}

-- ============================================================
--  LUXURY
-- ============================================================

VehicleDistributions.SC_LuxuryGlovebox = {
    rolls = 4,
    items = {
        "CigarettePack", 8,
        "CreditCard",    4,
        "Cologne",       1,
        "Flask", 8,
        "Lighter",       2,
        "Money",         4,
        "Pen",           2,
        "PenFancy",      2,
        "Perfume",       1,
        "Pills", 8,
        "Pocketwatch", 8,
        "WristWatch_Left_Expensive", 0.05,
        "Whiskey",       0.3,
    },
    junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.SC_LuxuryTrunkBase = {
    rolls = 4,
    items = {
        "DuctTape",          0.3,
        "PetrolCan",    0.3,
        "Garbagebag", 8,
        "Plasticbag", 8,
        "Tarp",              0.3,
        "WaterBottleEmpty", 8,
        "WhiskeyEmpty", 8,
    },
    junk = {
        rolls = 1,
        items = {
            "CarBattery1", 8,
            "FirstAidKit", 8,
            "Jack", 8,
            "LugWrench", 8,
            "NormalTire3", 8,
            "Screwdriver", 8,
            "TirePump", 8,
            "Wrench", 8,
        }
    }
}

-- Specific cycling variants --------------------------------

VehicleDistributions.SC_Luxury_BusinessExec = {
    GloveBox = VehicleDistributions.SC_LuxuryGlovebox,
    TruckBed = {
        rolls = 4,
        items = {
            "Briefcase",     2,
            "Paperwork",     4,
            "PenFancy",      2,
            "Money",         4,
            "StockCertificate", 1,
            "BusinessCard",  2,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

VehicleDistributions.SC_Luxury_SocialElite = {
    GloveBox = VehicleDistributions.SC_LuxuryGlovebox,
    TruckBed = {
        rolls = 4,
        items = {
            "Bag_GolfBag",   0.2,
            "Flask",         1,
            "TrophyBronze", 8,
            "TrophySilver",  0.2,
            "TrophyGold",    0.02,
            "Whiskey",       1,
            "Wine",          1,
            "Wine2",         1,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

VehicleDistributions.SC_Luxury = {
    TruckBed    = VehicleDistributions.SC_LuxuryTrunkBase,
    TruckBedOpen = VehicleDistributions.SC_LuxuryTrunkBase,
    GloveBox    = VehicleDistributions.SC_LuxuryGlovebox,
}

-- ============================================================
--  SPORT
-- ============================================================

VehicleDistributions.SC_SportGlovebox = {
    rolls = 4,
    items = {
        "CigarettePack",    1,
        "CreditCard",    2,
        "Cologne",       1,
        "Disc_Retail",   2,
        "Earbuds",       2,
        "Lighter",       2,
        "Magazine",      2,
        "Mirror",        1,
        "Pen",           2,
        "Perfume",       1,
        "RubberBand",    1,
        "Tissue",        1,
    },
    junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.SC_SportTrunkBase = {
    rolls = 4,
    items = {
        "DuctTape", 8,
        "PetrolCan", 8,
        "Garbagebag", 8,
        "Plasticbag", 8,
        "PopBottleEmpty", 8,
        "RubberBand", 8,
        "WaterBottleEmpty", 8,
        "WhiskeyEmpty", 8,
    },
    junk = {
        rolls = 1,
        items = {
            "BaseballBat", 8,
            "CarBattery1", 8,
            "FirstAidKit", 8,
            "Jack", 8,
            "LugWrench", 8,
            "NormalTire3", 8,
            "Screwdriver", 8,
            "TirePump", 8,
            "Wrench", 8,
        }
    }
}

-- Specific cycling variants --------------------------------

VehicleDistributions.SC_Sport_TrackDay = {
    GloveBox = VehicleDistributions.SC_SportGlovebox,
    TruckBed = {
        rolls = 4,
        items = {
            "HottieZ",       2,
            "TrophyBronze",  1,
            "TrophySilver", 8,
            "TrophyGold",    0.05,
            "Gloves_FingerlessLeatherGloves", 1,
            "Earbuds",       1,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

VehicleDistributions.SC_Sport_StreetKid = {
    GloveBox = VehicleDistributions.SC_SportGlovebox,
    TruckBed = {
        rolls = 4,
        items = {
            "Disc_Retail",   3,
            "Earbuds",       2,
            "PopBottleEmpty", 2,
            "PopEmpty",      2,
            "CigarettePack",    2,
            "Magazine",      2,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

VehicleDistributions.SC_Sport = {
    TruckBed    = VehicleDistributions.SC_SportTrunkBase,
    TruckBedOpen = VehicleDistributions.SC_SportTrunkBase,
    GloveBox    = VehicleDistributions.SC_SportGlovebox,
}

-- ============================================================
--  MASS GEN FAC
-- ============================================================

VehicleDistributions.MassGenFacGloveBox = {
    rolls = 4,
    items = {
        "AlcoholWipes",  8,
        "Bandage",       4,
        "Bandaid",       10,
        "Battery",       10,
        "BluePen",       8,
        "CigarettePack",    8,
        "Cologne",       4,
        "Comb",          4,
        "CreditCard",    4,
        "Disc_Retail",   2,
        "DuctTape",      2,
        "Earbuds",       2,
        "Eraser",        6,
        "Lighter",       4,
        "Lipstick",      6,
        "Magazine",      10,
        "MakeupEyeshadow", 6,
        "MakeupFoundation", 6,
        "Matches",       8,
        "Mirror",        4,
        "Notebook",      10,
        "Paperclip",     4,
        "Pen",           8,
        "Pencil",        10,
        "Perfume",       4,
        "Razor",         4,
        "RedPen",        8,
        "RubberBand",    6,
        "Scotchtape",    8,
        "Tissue",        10,
        "Twine",         10,
    },
    junk = {
        rolls = 1,
        items = {
            "Camera",            0.03,
            "CameraDisposable",  0.05,
            "CameraExpensive",   0.001,
            "Glasses_Aviators",  0.05,
            "Glasses_SafetyGoggles", 20,
            "Glasses_Sun",       0.1,
            "Gloves_LeatherGloves", 20,
            "Gloves_LeatherGlovesBlack", 0.05,
            "HandTorch",         4,
            "HuntingKnife",      0.1,
            "LouisvilleMap1",    4,
            "LouisvilleMap2",    4,
            "LouisvilleMap3",    4,
            "LouisvilleMap4",    4,
            "LouisvilleMap5",    4,
            "LouisvilleMap6",    4,
            "LouisvilleMap7",    4,
            "LouisvilleMap8",    4,
            "LouisvilleMap9",    4,
            "MarchRidgeMap",     4,
            "MuldraughMap",      4,
            "Pistol",            0.8,
            "Pistol2",           0.6,
            "Radio.CDplayer",    2,
            "Radio.WalkieTalkie2", 2,
            "Radio.WalkieTalkie3", 1,
            "Revolver_Short",    0.8,
            "RiversideMap",      4,
            "RosewoodMap",       4,
            "ToiletPaper",       4,
            "Wallet",            4,
            "Wallet2",           4,
            "Wallet3",           4,
            "Wallet4",           4,
            "WestpointMap",      4,
            "WhiskeyFull", 8,
        }
    }
}

VehicleDistributions.MassGenFacTruckBed = {
    rolls = 4,
    items = {
        "BallPeenHammer",    10,
        "BlowTorch",         10,
        "DuctTape",          8,
        "PetrolCan",    10,
        "EmptySandbag",      4,
        "Garbagebag",        6,
        "Glasses_SafetyGoggles", 10,
        "Hat_DustMask",      10,
        "Hat_HardHat",       10,
        "MetalBar",          20,
        "MetalBar",          10,
        "MetalPipe",         20,
        "MetalPipe",         10,
        "Plasticbag",        10,
        "PopBottleEmpty",    4,
        "PopEmpty",          4,
        "PropaneTank",       10,
        "RubberBand",        6,
        "ScrapMetal",        20,
        "ScrapMetal",        10,
        "Screwdriver",       10,
        "SheetMetal",        20,
        "SheetMetal",        10,
        "SmallSheetMetal",   20,
        "SmallSheetMetal",   10,
        "Tarp",              10,
        "Tissue",            10,
        "ToiletPaper",       6,
        "Tote",              6,
        "Twine",             10,
        "Vest_Foreman",      1,
        "Vest_HighViz",      4,
        "WaterBottleEmpty",  4,
        "WeldingMask",       10,
        "WeldingRods",       20,
        "WhiskeyEmpty",      1,
        "Wire",              20,
        "Wire",              10,
    },
    junk = {
        rolls = 1,
        items = {
            "BaseballBat",   1,
            "CarBattery2",   4,
            "FirstAidKit",   4,
            "Jack",          2,
            "LugWrench",     8,
            "NormalTire2",   10,
            "PropaneTank",   50,
            "Screwdriver",   10,
            "TirePump",      8,
            "Wrench",        8,
        }
    }
}

VehicleDistributions.MassGenFac = {
    TruckBed = VehicleDistributions.MassGenFacTrunkBed,
    GloveBox = VehicleDistributions.MassGenFacGloveBox,
}

-- ============================================================
--  CIVILIAN SPECIFIC VARIANTS  (used in Specific arrays)
-- ============================================================

-- GROCERIES ------------------------------------------------
VehicleDistributions.SC_Specific_Groceries = {
    GloveBox = VehicleDistributions.SC_GloveBoxBase,
    TruckBed = {
        rolls = 4,
        items = {
            "GroceryBag1",   100,
            "GroceryBag1",    50,
            "GroceryBag2",     8,
            "GroceryBag3",     8,
            "GroceryBag4",     8,
            "GroceryBag5",     8,
            "Cooler_Beer",     4,
            "Cooler_Meat",     4,
            "Cooler_Soda",     4,
            "BookCooking1",    2,
            "BookCooking2",    1,
            "CookingMag1",     1,
            "CookingMag2",     1,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- BAD TEENS ------------------------------------------------
VehicleDistributions.SC_Specific_BadTeens = {
    GloveBox = {
        rolls = 1,
        items = {
            "BeerCan",           20,
            "BeerCan",           10,
            "Flask",             10,
            "EggCarton",         10,
            "Firecracker",       50,
            "Firecracker",       20,
            "ToiletPaper",       50,
            "ToiletPaper",       20,
            "HottieZ",           20,
            "TrickMag1",          4,
            "WeaponMag4",         4,
            "Glasses_3dGlasses",  4,
            "Glasses_Venetian",  10,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "BeerCan",           20,
            "BeerCan",           10,
            "Cooler_Beer",        4,
            "BaseballBat",       10,
            "EggCarton",         10,
            "Mov_GardenGnome",   20,
            "ToiletPaper",       50,
            "ToiletPaper",       20,
            "Firecracker",       20,
            "HottieZ",           10,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- DRINKER --------------------------------------------------
VehicleDistributions.SC_Specific_Drinker = {
    GloveBox = {
        rolls = 1,
        items = {
            "BeerBottle",    20,
            "BeerBottle",    10,
            "BeerCan",       20,
            "BeerCan",       10,
            "BeerCanEmpty",  50,
            "BeerCanEmpty",  20,
            "BeerEmpty",     50,
            "BeerEmpty",     20,
            "BottleOpener", 200,
            "Flask",         20,
            "WhiskeyEmpty",  20,
            "Wine",           2,
            "Wine2",          2,
            "WineBox",        8,
            "WineEmpty",     20,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "BeerBottle",    50,
            "BeerBottle",    20,
            "BeerCan",       50,
            "BeerCan",       20,
            "BeerCanEmpty",  50,
            "BeerCanEmpty",  20,
            "BeerEmpty",     50,
            "BeerEmpty",     20,
            "WhiskeyEmpty",  50,
            "Wine",           8,
            "Wine2",          8,
            "WineBox",       20,
            "WineBox",       10,
            "WineEmpty",     50,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- PACK RAT -------------------------------------------------
VehicleDistributions.SC_Specific_PackRat = {
    GloveBox = {
        rolls = 1,
        items = {
            "Bag_DuffelBag",         10,
            "Bag_DuffelBagTINT",      4,
            "Bag_FannyPackFront",              4,
            "Garbagebag",        10,
            "Plasticbag",        20,
            -- removed: no B42 equivalent
            "Bag_Satchel",            4,
            "Tote",              10,
            "Battery",               10,
            "DuctTape",              10,
            "HandTorch",            10,
            "Lighter",               10,
            "Matches",               10,
            "Rope",                  10,
            "Twine",                 20,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Bag_DuffelBag",         20,
            "Bag_DuffelBagTINT",     10,
            "Bag_FannyPackFront",             10,
            "Garbagebag",        20,
            "Bag_NormalHikingBag",          4,
            "Plasticbag",        50,
            -- removed: no B42 equivalent
            "Bag_Satchel",           10,
            "Tote",              20,
            "DuctTape",              20,
            "PetrolCan",        10,
            "Rope",                  20,
            "Tarp",                  10,
            "Twine",                 30,
            "WaterBottleEmpty",      10,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- CAMPER ---------------------------------------------------
VehicleDistributions.SC_Specific_Camper = {
    GloveBox = {
        rolls = 1,
        items = {
            "Bag_NormalHikingBag",          2,
            "Candle",                10,
            "CanteenCowboy",         10,
            "FlashLight_AngleHead",   4,
            "Flask",                  4,
            "HandTorch",              4,
            "Hat_Bandana",            2,
            "InsectRepellent",       10,
            "KnifePocket",            4,
            "Lighter",               10,
            "Matches",               20,
            "Rope",                  10,
            "Tarp",                   4,
            "Twine",                 10,
            "WaterPurificationTablets", 4,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Bag_NormalHikingBag",          4,
            "Bag_TentBag",            2,
            "Candle",                10,
            "DuctTape",              10,
            "PetrolCan",         4,
            "HandTorch",              4,
            "HuntingKnife",           2,
            "Matches",               20,
            "Rope",                  20,
            "SleepingBag_Cheap_Green_Packed",            4,
            "Tarp",                  10,
            "Twine",                 20,
            "WaterBottleEmpty",      10,
            "WaterPurificationTablets", 4,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- FISHERMAN ------------------------------------------------
VehicleDistributions.SC_Specific_Fisherman = {
    GloveBox = {
        rolls = 1,
        items = {
            "Bag_FishingBasket",   2,
            "Bobber",             20,
            "Bobber",             10,
            "BookFishing1",        2,
            "BookFishing2",        1,
            "BottleOpener",       10,
            "FishingHook",        20,
            "FishingHook",        10,
            "FishingLine",        20,
            "FishingTackle",      20,
            "FishingTackle2",     20,
            "Flask",               2,
            "Hat_BucketHatFishing", 4,
            "InsectRepellent",    10,
            "KnifeFillet",        10,
            "Lighter",             4,
            "Pliers",              8,
            "Tacklebox",           2,
            "Twine",              10,
            "Whetstone",           4,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Bag_FishingBasket",   4,
            "Bobber",             20,
            "FishingHook",        20,
            "FishingLine",        20,
            "FishingRod",          4,
            "FishingTackle",      20,
            "FishingTackle2",     20,
            "Hat_BucketHatFishing", 4,
            "InsectRepellent",    10,
            "KnifeFillet",        10,
            "MinnowLure",         10,
            "JigLure",            10,
            "Rope",                4,
            "Tacklebox",           4,
            "Tarp",                4,
            "WaterBottleEmpty",    4,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- HUNTER ---------------------------------------------------
VehicleDistributions.SC_Specific_Hunter = {
    GloveBox = {
        rolls = 1,
        items = {
            "Bullets303Box",              8,
            "308Box",             10,
            "Bullets44Box",               6,
            -- removed: renamed in B42
            -- removed: renamed in B42
            -- removed: renamed in B42
            -- removed: renamed in B42
            -- removed: renamed in B42
            "Candle",              4,
            "CanteenCowboy",       8,
            "FlashLight_AngleHead", 4,
            "HuntingKnife",        4,
            "HuntingMag1",        2,
            "HuntingMag2",        2,
            "HuntingMag3",        2,
            "Lighter",             8,
            "Matches",            10,
            "Rope",                4,
            "ShotgunShellsBox",    8,
            "Whetstone",           4,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Bullets303Box",              8,
            "308Box",             10,
            "Bag_NormalHikingBag",       2,
            -- removed: renamed in B42
            -- removed: renamed in B42
            "Candle",              4,
            -- removed: no B42 equivalent
            -- removed: no B42 equivalent
            "HuntingKnife",        4,
            "HuntingRifle",        4,
            "Matches",            10,
            "Rope",               10,
            "Shotgun",             4,
            "ShotgunShellsBox",   10,
            "Tarp",                4,
            "Vest_Hunting_Orange",  4,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- SURVIVALIST ----------------------------------------------
VehicleDistributions.SC_Specific_Survivalist = {
    GloveBox = {
        rolls = 1,
        items = {
            "Antibiotics",         4,
            "Bag_LeatherWaterBag", 4,
            "Bandage",            10,
            "BookFirstAid1",       2,
            "BookFirstAid2",       1,
            "CanteenCowboy",      10,
            "FirstAidKit",         4,
            "FlashLight_AngleHead", 4,
            "HuntingKnife",        4,
            "Lighter",             8,
            "Matches",            10,
            "Rope",               10,
            "Twine",              10,
            "WaterPurificationTablets", 4,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Antibiotics",         4,
            "Bag_NormalHikingBag",       4,
            "Bandage",            10,
            "CanteenCowboy",      10,
            "DuctTape",           10,
            "PetrolCan",      4,
            "FirstAidKit",         4,
            "HuntingKnife",        4,
            -- removed: no B42 equivalent
            "Rope",               20,
            "SleepingBag_Cheap_Green_Packed",         2,
            "Tarp",               10,
            "Twine",              20,
            "WaterBottleEmpty",   10,
            "WaterPurificationTablets", 4,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- EVACUEE --------------------------------------------------
VehicleDistributions.SC_Specific_Evacuee = {
    GloveBox = {
        rolls = 1,
        items = {
            "Bag_DuffelBag",     10,
            "Bandage",           10,
            "Battery",           10,
            "CreditCard",         4,
            "Money",             10,
            "Money",              4,
            "Paperwork",         20,
            "Paperwork",         10,
            "Photo",            20,
            "Photo",            10,
            "Pills",              4,
            "WaterBottleEmpty",   4,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Bag_DuffelBag",     20,
            "Bag_DuffelBagTINT",  8,
            "Suitcase",       4,
            "Suitcase",      4,
            "Bandage",           10,
            -- removed: no B42 equivalent
            "FirstAidKit",        4,
            -- removed: no B42 equivalent
            "Money",             10,
            "Paperwork",         20,
            "SleepingBag_Cheap_Green_Packed",        2,
            "WaterBottleEmpty",  10,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- NURSE / FIRST RESPONDER ----------------------------------
VehicleDistributions.SC_Specific_Nurse = {
    GloveBox = {
        rolls = 1,
        items = {
            "AlcoholWipes",      10,
            "Antibiotics",        4,
            "Bandage",           10,
            "BookFirstAid1",      2,
            "BookFirstAid2",      1,
            "Disinfectant",       4,
            "FirstAidKit",       10,
            "Gloves_Surgical",   10,
            "Hat_SurgicalMask",  10,
            "Magazine_Health",   10,
            "Pills",             10,
            "PillsAntiDep",       4,
            "Scalpel",            4,
            "Stethoscope",        4,
            "SutureNeedle",       4,
            "Tweezers",          10,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "AlcoholWipes",      10,
            "Antibiotics",        4,
            "Bag_MedicalBag",     2,
            "Bandage",           10,
            "Disinfectant",       4,
            "FirstAidKit",       10,
            "Gloves_Surgical",   10,
            "Hat_SurgicalCap",   10,
            "Hat_SurgicalMask",  10,
            "Pills",             10,
            "PillsAntiDep",       4,
            "PillsSleepingTablets", 4,
            "Shirt_Scrubs",       8,
            "Trousers_Scrubs",    8,
            "Tweezers",          10,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- PREPPER --------------------------------------------------
VehicleDistributions.SC_Specific_Prepper = {
    GloveBox = {
        rolls = 1,
        items = {
            "Antibiotics",         4,
            "Bandage",            10,
            "BookFirstAid1",       2,
            "CanteenCowboy",       8,
            "FirstAidKit",         4,
            "HandTorch",           4,
            "HuntingKnife",        4,
            "Lighter",            10,
            "Matches",            10,
            "Pistol",              2,
            "Rope",               10,
            "WaterPurificationTablets", 4,
            "Whiskey",             1,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Antibiotics",         4,
            "Bag_NormalHikingBag",       4,
            "Bandage",            10,
            "CanteenCowboy",       8,
            "DuctTape",           10,
            "PetrolCan",      4,
            "FirstAidKit",         4,
            "HandTorch",           4,
            "HuntingKnife",        4,
            "Matches",            10,
            -- removed: no B42 equivalent
            "Pistol",              2,
            "Rope",               20,
            "Tarp",               10,
            "Twine",              20,
            "WaterBottleEmpty",   10,
            "WaterPurificationTablets", 4,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- FARMER ---------------------------------------------------
VehicleDistributions.SC_Specific_Farmer = {
    GloveBox = {
        rolls = 1,
        items = {
            "BookFarming1",        2,
            "BookFarming2",        1,
            "BookFarming3", 8,
            "FarmingMag1",         2,
            "FarmingMag2",         2,
            -- removed: no B42 equivalent
            "Hat_CowboyHatTINT",         1,
            "Hat_StrawHat",        2,
            "HuntingKnife",        2,
            "Lighter",             4,
            "Matches",             8,
            -- removed: B42 seed IDs differ
            -- removed: B42 seed IDs differ
            "Twine",              10,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "BookFarming1",        2,
            "BookFarming2",        1,
            "FarmingMag1",         2,
            -- removed: no B42 equivalent
            "Hammer",              4,
            "Hat_StrawHat",        2,
            "GardenHoe",                 4,
            "NailsBox",           10,
            "Plank",               8,
            -- removed: B42 seed IDs differ
            -- removed: B42 seed IDs differ
            -- removed: B42 seed IDs differ
            "Shovel",              4,
            "Tarp",                4,
            "Twine",              10,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- ROAD TRIP ------------------------------------------------
VehicleDistributions.SC_Specific_RoadTrip = {
    GloveBox = {
        rolls = 1,
        items = {
            "LouisvilleMap1",   4,
            "LouisvilleMap2",   4,
            "LouisvilleMap3",   4,
            "LouisvilleMap4",   4,
            "MarchRidgeMap",    4,
            "MuldraughMap",     4,
            "RiversideMap",     4,
            "RosewoodMap",      4,
            "WestpointMap",     4,
            "Clipboard",        4,
            "Disc_Retail",      8,
            "Earbuds",          4,
            "Magazine",         4,
            "Notebook",         4,
            "PopEmpty",        10,
            "WaterBottleEmpty", 4,
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 4,
        items = {
            "Bag_DuffelBag",    8,
            "Suitcase",     4,
            "Suitcase",    4,
            -- removed: no B42 equivalent
            "Disc_Retail",      8,
            "PetrolCan",   4,
            "LouisvilleMap1",   2,
            "MuldraughMap",     2,
            "PopBottleEmpty",  10,
            "Tarp",             2,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- SMOKER ---------------------------------------------------
VehicleDistributions.SC_Specific_Smoker = {
    GloveBox = {
        rolls = 1,
        items = {
            "CigarettePack",              20,
            "CigarettePack",              10,
            "CigaretteRollingPapers",   4,
            "Cigar",                   10,
            "Lighter",                 20,
            "Lighter",                 10,
            "Matches",                 10,
            "TobaccoLoose",             4,
            "TobaccoChewing",           2,
            -- removed: no B42 equivalent
        },
        junk = ClutterTables.GloveBoxJunk,
    },
    TruckBed = {
        rolls = 2,
        items = {
            "CigarettePack",              20,
            "CigarettePack",              10,
            "CigaretteRollingPapers",   4,
            "Cigar",                    4,
            "Lighter",                 10,
            "Matches",                 10,
            "TobaccoLoose",             4,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- SPORT LUXURY CROSSOVER (Porsche/BMW outdoorsy money) -----
VehicleDistributions.SC_Specific_LuxuryAdventurer = {
    GloveBox = VehicleDistributions.SC_LuxuryGlovebox,
    TruckBed = {
        rolls = 4,
        items = {
            "Bag_NormalHikingBag",       2,
            "Bag_GolfBag",         2,
            "Flask",               4,
            "Glasses_Aviators",    4,
            "Hat_PeakedCapYacht", 8,
            "InsectRepellent",     4,
            "Magazine_Rich",       4,
            "Rope",                4,
            "Tarp",                2,
            "Whiskey",             2,
            "Wine",                2,
        },
        junk = ClutterTables.TrunkJunk,
    },
}

-- ============================================================
--  EMERGENCY / SPECIALTY  (unchanged, no cycling needed)
-- ============================================================

VehicleDistributions.SC_MilitaryGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
        "SCGLClothing.Bag_SmallALICEPack",  10,
        "SCGLClothing.Bag_MediumALICEPack", 10,
        "SCGLClothing.Bag_LargeALICEPack",  10,
        "MEA.GIJerryCan",                   10,
        "MEA.AmmoCan556X45",                50,
        "MEA.AmmoCan762X51",                50,
        "MEA.AmmoCan50BMG",                 10,
    }
}

VehicleDistributions.SC_MilitaryGunRack = {
    rolls = 100,
    items = {
        "ColtM16A2_kitted", 100,
    }
}

VehicleDistributions.SC_MilitaryBackTruck = {
    rolls = 4,
    items = {
        "SCGLClothing.Hat_PASGTHelmetWoodland", 1,
        "Vest_BulletArmy",                      1,
        "AssaultRifle",                         1,
    }
}

VehicleDistributions.SC_Military = {
    TruckBed    = VehicleDistributions.SC_MilitaryTruckBed,
    TruckBedOpen = VehicleDistributions.SC_MilitaryTruckBed,
    GunRackSC   = VehicleDistributions.SC_MilitaryGunRack,
    GloveBox    = VehicleDistributions.SC_MilitaryGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_MilitiaGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
        "MEA.GIJerryCan",       10,
        "MEA.AmmoCan556X45",    50,
        "MEA.AmmoCan762X51",    50,
        "MEA.AmmoCan50BMG",     10,
    }
}

VehicleDistributions.SC_MilitiaGunRack = {
    rolls = 100,
    items = {
        "AssaultRifle2", 100,
        "Shotgun",       100,
    }
}

VehicleDistributions.SC_Militia = {
    TruckBed    = VehicleDistributions.SC_MilitiaTruckBed,
    TruckBedOpen = VehicleDistributions.SC_MilitiaTruckBed,
    GunRackSC   = VehicleDistributions.SC_MilitiaGunRack,
    GloveBox    = VehicleDistributions.SC_MilitiaGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_StatePoliceGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
        "Pen",    1,
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
        "Shotgun",       100,
    }
}

VehicleDistributions.SC_StatePolice = {
    TruckBed    = VehicleDistributions.SC_StatePoliceTruckBed,
    TruckBedOpen = VehicleDistributions.SC_StatePoliceTruckBed,
    GunRackSC   = VehicleDistributions.SC_StatePoliceGunRack,
    GloveBox    = VehicleDistributions.SC_StatePoliceGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_DeputySheriffGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
        "Shotgun",       100,
    }
}

VehicleDistributions.SC_DeputySheriff = {
    TruckBed    = VehicleDistributions.SC_DeputySheriffTruckBed,
    TruckBedOpen = VehicleDistributions.SC_DeputySheriffTruckBed,
    GunRackSC   = VehicleDistributions.SC_DeputySheriffGunRack,
    GloveBox    = VehicleDistributions.SC_DeputySheriffGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_CityPoliceGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
        "Shotgun",       100,
    }
}

VehicleDistributions.SC_CityPolice = {
    TruckBed    = VehicleDistributions.SC_CityPoliceTruckBed,
    TruckBedOpen = VehicleDistributions.SC_CityPoliceTruckBed,
    GunRackSC   = VehicleDistributions.SC_CityPoliceGunRack,
    GloveBox    = VehicleDistributions.SC_CityPoliceGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_ParkRangerGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
        "Shotgun",       100,
    }
}

VehicleDistributions.SC_ParkRanger = {
    TruckBed    = VehicleDistributions.SC_ParkRangerTruckBed,
    TruckBedOpen = VehicleDistributions.SC_ParkRangerTruckBed,
    GunRackSC   = VehicleDistributions.SC_ParkRangerGunRack,
    GloveBox    = VehicleDistributions.SC_ParkRangerGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_FireDepartmentGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
    }
}

VehicleDistributions.SC_FireDepartmentTruckBed = {
    rolls = 4,
    items = {
        "Bag_MedicalBag", 1,
        "Axe",            5,
        "Hat_Fireman",    5,
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
    TruckBed       = VehicleDistributions.SC_FireDepartmentTruckBed,
    TruckBedOpen   = VehicleDistributions.SC_FireDepartmentTruckBed,
    RearVanSpace   = VehicleDistributions.SC_FireDepartmentTruckBed,
    GloveBox       = VehicleDistributions.SC_FireDepartmentGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_BubbaGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
        "Shotgun",      100,
    }
}

VehicleDistributions.SC_Bubba = {
    TruckBed    = VehicleDistributions.SC_BubbaTruckBed,
    TruckBedOpen = VehicleDistributions.SC_BubbaTruckBed,
    GunRackSC   = VehicleDistributions.SC_BubbaGunRack,
    GloveBox    = VehicleDistributions.SC_BubbaGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_BankCarGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
    GloveBox = VehicleDistributions.SC_BankCarGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_MailCarGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
    }
}

VehicleDistributions.SC_MailCarTruckBed = {
    rolls = 50,
    items = {
        "HottieZ",           0.01,
        "Magazine",          50,
        "TVMagazine",        50,
        "FarmingMag1",       1,
        "EngineerMagazine1", 1,
        "EngineerMagazine2", 1,
        "MagazineCrossword1", 5,
        "MagazineCrossword2", 5,
        "MagazineCrossword3", 5,
        "MagazineWordsearch1", 5,
        "MagazineWordsearch2", 5,
        "MagazineWordsearch3", 5,
        "HuntingMag1",      1,
        "HuntingMag2",      1,
        "HuntingMag3",      1,
        "HuntingMag4",      1,
    }
}

VehicleDistributions.SC_MailCar = {
    TruckBed = VehicleDistributions.SC_MailCarTruckBed,
    GloveBox = VehicleDistributions.SC_MailCarGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_PowerCompanyGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
    }
}

VehicleDistributions.SC_PowerCompanyTruckBed = {
    rolls = 4,
    items = {
        "Wire",          10,
        "Screwdriver",   8,
        "Wrench",        8,
        "Hat_HardHat",   6,
        "Vest_HighViz",  6,
        "DuctTape",      4,
    }
}

VehicleDistributions.SC_PowerCompany = {
    TruckBed = VehicleDistributions.SC_PowerCompanyTruckBed,
    GloveBox = VehicleDistributions.SC_PowerCompanyGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_McCoyGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
    }
}

VehicleDistributions.SC_McCoyTruckBed = {
    rolls = 4,
    items = {
        "Screwdriver",   6,
        "Wrench",        6,
        "Hat_HardHat",   4,
        "Vest_HighViz",  4,
        "DuctTape",      4,
        "MetalPipe",     8,
    }
}

VehicleDistributions.SC_McCoy = {
    TruckBed = VehicleDistributions.SC_McCoyTruckBed,
    GloveBox = VehicleDistributions.SC_McCoyGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_WorkTruckGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
    }
}

VehicleDistributions.SC_WorkTruckTruckBed = {
    rolls = 10,
    items = {
        "Sledgehammer", 8,
        "Hammer",        2,
        "ClubHammer",    1,
        "Plank",         5,
        "Tarp",          1,
        "Hat_HardHat",   1,
        "Bag_ToolBag",   1,
        "NailsBox",      10,
        "ScrewsBox",     10,
        "MetalPipe",     10,
        "Saw",           3,
    }
}

VehicleDistributions.SC_WorkTruck = {
    TruckBed = VehicleDistributions.SC_WorkTruckTruckBed,
    GloveBox = VehicleDistributions.SC_WorkTruckGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_PaperCarGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
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
    GloveBox = VehicleDistributions.SC_PaperCarGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_AmbulanceGlovebox = {
    rolls = 4,
    items = {
        "Pen",           8,
        "RedPen",        8,
        "RubberBand",    6,
        "WaterBottle", 10,
    }
}

VehicleDistributions.SC_AmbulanceTruckBed = {
    rolls = 10,
    items = {
        "Bag_MedicalBag",  5,
        "Bag_MedicalBag",  5,
        "FirstAidKit",     10,
        "FirstAidKit",     10,
        "Gloves_Surgical", 10,
        "Gloves_Surgical", 10,
    }
}

VehicleDistributions.SC_Ambulance = {
    TruckBed = VehicleDistributions.SC_AmbulanceTruckBed,
    GloveBox = VehicleDistributions.SC_AmbulanceGlovebox,
}

--------------------------------------------------------------------

VehicleDistributions.SC_SpiffoGlovebox = {
    rolls = 4,
    items = {
        "AlcoholWipes", 8,
        "Bandage", 8,
    },
}

VehicleDistributions.SC_SpiffoTruckBed = {
    rolls = 1,
    items = {
        "SpiffoBig", 1,
    }
}

VehicleDistributions.SC_Spiffo = {
    TruckBed     = VehicleDistributions.SC_SpiffoTruckBed,
    TruckBedOpen = VehicleDistributions.SC_SpiffoTruckBed,
    RearVanSpace = VehicleDistributions.SC_SpiffoTruckBed,
    GloveBox     = VehicleDistributions.SC_SpiffoGlovebox,
}

-- ============================================================
--  VEHICLE ASSIGNMENTS
-- ============================================================
-- Aliases for readability
local Std         = VehicleDistributions.SC_Standard
local Commuter    = VehicleDistributions.SC_Standard_Commuter
local Outdoorsy   = VehicleDistributions.SC_Standard_Outdoorsy
local DIY         = VehicleDistributions.SC_Standard_DIY
local Groceries   = VehicleDistributions.SC_Specific_Groceries
local BadTeens    = VehicleDistributions.SC_Specific_BadTeens
local Drinker     = VehicleDistributions.SC_Specific_Drinker
local PackRat     = VehicleDistributions.SC_Specific_PackRat
local Camper      = VehicleDistributions.SC_Specific_Camper
local Fisherman   = VehicleDistributions.SC_Specific_Fisherman
local Hunter      = VehicleDistributions.SC_Specific_Hunter
local Survivalist = VehicleDistributions.SC_Specific_Survivalist
local Evacuee     = VehicleDistributions.SC_Specific_Evacuee
local Nurse       = VehicleDistributions.SC_Specific_Nurse
local Prepper     = VehicleDistributions.SC_Specific_Prepper
local Farmer      = VehicleDistributions.SC_Specific_Farmer
local RoadTrip    = VehicleDistributions.SC_Specific_RoadTrip
local Smoker      = VehicleDistributions.SC_Specific_Smoker
local LuxAdv      = VehicleDistributions.SC_Specific_LuxuryAdventurer
local Sport_T     = VehicleDistributions.SC_Sport_TrackDay
local Sport_S     = VehicleDistributions.SC_Sport_StreetKid
local Lux_B       = VehicleDistributions.SC_Luxury_BusinessExec
local Lux_E       = VehicleDistributions.SC_Luxury_SocialElite

-- Helper: create entry and set both Normal and Specific in one shot.
-- For vehicles that already exist in distributionTable (vanilla shared names),
-- this REPLACES their entry — so only use for SCKCO-exclusive script names.
local function addEntry(name, normal, specific)
    distributionTable[name] = { Normal = normal }
    if specific then
        distributionTable[name].Specific = specific
    end
end

-- ============================================================
--  SCKCO-EXCLUSIVE CIVILIANS  (safe to create fresh)
-- ============================================================

-- Compact / sedan
addEntry("SC_HondaAccord",      Std, { Commuter, DIY, Groceries, Drinker, Smoker, RoadTrip, BadTeens, Nurse })
addEntry("SC_VWRabbit",         Std, { Commuter, DIY, BadTeens, Drinker, Smoker, RoadTrip })
addEntry("SC_VWRabbit_Pizza",    Std, nil)
addEntry("SC_ChevroletCavalier", Std, { Commuter, BadTeens, Drinker, Smoker, Groceries })
addEntry("SC_FordCrownVictoria85", Std, { Commuter, Drinker, Smoker })
addEntry("SC_FordCrownVictoria85_Taxi", Std, nil)
addEntry("SC_FordCrownVictoria92", Std, { Commuter, Drinker, Smoker })
addEntry("SC_ChevroletCaprice85", Std, { Commuter, Drinker, Groceries, Smoker })
addEntry("SC_FordTaurus",        Std, { Commuter, Groceries, Drinker, Nurse })

-- Wagons / vans
addEntry("SC_FordCountrySquire", Std, { Commuter, Groceries, RoadTrip, Camper, Evacuee, PackRat })
addEntry("SC_PlymouthVoyager",   Std, { Commuter, Groceries, RoadTrip, Camper, PackRat, BadTeens })
addEntry("SC_ChevroletG30Seats", Std, { Commuter, RoadTrip, PackRat, Drinker })

-- Box trucks
addEntry("SC_ChevroletP30",             Std, nil)
addEntry("SC_ChevroletP30_Greenes",     Std, nil)
addEntry("SC_ChevroletP30_BunnyBread",  Std, nil)
addEntry("SC_FordF700BoxTruck",         Std, { DIY, PackRat })
addEntry("SC_FordF700BoxTruck_BunnyBread", Std, nil)
addEntry("SC_FordF700BoxTruck_Greenes",    Std, nil)
addEntry("SC_FordF700BoxTruck_GigaMart",   Std, nil)
addEntry("SC_FordF700BoxTruck_Budget",     Std, nil)
addEntry("SC_FordF700BoxTruck_Ryder",      Std, nil)
addEntry("SC_FordF700BoxTruck_MacTools",   Std, nil)

-- Pickups / light trucks
addEntry("SC_MazdaB2000",       Std, { Outdoorsy, DIY, Farmer, Drinker, Smoker, Hunter })
addEntry("SC_FordBronco",       Std, { Outdoorsy, DIY, Hunter, Camper, Prepper, Drinker })
addEntry("SC_FordF15092",       Std, { Outdoorsy, DIY, Farmer, Hunter, Camper, Drinker, Smoker })
addEntry("SC_ChevroletG30",     Std, { DIY, Farmer, PackRat, Drinker })
addEntry("SC_ChevroletC70GrainTruck", Std, { Farmer, DIY })
addEntry("SC_ChevroletSuburban", Std, { Outdoorsy, DIY, Camper, RoadTrip, PackRat, Evacuee })

-- SUVs / off-road
addEntry("SC_ChevroletK5Blazer", Std, { Outdoorsy, Hunter, Camper, DIY, Prepper, Drinker })
addEntry("SC_JeepCJ7",           Std, { Outdoorsy, Hunter, Camper, Survivalist })
addEntry("SC_JeepCherokee",      Std, { Outdoorsy, Hunter, Camper, Commuter, RoadTrip })
addEntry("SC_JeepGrandWagoneer",      Std, { Outdoorsy, Hunter, Camper, Commuter, RoadTrip })
addEntry("SC_GeoTracker",        Std, { Outdoorsy, Camper, DIY })
addEntry("SC_FordExplorer",      Std, { Outdoorsy, Camper, Commuter, RoadTrip, Groceries })
addEntry("SC_NissanPathfinder",      Std, { Outdoorsy, Camper, Commuter, RoadTrip, Groceries })

-- Sport
addEntry("SC_ChevroletCamaro87", VehicleDistributions.SC_Sport, { Sport_T, Sport_S, Drinker, Smoker, BadTeens })
addEntry("SC_FordMustang90",     VehicleDistributions.SC_Sport, { Sport_T, Sport_S, Drinker, Smoker })

-- Luxury
addEntry("SC_Porsche911",       VehicleDistributions.SC_Luxury, { Lux_E, Lux_B, LuxAdv, Sport_T })
addEntry("SC_BMW520i",          VehicleDistributions.SC_Luxury, { Lux_B, Lux_E, Commuter })
addEntry("SC_CadillacBrougham", VehicleDistributions.SC_Luxury, { Lux_E, Drinker, Smoker })
addEntry("SC_CadillacLimo",     VehicleDistributions.SC_Luxury, { Lux_E })
addEntry("SC_Mercedes280",      VehicleDistributions.SC_Luxury, { Lux_B, Lux_E, LuxAdv })

-- Bubba
addEntry("SC_ChevroletK10_Dixie", VehicleDistributions.SC_Bubba, { Hunter, Drinker, Smoker })
addEntry("SC_DodgeM880_Bubba",    VehicleDistributions.SC_Bubba, { Hunter, Drinker, Prepper })

-- ============================================================
--  VANILLA SHARED NAMES — patch Specific onto existing entries
--  (these already exist in distributionTable from vanilla)
-- ============================================================
-- For shared names like "CarNormal", "OffRoad", "SportsCar", etc.
-- vanilla already set Normal on them. We only need to set Normal (overwrite
-- to our table) and Specific. Setting the whole sub-table is fine because
-- vanilla's Specific on these names uses vanilla profiles we're not using.

distributionTable["CarNormal"].Normal   = Std
distributionTable["CarNormal"].Specific = { Commuter, DIY, Groceries, Drinker, Smoker, BadTeens, RoadTrip, Nurse, Evacuee }

distributionTable["ModernCar"].Normal   = Std
distributionTable["ModernCar"].Specific = { Commuter, DIY, Groceries, Drinker, Smoker, BadTeens, RoadTrip, Nurse }

distributionTable["ModernCar02"].Normal   = Std
distributionTable["ModernCar02"].Specific = { Commuter, DIY, Groceries, Drinker, Smoker, BadTeens, RoadTrip }

distributionTable["SportsCar"].Normal   = VehicleDistributions.SC_Sport
distributionTable["SportsCar"].Specific = { Sport_T, Sport_S, Drinker, Smoker, BadTeens }

distributionTable["OffRoad"].Normal   = Std
distributionTable["OffRoad"].Specific = { Outdoorsy, Hunter, Camper, Survivalist }

addEntry("PickupVan",   Std, { Commuter, DIY, PackRat, RoadTrip })
addEntry("Van_Transit", Std, { Commuter, DIY, PackRat, Groceries, RoadTrip })

-- ============================================================
--  MILITIA
-- ============================================================
addEntry("SC_DodgeM880Militia",        VehicleDistributions.SC_Militia, nil)
addEntry("SC_CUCVZhenjaEdition",       VehicleDistributions.SC_Militia, nil)
addEntry("SC_ChevroletC70Survivalist", VehicleDistributions.SC_Militia, { Survivalist, Prepper })

-- ============================================================
--  AMBULANCE
-- ============================================================
addEntry("VanAmbulance",                     VehicleDistributions.SC_Ambulance, nil)
addEntry("SC_ChevroletG30Ambulance",         VehicleDistributions.SC_Ambulance, nil)
addEntry("SC_FordF350Ambulance_StPeregrin",  VehicleDistributions.SC_Ambulance, nil)
addEntry("SC_FordF350Ambulance_Meade",       VehicleDistributions.SC_Ambulance, nil)
addEntry("SC_FordF350Ambulance_Life",        VehicleDistributions.SC_Ambulance, nil)
addEntry("SC_ChevroletM1010Ambulance_3Tone", VehicleDistributions.SC_Ambulance, nil)

-- Armored / bank
distributionTable["SC_FordF700Armored_Dunbar"]    = { Normal = VehicleDistributions.SC_BankCar }
distributionTable["SC_FordF700Armored_Brinks"]    = { Normal = VehicleDistributions.SC_BankCar }
distributionTable["SC_FordF700Armored_Transport"] = { Normal = VehicleDistributions.SC_BankCar }

-- SWAT
distributionTable["SC_FordF700Armored_Police"] = { Normal = VehicleDistributions.SC_SWAT }
distributionTable["SC_ChevroletP30_SWAT"]      = { Normal = VehicleDistributions.SC_SWAT }

-- State Police
distributionTable["SC_FordCrownVictoria85_StatePolice"]  = { Normal = VehicleDistributions.SC_StatePolice }
distributionTable["SC_ChevroletSuburban_StatePolice"]    = { Normal = VehicleDistributions.SC_StatePolice }
distributionTable["PickUpVanLightsPolice"]               = { Normal = VehicleDistributions.SC_StatePolice }
distributionTable["CarLightsPolice"]                     = { Normal = VehicleDistributions.SC_StatePolice }
distributionTable["SC_FordMustang90_StatePolice"]        = { Normal = VehicleDistributions.SC_StatePolice }

-- Park Ranger
distributionTable["SC_FordCrownVictoria85_ParkRanger"]  = { Normal = VehicleDistributions.SC_ParkRanger }
distributionTable["SC_ChevroletCaprice85_ParkRanger"]   = { Normal = VehicleDistributions.SC_ParkRanger }
distributionTable["CarLights"]                           = { Normal = VehicleDistributions.SC_ParkRanger }
distributionTable["PickUpTruckLights"]                   = { Normal = VehicleDistributions.SC_ParkRanger }
distributionTable["SC_ChevroletK10_ParkRanger"]          = { Normal = VehicleDistributions.SC_ParkRanger }
distributionTable["SC_ChevroletK5Blazer_ParkRanger"]     = { Normal = VehicleDistributions.SC_ParkRanger }

-- City Police
distributionTable["SC_FordCrownVictoria85LouisvillePolice"] = { Normal = VehicleDistributions.SC_CityPolice }
distributionTable["SC_FordCrownVictoria92LouisvillePolice"] = { Normal = VehicleDistributions.SC_CityPolice }
distributionTable["SC_FordCrownVictoria92JeffersonPolice"]  = { Normal = VehicleDistributions.SC_CityPolice }

-- Sheriff
distributionTable["SC_FordCrownVictoria92JeffersonSheriff"] = { Normal = VehicleDistributions.SC_DeputySheriff }
distributionTable["SC_FordCrownVictoria92MuhlenSheriff"]    = { Normal = VehicleDistributions.SC_DeputySheriff }
distributionTable["SC_FordCrownVictoria92WarrenSheriff"]    = { Normal = VehicleDistributions.SC_DeputySheriff }
distributionTable["SC_FordCrownVictoria92MeadeSheriff"]     = { Normal = VehicleDistributions.SC_DeputySheriff }

-- Military
distributionTable["SC_DodgeM880"]                           = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008_3Tone"]                = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008_OD"]                   = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008_DesertMERDC"]          = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008TroopCarrier_3Tone"]    = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008TroopCarrier_OD"]       = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1008TroopCarrier_DesertMERDC"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009_3Tone"]                = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009_OD"]                   = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009_DesertMERDC"]          = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009MP_3Tone"]              = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009MP_OD"]                 = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1009MP_DesertMERDC"]        = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_ChevroletM1010Ambulance_OD"]          = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_ChevroletM1010Ambulance_DesertMERDC"] = { Normal = VehicleDistributions.SC_Ambulance }

distributionTable["SC_CadillacLimo"] = { Normal = VehicleDistributions.SC_Limo }

distributionTable["SC_AMGeneralM151A2_3Tone"]      = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_Tan"]        = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_OD"]         = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_MERDC"]      = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM151A2_Cleaners"]   = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097_3Tone"]       = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097_OD"]          = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097_Tan"]         = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097TroopCarrier_3Tone"] = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097TroopCarrier_OD"]   = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1097TroopCarrier_Tan"]  = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025_3Tone"]       = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025_OD"]          = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025_Tan"]         = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025MP_3Tone"]     = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025MP_OD"]        = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM1025MP_Tan"]       = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM997Ambulance_3Tone"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_AMGeneralM997Ambulance_OD"]  = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_AMGeneralM997Ambulance_Tan"] = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_AMGeneralM998Soft_3Tone"]    = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Soft_OD"]       = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Soft_Tan"]      = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Hard_3Tone"]    = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Hard_OD"]       = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM998Hard_Tan"]      = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM35A2_3Tone"]       = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM35A2_OD"]          = { Normal = VehicleDistributions.SC_Military }
distributionTable["SC_AMGeneralM35A2_MERDC"]       = { Normal = VehicleDistributions.SC_Military }

-- Fire
distributionTable["PickUpVanLightsFire"]   = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_HahnPumper_Red"]     = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_HahnPumper_Yellow"]  = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_CrownFireCoach_Red"] = { Normal = VehicleDistributions.SC_FireDepartment }
distributionTable["SC_CrownFireCoach_White"] = { Normal = VehicleDistributions.SC_FireDepartment }

-- Work / service
distributionTable["SC_ChevroletK5Blazer_McCoy"]    = { Normal = VehicleDistributions.SC_Standard }
distributionTable["SC_ChevroletK5Blazer_Fossoil"]  = { Normal = VehicleDistributions.SC_Standard }
distributionTable["SC_ChevroletG30_Fossoil"]       = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["SC_ChevroletG30BoxVan"]         = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["SC_ChevroletG30_MassGenFac"]    = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["Van_MassGenFac"]                = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["SC_ChevroletG30_LectroMax"]     = { Normal = VehicleDistributions.SC_WorkTruck }
distributionTable["VanSpiffo"]                     = { Normal = VehicleDistributions.SC_Spiffo }
distributionTable["SC_ChevroletG30_Spiffo"]        = { Normal = VehicleDistributions.SC_Spiffo }
distributionTable["SC_ChevroletG30_McCoy"]         = { Normal = VehicleDistributions.SC_McCoy }
distributionTable["SC_ChevroletG30_LBMW"]          = { Normal = VehicleDistributions.Radio }
distributionTable["SC_ChevroletG30_3N"]            = { Normal = VehicleDistributions.Radio }
distributionTable["SC_ChevroletG30Ambulance"]      = { Normal = VehicleDistributions.SC_Ambulance }
distributionTable["SC_GrummanLLV"]                 = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["SC_ChevroletG30_Mail"]          = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["SC_ChevroletG30_FedEx"]         = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVanMail"]                   = { Normal = VehicleDistributions.SC_MailCar }
distributionTable["StepVan_Heralds"]               = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletP30_Heralds"]       = { Normal = VehicleDistributions.SC_PaperCar }
distributionTable["SC_ChevroletG30_Heralds"]       = { Normal = VehicleDistributions.SC_PaperCar }