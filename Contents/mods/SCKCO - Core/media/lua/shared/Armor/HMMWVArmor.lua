---
--- Created by cytt0rak
---  WIP

function HMMWVWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("Windshield"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function HMMWVDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV" )) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("DoorFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function HMMWVWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("WindowFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function HMMWVWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("WindowFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function HMMWVWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV" )) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("WindowRearRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function HMMWVTireFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV" )) then

        local part = vehicle:getPartById("TireFrontLeft")
        if (vehicle:getPartById("TireFrontLeft"):getCondition() < 50) and (vehicle:getPartById("TireFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireFrontLeft)
    end


end

function HMMWVTireFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV" )) then

        local part = vehicle:getPartById("TireFrontRight")
        if (vehicle:getPartById("TireFrontRight"):getCondition() < 50) and (vehicle:getPartById("TireFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireFrontRight)
    end


end

function HMMWVTireRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV )) then

        local part = vehicle:getPartById("TireRearLeft")
        if (vehicle:getPartById("TireRearLeft"):getCondition() < 50) and (vehicle:getPartById("TireRearLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireRearLeft)
    end


end

function HMMWVTireRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "HMMWV )) then

        local part = vehicle:getPartById("TireRearRight")
        if (vehicle:getPartById("TireRearRight"):getCondition() < 50) and (vehicle:getPartById("TireRearRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireRearRight)
    end


end

Events.OnPlayerUpdate.Add(HMMWVWindshield);
Events.OnPlayerUpdate.Add(HMMWVWindshieldRear);
Events.OnPlayerUpdate.Add(HMMWVGasTank);
Events.OnPlayerUpdate.Add(HMMWVEngineDoor);
Events.OnPlayerUpdate.Add(HMMWVDoorFrontLeft);
Events.OnPlayerUpdate.Add(HMMWVDoorFrontRight);
Events.OnPlayerUpdate.Add(HMMWVWindowFrontLeft);
Events.OnPlayerUpdate.Add(HMMWVWindowFrontRight);
Events.OnPlayerUpdate.Add(HMMWVWindowMiddleLeft);
Events.OnPlayerUpdate.Add(HMMWVWindowMiddleRight);
Events.OnPlayerUpdate.Add(HMMWVWindowRearRight);
Events.OnPlayerUpdate.Add(HMMWVMuffler);
Events.OnPlayerUpdate.Add(HMMWVBullbar);
Events.OnPlayerUpdate.Add(HMMWVTireFrontLeft);
Events.OnPlayerUpdate.Add(HMMWVTireFrontRight);
Events.OnPlayerUpdate.Add(HMMWVTireRearLeft);
Events.OnPlayerUpdate.Add(HMMWVTireRearRight);