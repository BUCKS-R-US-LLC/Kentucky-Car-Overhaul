---
--- Created by cytt0rak
---  WIP

function M1009Windshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1009", "SC_M1009MilitaryPolice")) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("M1009WindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("M1009WindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1009WindshieldArmor"):setCondition(vehicle:getPartById("M1009WindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end

function M1009Bullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1009", "SC_M1009MilitaryPolice")) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("M1009Bullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("M1009Bullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1009Bullbar"):setCondition(vehicle:getPartById("M1009Bullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function M1009WindowFrontLeftArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1009", "SC_M1009MilitaryPolice")) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("M1009FrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("M1009FrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1009FrontLeftWindowArmor"):setCondition(vehicle:getPartById("M1009FrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function M1009WindowFrontRightArmor(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_M1009", "SC_M1009MilitaryPolice")) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("M1009FrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("M1009FrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("M1009FrontRightWindowArmor"):setCondition(vehicle:getPartById("M1009FrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end

Events.OnPlayerUpdate.Add(M1009WindshieldArmor);
Events.OnPlayerUpdate.Add(M1009Bullbar);
Events.OnPlayerUpdate.Add(M1009WindowFrontLeftArmor);
Events.OnPlayerUpdate.Add(M1009WindowFrontRightArmor);