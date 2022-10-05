VehicleZoneDistribution = VehicleZoneDistribution or {};

if not VehicleZoneDistribution.GeneralMilitary or not VehicleZoneDistribution.GeneralMilitary.vehicles then
    VehicleZoneDistribution.GeneralMilitary = {};
    VehicleZoneDistribution.GeneralMilitary.vehicles = {};
    VehicleZoneDistribution.GeneralMilitary.specialCar = false;
    VehicleZoneDistribution.GeneralMilitary.chanceToSpawnSpecial = 0;
    VehicleZoneDistribution.GeneralMilitary.randomAngle = false;
    VehicleZoneDistribution.GeneralMilitary.spawnRate = 30; -- 30
end
