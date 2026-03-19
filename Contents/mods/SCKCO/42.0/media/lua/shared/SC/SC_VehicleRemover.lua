if not VehicleZoneDistribution then return end
 
local zones = VehicleZoneDistribution
local std = { "parkingstall", "bad", "medium", "good" }
 
local function remove(name, extra)
	for _, zone in ipairs(std) do
		if zones[zone] then zones[zone].vehicles[name] = nil end
	end
	if extra then
		for _, zone in ipairs(extra) do
			if zones[zone] then zones[zone].vehicles[name] = nil end
		end
	end
end
 
local function removeOnly(name, zoneList)
	for _, zone in ipairs(zoneList) do
		if zones[zone] then zones[zone].vehicles[name] = nil end
	end
end
 
-- Standard vehicles
remove("Base.ModernCar")
remove("Base.ModernCar02")
remove("Base.CarStationWagon")
remove("Base.CarStationWagon2")
remove("Base.CarNormal")
remove("Base.CarLights")
remove("Base.CarLightsPolice", { "police" })
remove("Base.CarTaxi")
remove("Base.CarTaxi2")
remove("Base.CarLuxury")
remove("Base.OffRoad")
remove("Base.SUV")
remove("Base.SmallCar")
remove("Base.SmallCar02")
remove("Base.PickUpTruck")
remove("Base.PickUpTruckLights")
remove("Base.PickUpTruckLightsFire")
remove("Base.PickUpTruckMccoy")
remove("Base.PickUpVan")
remove("Base.PickUpVanLights")
remove("Base.PickUpVanLightsFire")
remove("Base.PickUpVanLightsPolice", { "police" })
remove("Base.PickUpVanLightsMccoy")
remove("Base.StepVan")
remove("Base.StepVanMail", { "postal" })
remove("Base.StepVan_Heralds", { "kyheralds" })
remove("Base.StepVan_Scarlet", { "scarlet" })
remove("Base.Van")
remove("Base.VanAmbulance")
remove("Base.VanRadio")
remove("Base.VanRadio_3N")
remove("Base.VanSeats")
remove("Base.VanSpecial")
remove("Base.VanSpiffo")
remove("Base.Van_KnoxDisti")
remove("Base.Van_LectroMax", { "lectromax" })
remove("Base.Van_MassGenFac")
remove("Base.Van_Transit")
remove("Base.Base_Offroad")
 
-- Traffic jam smashed wrecks
local smashed = {
	"CarLights", "CarLuxury", "CarNormal", "CarSmall", "CarSmall02",
	"CarStationWagon", "ModernCar", "ModernCar02", "Offroad",
	"PickUpTruck", "PickUpVan", "SUV", "StepVan", "StepVanMail",
}
for _, name in ipairs(smashed) do
	for _, side in ipairs({ "Front", "Left", "Right", "Rear" }) do
		if zones.trafficjams then
			zones.trafficjams.vehicles["Base." .. name .. "Smashed" .. side] = nil
		end
	end
end
 
-- Traffic jam wrecks (west)
local trafficjamw = {
	"CarNormal", "SmallCar", "SmallCar02", "CarTaxi", "CarTaxi2",
	"PickUpTruck", "PickUpVan", "CarStationWagon", "CarStationWagon2",
	"VanSeats", "Van", "StepVan", "ModernCar", "ModernCar02",
}
for _, name in ipairs(trafficjamw) do
	if zones.trafficjamw then
		zones.trafficjamw.vehicles["Base." .. name] = nil
	end
end