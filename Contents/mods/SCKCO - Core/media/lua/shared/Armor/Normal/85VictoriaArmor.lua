---
--- Created by cytt0rak
---  WIP

function CrownVictoriaWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("CrownVictoriaWindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaWindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaWindshieldArmor"):setCondition(vehicle:getPartById("CrownVictoriaWindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function CrownVictoriaWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("CrownVictoriaFrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaFrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaFrontLeftWindowArmor"):setCondition(vehicle:getPartById("CrownVictoriaFrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CrownVictoriaWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("CrownVictoriaFrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaFrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaFrontRightWindowArmor"):setCondition(vehicle:getPartById("CrownVictoriaFrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function CrownVictoriaWindowRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("CrownVictoriaRearLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaRearLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaRearLeftWindowArmor"):setCondition(vehicle:getPartById("CrownVictoriaRearLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CrownVictoriaWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):setCondition(vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function CrownVictoriaBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("CrownVictoriaBullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("CrownVictoriaBullbar"):setCondition(vehicle:getPartById("CrownVictoriaBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function CrownVictoriaDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("CrownVictoriaFrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaFrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaFrontLeftDoorArmor"):setCondition(vehicle:getPartById("CrownVictoriaFrontLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function CrownVictoriaDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("CrownVictoriaFrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaFrontRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaFrontRightDoorArmor"):setCondition(vehicle:getPartById("CrownVictoriaFrontRightDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function CrownVictoriaDoorRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("DoorRearLeft")
        if (vehicle:getPartById("CrownVictoriaRearLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorRearLeft"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaRearLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaRearLeftDoorArmor"):setCondition(vehicle:getPartById("CrownVictoriaRearLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorRearLeft)
    end


end

function CrownVictoriaDoorRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("DoorRearRight")
        if (vehicle:getPartById("CrownVictoriaRearRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorRearRight"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaRearRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaRearRightDoorArmor"):setCondition(vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorRearRight)
    end


end

function CrownVictoriaWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):setCondition(vehicle:getPartById("CrownVictoriaRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function CrownVictoriaBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "CarNormal", "CarLights", "CarLightsPolice", "SC_CrownVictoria")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("CrownVictoriaBullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("CrownVictoriaBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("CrownVictoriaBullbar"):setCondition(vehicle:getPartById("CrownVictoriaBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

Events.OnPlayerUpdate.Add(CrownVictoriaWindshield);
Events.OnPlayerUpdate.Add(CrownVictoriaBullbar);
Events.OnPlayerUpdate.Add(CrownVictoriaDoorFrontLeft);
Events.OnPlayerUpdate.Add(CrownVictoriaDoorFrontRight);
Events.OnPlayerUpdate.Add(CrownVictoriaDoorRearLeft);
Events.OnPlayerUpdate.Add(CrownVictoriaDoorRearRight);
Events.OnPlayerUpdate.Add(CrownVictoriaWindowFrontLeft);
Events.OnPlayerUpdate.Add(CrownVictoriaWindowFrontRight);
Events.OnPlayerUpdate.Add(CrownVictoriaWindowRearLeft);
Events.OnPlayerUpdate.Add(CrownVictoriaWindowRearRight);