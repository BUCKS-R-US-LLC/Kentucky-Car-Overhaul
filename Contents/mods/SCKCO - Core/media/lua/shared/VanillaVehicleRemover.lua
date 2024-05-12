local function sortOutNils(tbl)
    local newTbl = {}
    for k,v in pairs(tbl) do if(v ~= nil) then newTbl[k] = v end end
    tbl = newTbl
end

if VehicleZoneDistribution then -- check if the table exists for backwards compatibility

	VehicleZoneDistribution.parkingstall.vehicles["Base.ModernCar"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.ModernCar"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.ModernCar"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.ModernCar"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.ModernCar02"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.ModernCar02"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.ModernCar02"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.ModernCar02"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.CarStationWagon"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarStationWagon"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarStationWagon"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarStationWagon"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.CarStationWagon2"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarStationWagon2"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarStationWagon2"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarStationWagon2"] = nil;
	
	VehicleZoneDistribution.parkingstall.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarNormal"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.CarLights"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarLights"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarLights"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarLights"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.CarLightsPolice"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarLightsPolice"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarLightsPolice"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarLightsPolice"] = nil;
	VehicleZoneDistribution.police.vehicles["Base.CarLightsPolice"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.CarTaxi"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarTaxi"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarTaxi"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarTaxi"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.CarTaxi2"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarTaxi2"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarTaxi2"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarTaxi2"] = nil;
	
	VehicleZoneDistribution.parkingstall.vehicles["Base.CarLuxury"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarLuxury"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarLuxury"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarLuxury"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.Offroad"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.Offroad"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.Offroad"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.Offroad"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.SUV"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.SUV"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.SUV"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.SUV"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.SmallCar"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.SmallCar"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.SmallCar"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.SmallCar"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.SmallCar02"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.SmallCar02"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.SmallCar02"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.SmallCar02"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpTruck"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpTruck"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpTruck"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpTruck"] = nil;
	
	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpTruckLights"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpTruckLights"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpTruckLights"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpTruckLights"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpTruckLightsFire"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpTruckLightsFire"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpTruckLightsFire"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpTruckLightsFire"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpTruckMccoy"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpTruckMccoy"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpTruckMccoy"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpTruckMccoy"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpVan"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpVan"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpVan"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpVan"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpVanLights"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpVanLights"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpVanLights"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpVanLights"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpVanLightsFire"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpVanLightsFire"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpVanLightsFire"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpVanLightsFire"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpVanLightsPolice"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpVanLightsPolice"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpVanLightsPolice"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpVanLightsPolice"] = nil;
	VehicleZoneDistribution.police.vehicles["Base.PickUpVanLightsPolice"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.PickUpVanLightsMccoy"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.PickUpVanLightsMccoy"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.PickUpVanLightsMccoy"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.PickUpVanLightsMccoy"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.StepVan"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.StepVan"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.StepVan"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.StepVan"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.StepVanMail"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.StepVanMail"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.StepVanMail"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.StepVanMail"] = nil;
	VehicleZoneDistribution.postal.vehicles["Base.StepVanMail"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.StepVan_Heralds"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.StepVan_Heralds"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.StepVan_Heralds"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.StepVan_Heralds"] = nil;
	VehicleZoneDistribution.kyheralds.vehicles["Base.StepVan_Heralds"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.StepVan_Scarlet"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.StepVan_Scarlet"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.StepVan_Scarlet"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.StepVan_Scarlet"] = nil;
	VehicleZoneDistribution.scarlet.vehicles["Base.StepVan_Scarlet"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.Van"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.Van"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.Van"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.Van"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.VanAmbulance"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.VanAmbulance"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.VanAmbulance"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.VanAmbulance"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.VanRadio "] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.VanRadio "] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.VanRadio "] = nil;
	VehicleZoneDistribution.good.vehicles["Base.VanRadio "] = nil;
	
	VehicleZoneDistribution.parkingstall.vehicles["Base.VanRadio_3N "] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.VanRadio_3N "] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.VanRadio_3N "] = nil;
	VehicleZoneDistribution.good.vehicles["Base.VanRadio_3N "] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.VanSeats"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.VanSeats"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.VanSeats"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.VanSeats"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.VanSpecial"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.VanSpecial"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.VanSpecial"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.VanSpecial"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.VanSpiffo"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.VanSpiffo"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.VanSpiffo"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.VanSpiffo"] = nil;
	
	VehicleZoneDistribution.parkingstall.vehicles["Base.Van_KnoxDisti"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.Van_KnoxDisti"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.Van_KnoxDisti"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.Van_KnoxDisti"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.Van_LectroMax"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.Van_LectroMax"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.Van_LectroMax"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.Van_LectroMax"] = nil;
	VehicleZoneDistribution.lectromax.vehicles["Base.Van_LectroMax"] = nil;
	
	VehicleZoneDistribution.parkingstall.vehicles["Base.Van_MassGenFac"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.Van_MassGenFac"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.Van_MassGenFac"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.Van_MassGenFac"] = nil;

	VehicleZoneDistribution.parkingstall.vehicles["Base.Van_Transit"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.Van_Transit"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.Van_Transit"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.Van_Transit"] = nil;
	
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLightsSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLightsSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLightsSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLightsSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedRear"] = nil;
	
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarLuxurySmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.CarNormalSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarNormalSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarNormalSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarNormalSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmallSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmallSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmallSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmallSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmall02SmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmall02SmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmall02SmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarSmall02SmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.CarStationWagonSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarStationWagonSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarStationWagonSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.CarStationWagonSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCarSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCarSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCarSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCarSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCar02SmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCar02SmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCar02SmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.ModernCar02SmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.OffroadSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.OffroadSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.OffroadSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.OffroadSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpTruckSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpTruckSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpTruckSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpTruckSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpVanSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpVanSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpVanSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.PickUpVanSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.SUVSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.SUVSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.SUVSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.SUVSmashedRear"] = nil;
	
	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanSmashedRear"] = nil;

	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanMailSmashedFront"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanMailSmashedLeft"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanMailSmashedRight"] = nil;
	VehicleZoneDistribution.trafficjams.vehicles["Base.StepVanMailSmashedRear"] = nil;

	-- Devs cars
	VehicleZoneDistribution.trafficjamw.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.SmallCar"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.SmallCar02"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.CarTaxi"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.CarTaxi2"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.PickUpTruck"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.PickUpVan"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.CarStationWagon"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.CarStationWagon2"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.VanSeats"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.Van"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.StepVan"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.ModernCar"] = nil;
	VehicleZoneDistribution.trafficjamw.vehicles["Base.ModernCar02"] = nil;

	-- Developers added a space to the "offroad" alas preventing total renaming
	VehicleZoneDistribution.bad.vehicles["Base.Offroad"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.Offroad"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.Offroad"] = nil;
end