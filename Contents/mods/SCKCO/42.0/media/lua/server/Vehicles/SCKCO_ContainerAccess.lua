require "Vehicles/ISUI/ISVehicleMenu"

SCKCO = SCKCO or {}
SCKCO.ContainerAccess = SCKCO.ContainerAccess or {}

-- Bed cargo: reachable while seated anywhere in this vehicle, or while standing in the part's area.
-- Mirrors Vehicles.ContainerAccess.GloveBox (seated) plus the standard outside area check.
SCKCO.ContainerAccess.BedOrSeat = function(vehicle, part, chr)
	if not chr or not vehicle or not part then return false end

	if chr:getVehicle() == vehicle then return true end

	local area = part:getArea()
	if not area then return false end

	return vehicle:isInArea(area, chr)
end
