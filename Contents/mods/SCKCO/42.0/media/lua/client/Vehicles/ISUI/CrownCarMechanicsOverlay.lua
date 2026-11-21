ISCarMechanicsOverlay.CarList["Base.SC_CrownFireCoach_Red"] = {imgPrefix = "firecoach_", x=0,y=0};  -- name-mismatch fix
ISCarMechanicsOverlay.CarList["Base.SC_CrownFireCoach_White"] = {imgPrefix = "firecoach_", x=0,y=0};  -- name-mismatch fix


ISCarMechanicsOverlay.PartList["Battery"].vehicles = ISCarMechanicsOverlay.PartList["Battery"].vehicles or {};
--
ISCarMechanicsOverlay.PartList["SuspensionFrontLeft"].vehicles = ISCarMechanicsOverlay.PartList["SuspensionFrontLeft"].vehicles or {};
ISCarMechanicsOverlay.PartList["SuspensionFrontRight"].vehicles = ISCarMechanicsOverlay.PartList["SuspensionFrontRight"].vehicles or {};
ISCarMechanicsOverlay.PartList["SuspensionRearLeft"].vehicles = ISCarMechanicsOverlay.PartList["SuspensionRearLeft"].vehicles or {};
ISCarMechanicsOverlay.PartList["SuspensionRearRight"].vehicles = ISCarMechanicsOverlay.PartList["SuspensionRearRight"].vehicles or {};
--
ISCarMechanicsOverlay.PartList["BrakeFrontLeft"].vehicles = ISCarMechanicsOverlay.PartList["BrakeFrontLeft"].vehicles or {};
ISCarMechanicsOverlay.PartList["BrakeFrontRight"].vehicles = ISCarMechanicsOverlay.PartList["BrakeFrontRight"].vehicles or {};
ISCarMechanicsOverlay.PartList["BrakeRearLeft"].vehicles = ISCarMechanicsOverlay.PartList["BrakeRearLeft"].vehicles or {};
ISCarMechanicsOverlay.PartList["BrakeRearRight"].vehicles = ISCarMechanicsOverlay.PartList["BrakeRearRight"].vehicles or {};
--
ISCarMechanicsOverlay.PartList["DoorFrontLeft"].vehicles = ISCarMechanicsOverlay.PartList["DoorFrontLeft"].vehicles or {};
ISCarMechanicsOverlay.PartList["DoorFrontRight"].vehicles = ISCarMechanicsOverlay.PartList["DoorFrontRight"].vehicles or {};
--
ISCarMechanicsOverlay.PartList["DoorRear"] = {img="trunk", vehicles = {"all_"}};
ISCarMechanicsOverlay.PartList["DoorRear"].vehicles = ISCarMechanicsOverlay.PartList["DoorRear"].vehicles or {};
--
ISCarMechanicsOverlay.PartList["Engine"].vehicles = ISCarMechanicsOverlay.PartList["Engine"].vehicles or {};
--
ISCarMechanicsOverlay.PartList["Muffler"].vehicles = ISCarMechanicsOverlay.PartList["Muffler"].vehicles or {};