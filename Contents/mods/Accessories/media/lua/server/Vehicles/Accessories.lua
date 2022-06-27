
local distributionTable = VehicleDistributions[1]

VehicleDistributions.SACEEFEMATruckBed = {
    rolls = 20,
    items ={
        
        "Base.Jacket_FEMA", 20,
        "Base.Jacket_FEMA", 20,
        "Base.Jacket_FEMA", 20,
        "Base.Jacket_FEMA", 20,
        "Hat_DustMask", 10,
        "Radio.WalkieTalkie3", 10,
        "Vest_HighViz", 10,

    }
}


VehicleDistributions.SACEEFEMA = {

    TruckBed = VehicleDistributions.SACEEFEMATruckBed;
    TruckbedOpen = VehicleDistributions.SACEEFEMATruckBed;
     
}

distributionTable["SC_G30VanWindowlessFEMA"] = { Normal = VehicleDistributions.SACEEFEMA; }
