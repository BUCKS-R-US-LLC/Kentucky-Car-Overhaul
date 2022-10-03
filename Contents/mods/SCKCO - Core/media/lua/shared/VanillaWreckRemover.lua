local function sortOutNils(tbl)
    local newTbl = {}
    for k,v in pairs(tbl) do if(v ~= nil) then newTbl[k] = v end end
    tbl = newTbl
end

if VehicleZoneDistribution then -- check if the table exists for backwards compatibility

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
