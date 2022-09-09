---
--- Created by cytt0rak
---  WIP
---

function M35A1CargoWeightFix(player, part, elapsedMinutes)
	local vehicle = player:getVehicle()
	if (vehicle and string.find( vehicle:getScriptName(), "M35A1" )) then

		if vehicle:getMass() > 1470 then

			vehicle:setMass(1469)

		end

	end

end

--- Events.OnPlayerUpdate.Add(M35A1CargoWeightFix);