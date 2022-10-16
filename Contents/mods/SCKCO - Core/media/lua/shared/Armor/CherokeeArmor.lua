---
--- Created by cytt0rak
---  WIP

function CherokeeWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("JeepCherokeeWindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeWindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeWindshieldArmor"):setCondition(vehicle:getPartById("JeepCherokeeWindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function CherokeeEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("JeepCherokeeBullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeBullbar"):setCondition(vehicle:getPartById("JeepCherokeeBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end


function CherokeeGasTank(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

        local part = vehicle:getPartById("GasTank")
        if (vehicle:getPartById("GasTank"):getCondition() < 70) and (vehicle:getPartById("GasTank"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(GasTank)
    end


end

function CherokeeWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("JeepCherokeeWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeeWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CherokeeWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("JeepCherokeeWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeetWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function CherokeeBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("JeepCherokeeBullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("JeepCherokeeBullbar"):setCondition(vehicle:getPartById("CherokeeBumper"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

Events.OnPlayerUpdate.Add(CherokeeWindshield);
Events.OnPlayerUpdate.Add(CherokeeGasTank);
Events.OnPlayerUpdate.Add(CherokeeEngineDoor);
Events.OnPlayerUpdate.Add(CherokeeDoorFrontLeft);
Events.OnPlayerUpdate.Add(CherokeeDoorFrontRight);
Events.OnPlayerUpdate.Add(CherokeeWindowFrontLeft);
Events.OnPlayerUpdate.Add(CherokeeWindowFrontRight);
Events.OnPlayerUpdate.Add(CherokeeBullbar);