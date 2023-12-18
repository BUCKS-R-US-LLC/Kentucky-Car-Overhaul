---
--- Created by cytt0rak
---  WIP

function K5Windshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpVan")) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("K5WindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("K5WindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K5WindshieldArmor"):setCondition(vehicle:getPartById("K5WindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function K5Bullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpVan")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("K5Bullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("K5Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K5Bullbar"):setCondition(vehicle:getPartById("K5Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function K5WindowFrontLeftArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpVan")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("K5FrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("K5FrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K5FrontLeftWindowArmor"):setCondition(vehicle:getPartById("K5FrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function K5WindowFrontRightArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "PickUpVan")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("K5FrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("K5FrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("K5FrontRightWindowArmor"):setCondition(vehicle:getPartById("K5FrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

Events.OnPlayerUpdate.Add(K5WindshieldArmor);
Events.OnPlayerUpdate.Add(K5Bullbar);
Events.OnPlayerUpdate.Add(K5WindowFrontLeftArmor);
Events.OnPlayerUpdate.Add(K5WindowFrontRightArmor);