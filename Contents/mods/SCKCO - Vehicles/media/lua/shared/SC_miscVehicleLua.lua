--- Created by cytt0rak & Chuck
local miscVehicleLua =  {}

function miscVehicleLua.M35A1CargoWeightFix(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "M35A1" )) then
        if vehicle:getMass() > 1470 then  vehicle:setMass(1469) end
    end
end


---@param owner IsoGameCharacter|IsoPlayer|IsoMovingObject
---@param weapon HandWeapon|InventoryItem
function miscVehicleLua.getHitVehicles(owner, weapon)
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


function miscVehicleLua.processOnWeaponSwingHitPoint(player, weapon)
    ---@type BaseVehicle
    local vehicle = miscVehicleLua.getHitVehicles(player, weapon)
    if vehicle then miscVehicleLua.processPartDamages(player, vehicle) end
end


function miscVehicleLua.processOnPlayerUpdate(player)

    local data = miscVehicleLua.processVehicleHits[player]
    if data and data.ticked then return end

    ---@type BaseVehicle
    local vehicle = player:getVehicle()
    if vehicle then miscVehicleLua.processPartDamages(player, vehicle) end
end


miscVehicleLua.processVehicleHits = {}


function miscVehicleLua.recursivePartChild(part)
    if part:getChildCount() > 0 then

        for i=part:getChildCount()-1, 0, -1 do
            local child = part:getChild(i)
            if child and child:getCondition() > 0 then
                --print("   ------ child: ", child:getId(), " : ", child:getChildCount())
                return miscVehicleLua.recursivePartChild(child)
            end
        end
    end
    --print(" --- part: ", part:getId(), " : ", part:getChildCount())
    return part
end

---@param player IsoGameCharacter|IsoPlayer|IsoMovingObject
---@param vehicle BaseVehicle
function miscVehicleLua.getNearestPart(vehicle, player)
    if not vehicle or not player then return end
    for i=vehicle:getPartCount()-1, 0, -1 do
        ---@type VehiclePart
        local part = vehicle:getPartByIndex(i)

        if part and (part:getCategory()=="door" or part:getCategory()=="bodywork") and vehicle:isInArea(part:getArea(), player) and part:getCondition() > 0 then
            --print(" - part: ", part:getId(), " : ", part:getChildCount())
            local truePart = miscVehicleLua.recursivePartChild(part)
            return truePart
        end
    end

end


function miscVehicleLua.getParentIfArmor(part, vehicleArmor)
    local partID = part and part:getId()
    local armorID = partID and vehicleArmor[partID] and partID
    if not armorID then return end
    local armor = part
    local parent = armor:getParent()
    return parent
end

miscVehicleLua.vehicleArmorDictionary = {}
---@param player IsoGameCharacter|IsoPlayer|IsoMovingObject
---@param vehicle BaseVehicle
function miscVehicleLua.processPartDamages(player, vehicle)
    if not vehicle then return end

    local vehicleScript = vehicle:getScript()
    local vehicleScriptName = vehicle:getScriptName()
    local dict = miscVehicleLua.vehicleArmorDictionary
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

            elseif part:getTable("armorBehavior") then
                dict[vehicleScriptName][partID] = partID
            end
        end

        vehicleArmor = dict[vehicleScriptName]
    end

    local partsToCheck = {}

    if not player:getVehicle() then partsToCheck = { miscVehicleLua.getNearestPart(vehicle, player)} end

    if player:getVehicle() then
        for armorID, parentID in pairs(vehicleArmor) do
            local armor = vehicle:getPartById(armorID)
            if armor then table.insert(partsToCheck, armor) end
        end
    end

    local alreadyHaveVehicleData = miscVehicleLua.processVehicleHits[player] and miscVehicleLua.processVehicleHits[player].vehicle
    if alreadyHaveVehicleData and alreadyHaveVehicleData ~= vehicle then miscVehicleLua.processVehicleHits[player] = nil end

    for _,armor in pairs(partsToCheck) do
        local parent = armor:getTable("armorBehavior") and armor or miscVehicleLua.getParentIfArmor(armor, vehicleArmor)
        if parent then
            local preHitCond = parent and parent:getCondition()

            if armor and parent and (armor:getCondition() > 1) and armor:getInventoryItem() then
                miscVehicleLua.processVehicleHits[player] = miscVehicleLua.processVehicleHits[player] or { parts={}}
                miscVehicleLua.processVehicleHits[player].vehicle = vehicle
                miscVehicleLua.processVehicleHits[player].parts[parent] = { armor=armor, preHitCond=preHitCond}
            end
        end
    end

end


function miscVehicleLua.armorAbsorb(part, damage)
    local armorBehavior = part:getTable("armorBehavior")
    if not armorBehavior then return damage end
    local absorptionRate = armorBehavior.damageAbsorptionOneTo or 1
    return damage * absorptionRate
end


function miscVehicleLua.applyDamageToArmor(player)

    local data = miscVehicleLua.processVehicleHits[player]
    if not data then return end

    local playerVehicle = player:getVehicle()
    if playerVehicle and (not data.ticked) then
        data.ticked = true
        return
    end

    for parent, subData in pairs(data.parts) do

        local preHitCond = subData.preHitCond
        local armor = subData.armor
        local currentParentCond = parent and parent:getCondition()
        local recordedDamage = preHitCond-currentParentCond
        if recordedDamage > 0 then

            local pCond = math.max(math.min(parent:getCondition()+recordedDamage, 100), 0)
            local damageToArmor = miscVehicleLua.armorAbsorb(armor, recordedDamage)

            local currentACond = parent==armor and preHitCond or armor:getCondition()
            local aCond = math.max(math.min(currentACond-damageToArmor, 100), 0)

            if getDebug() then
                print("---- parent: ", parent and parent.getId and parent:getId(), "=", armor and armor.getId and armor:getId(), ", recordedDamage:", recordedDamage, "  damageToArmor:", damageToArmor)
            end

            if parent~=armor then
                sendClientCommand("vehicle", "setPartCondition", { vehicle = data.vehicle:getId(), part = parent:getId(), condition=pCond })
            end
            sendClientCommand("vehicle", "setPartCondition", { vehicle = data.vehicle:getId(), part = armor:getId(), condition=aCond })

            if parent~=armor then parent:setCondition(pCond) end
            armor:setCondition(aCond)
        end
    end
    data.ticked = false
    miscVehicleLua.processVehicleHits[player] = nil
end


function miscVehicleLua.applyDamageToArmorOnUpdate(player)
    local vehicle = player:getVehicle()
    if vehicle then miscVehicleLua.applyDamageToArmor(player) end
end


return miscVehicleLua