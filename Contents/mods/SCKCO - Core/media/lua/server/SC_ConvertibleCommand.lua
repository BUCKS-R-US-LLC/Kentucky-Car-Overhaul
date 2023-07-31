Vehicles.Convertible = {}

function Vehicles.Convertible.Open(vehicle, part, character)
	if not part:getInventoryItem() then return end
	if part:getDoor():isOpen() then
		ISTimedActionQueue.add(ISCloseVehicleDoor:new(character, vehicle, part))
	else
		if part:getDoor():isLocked() then
			ISTimedActionQueue.add(ISUnlockVehicleDoor:new(character, part))
		end
		ISTimedActionQueue.add(ISOpenVehicleDoor:new(character, vehicle, part))
	end
end