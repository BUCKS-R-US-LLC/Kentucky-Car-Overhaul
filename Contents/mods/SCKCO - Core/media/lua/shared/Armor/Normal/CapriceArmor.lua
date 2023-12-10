---
--- Created by cytt0rak
---  WIP

function CapriceWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("CapriceWindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("CapriceWindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceWindshieldArmor"):setCondition(vehicle:getPartById("CapriceWindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function CapriceWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("CapriceFrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("CapriceFrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceFrontLeftWindowArmor"):setCondition(vehicle:getPartById("CapriceFrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CapriceWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("CapriceFrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("CapriceFrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceFrontRightWindowArmor"):setCondition(vehicle:getPartById("CapriceFrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function CapriceWindowRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("CapriceRearLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("CapriceRearLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceRearLeftWindowArmor"):setCondition(vehicle:getPartById("CapriceRearLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function CapriceWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("CapriceRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("CapriceRearRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceRearRightWindowArmor"):setCondition(vehicle:getPartById("CapriceRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function CapriceBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("CapriceBullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("CapriceBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("CapriceBullbar"):setCondition(vehicle:getPartById("CapriceBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineWindow)
    end


end

function CapriceDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("CapriceFrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("CapriceFrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceFrontLeftDoorArmor"):setCondition(vehicle:getPartById("CapriceFrontLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function CapriceDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("CapriceFrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("CapriceFrontRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceFrontRightDoorArmor"):setCondition(vehicle:getPartById("CapriceFrontRightDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function CapriceDoorRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("DoorRearLeft")
        if (vehicle:getPartById("CapriceRearLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorRearLeft"):getCondition() < 70) and (vehicle:getPartById("CapriceRearLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceRearLeftDoorArmor"):setCondition(vehicle:getPartById("CapriceRearLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorRearLeft)
    end


end

function CapriceDoorRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("DoorRearRight")
        if (vehicle:getPartById("CapriceRearRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorRearRight"):getCondition() < 70) and (vehicle:getPartById("CapriceRearRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceRearRightDoorArmor"):setCondition(vehicle:getPartById("CapriceRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorRearRight)
    end


end

function CapriceWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("CapriceRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("CapriceRearRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("CapriceRearRightWindowArmor"):setCondition(vehicle:getPartById("CapriceRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function CapriceBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_Caprice")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("CapriceBullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("CapriceBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("CapriceBullbar"):setCondition(vehicle:getPartById("CapriceBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

Events.OnPlayerUpdate.Add(CapriceWindshield);
Events.OnPlayerUpdate.Add(CapriceBullbar);
Events.OnPlayerUpdate.Add(CapriceDoorFrontLeft);
Events.OnPlayerUpdate.Add(CapriceDoorFrontRight);
Events.OnPlayerUpdate.Add(CapriceDoorRearLeft);
Events.OnPlayerUpdate.Add(CapriceDoorRearRight);
Events.OnPlayerUpdate.Add(CapriceWindowFrontLeft);
Events.OnPlayerUpdate.Add(CapriceWindowFrontRight);
Events.OnPlayerUpdate.Add(CapriceWindowRearLeft);
Events.OnPlayerUpdate.Add(CapriceWindowRearRight);