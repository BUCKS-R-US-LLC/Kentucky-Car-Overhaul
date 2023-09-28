---
--- Created by cytt0rak
---  WIP

function TractorEngine(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Oliver2050")) then

        local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("Engine"):getCondition() < 50) and (vehicle:getPartById("Engine"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(Engine)
    end


end

Events.OnPlayerUpdate.Add(TractorEngine);