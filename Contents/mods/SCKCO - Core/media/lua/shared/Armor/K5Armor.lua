---
--- Created by cytt0rak
---  WIP

function ChevyBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Blazer", "PickUpVan", "PickUpTruck", "M1009", "M1008", "M1010" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("K5Bullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("K5Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50 })
            vehicle:getPartById("K5Bullbar"):setCondition(vehicle:getPartById("K5Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

Events.OnPlayerUpdate.Add(ChevyBullbar);