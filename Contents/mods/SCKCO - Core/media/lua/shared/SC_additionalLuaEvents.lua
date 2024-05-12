--- Created by cytt0rak & Chuck
local luaEvents =  {}

function luaEvents.M35A1CargoWeightFix(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "M35A1" )) then
        if vehicle:getMass() > 1470 then  vehicle:setMass(1469) end
    end
end
--- Events.OnPlayerUpdate.Add(luaEvents.M35A1CargoWeightFix)


---@param owner IsoGameCharacter|IsoPlayer|IsoMovingObject
---@param weapon HandWeapon|InventoryItem
function luaEvents.getHitVehicles(owner, weapon)
    if weapon and weapon:getType() ~= "BareHands" then

        local range = (weapon:getMaxRange() * weapon:getRangeMod(owner)) + 0.5
        local ownerForwardDir = owner:getForwardDirection()
        local ownerX, ownerY = owner:getX(), owner:getY()
        local attackX, attackY = ownerForwardDir:getX(), ownerForwardDir:getY()

        for i=1, 10, 1 do
            local iDiv = i/10
            ---@type IsoGridSquare
            local attackSquare = getSquare(ownerX+attackX*range*iDiv, ownerY+attackY*range*iDiv, owner:getZ())
            if attackSquare then

                local vehicle = attackSquare:getVehicleContainer()
                if vehicle then return vehicle end
            end
        end
    end
end


function luaEvents.processOnWeaponSwingHitPoint(player, weapon)
    ---@type BaseVehicle
    local vehicle = luaEvents.getHitVehicles(player, weapon)
    if vehicle then luaEvents.processPartDamages(player, vehicle) end
end
Events.OnWeaponSwingHitPoint.Add(luaEvents.processOnWeaponSwingHitPoint)

function luaEvents.processOnPlayerUpdate(player)
    ---@type BaseVehicle
    local vehicle = player:getVehicle()
    if vehicle then luaEvents.processPartDamages(player, vehicle) end
end
Events.OnPlayerUpdate.Add(luaEvents.processOnWeaponSwingHitPoint)


luaEvents.processVehicleHits = {}


---@param player IsoGameCharacter|IsoPlayer|IsoMovingObject
---@param vehicle BaseVehicle
function luaEvents.getNearestPart(vehicle, player)
    if not vehicle or not player then return end
    for i=vehicle:getPartCount()-1, 0, -1 do
        ---@type VehiclePart
        local part = vehicle:getPartByIndex(i)
        if part and vehicle:isInArea(part:getArea(), player) and part:getCondition() > 0 then
            return part
        end
    end

end


luaEvents.vehicleArmorDictionary = {}
---@param player IsoGameCharacter|IsoPlayer|IsoMovingObject
---@param vehicle BaseVehicle
function luaEvents.processPartDamages(player, vehicle)
    if not vehicle then return end

    --print("vehicle: ", vehicle)

    local vehicleScript = vehicle:getScript()
    local vehicleScriptName = vehicle:getScriptName()
    local dict = luaEvents.vehicleArmorDictionary
    local vehicleArmor = dict[vehicleScriptName]

    if not vehicleArmor then
        dict[vehicleScriptName] = dict[vehicleScriptName] or {}

        local partCount = vehicleScript:getPartCount()

        for i=0, partCount-1 do
            local part = vehicle:getPartByIndex(i)
            local partID = part:getId()

            if string.find(partID, "SCArmor") then
                local parent = part:getParent()
                local parentID = parent and parent:getId()

                if parent then dict[vehicleScriptName][parentID] = partID end
            end
        end
    else

        local nearestPart = luaEvents.getNearestPart(vehicle, player)

        --print("nearestPart: ", (nearestPart and nearestPart:getId()))

        local armorID = nearestPart and dict[vehicleScriptName][nearestPart:getId()]
        if not armorID then return end

        local preHitCond = nearestPart and nearestPart:getCondition()
        local armor = vehicle:getPartById(armorID)

        if armor and nearestPart and (armor:getCondition() > 1) and (armor:getInventoryItem()) then
            luaEvents.processVehicleHits[player] = {vehicle=vehicle, armor=armor, parent=nearestPart, preHitCond=preHitCond}
        end

    end
end


function luaEvents.applyDamageToArmor(player)

    local data = luaEvents.processVehicleHits[player]
    if not data then return end

    ---@type VehiclePart
    local parent = data.parent
    local preHitCond = data.preHitCond
    local armor = data.armor

    local currentParentCond = parent and parent:getCondition()

    local recordedDamage = preHitCond-currentParentCond

    --print("-- armor: ", parent:getId(), " - recordedDamage: ", recordedDamage)

    if recordedDamage > 0 then

        local pCond = math.max(math.min(parent:getCondition()+recordedDamage, 100), 0)
        local aCond = math.max(math.min(armor:getCondition()-recordedDamage, 100), 0)

        sendClientCommand("vehicle", "setPartCondition", { vehicle = data.vehicle:getId(), part = parent:getId(), condition=pCond })
        sendClientCommand("vehicle", "setPartCondition", { vehicle = data.vehicle:getId(), part = armor:getId(), condition=aCond })

        parent:setCondition(pCond)
        armor:setCondition(aCond)
    end

    luaEvents.processVehicleHits[player] = nil
end
Events.OnPlayerAttackFinished.Add(luaEvents.applyDamageToArmor)


function luaEvents.applyDamageToArmorOnUpdate(player)
    local vehicle = player:getVehicle()
    if vehicle then luaEvents.applyDamageToArmor(player) end
end

Events.OnPlayerUpdate.Add(luaEvents.applyDamageToArmorOnUpdate)


return luaEvents