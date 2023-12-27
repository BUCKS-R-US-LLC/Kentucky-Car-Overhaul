---
--- Created by cytt0rak
---  WIP

function M35A1Windshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M35A1" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("M35A1WindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("M35A1WindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("M35A1WindshieldArmor"):setCondition(vehicle:getPartById("M35A1WindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function M35Engine(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M35A1")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("Engine"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50 })
            vehicle:getPartById("M35A1Bumper"):setCondition(vehicle:getPartById("M35A1Bumper"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function M35A1DoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M35A1" )) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("M35A1FrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("M35A1FrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("M35A1FrontLeftDoorArmor"):setCondition(vehicle:getPartById("M35A1FrontLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function M35A1DoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M35A1" )) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("M35A1FrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("M35A1FrontRightDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("M35A1FrontRightDoorArmor"):setCondition(vehicle:getPartById("M35A1FrontRightDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end


function M35A1WindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M35A1" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("M35A1FrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("M35A1FrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("M35A1FrontLeftWindowArmor"):setCondition(vehicle:getPartById("M35A1FrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function M35A1WindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M35A1" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("M35A1FrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("M35A1FrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("M35A1FrontRightWindowArmor"):setCondition(vehicle:getPartById("M35A1FrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function M35A1Bumper(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M35A1" )) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("M35A1Bumper"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("M35A1Bumper"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })
            vehicle:getPartById("M35A1Bumper"):setCondition(vehicle:getPartById("M35A1Bumper"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

Events.OnPlayerUpdate.Add(M35A1Windshield);
Events.OnPlayerUpdate.Add(M35A1DoorFrontLeft);
Events.OnPlayerUpdate.Add(M35A1DoorFrontRight);
Events.OnPlayerUpdate.Add(M35A1WindowFrontLeft);
Events.OnPlayerUpdate.Add(M35A1WindowFrontRight);
Events.OnPlayerUpdate.Add(M35A1Bumper);