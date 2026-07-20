--- Created by cytt0rak & Chuck
local miscVehicleLua =  {}

function miscVehicleLua.M35A2CargoWeightFix(player, part, elapsedMinutes)
    local vehicle = player:getVehicle()
    if (vehicle and string.find( vehicle:getScriptName(), "SC_AMGeneralM35A2" )) then
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
    if vehicle then miscVehicleLua.processPartDamages(player, vehicle, true) end
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
function miscVehicleLua.processPartDamages(player, vehicle, onUpdate)
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

    local alreadyHaveVehicleData = miscVehicleLua.processVehicleHits[player]

    for _,armor in pairs(partsToCheck) do
        local parent = miscVehicleLua.getParentIfArmor(armor, vehicleArmor)
        if parent then

            -- key by armor, not parent: several plates may map to the same parent
            -- (Bumper/Grille both -> Engine). Keying by parent overwrote all but the last
            -- entry visited, so only one plate registered. armor is the unique identity.
            local prevData = onUpdate and alreadyHaveVehicleData and alreadyHaveVehicleData.parts and alreadyHaveVehicleData.parts[armor]
            local preHitCond = prevData and prevData.preHitCond or parent:getCondition()

            if armor and parent then
                miscVehicleLua.processVehicleHits[player] = miscVehicleLua.processVehicleHits[player] or { parts={}}
                miscVehicleLua.processVehicleHits[player].vehicle = vehicle

                if armor:getInventoryItem() and (armor:getCondition() > 1) then
                    miscVehicleLua.processVehicleHits[player].parts[armor] = { parent=parent, armor=armor, preHitCond=preHitCond}
                else
                    miscVehicleLua.processVehicleHits[player].parts[armor] = nil
                end
            end
        end
    end

end


-- fallback used when a plate's armorBehavior table omits damageThreshold, so metal
-- behaviour holds even if template table-merge drops the per-part value.
miscVehicleLua.defaultDamageThreshold = 5

function miscVehicleLua.armorAbsorb(part, damage)
    local armorBehavior = part:getTable("armorBehavior")
    if not armorBehavior then return damage end
    local threshold = armorBehavior.damageThreshold or miscVehicleLua.defaultDamageThreshold
    local absorptionRate = armorBehavior.damageAbsorptionOneTo or 1
    -- hits at or below the threshold do not wear the plate (zombie claws log as ~3
    -- condition); only the overmatch above it scales into plate wear.
    local effective = damage - threshold
    if effective <= 0 then return 0 end
    return effective * absorptionRate
end


function miscVehicleLua.applyDamageToArmor(player, weapon, playerVehicle)

    local data = miscVehicleLua.processVehicleHits[player]
    if not data then return end

    if (not weapon) and (playerVehicle and data.vehicle == playerVehicle and (not data.ticked)) then
        data.ticked = true
        return
    end

    -- parts is now keyed by armor part; parent and armor both live in subData.
    for _, subData in pairs(data.parts) do

        local preHitCond = subData.preHitCond
        local armor = subData.armor
        local parent = subData.parent
        local currentParentCond = parent and parent:getCondition()
        --local currentArmorCond
        local recordedDamage = preHitCond-currentParentCond

        if recordedDamage > 0 then

            local pCond = math.max(math.min(parent:getCondition()+recordedDamage, 100), 0)
            local damageToArmor = miscVehicleLua.armorAbsorb(armor, recordedDamage)

            local currentACond = parent==armor and preHitCond or armor:getCondition()
            local aCond = math.max(math.min(currentACond-damageToArmor, 100), 0)

            if getDebug() then
                print("---- parent: ", parent and parent.getId and parent:getId(), "=", armor and armor.getId and armor:getId(), ", recordedDamage:", recordedDamage, "  damageToArmor:", damageToArmor)
            end

            -- always restore the protected part; an intact plate keeps it pristine
            if parent~=armor then
                sendClientCommand("vehicle", "setPartCondition", { vehicle = data.vehicle:getId(), part = parent:getId(), condition=pCond })
                parent:setCondition(pCond)
            end

            -- only write the plate when it actually wears (armorAbsorb returns 0 below
            -- threshold); skips the constant network spam from minor hits
            if damageToArmor > 0 or parent==armor then
                sendClientCommand("vehicle", "setPartCondition", { vehicle = data.vehicle:getId(), part = armor:getId(), condition=aCond })
                armor:setCondition(aCond)
            end

            -- re-baseline so a second code path this frame cannot re-apply the same drop
            subData.preHitCond = pCond
        end
    end

    data.ticked = nil
    --miscVehicleLua.processVehicleHits[player] = nil
end


function miscVehicleLua.applyDamageToArmorOnUpdate(player)
    local vehicle = player:getVehicle()
    if vehicle then miscVehicleLua.applyDamageToArmor(player, nil, vehicle) end
end



-- Vehicle script part hooks resolve against the global SCKCO namespace, not this module
-- table, so guard-merge rather than assign. Surplus fleet spawns with the lighter socket
-- fitted but empty; the part stays installable so a scavenged CigaretteLighterSC retrofits.
SCKCO = SCKCO or {}
SCKCO.Create = SCKCO.Create or {}

---@param vehicle BaseVehicle
---@param part VehiclePart
function SCKCO.Create.LighterDelete(vehicle, part)
    part:setInventoryItem(nil)
end


return miscVehicleLua
