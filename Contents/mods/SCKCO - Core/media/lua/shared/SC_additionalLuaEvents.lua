--- Created by cytt0rak & Chuck
local luaEvents =  {}

function luaEvents.M35A1CargoWeightFix(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "M35A1" )) then
        if vehicle:getMass() > 1470 then  vehicle:setMass(1469) end
    end
end
--- Events.OnPlayerUpdate.Add(luaEvents.M35A1CargoWeightFix)

luaEvents.vehiclesToArmor = {}

function luaEvents.processArmor(player)
    ---@type BaseVehicle
    local vehicle = player:getVehicle()
    if not vehicle then return end

    local vehicleScript = vehicle:getScript()
    local vehicleScriptName = vehicle:getScriptName()
    local storedArmors = luaEvents.vehiclesToArmor[vehicleScriptName]

    if not storedArmors then
        --store vehicleID for referencing later
        luaEvents.vehiclesToArmor[vehicleScriptName] = luaEvents.vehiclesToArmor[vehicleScriptName] or {}

        local partCount = vehicleScript:getPartCount()

        for i=0, partCount-1 do
            --local partScript = vehicleScript:getPart(i)
            local part = vehicle:getPartByIndex(i)
            local partID = part:getId()

            if string.find(partID, "SCArmor") then
                local parent = part:getParent()
                local parentID = parent:getId()

                if parent then
                    print(" part: ", partID, " = ", parentID)
                    luaEvents.vehiclesToArmor[vehicleScriptName][parentID] = partID
                end
            end
        end
    else
        for parentID,partID in pairs(luaEvents.vehiclesToArmor[vehicleScriptName]) do

            local parent = vehicle:getPartById(parentID)
            local part = vehicle:getPartById(partID)

            if (part:getCondition() > 1) and (parent:getCondition() < 70) and (part:getInventoryItem()) then
                sendClientCommand(player, "vehicle", "setPartCondition", { vehicle = vehicle:getId(), part = part:getId(), condition=70 })
                part:setCondition(part:getCondition()-1)
            end
        end
    end
end

Events.OnPlayerUpdate.Add(luaEvents.processArmor)

return luaEvents