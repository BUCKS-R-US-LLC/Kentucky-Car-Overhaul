require "Vehicles/ISUI/ISCarMechanicsOverlay"

ISCarMechanicsOverlay.CarList["Base.SC_HondaAccord"] = {imgPrefix = "accord_", x=0,y=0}
--
ISCarMechanicsOverlay.PartList["DoorFrontLeft"].vehicles["accord_"] = {x=0,y=0,x2=0,y2=0}
ISCarMechanicsOverlay.PartList["DoorFrontRight"].vehicles["accord_"] = {x=0,y=0,x2=0,y2=0}
--
ISCarMechanicsOverlay.CarList["Base.SmallCar"] = ISCarMechanicsOverlay.CarList["Base.SC_HondaAccord"]