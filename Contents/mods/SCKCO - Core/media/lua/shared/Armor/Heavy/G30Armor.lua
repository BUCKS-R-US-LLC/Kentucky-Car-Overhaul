---
--- Created by cytt0rak
---  WIP

function G30WindowlessWindshield(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Van" "VanRadio", "VanRadio_3N", "VanSpecial", "VanSpiffo", "Van_KnoxDisti", "Van_LectroMax", "Van_GenFac", "Van_Transit", "VanAmbulance" )) then

local part = vehicle:getPartById("Windshield")
        if (vehicle:getPartById("G30WindowlessWindshieldArmor"):getCondition() > 1) and (vehicle:getPartById("Windshield"):getCondition() < 70) and (vehicle:getPartById("G30WindowlessWindshieldArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("G30WindowlessWindshieldArmor"):setCondition(vehicle:getPartById("G30WindowlessWindshieldArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(Windshield)
    end


end


function G30WindowlessWindowFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Van" "VanRadio", "VanRadio_3N", "VanSpecial", "VanSpiffo", "Van_KnoxDisti", "Van_LectroMax", "Van_GenFac", "Van_Transit", "VanAmbulance" )) then

        local part = vehicle:getPartById("WindowFrontLeft")
        if (vehicle:getPartById("G30WindowlessFrontLeftWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontLeft"):getCondition() < 70) and (vehicle:getPartById("G30WindowlessFrontLeftWindowArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("G30WindowlessFrontLeftWindowArmor"):setCondition(vehicle:getPartById("G30WindowlessFrontLeftWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontLeft)
    end


end

function G30WindowlessWindowFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Van" "VanRadio", "VanRadio_3N", "VanSpecial", "VanSpiffo", "Van_KnoxDisti", "Van_LectroMax", "Van_GenFac", "Van_Transit", "VanAmbulance" )) then

        local part = vehicle:getPartById("WindowFrontRight")
        if (vehicle:getPartById("G30WindowlessFrontRightWindowArmor"):getCondition() > 1) and (vehicle:getPartById("WindowFrontRight"):getCondition() < 70) and (vehicle:getPartById("G30WindowlessFrontRightWindowArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("G30WindowlessFrontRightWindowArmor"):setCondition(vehicle:getPartById("G30WindowlessFrontRightWindowArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(WindowFrontRight)
    end


end


function G30WindowlessBullbar(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Van" "VanRadio", "VanRadio_3N", "VanSpecial", "VanSpiffo", "Van_KnoxDisti", "Van_LectroMax", "Van_GenFac", "Van_Transit", "VanAmbulance" )) then

local part = vehicle:getPartById("Engine")
        if (vehicle:getPartById("G30WindowlessBullbar"):getCondition() > 1) and (vehicle:getPartById("Engine"):getCondition() < 70) and (vehicle:getPartById("G30WindowlessBullbar"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("G30WindowlessBullbar"):setCondition(vehicle:getPartById("G30WindowlessBullbar"):getCondition()-1)

        end
        vehicle:transmitPartModData(Engine)
    end


end

function G30WindowlessDoorFrontLeft(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Van" "VanRadio", "VanRadio_3N", "VanSpecial", "VanSpiffo", "Van_KnoxDisti", "Van_LectroMax", "Van_GenFac", "Van_Transit", "VanAmbulance" )) then

        local part = vehicle:getPartById("DoorFrontLeft")
        if (vehicle:getPartById("G30WindowlessFrontLeftDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontLeft"):getCondition() < 70) and (vehicle:getPartById("G30WindowlessFrontLeftDoorArmor"):getInventoryItem()) then

            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("G30WindowlessFrontLeftDoorArmor"):setCondition(vehicle:getPartById("G30WindowlessFrontLeftDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontLeft)
    end


end

function G30WindowlessDoorFrontRight(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "Van" "VanRadio", "VanRadio_3N", "VanSpecial", "VanSpiffo", "Van_KnoxDisti", "Van_LectroMax", "Van_GenFac", "Van_Transit", "VanAmbulance" )) then

        local part = vehicle:getPartById("DoorFrontRight")
        if (vehicle:getPartById("G30WindowlessFrontRightDoorArmor"):getCondition() > 1) and (vehicle:getPartById("DoorFrontRight"):getCondition() < 70) and (vehicle:getPartById("G30WindowlessFrontRightDoorArmor"):getInventoryItem()) then


            sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition = 70 })
            vehicle:getPartById("G30WindowlessFrontRightDoorArmor"):setCondition(vehicle:getPartById("G30WindowlessFrontRightDoorArmor"):getCondition()-1)

        end
        vehicle:transmitPartModData(DoorFrontRight)
    end


end

Events.OnPlayerUpdate.Add(G30WindowlessWindshield);
Events.OnPlayerUpdate.Add(G30WindowlessBullbar);
Events.OnPlayerUpdate.Add(G30WindowlessDoorFrontLeft);
Events.OnPlayerUpdate.Add(G30WindowlessDoorFrontRight);
Events.OnPlayerUpdate.Add(G30WindowlessWindowFrontLeft);
Events.OnPlayerUpdate.Add(G30WindowlessWindowFrontRight);