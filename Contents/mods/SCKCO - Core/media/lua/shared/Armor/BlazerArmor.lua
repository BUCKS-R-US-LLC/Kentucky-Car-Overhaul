---
--- Created by cytt0rak
---  WIP

function ChevyBullbar1(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CUCVZhenjaEdition", "SC_M1008", "SC_M1009", "SC_M1009MilitaryPolice", "SC_M1008TroopCarrier", "SC_M1008Ambulance", "SC_M1010Ambulance", "SC_M1028A3")) then

        local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("K5Bullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("K5Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K5Bullbar"):setCondition(vehicle:getPartById("K5Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function ChevyBullbar2(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CUCVZhenjaEdition", "SC_M1009", "SC_M1009MilitaryPolice", "SC_M1008TroopCarrier", "SC_M1008Ambulance", "SC_M1010Ambulance", "SC_M1028A3")) then

        local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("K5Bullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("K5Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K5Bullbar"):setCondition(vehicle:getPartById("K5Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function K5BullbarPolice(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpVanLightsPolice")) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("K5BullbarPolice"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 100) and (vehicle:getPartById("K5BullbarPolice"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50})
            vehicle:getPartById("K5BullbarPolice"):setCondition(vehicle:getPartById("K5BullbarPolice"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

Events.OnPlayerUpdate.Add(ChevyBullbar1);
Events.OnPlayerUpdate.Add(ChevyBullbar2);
Events.OnPlayerUpdate.Add(K5BullbarPolice);