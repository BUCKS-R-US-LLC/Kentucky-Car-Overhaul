local distributionTable = VehicleDistributions[1]

VehicleDistributions.IFAVGloveBox = {
    rolls = 20,
    items ={
        "FirstAidKit", 1,
        "Crayons ", 0.01,
    }
}

VehicleDistributions.IFAVMisc = {
    rolls = 20,
    items ={

        "FirstAidKit", 3,
        "Bag_ALICEpack", 10,
        "PetrolCan", 10,
    }
}

VehicleDistributions.IFAV = {

	GloveBox = VehicleDistributions.IFAVGloveBox;
	TruckBed = VehicleDistributions.IFAVMisc;
}

distributionTable["IFAV"] = { Normal = VehicleDistributions.IFAV; }


