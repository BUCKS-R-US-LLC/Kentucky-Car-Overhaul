---
--- Created by cytt0rak
---  WIP

function PorscheEngine(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Porsche911")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("Engine"):getCondition() < 20) and (vehicle:getPartById("Engine"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 30 })

        end
        vehicle:transmitPartModData(Engine)
    end


end

Events.OnPlayerUpdate.Add(PorscheEngine);
