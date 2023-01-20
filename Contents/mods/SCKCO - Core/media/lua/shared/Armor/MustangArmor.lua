---
--- Created by cytt0rak
---  WIP

function MustangWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("FordMustangWindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("FordMustangWindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangWindshieldArmor"):setCondition(vehicle:getPartById("FordMustangWindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function MustangGasTank(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("GasTank")
        if (vehicle:getPartById("GasTank"):getCondition() < 70) and (vehicle:getPartById("GasTank"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(GasTank)
    end


end

function MustangWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("FordMustangFrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("FordMustangFrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangFrontLeftWindowArmor"):setCondition(vehicle:getPartById("FordMustangFrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function MustangWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("FordMustangFrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("FordMustangFrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangFrontRightWindowArmor"):setCondition(vehicle:getPartById("FordMustangFrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end


function MustangWindowRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("FordMustangRearLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("FordMustangRearLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangRearLeftWindowArmor"):setCondition(vehicle:getPartById("FordMustangRearLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function MustangWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("FordMustangRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("FordMustangRearRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangRearRightWindowArmor"):setCondition(vehicle:getPartById("FordMustangRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function MustangBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("FordMustangBullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("FordMustangBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FordMustangBullbar"):setCondition(vehicle:getPartById("FordMustangBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineWindow)
    end


end


function MustangDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("FordMustangFrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("FordMustangFrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangFrontLeftDoorArmor"):setCondition(vehicle:getPartById("FordMustangFrontLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end


function MustangDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("FordMustangFrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("FordMustangFrontRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangFrontRightDoorArmor"):setCondition(vehicle:getPartById("FordMustangFrontRightDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function MustangWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("FordMustangRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("FordMustangRearRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangRearRightWindowArmor"):setCondition(vehicle:getPartById("FordMustangRearRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function MustangWindowRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("FordMustangRearLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("FordMustangRearLeftWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("FordMustangRearLeftWindowArmor"):setCondition(vehicle:getPartById("FordMustangRearLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function MustangBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Mustang" )) then

        local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("FordMustangBullbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("FordMustangBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FordMustangBullbar"):setCondition(vehicle:getPartById("FordMustangBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end


Events.OnPlayerUpdate.Add(MustangWindshield);
Events.OnPlayerUpdate.Add(MustangGasTank);
Events.OnPlayerUpdate.Add(MustangBullbar);
Events.OnPlayerUpdate.Add(MustangDoorFrontLeft);
Events.OnPlayerUpdate.Add(MustangDoorFrontRight);
Events.OnPlayerUpdate.Add(MustangWindowFrontLeft);
Events.OnPlayerUpdate.Add(MustangWindowFrontRight);
Events.OnPlayerUpdate.Add(MustangWindowRearLeft);
Events.OnPlayerUpdate.Add(MustangWindowRearRight);