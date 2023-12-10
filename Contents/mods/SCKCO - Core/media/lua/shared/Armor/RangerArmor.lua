---
--- Created by cytt0rak
---  WIP

function RangerWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("Windshield"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function RangerEngine(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("Engine"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(Engine)
    end


end

function RangerEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("EngineDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function RangerPushbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("RangerPushbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 100) and (vehicle:getPartById("RangerPushbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100})
            vehicle:getPartById("RangerPushbar"):setCondition(vehicle:getPartById("RangerPushbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function RangerDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("DoorFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function RangerWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("WindowFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function RangerWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("WindowFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

function RangerWindshieldRear(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

        local part = vehicle:getPartById("WindshieldRear")
        if (vehicle:getPartById("WindshieldRear"):getCondition() < 70) and (vehicle:getPartById("WindshieldRear"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(WindshieldRear)
    end


end

function RangerEngineDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("EngineDoor"):getCondition() < 70) and (vehicle:getPartById("EngineDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end

function RangerMuffler(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights" )) then

        local part = vehicle:getPartById("Muffler")
        if (vehicle:getPartById("Muffler"):getCondition() < 70) and (vehicle:getPartById("Muffler"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })

        end
        vehicle:transmitPartModData(Muffler)
    end


end

function RangerTireFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights" )) then

        local part = vehicle:getPartById("TireFrontLeft")
        if (vehicle:getPartById("TireFrontLeft"):getCondition() < 50) and (vehicle:getPartById("TireFrontLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50 })

        end
        vehicle:transmitPartModData(TireFrontLeft)
    end


end

function RangerTireFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights" )) then

        local part = vehicle:getPartById("TireFrontRight")
        if (vehicle:getPartById("TireFrontRight"):getCondition() < 50) and (vehicle:getPartById("TireFrontRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50 })

        end
        vehicle:transmitPartModData(TireFrontRight)
    end


end

function RangerTireRearLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights" )) then

        local part = vehicle:getPartById("TireRearLeft")
        if (vehicle:getPartById("TireRearLeft"):getCondition() < 50) and (vehicle:getPartById("TireRearLeft"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50 })

        end
        vehicle:transmitPartModData(TireRearLeft)
    end


end

function RangerTireRearRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights" )) then

        local part = vehicle:getPartById("TireRearRight")
        if (vehicle:getPartById("TireRearRight"):getCondition() < 50) and (vehicle:getPartById("TireRearRight"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 50 })

        end
        vehicle:transmitPartModData(TireRearRight)
    end


end

function RangerTruckBed(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights" )) then

        local part = vehicle:getPartById("TruckBed")
        if (vehicle:getPartById("TruckBed"):getCondition() < 50) and (vehicle:getPartById("TruckBed"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(TruckBed)
    end


end

function RangerTrunkDoor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights" )) then

        local part = vehicle:getPartById("TrunkDoor")
        if (vehicle:getPartById("TrunkDoor"):getCondition() < 50) and (vehicle:getPartById("TrunkDoor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100 })

        end
        vehicle:transmitPartModData(TrunkDoor)
    end


end

function RangerPushbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_CadillacGageRanger", "SC_CadillacGageRangerLights")) then

local part = vehicle:getPartById("EngineDoor")
        if (vehicle:getPartById("RangerPushbar"):getCondition() > 1) and (vehicle:getPartById("EngineDoor"):getCondition() < 100) and (vehicle:getPartById("RangerPushbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 100})
            vehicle:getPartById("RangerPushbar"):setCondition(vehicle:getPartById("RangerPushbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(EngineDoor)
    end


end


Events.OnPlayerUpdate.Add(RangerWindshield);
Events.OnPlayerUpdate.Add(RangerWindshieldRear);
Events.OnPlayerUpdate.Add(RangerGasTank);
Events.OnPlayerUpdate.Add(RangerEngine);
Events.OnPlayerUpdate.Add(RangerEngineDoor);
Events.OnPlayerUpdate.Add(RangerPushbar);
Events.OnPlayerUpdate.Add(RangerDoorFrontLeft);
Events.OnPlayerUpdate.Add(RangerDoorFrontRight);
Events.OnPlayerUpdate.Add(RangerWindowFrontLeft);
Events.OnPlayerUpdate.Add(RangerWindowFrontRight);
Events.OnPlayerUpdate.Add(RangerMuffler);
Events.OnPlayerUpdate.Add(RangerTireFrontLeft);
Events.OnPlayerUpdate.Add(RangerTireFrontRight);
Events.OnPlayerUpdate.Add(RangerTireRearLeft);
Events.OnPlayerUpdate.Add(RangerTireRearRight);
Events.OnPlayerUpdate.Add(RangerTruckBed);
Events.OnPlayerUpdate.Add(RangerTrunkDoor);