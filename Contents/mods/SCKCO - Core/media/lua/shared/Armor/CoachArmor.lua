---
--- Created by cytt0rak
---  WIP

function FireCoachWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Crown FireCoach" )) then


    local part = vehicle:getPartById("Windshield")

        if (vehicle:getPartById("FireCoachArmorWindshield"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("FireCoachArmorWindshield"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FireCoachArmorWindshield"):setCondition(vehicle:getPartById("FireCoachArmorWindshield"):getCondition()-1)

    end
        vehicle:transmitPartModData(Windshield)
    end


end

function FireCoachEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Crown FireCoach" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("EngineDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function FireCoachGasTank(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Crown FireCoach" )) then

        local part = vehicle:getPartById("GasTank")
        if (vehicle:getPartById("GasTank"):getCondition() < 70) and (vehicle:getPartById("GasTank"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(GasTank)
    end


end

function FireCoachLeftDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Crown FireCoach" )) then

local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("FireCoachFrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("FireCoachFrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FireCoachFrontLeftDoorArmor"):setCondition(vehicle:getPartById("FireCoachFrontLeftDoorArmor"):getCondition()-1)


        end
        vehicle:transmitPartModData(WindowFrontLeft)
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function FireCoachRightDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Crown FireCoach" )) then

local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("FireCoachFrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("FireCoachFrontRightDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FireCoachFrontRightDoorArmor"):setCondition(vehicle:getPartById("FireCoachFrontRightDoorArmor"):getCondition()-1)


        end
        vehicle:transmitPartModData(WindowFrontRight)
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function FireCoachLeftWindow(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Crown FireCoach" )) then


        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("FireCoachFrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("FireCoachFrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FireCoachFrontLeftDoorArmor"):setCondition(vehicle:getPartById("FireCoachFrontLeftDoorArmor"):getCondition()-1)



        end
        vehicle:transmitPartModData(WindowFrontLeft)
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function FireCoachRightWindow(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CrownFireCoach" )) then


        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("FireCoachFrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("FireCoachFrontRightDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FireCoachFrontRightDoorArmor"):setCondition(vehicle:getPartById("FireCoachFrontRightDoorArmor"):getCondition()-1)


        end
        vehicle:transmitPartModData(WindowFrontRight)
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function FireCoachRearRightWindow(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CrownFireCoach" )) then


        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("FireCoachRearRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("FireCoachRearRightWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FireCoachRearRightWindowArmor"):setCondition(vehicle:getPartById("FireCoachRearRightWindowArmor"):getCondition()-1)


        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function FireCoachRearLeftWindow(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CrownFireCoach" )) then


        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("FireCoachRearLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("FireCoachRearLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("FireCoachRearLeftWindowArmor"):setCondition(vehicle:getPartById("FireCoachRearLeftWindowArmor"):getCondition()-1)


        end
        vehicle:transmitPartModData(WindowRearLeft)
    end


end

Events.OnPlayerUpdate.Add(FireCoachWindshield);
Events.OnPlayerUpdate.Add(FireCoachGasTank);
Events.OnPlayerUpdate.Add(FireCoachEngineDoor);
Events.OnPlayerUpdate.Add(FireCoachLeftDoor);
Events.OnPlayerUpdate.Add(FireCoachRightDoor);
Events.OnPlayerUpdate.Add(FireCoachLeftWindow);
Events.OnPlayerUpdate.Add(FireCoachRightWindow);
Events.OnPlayerUpdate.Add(FireCoachRearRightWindow);
Events.OnPlayerUpdate.Add(FireCoachRearLeftWindow);
