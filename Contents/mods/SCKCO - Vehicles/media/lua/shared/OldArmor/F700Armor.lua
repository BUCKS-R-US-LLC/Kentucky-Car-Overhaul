
--- Created by cytt0rak

function F700ArmoredWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_FordF700ArmoredBank", "SC_FordF700ArmoredPolice")) then

        local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("Windshield"):getCondition() < 100) and (vehicle:getPartById("Windshield"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function F700ArmoredWindshieldRear(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_FordF700ArmoredBank", "SC_FordF700ArmoredPolice")) then

        local part = vehicle:getPartById("WindshieldRear")
        if (vehicle:getPartById("WindshieldRear"):getCondition() < 100) and (vehicle:getPartById("WindshieldRear"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindshieldRear)
    end


end

function F700ArmoredEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_FordF700ArmoredBank", "SC_FordF700ArmoredPolice")) then

        local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("EngineDoor"):getCondition() < 100) and (vehicle:getPartById("EngineDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function F700ArmoredDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_FordF700ArmoredBank", "SC_FordF700ArmoredPolice")) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("DoorFrontLeft"):getCondition() < 100) and (vehicle:getPartById("DoorFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function F700ArmoredDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_FordF700ArmoredBank", "SC_FordF700ArmoredPolice")) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("DoorFrontRight"):getCondition() < 100) and (vehicle:getPartById("DoorFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function F700ArmoredWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_FordF700ArmoredBank", "SC_FordF700ArmoredPolice")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("WindowFrontLeft"):getCondition() < 100) and (vehicle:getPartById("WindowFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function F700ArmoredWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_FordF700ArmoredBank", "SC_FordF700ArmoredPolice")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("WindowFrontRight"):getCondition() < 100) and (vehicle:getPartById("WindowFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

Events.OnPlayerUpdate.Add(F700ArmoredWindshield);
Events.OnPlayerUpdate.Add(F700ArmoredWindshieldRear);
Events.OnPlayerUpdate.Add(F700ArmoredEngineDoor);
Events.OnPlayerUpdate.Add(F700ArmoredDoorFrontLeft);
Events.OnPlayerUpdate.Add(F700ArmoredDoorFrontRight);
Events.OnPlayerUpdate.Add(F700ArmoredWindowFrontLeft);
Events.OnPlayerUpdate.Add(F700ArmoredWindowFrontRight);