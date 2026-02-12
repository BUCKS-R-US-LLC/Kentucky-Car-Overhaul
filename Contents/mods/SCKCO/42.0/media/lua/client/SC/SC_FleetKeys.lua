print("SC_FleetKeys loading")

-- ========================================
-- CONFIGURATION
-- ========================================

local FLEET_CONFIG = {
    -- '85 Crown Victoria State Police (KeyId: 88888801)
    ["Base.SC_FordCrownVictoria85_StatePolice"] = 88888801,
    -- '85 Crown Victoria Louisville PD (KeyId: 88888802)
    ["Base.SC_FordCrownVictoria85_LouisvillePD"] = 88888802,
    -- '85 Crown Victoria Louisville PD (KeyId: 88888803)
    ["Base.SC_FordCrownVictoria85_ParkRanger"] = 88888803,

    -- '92 Crown Victoria State Police (KeyId: 88888804)
    ["Base.SC_FordCrownVictoria92_StatePolice"] = 88888804,
    -- '92 Crown Victoria Louisville PD (KeyId: 88888805)
    ["Base.SC_FordCrownVictoria92_LouisvillePD"] = 88888805,
    -- '92 Crown Victoria Jefferson PD (KeyId: 88888806)
    ["Base.SC_FordCrownVictoria92_JeffersonPD"] = 88888806,
    -- '92 Crown Victoria Jefferson Sheriff (KeyId: 88888807)
    ["Base.SC_FordCrownVictoria92_JeffersonSheriff"] = 88888807,
    -- '92 Crown Victoria Meade Sheriff (KeyId: 88888808)
    ["Base.SC_FordCrownVictoria92_MeadeSheriff"] = 88888808,
    -- '92 Crown Victoria Muhlen Sheriff (KeyId: 88888809)
    ["Base.SC_FordCrownVictoria92_MuhlenSheriff"] = 88888809,
    -- '92 Crown Victoria Warren Sheriff (KeyId: 88888810)
    ["Base.SC_FordCrownVictoria92_WarrenSheriff"] = 88888810,
    -- '92 Crown Victoria Bullitt Sheriff (KeyId: 88888811)
    ["Base.SC_FordCrownVictoria92_BullittSheriff"] = 88888811,
    -- '92 Crown Victoria Brandenburg PD (KeyId: 88888812)
    ["Base.SC_FordCrownVictoria92_BrandenburgPD"] = 88888812,

    -- '85 Crown Victoria Taxi Fleet (KeyId: 88888803)
    ["Base.SC_FordCrownVictoria85_Taxi"] = 88888813,
    
    -- CUCV Fleet (KeyId: 88888814)
    ["Base.SC_ChevroletM1008_3Tone"] = 88888814,
    ["Base.SC_ChevroletM1008_OD"] = 88888814,
    ["Base.SC_ChevroletM1008_DesertMERDC"] = 88888814,
    ["Base.SC_ChevroletM1008TroopCarrier_3Tone"] = 88888814,
    ["Base.SC_ChevroletM1008TroopCarrier_OD"] = 88888814,
    ["Base.SC_ChevroletM1008TroopCarrier_DesertMERDC"] = 88888814,
    ["Base.SC_ChevroletM1009_3Tone"] = 88888814,
    ["Base.SC_ChevroletM1009_OD"] = 88888814,
    ["Base.SC_ChevroletM1009_DesertMERDC"] = 88888814,
    ["Base.SC_ChevroletM1028A3_3Tone"] = 88888814,
    ["Base.SC_ChevroletM1028A3_OD"] = 88888814,
    ["Base.SC_ChevroletM1028A3_DesertMERDC"] = 88888814,
    ["Base.SC_ChevroletM1010Ambulance_3Tone"] = 88888814,
    ["Base.SC_ChevroletM1010Ambulance_OD"] = 88888814,
    ["Base.SC_ChevroletM1010Ambulance_DesertMERDC"] = 88888814,
}

local FLEET_KEYS = {
    [88888801] = "SCKCO.85CrownVicStatePoliceFleetKey",
    [88888802] = "SCKCO.85CrownVicLouisvillePDFleetKey",
    [88888803] = "SCKCO.85CrownVicParkRangerFleetKey",
    [88888804] = "SCKCO.92CrownVicStatePoliceFleetKey",
    [88888805] = "SCKCO.92CrownVicLouisvillePDFleetKey",
    [88888806] = "SCKCO.92CrownVicJeffersonPDFleetKey",
    [88888807] = "SCKCO.92CrownVicJeffersonSheriffFleetKey",
    [88888808] = "SCKCO.92CrownVicMeadeSheriffFleetKey",
    [88888809] = "SCKCO.92CrownVicMuhlenSheriffFleetKey",
    [88888810] = "SCKCO.92CrownVicWarrenSheriffFleetKey",
    [88888811] = "SCKCO.92CrownVicBullittSheriffFleetKey",
    [88888812] = "SCKCO.92CrownVicBrandenburgPDFleetKey",
    [88888813] = "SCKCO.85CrownVicTaxiFleetKey",
    [88888814] = "SCKCO.CUCVFleetKey",
}

-- ========================================
-- HELPER FUNCTIONS
-- ========================================

