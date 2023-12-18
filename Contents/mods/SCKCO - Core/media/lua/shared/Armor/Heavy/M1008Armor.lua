---
--- Created by cytt0rak
---  WIP

function M1008Windshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1008", "SC_M1008TroopCarrier", "SC_M1028A3")) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("M1008WindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("M1008WindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1008WindshieldArmor"):setCondition(vehicle:getPartById("M1008WindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function M1008Bullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1008", "SC_M1008TroopCarrier", "SC_M1028A3")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("M1008Bullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("M1008Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1008Bullbar"):setCondition(vehicle:getPartById("M1008Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function M1008WindowFrontLeftArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1008", "SC_M1008TroopCarrier", "SC_M1028A3")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("M1008FrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("M1008FrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1008FrontLeftWindowArmor"):setCondition(vehicle:getPartById("M1008FrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function M1008WindowFrontRightArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1008", "SC_M1008TroopCarrier", "SC_M1028A3")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("M1008FrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("M1008FrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1008FrontRightWindowArmor"):setCondition(vehicle:getPartById("M1008FrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

Events.OnPlayerUpdate.Add(M1008WindshieldArmor);
Events.OnPlayerUpdate.Add(M1008Bullbar);
Events.OnPlayerUpdate.Add(M1008WindowFrontLeftArmor);
Events.OnPlayerUpdate.Add(M1008WindowFrontRightArmor);