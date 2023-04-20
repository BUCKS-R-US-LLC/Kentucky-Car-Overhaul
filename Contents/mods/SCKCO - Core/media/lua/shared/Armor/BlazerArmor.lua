---
--- Created by cytt0rak
---  WIP

function K5Bullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "K5" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("K5Bullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("K5Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("K5Bullbar"):setCondition(vehicle:getPartById("K5Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function CUCVBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CUCV" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("K5Bullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("K5Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("K5Bullbar"):setCondition(vehicle:getPartById("K5Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

Events.OnPlayerUpdate.Add(K5Bullbar);
Events.OnPlayerUpdate.Add(CUCVBullbar);