
--- Created by cytt0rak

function RangerWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("Windshield"):getCondition() < 100) and (vehicle:getPartById("Windshield"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function RangerWindshieldRear(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("WindshieldRear")
        if (vehicle:getPartById("WindshieldRear"):getCondition() < 100) and (vehicle:getPartById("WindshieldRear"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindshieldRear)
    end


end

function RangerEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("EngineDoor"):getCondition() < 100) and (vehicle:getPartById("EngineDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function RangerDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("DoorFrontLeft"):getCondition() < 100) and (vehicle:getPartById("DoorFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function RangerDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("DoorFrontRight"):getCondition() < 100) and (vehicle:getPartById("DoorFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function RangerWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("WindowFrontLeft"):getCondition() < 100) and (vehicle:getPartById("WindowFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function RangerWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("WindowFrontRight"):getCondition() < 100) and (vehicle:getPartById("WindowFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

Events.OnPlayerUpdate.Add(RangerWindshield);
Events.OnPlayerUpdate.Add(RangerWindshieldRear);
Events.OnPlayerUpdate.Add(RangerEngineDoor);
Events.OnPlayerUpdate.Add(RangerDoorFrontLeft);
Events.OnPlayerUpdate.Add(RangerDoorFrontRight);
Events.OnPlayerUpdate.Add(RangerWindowFrontLeft);
Events.OnPlayerUpdate.Add(RangerWindowFrontRight);