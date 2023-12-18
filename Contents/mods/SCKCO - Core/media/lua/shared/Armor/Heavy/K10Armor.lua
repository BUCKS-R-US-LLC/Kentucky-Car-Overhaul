---
--- Created by cytt0rak
---  WIP

function K10Windshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpTruck")) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("K10WindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("K10WindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K10WindshieldArmor"):setCondition(vehicle:getPartById("K10WindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function K10Bullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpTruck")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("K10Bullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("K10Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K10Bullbar"):setCondition(vehicle:getPartById("K10Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function K10WindowFrontLeftArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpTruck")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("K10FrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("K10FrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K10FrontLeftWindowArmor"):setCondition(vehicle:getPartById("K10FrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function K10WindowFrontRightArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpTruck")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("K10FrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("K10FrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K10FrontRightWindowArmor"):setCondition(vehicle:getPartById("K10FrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

Events.OnPlayerUpdate.Add(K10WindshieldArmor);
Events.OnPlayerUpdate.Add(K10Bullbar);
Events.OnPlayerUpdate.Add(K10WindowFrontLeftArmor);
Events.OnPlayerUpdate.Add(K10WindowFrontRightArmor);