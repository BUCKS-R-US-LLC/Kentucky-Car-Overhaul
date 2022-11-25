---
--- Created by cytt0rak
---  WIP

function F700PoliceWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("Windshield"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function F700PoliceEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("F700PoliceArmBodyBar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("F700PoliceArmBodyBar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function F700PoliceArmBodyBar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("F700PoliceArmBodyBar")
        if (vehicle:getPartById("F700PoliceArmBodyBar"):getCondition() < 70) and (vehicle:getPartById("F700PoliceArmBodyBar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(F700PoliceArmBodyBar)
    end


end

function F700PoliceGasTank(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("GasTank")
        if (vehicle:getPartById("GasTank"):getCondition() < 70) and (vehicle:getPartById("GasTank"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(GasTank)
    end


end

function F700PoliceDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("DoorFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function F700PoliceDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("DoorFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

function F700PoliceWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("WindowFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function F700PoliceWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("WindowFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function F700PoliceWindowRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("WindowRearLeft")
        if (vehicle:getPartById("WindowRearLeft"):getCondition() < 70) and (vehicle:getPartById("WindowRearLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindowRearLeft)
    end


end

function F700PoliceWindowRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("WindowRearRight")
        if (vehicle:getPartById("WindowRearRight"):getCondition() < 70) and (vehicle:getPartById("WindowRearRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindowRearRight)
    end


end

function F700PoliceWindshieldRear(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("WindshieldRear")
        if (vehicle:getPartById("WindshieldRear"):getCondition() < 70) and (vehicle:getPartById("WindshieldRear"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(WindshieldRear)
    end


end

function F700PoliceMuffler(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("Muffler")
        if (vehicle:getPartById("Muffler"):getCondition() < 70) and (vehicle:getPartById("Muffler"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(Muffler)
    end


end

function F700PoliceTrunkDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("TrunkDoor")
        if (vehicle:getPartById("TrunkDoor"):getCondition() < 70) and (vehicle:getPartById("TrunkDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(TrunkDoor)
    end


end

function F700PoliceTruckBed(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("TruckBed")
        if (vehicle:getPartById("TruckBed"):getCondition() < 70) and (vehicle:getPartById("TruckBed"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(TruckBed)
    end


end

function F700PoliceTireFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("TireFrontLeft")
        if (vehicle:getPartById("TireFrontLeft"):getCondition() < 50) and (vehicle:getPartById("TireFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireFrontLeft)
    end


end

function F700PoliceTireFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("TireFrontRight")
        if (vehicle:getPartById("TireFrontRight"):getCondition() < 50) and (vehicle:getPartById("TireFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireFrontRight)
    end


end

function F700PoliceTireRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("TireRearLeft")
        if (vehicle:getPartById("TireRearLeft"):getCondition() < 50) and (vehicle:getPartById("TireRearLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireRearLeft)
    end


end

function F700PoliceTireRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "F700Police" )) then

        local part = vehicle:getPartById("TireRearRight")
        if (vehicle:getPartById("TireRearRight"):getCondition() < 50) and (vehicle:getPartById("TireRearRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 51 })

        end
        vehicle:transmitPartModData(TireRearRight)
    end


end

Events.OnPlayerUpdate.Add(F700PoliceWindshield);
Events.OnPlayerUpdate.Add(F700PoliceWindshieldRear);
Events.OnPlayerUpdate.Add(F700PoliceGasTank);
Events.OnPlayerUpdate.Add(F700PoliceEngineDoor);
Events.OnPlayerUpdate.Add(F700PoliceDoorFrontLeft);
Events.OnPlayerUpdate.Add(F700PoliceDoorFrontRight);
Events.OnPlayerUpdate.Add(F700PoliceWindowFrontLeft);
Events.OnPlayerUpdate.Add(F700PoliceWindowFrontRight);
Events.OnPlayerUpdate.Add(F700PoliceWindowRearRight);
Events.OnPlayerUpdate.Add(F700PoliceWindowRearLeft);
Events.OnPlayerUpdate.Add(F700PoliceTruckBed);
Events.OnPlayerUpdate.Add(F700PoliceTrunkDoor);
Events.OnPlayerUpdate.Add(F700PoliceMuffler);
Events.OnPlayerUpdate.Add(F700PoliceArmBodyBar);
Events.OnPlayerUpdate.Add(F700PoliceTireFrontLeft);
Events.OnPlayerUpdate.Add(F700PoliceTireFrontRight);
Events.OnPlayerUpdate.Add(F700PoliceTireRearLeft);
Events.OnPlayerUpdate.Add(F700PoliceTireRearRight);