---
--- Created by cytt0rak
---  WIP

function C70GasTank(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "C70" )) then

        local part = vehicle:getPartById("GasTank")
        if (vehicle:getPartById("GasTank"):getCondition() < 70) and (vehicle:getPartById("GasTank"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(GasTank)
    end


end

function C70SurvivorWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "C70Survivalist" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("C70BrushGuardFabricated"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("C70BrushGuardFabricated"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("C70BrushGuardFabricated"):setCondition(vehicle:getPartById("C70BrushGuardFabricated"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function C70EngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "C70GrainTruck" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("C70Bullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("C70Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("C70Bullbar"):setCondition(vehicle:getPartById("C70Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function C70SurvivorEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "C70Survivalist" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("C70BullbarFabricated"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("C70BullbarFabricated"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("C70BullbarFabricated"):setCondition(vehicle:getPartById("C70BullbarFabricated"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

Events.OnPlayerUpdate.Add(C70GasTank);
Events.OnPlayerUpdate.Add(C70EngineDoor);
Events.OnPlayerUpdate.Add(C70SurvivorWindshield);
Events.OnPlayerUpdate.Add(C70SurvivorEngineDoor);