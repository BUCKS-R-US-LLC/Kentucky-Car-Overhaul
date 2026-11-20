---part chance variation by Chuck

---This goes in the part script
--        table partVariation
--            {
--- chances are a list of vehicle IDs and a "default", vehicle IDs will supersede the "default" value
--- With no 'chances' sub-table, the chance is 100%
--                chances = {
--                    default = 0,
--                    SC_FordMustang = 50,
--                }
--- Make sure to include the original `additionalVehicleFunc` this is different depending on part type, most use 'Default'.
--- If no `additationalVehicleFunc` is provided it will default to `Default`.
--                additionalVehicleFunc = Default
--
--- removeOnCreate removes a list of parts when the vehicle spawns. Supports chance rolls -- parts are only
--- removed if the chance check passes. Can be combined with any other partVariation options.
--                removeOnCreate = {
--                    1 = DoorFrontLeft,
--                    2 = DoorFrontRight,
--                    3 = DoorRearLeft,
--                    4 = DoorRearRight,
--                }
--            }
--
--- lua Create needs ot be overwritten so the above is true.
--		lua { create = Vehicles.Create.SCKCO_VehiclePartVariation, } }

---FOR MILITARY IGNITION
--  template = Engine,
--  part Engine
--  {
--     table partVariation
--      {
--          militaryIgnition = true,
--          additionalVehicleFunc = Engine,
--      }
--      lua {
--          create = Vehicles.Create.SCKCO_VehiclePartVariation,
--- NOTE: the update is now -> SCKCO_militaryEngine (This corrects previously spawned in cars.)
--          update = Vehicles.Update.SCKCO_militaryEngine,
--          checkEngine = Vehicles.CheckEngine.Engine,
--      }
--  }

--         part removeParts
--        {
--           category = nodisplay,
--           table removeOnCreate {
--                1=DoorFrontLeft,
--                2=DoorFrontRight,
--                3=DoorRearLeft,
--                4=DoorRearRight,
--           }
--           lua { init = Vehicles.Create.SCKCO_removeOnCreate, update = Vehicles.Create.SCKCO_removeOnCreate, }
--        }
--
---  OR, use removeOnCreate directly inside partVariation (supports chance rolls):
--		part Engine
--        {
--            table partVariation
--            {
--                militaryIgnition = true,
--                additionalVehicleFunc = Engine,
--                noLockDoors = true,
--                removeOnCreate = {
--                    1 = DoorFrontLeft,
--                    2 = DoorFrontRight,
--                    3 = DoorRearLeft,
--                    4 = DoorRearRight,
--                }
--            }
--            lua {
--                create = Vehicles.Create.SCKCO_VehiclePartVariation,
--                update = Vehicles.Update.SCKCO_militaryEngine,
--                checkEngine = Vehicles.CheckEngine.Engine,
--            }
--        }

require "Vehicles/Vehicles"

-- Military ignition dashboard UI lives in client/SC/SC_clientEvents.lua: ISVehicleDashboard is a
-- client class, and indexing it here aborted this file on dedicated servers before the hooks below loaded.


---@param vehicle BaseVehicle
---@param part VehiclePart
local function SC_applySpecials(vehicle, part, partTable)
    -- Part update fires on VirtualVehicle instances (streamed-out cars) via VirtualVehicleManager.
    -- Those lack BaseVehicle-only methods (isHotwired/setHotwired/getDoor/transmitPartItem), so the
    -- specials are skipped until the vehicle is physically loaded; the update re-fires once it is.
    if not instanceof(vehicle, "BaseVehicle") then return end

    partTable = partTable or part:getTable("partVariation")
    if not partTable then return end

    if partTable.militaryIgnition and not vehicle:isHotwired() then vehicle:setHotwired(true) end

    if partTable.noLockDoors then
        for i=0, vehicle:getPartCount()-1 do
            ---@type VehiclePart
            local partByIndex = vehicle:getPartByIndex(i)
            local door = partByIndex and partByIndex:getDoor()
            -- runs every part update: only write and sync when the state actually differs
            if door and (door:isLocked() or not door:isLockBroken()) then
                door:setLocked(false)
                door:setLockBroken(true)
                vehicle:transmitPartDoor(partByIndex)
            end
        end
    end

    if partTable.removeOnCreate then
        for _, partID in pairs(partTable.removeOnCreate) do
            local removeThis = vehicle:getPartById(partID)
            if removeThis then
                removeThis:setInventoryItem(nil)
                vehicle:transmitPartItem(removeThis)
            end
        end
    end
end


---@param vehicle BaseVehicle
---@param part VehiclePart
function Vehicles.Update.SCKCO_militaryEngine(vehicle, part, elapsedMinutes)
    SC_applySpecials(vehicle, part)
    Vehicles.Update.Engine(vehicle, part, elapsedMinutes)
end



function Vehicles.Init.TrunkDoorSCKCO_Storage(vehicle, part)
    SCKCO_VisualStorage.update(vehicle, part, nil, true)
    Vehicles.Init.Door(vehicle, part)
end


function Vehicles.Use.TrunkDoorSCKCO_Storage(vehicle, part, character)
    SCKCO_VisualStorage.update(vehicle, part, nil, true)
    Vehicles.Use.TrunkDoor(vehicle, part, character)
end



function Vehicles.Create.SCKCO_removeOnCreate(vehicle, part, elapsedMinutes)
    local removeOnCreate = part:getTable("removeOnCreate")
    if removeOnCreate then
        for k,partID in pairs(removeOnCreate) do
            local removeThis = vehicle:getPartById(partID)
            if removeThis then
                removeThis:setInventoryItem(nil)
                vehicle:transmitPartItem(removeThis)
            end
        end
    end

    if elapsedMinutes then
        part:setInventoryItem(nil)
        vehicle:transmitPartItem(part)
    end
end


---@param vehicle BaseVehicle
---@param part VehiclePart
function Vehicles.Create.SCKCO_VehiclePartVariation(vehicle, part)

    local vehicleID = vehicle:getScriptName()

    local partTable = part:getTable("partVariation")
    if not partTable then
        Vehicles.Create.Default(vehicle, part)
        return
    end
    
    local chances = partTable.chances
    local chance = (chances and tonumber(chances[vehicleID] or chances["default"])) --or 0

    --print("vehicleID: ",vehicleID," part:", part:getId(), " chance:",chance)

    -- ZombRand(100) is 0..99, so chance 0 never passes and chance 100 always does
    if (not chance) or (ZombRand(100) < chance) then

        SC_applySpecials(vehicle, part, partTable)
        
        local additionalFunc = partTable.additionalVehicleFunc
        local addFunc = (additionalFunc and (Vehicles.Create[additionalFunc])) or Vehicles.Create.Default

        if addFunc then
            --print(" -- additionalFunc: ",additionalFunc)
            addFunc(vehicle, part)
        end
    end
end