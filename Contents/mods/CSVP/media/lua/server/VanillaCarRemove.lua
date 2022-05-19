if VehicleZoneDistribution then 

--- This is a soft shut off for vanilla vehicles incase of a mod conflict

	-- overall

	VehicleZoneDistribution.parkingstall.vehicles["Base.CarNormal"] = nil,

	VehicleZoneDistribution.junkyard.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.trailerpark.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.bad.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.medium.vehicles["Base.CarNormal"] = nil;
	VehicleZoneDistribution.good.vehicles["Base.CarNormal"] = nil;

	-- police
	VehicleZoneDistribution.police.vehicles["Base.PickUpVanLightsPolice"] = nil;
	VehicleZoneDistribution.police.vehicles["Base.CarLightsPolice"] = nil;

	-- ranger
	VehicleZoneDistribution.ranger.vehicles["Base.CarLights"] = nil;
	VehicleZoneDistribution.ranger.vehicles["Base.PickUpVanLights"] = nil;
	VehicleZoneDistribution.ranger.vehicles["Base.PickUpTruckLights"] = nil;


end