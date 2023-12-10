---
--- Created by cytt0rak
---  WIP

function HMMWVWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1025", "SC_M998" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("Windshield"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 30 })

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function HMMWVEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1025", "SC_M998" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("EngineDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 30 })

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function HMMWVEngine(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1025", "SC_M998" )) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("Engine"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(Engine)
    end


end

function HMMWVWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1025" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("WindowFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 30 })

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function HMMWVWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "M1025" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("WindowFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 30 })

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function HMMWVWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1025" )) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("WindowRearRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 30 })

        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function HMMWVWindowRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1025" )) then

        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("WindowRearLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 30 })

        end
        vehicle:transmitPartModData(WindowRearLeft)
    end


end

Events.OnPlayerUpdate.Add(HMMWVWindshield);
Events.OnPlayerUpdate.Add(HMMWVEngineDoor);
Events.OnPlayerUpdate.Add(HMMWVDoorFrontLeft);
Events.OnPlayerUpdate.Add(HMMWVDoorFrontRight);
Events.OnPlayerUpdate.Add(HMMWVDoorRearLeft);
Events.OnPlayerUpdate.Add(HMMWVDoorRearRight);
Events.OnPlayerUpdate.Add(HMMWVWindowFrontLeft);
Events.OnPlayerUpdate.Add(HMMWVWindowFrontRight);
Events.OnPlayerUpdate.Add(HMMWVWindowRearLeft);
Events.OnPlayerUpdate.Add(HMMWVWindowRearRight);