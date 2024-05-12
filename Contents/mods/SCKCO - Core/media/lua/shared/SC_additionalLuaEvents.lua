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


function luaEvents.recursivePartChild(part)
    if part:getChildCount() > 0 then

        for i=part:getChildCount()-1, 0, -1 do
            local child = part:getChild(i)
            if child and child:getCondition() > 0 then
                --print("   ------ child: ", child:getId(), " : ", child:getChildCount())
                return luaEvents.recursivePartChild(child)
            end
        end
    end
    --print(" --- part: ", part:getId(), " : ", part:getChildCount())
    return part
end

---@param player IsoGameCharacter|IsoPlayer|IsoMovingObject
---@param vehicle BaseVehicle
function luaEvents.getNearestPart(vehicle, player)
    if not vehicle or not player then return end
    for i=vehicle:getPartCount()-1, 0, -1 do
        ---@type VehiclePart
        local part = vehicle:getPartByIndex(i)

        if part and (part:getCategory()=="door" or part:getCategory()=="bodywork") and vehicle:isInArea(part:getArea(), player) and part:getCondition() > 0 then
            --print(" - part: ", part:getId(), " : ", part:getChildCount())
            local truePart = luaEvents.recursivePartChild(part)
            return truePart
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

                if parent then dict[vehicleScriptName][partID] = parentID end
            end
        end
    else

        local nearestPart = luaEvents.getNearestPart(vehicle, player)
        local nearestID = nearestPart and nearestPart:getId()

        local armorID = nearestID and dict[vehicleScriptName][nearestID] and nearestID
        if not armorID then return end
        local armor = nearestPart

        local parent = armor:getParent()
        local preHitCond = parent and parent:getCondition()

        if armor and parent and (armor:getCondition() > 1) and (armor:getInventoryItem()) then
            luaEvents.processVehicleHits[player] = {vehicle=vehicle, armor=armor, parent=parent, preHitCond=preHitCond}
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