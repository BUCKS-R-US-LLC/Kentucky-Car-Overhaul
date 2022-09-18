require "server/Vehicles/Vehicles"

function Vehicles.ContainerAccess.BackOfTruck(vehicle, part, chr)
    if chr:getVehicle() == vehicle then
        local seat = vehicle:getSeat(chr)
        return (seat > 1)

    elseif chr:getVehicle() then
        return false

    else
        if not vehicle:isInArea(part:getArea(), chr) then
            return false
        end

        local trunkDoor = vehicle:getPartById("TrunkDoor") or vehicle:getPartById("DoorRear")
        if trunkDoor and trunkDoor:getDoor() then
            if not trunkDoor:getInventoryItem() then return true end
            if not trunkDoor:getDoor():isOpen() then return false end
        end

        return true
    end
end