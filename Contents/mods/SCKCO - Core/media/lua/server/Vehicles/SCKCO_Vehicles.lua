require "server/Vehicles/Vehicles"

function Vehicles.ContainerAccess.BackOfTruckBed(vehicle, part, chr)
    if chr:getVehicle() == vehicle then
        local seat = vehicle:getSeat(chr)
        -- Can the seated player reach the passenger seat?
        -- Only character in front seat can access it
        return seat ~= 1 and seat ~= 0
    elseif chr:getVehicle() then
        -- Can't reach from inside a different vehicle.
        return false
    else
        -- Standing outside the vehicle.
        if not vehicle:isInArea(part:getArea(), chr) then return false end
        local doorPart = vehicle:getPartById("DoorFrontRight")
        if doorPart and doorPart:getDoor() and not doorPart:getDoor():isOpen() then
            return false
        end
        return true
    end
end