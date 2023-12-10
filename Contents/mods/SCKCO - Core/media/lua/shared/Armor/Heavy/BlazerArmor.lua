---
--- Created by cytt0rak
---  WIP

function ChevyEngine(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpVan", "PickUpVanLights", "PickUpVanLightsPolice", "SC_CUCVZhenjaEdition", "SC_M1008", "SC_M1009", "SC_M1009MilitaryPolice", "SC_M1008TroopCarrier", "SC_M1010Ambulance", "SC_M1010Ambulance", "SC_M1028A3")) then

        local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("Engine"):getCondition() < 20) and (vehicle:getPartById("Engine"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50 })

        end
        vehicle:transmitPartModData(Engine)
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

Events.OnPlayerUpdate.Add(ChevyEngine);
Events.OnPlayerUpdate.Add(K5BullbarPolice);