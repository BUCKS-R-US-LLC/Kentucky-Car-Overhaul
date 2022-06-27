require "VehicleZoneDefinition"
VehicleZoneDistribution.crownfirecoachs = VehicleZoneDistribution.crownfirecoachs or {}
VehicleZoneDistribution.crownfirecoachs.vehicles = VehicleZoneDistribution.crownfirecoachs.vehicles or {}
VehicleZoneDistribution.crownfirecoachs.vehicles["Base.SC_CrownFireCoach"] = {index = -1, spawnChance = 50}
VehicleZoneDistribution.crownfirecoachs.baseVehicleQuality = 1.1;
VehicleZoneDistribution.crownfirecoachs.spawnRate = 34; -- inflated spawn chance to force spawning for testing

function PA_crownfirecoachs_Zones()
    local dirs = getLotDirectories()
    for i=dirs:size(),1,-1 do
        local map = dirs:get(i-1)
        if map == "Muldraugh, KY" then
            getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 13700, 1791, 0, 5, 5, { Direction = "S" })
		getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 12379, 1776, 0, 5, 5, { Direction = "E" })
		getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 13681, 4041, 0, 5, 5, { Direction = "E" })
		getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 13906, 4052, 0, 5, 5, { Direction = "E" })
		getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 12843, 6365, 0, 5, 5, { Direction = "N" })
		getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 8169, 11750, 0, 5, 5, { Direction = "N" })
		getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 7145, 9476, 0, 5, 5, { Direction = "E" })
		getWorld():registerVehiclesZone("crownfirecoachs", "ParkingStall", 5977, 6506, 0, 5, 5, { Direction = "S" })
        end
    end
end

Events.OnLoadMapZones.Add(PA_crownfirecoachs_Zones)

