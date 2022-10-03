---
--- Created by cytt0rak
---  WIP

function CherokeeWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("CherokeeWindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("CherokeeWindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CherokeeWindshieldArmor"):setCondition(vehicle:getPartById("CherokeeWindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function CherokeeEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("CherokeeBumper"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("CherokeeBumper"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CherokeeBumper"):setCondition(vehicle:getPartById("CherokeeBumper"):getCondition()-1)

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

function CherokeeDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("DoorFrontLeft"):getInventoryItem()) and (vehicle:getPartById("CherokeeArmoring"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function CherokeeDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("DoorFrontRight"):getInventoryItem()) and (vehicle:getPartById("CherokeeArmoring"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end


function CherokeeWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("CherokeeFrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("CherokeeFrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CherokeeFrontLeftWindowArmor"):setCondition(vehicle:getPartById("CherokeeFrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CherokeeWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Cherokee" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("CherokeeFrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("CherokeeFrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CherokeeFrontRightWindowArmor"):setCondition(vehicle:getPartById("CherokeeFrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function CherokeeBumper(player, part, elapsedMinutes)
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
Events.OnPlayerUpdate.Add(CherokeeBumper);