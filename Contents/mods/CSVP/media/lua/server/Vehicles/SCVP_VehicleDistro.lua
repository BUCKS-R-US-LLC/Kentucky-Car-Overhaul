local distributionTable = VehicleDistributions[1]

VehicleDistributions.SCPolice = {
    TruckBed = {
        rolls = 4,
        items = {
            "308Box", 10,
            "AmmoStrap_Bullets", 4,
            "AmmoStrap_Shells", 4,
            "AssaultRifle2", 1,
            "Bullets9mmBox", 20,
            "Bullets9mmBox", 10,
            "HandTorch", 4,
            "Hat_CrashHelmet_Police", 2,
            "HolsterDouble", 1,
            "HolsterSimple", 4,
            "HuntingRifle", 8,
            "M14Clip", 4,
            "Nightstick", 2,
            "Pistol", 10,
            "Radio.WalkieTalkie4", 10,
            "Shotgun", 10,
            "ShotgunShellsBox", 10,
            "Sling", 4,
            "x2Scope", 4,
            "x4Scope", 2,
            "x8Scope", 1,
        },
        junk = {
            rolls = 1,
            items = {
                "FirstAidKit", 20,
                "Radio.HamRadio1", 20,
            }
        }
    },

    GloveBox = {
        rolls = 4,
        items = {
            "AlcoholWipes", 8,
            "Bandage", 4,
            "Bandaid", 10,
            "Battery", 10,
            "BluePen", 8,
            "Bullets9mmBox", 20,
            "Bullets9mmBox", 10,
            "Eraser", 6,
            "HandTorch", 4,
            "Magazine", 10,
            "Notebook", 10,
            "Paperclip", 4,
            "Pen", 8,
            "Pencil", 10,
            "Radio.WalkieTalkie4", 10,
            "RedPen", 8,
            "RubberBand", 6,
        },
        junk = {
            rolls = 1,
            items = {
                "Base.MarchRidgeMap", 4,
                "Base.MuldraughMap", 4,
                "Base.RiversideMap", 4,
                "Base.RosewoodMap", 4,
                "Base.WestpointMap", 4,
                "Cigarettes", 8,
                "FirstAidKit", 20,
                "Glasses_Aviators", 0.5,
                "Gloves_LeatherGlovesBlack", 0.5,
                "HandTorch", 4,
                "Lighter", 4,
                "Matches", 8,
                "Pistol", 20,
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

distributionTable["SC_BlazerK5StatePolice"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_BlazerK5LVPD"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_BlazerK5ParkRanger"] = { Normal = VehicleDistributions.SCPolice; }

distributionTable["SC_Caprice9C1StatePolice"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_Caprice9C1LVPD"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_Caprice9C1ParkRanger"] = { Normal = VehicleDistributions.SCPolice; }

distributionTable["SC_CrownVictoriaStatePolice"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_CrownVictoriaLVPD"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_CrownVictoriaParkRanger"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_StepVanP30Police"] = { Normal = VehicleDistributions.SCPolice; }
distributionTable["SC_StepVanP30ParkRanger"] = { Normal = VehicleDistributions.SCPolice; }

distributionTable["SC_K5BlazerCiv"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CapriceCiv"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CrownVictoriaCiv"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_CrownVictoriaTaxi"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_StepVanP30Civ"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_FordCountrySquire"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_G30Van"] = { Normal = VehicleDistributions.SCCivilian; }
distributionTable["SC_G30VanNormal"] = { Normal = VehicleDistributions.SCCivilian; }

