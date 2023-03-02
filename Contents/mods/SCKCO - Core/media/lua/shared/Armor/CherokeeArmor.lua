---
--- Created by cytt0rak
---  WIP

function CherokeeWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("JeepCherokeeWindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeWindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeWindshieldArmor"):setCondition(vehicle:getPartById("JeepCherokeeWindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function CherokeeGasTank(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("GasTank")
        if (vehicle:getPartById("GasTank"):getCondition() < 70) and (vehicle:getPartById("GasTank"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(GasTank)
    end


end

function CherokeeWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("JeepCherokeeFrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeFrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeFrontLeftWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeeFrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CherokeeWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("JeepCherokeeFrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeFrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeFrontRightWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeeFrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end


function CherokeeWindowRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("JeepCherokeeRearLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeRearLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeRearLeftWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeeRearLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CherokeeWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("JeepCherokeeRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeRearRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeRearRightWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeeRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function CherokeeBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("JeepCherokeeBullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("JeepCherokeeBullbar"):setCondition(vehicle:getPartById("JeepCherokeeBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineWindow)
    end


end


function CherokeeDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("JeepCherokeeFrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeFrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeFrontLeftDoorArmor"):setCondition(vehicle:getPartById("JeepCherokeeFrontLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end


function CherokeeDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("JeepCherokeeFrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeFrontRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeFrontRightDoorArmor"):setCondition(vehicle:getPartById("JeepCherokeeFrontRightDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end


function CherokeeDoorRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("DoorRearLeft")
        if (vehicle:getPartById("JeepCherokeeRearLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorRearLeft"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeRearLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeRearLeftDoorArmor"):setCondition(vehicle:getPartById("JeepCherokeeRearLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorRearLeft)
    end


end

function CherokeeDoorRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("DoorRearRight")
        if (vehicle:getPartById("JeepCherokeeRearRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorRearRight"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeRearRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeRearRightDoorArmor"):setCondition(vehicle:getPartById("JeepCherokeeRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorRearRight)
    end


end


function CherokeeWindowMiddleLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("WindowMiddleLeft")
        if (vehicle:getPartById("JeepCherokeeMiddleLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowMiddleLeft"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeMiddleLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeMiddleLeftWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeeMiddleLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowMiddleLeft)
    end


end

function CherokeeWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

        local part = vehicle:getPartById("WindowMiddleRight")
        if (vehicle:getPartById("JeepCherokeeMiddleRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowMiddleRight"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeMiddleRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("JeepCherokeeMiddleRightWindowArmor"):setCondition(vehicle:getPartById("JeepCherokeeRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowMiddleRight)
    end


end

function CherokeeBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Jeep Cherokee" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("JeepCherokeeBullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("JeepCherokeeBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("JeepCherokeeBullbar"):setCondition(vehicle:getPartById("JeepCherokeeBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end


Events.OnPlayerUpdate.Add(CherokeeWindshield);
Events.OnPlayerUpdate.Add(CherokeeGasTank);
Events.OnPlayerUpdate.Add(CherokeeBullbar);
Events.OnPlayerUpdate.Add(CherokeeDoorFrontLeft);
Events.OnPlayerUpdate.Add(CherokeeDoorFrontRight);
Events.OnPlayerUpdate.Add(CherokeeDoorRearLeft);
Events.OnPlayerUpdate.Add(CherokeeDoorRearRight);
Events.OnPlayerUpdate.Add(CherokeeWindowFrontLeft);
Events.OnPlayerUpdate.Add(CherokeeWindowFrontRight);
Events.OnPlayerUpdate.Add(CherokeeWindowMiddleLeft);
Events.OnPlayerUpdate.Add(CherokeeWindowMiddleRight);
Events.OnPlayerUpdate.Add(CherokeeWindowRearLeft);
Events.OnPlayerUpdate.Add(CherokeeWindowRearRight);