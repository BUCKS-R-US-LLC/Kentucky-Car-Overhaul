print("SC_FixOnSpawn loading")

local SC_VehicleFixer = {}

-- Vehicles that spawn with 85-100% part condition (better condition)
SC_VehicleFixer.vehicleListGood = {
    "SC_AMGeneralM998",
    "SC_AMGeneralM1025",
    "SC_AMGeneralM1097",
    "SC_AMGeneralM997",
    "SC_AMGeneralM35A2",
    "SC_ChevroletM1009",
    "SC_ChevroletM1008",
    "SC_ChevroletM1010",
    "SC_ChevroletM1028A3",
    "SC_FordCrownVictoria85_StatePolice",
    "SC_FordCrownVictoria85_LouisvillePD",
    "SC_FordCrownVictoria85_ParkRanger",
    "SC_FordCrownVictoria92_StatePolice",
    "SC_FordCrownVictoria92_LouisvillePD",
    "SC_FordCrownVictoria92_JeffersonPD",
    "SC_FordCrownVictoria92_JeffersonSheriff",
    "SC_FordCrownVictoria92_MeadeSheriff",
    "SC_FordCrownVictoria92_MuhlenSheriff",
    "SC_FordCrownVictoria92_WarrenSheriff",
    "SC_FordCrownVictoria92_BullittSheriff",
    "SC_FordCrownVictoria92_BrandenburgPD",
    "SC_FordMustang90_JeffersonPD",
    "SC_FordMustang90_StatePolice",
    "SC_FordMustang90_Undercover",
    "SC_ChevroletCaprice85_ParkRanger",
    "SC_JeepCherokee_AudubonPD",
    "SC_BMW520i",
    "SC_Porsche911",
}

-- Vehicles that spawn with 60-80% part condition (worse condition)
SC_VehicleFixer.vehicleListWorn = {
    "SC_ChevroletG30_Ambulance",
    "SC_FordF350Ambulance_Life",
    "SC_FordF350Ambulance_Meade",
    "SC_FordF350Ambulance_StPeregrin",
    "SC_FordCrownVictoria85_Taxi",
    "SC_GrummanLLV",
    "SC_FordF150",
    "SC_FordTaurus",
}

local fixedVehicles = {}

function SC_VehicleFixer.scanVehicles()
    local player = getPlayer()
    if not player then return end
    
    local cell = getCell()
    if not cell then return end
    
    local vehicles = cell:getVehicles()
    for i = 0, vehicles:size() - 1 do
        local vehicle = vehicles:get(i)
        
        if vehicle then
            local vehicleID = vehicle:getId()
            
            -- Only process if not already fixed
            if not fixedVehicles[vehicleID] then
                local scriptName = vehicle:getScriptName()
                
                -- Check which list this vehicle belongs to
                local conditionMin = nil
                local conditionMax = nil
                
                -- Check good condition list (85-100)
                for _, searchString in ipairs(SC_VehicleFixer.vehicleListGood) do
                    if string.find(scriptName, searchString) then
                        conditionMin = 85
                        conditionMax = 101
                        break
                    end
                end
                
                -- Check worn condition list (60-80) if not found in good list
                if not conditionMin then
                    for _, searchString in ipairs(SC_VehicleFixer.vehicleListWorn) do
                        if string.find(scriptName, searchString) then
                            conditionMin = 60
                            conditionMax = 81
                            break
                        end
                    end
                end
                
                -- If vehicle matches either list, fix it
                if conditionMin then
                    -- Remove rust
                    if vehicle.setRust then
                        vehicle:setRust(0)
                    end
                    
                    if vehicle.setRustOverlay then
                        vehicle:setRustOverlay(0)
                    end
                    
                    -- Set all parts to random condition in the specified range
                    for j = 0, vehicle:getPartCount() - 1 do
                        local part = vehicle:getPartByIndex(j)
                        if part and part:getInventoryItem() then
                            local randomCondition = ZombRand(conditionMin, conditionMax)
                            sendClientCommand(player, "vehicle", "setPartCondition", { 
                                vehicle = vehicleID, 
                                part = part:getId(), 
                                condition = randomCondition 
                            })
                            vehicle:transmitPartModData(part)
                        end
                    end
                    
                    vehicle:update()
                    fixedVehicles[vehicleID] = true
                    print("Fixed spawned vehicle: " .. scriptName .. " (ID: " .. vehicleID .. ") with condition range " .. conditionMin .. "-" .. (conditionMax-1))
                end
            end
        end
    end
end

Events.OnPlayerUpdate.Add(SC_VehicleFixer.scanVehicles)

print("SC_VehicleFixer loaded")

local vehicleSoundController = require("SC/SC_vehicleSoundController.lua")
Events.OnPlayerUpdate.Add(vehicleSoundController.handleUpdate)