local function searchContainer(container)
    if not container then return nil end
    
    for i = 0, container:getItems():size() - 1 do
        local item = container:getItems():get(i)
        if item then
            if item:IsInventoryContainer() then
                local found = searchContainer(item:getInventory())
                if found then return found end
            end
            
            if instanceof(item, "KeyRing") and item:getInventory() then
                local found = searchContainer(item:getInventory())
                if found then return found end
            end
        end
    end
    
    return nil
end

local function findFleetKey(player, keyId)
    if not player then return nil end
    
    local keyType = FLEET_KEYS[keyId]
    if not keyType then return nil end
    
    local function search(container)
        if not container then return nil end
        
        for i = 0, container:getItems():size() - 1 do
            local item = container:getItems():get(i)
            if item and item:getFullType() == keyType then
                return item
            end
            
            if item and item:IsInventoryContainer() then
                local found = search(item:getInventory())
                if found then return found end
            end
            
            if item and instanceof(item, "KeyRing") and item:getInventory() then
                local found = search(item:getInventory())
                if found then return found end
            end
        end
        return nil
    end
    
    local key = search(player:getInventory())
    if key then return key end
    
    local wornItems = player:getWornItems()
    for i = 0, wornItems:size() - 1 do
        local item = wornItems:get(i):getItem()
        if item then
            if item:IsInventoryContainer() then
                local found = search(item:getInventory())
                if found then return found end
            end
            if instanceof(item, "KeyRing") and item:getInventory() then
                local found = search(item:getInventory())
                if found then return found end
            end
        end
    end
    
    return nil
end

-- ========================================
-- CORE FUNCTIONS
-- ========================================

local function removeVanillaKeys(vehicle)
    if not vehicle then return end
    
    -- Remove keys from vehicle containers
    local partData = vehicle:getPartById("GloveBox")
    if partData then
        local container = partData:getItemContainer()
        if container then
            for i = container:getItems():size() - 1, 0, -1 do
                local item = container:getItems():get(i)
                if item and (item:getFullType() == "Base.CarKey" or item:getFullType() == "Base.KeyRing") then
                    container:Remove(item)
                    print("SC_FleetKeys Removed " .. item:getFullType() .. " from " .. vehicle:getScriptName())
                end
            end
        end
    end
    
    -- Remove keys from ground around vehicle
    local square = vehicle:getSquare()
    if square then
        local objects = square:getObjects()
        for i = objects:size() - 1, 0, -1 do
            local obj = objects:get(i)
            if obj and instanceof(obj, "IsoWorldInventoryObject") then
                local item = obj:getItem()
                if item and (item:getFullType() == "Base.CarKey" or item:getFullType() == "Base.KeyRing") then
                    square:transmitRemoveItemFromSquare(obj)
                    print("SC_FleetKeys Removed " .. item:getFullType() .. " from ground near " .. vehicle:getScriptName())
                end
            end
        end
    end
end

local function assignFleetKeyIds()
    local player = getPlayer()
    if not player then return end
    if not FLEET_KEYS then return end
    
    for keyId, keyType in pairs(FLEET_KEYS) do
        local key = findFleetKey(player, keyId)
        if key and key:getKeyId() ~= keyId then
            key:setKeyId(keyId)
            print("SC_FleetKeys Assigned KeyId " .. keyId .. " to " .. keyType)
        end
    end
end

local function assignVehicleKeys()
    local vehicles = getCell():getVehicles()
    
    for i = 0, vehicles:size() - 1 do
        local vehicle = vehicles:get(i)
        if vehicle then
            local fleetKeyId = FLEET_CONFIG[vehicle:getScriptName()]
            if fleetKeyId then
                if vehicle:getKeyId() ~= fleetKeyId then
                    vehicle:setKeyId(fleetKeyId)
                    print("SC_FleetKeys Vehicle " .. vehicle:getScriptName() .. " -> KeyId " .. fleetKeyId)
                end
                removeVanillaKeys(vehicle)
            end
        end
    end
end

local function syncNearbyVehicles()
    local player = getPlayer()
    if not player then return end
    
    local square = player:getCurrentSquare()
    if not square then return end
    
    local vehicles = getCell():getVehicles()
    for i = 0, vehicles:size() - 1 do
        local vehicle = vehicles:get(i)
        if vehicle and vehicle:getSquare() then
            if square:DistToProper(vehicle:getSquare()) <= 3 then
                local fleetKeyId = FLEET_CONFIG[vehicle:getScriptName()]
                if fleetKeyId then
                    local key = findFleetKey(player, fleetKeyId)
                    
                    if vehicle:getKeyId() ~= fleetKeyId then
                        vehicle:setKeyId(fleetKeyId)
                    end
                    
                    if key and key:getKeyId() ~= fleetKeyId then
                        key:setKeyId(fleetKeyId)
                    end
                end
            end
        end
    end
end

-- ========================================
-- EVENT HANDLERS
-- ========================================

Events.OnRefreshInventoryWindowContainers.Add(assignFleetKeyIds)
Events.OnPlayerMove.Add(syncNearbyVehicles)

Events.OnGameStart.Add(function()
    print("SC_FleetKeys loaded")
    assignVehicleKeys()
end)

local tickCounter = 0
Events.OnTick.Add(function()
    tickCounter = tickCounter + 1
    if tickCounter >= 600 then
        assignVehicleKeys()
        tickCounter = 0
    end
end)