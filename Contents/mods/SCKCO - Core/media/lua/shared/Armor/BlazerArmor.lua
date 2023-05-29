---
--- Created by cytt0rak
---  WIP

function K5Bullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_K5BlazerFossoil", "SC_K5BlazerMcCoys", "PickUpVan", "PickUpVanLights", "PickUpVanLightsFire", "PickUpLightsPolice", "PickupVanLightsMccoy")) then

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
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1008", "SC_M1009", "SC_M1010", "SC_M1028A3", "SC_CUCVZhenjaEdition")) then

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