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
--- If no `additionalVehicleFunc` is provided it will default to `Default`.
--                additionalVehicleFunc = Default
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
--		part Engine
--        {
--            table partVariation
--            {
--                militaryIgnition = true,
--                additionalVehicleFunc = Engine,
--                noLockDoors = true,
--            }
--            lua {
--                create = Vehicles.Create.SCKCO_VehiclePartVariation,
--                update = Vehicles.Update.SCKCO_militaryEngine,
--                checkEngine = Vehicles.CheckEngine.Engine,
--            }
--        }

require "Vehicles/Vehicles"

local SC_militaryIgnitionUI = {}
SC_militaryIgnitionUI.knob = getTexture("media/ui/militaryIgnitionUI.png")
SC_militaryIgnitionUI.panel = {}
SC_militaryIgnitionUI.panel.texture = getTexture("media/ui/militaryIgnitionUI_panel.png")
SC_militaryIgnitionUI.panel.width = SC_militaryIgnitionUI.panel.texture:getWidth()
SC_militaryIgnitionUI.panel.height = SC_militaryIgnitionUI.panel.texture:getHeight()


local ISVehicleDashboard_prerender = ISVehicleDashboard.prerender
function ISVehicleDashboard:prerender()
    if not self.vehicle or not ISUIHandler.allUIVisible then return end
    ISVehicleDashboard_prerender(self)

    local part = self.vehicle:getPartById("Engine")
    local partTable = part:getTable("partVariation")
    if partTable and partTable.militaryIgnition then
        self.ignitionTex.texture = SC_militaryIgnitionUI.knob
        self.ignitionTex.mouseovertext = getText("Tooltip_MilitaryIgnition")
    end
end


local ISVehicleDashboard_render = ISVehicleDashboard.render
function ISVehicleDashboard:render()
    if not self.vehicle then return end

    local part = self.vehicle:getPartById("Engine")
    local partTable = part:getTable("partVariation")
    if partTable and partTable.militaryIgnition then
        local panel = SC_militaryIgnitionUI.panel
        self:drawTexture(panel.texture,
                self.ignitionTex.x-8,
                self.ignitionTex.y-8,
                1, 1, 1, 1)
    end

    ISVehicleDashboard_render(self)
end


---@param vehicle BaseVehicle
---@param part VehiclePart
local function SC_applySpecials(vehicle, part, partTable)
    partTable = partTable or part:getTable("partVariation")
    if not partTable then return end

    if partTable.militaryIgnition and not vehicle:isHotwired() then vehicle:setHotwired(true) end

    if partTable.noLockDoors then
        for i=0, vehicle:getPartCount() do
            ---@type VehiclePart
            local partByIndex = vehicle:getPartByIndex(i)
            local door = partByIndex and partByIndex:getDoor()
            if door then
                door:setLocked(false)
                door:setLockBroken(true)
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


Vehicles.SKCO_itemTypesToModels = {

    ["Base.PetrolCan"] = "GasCan",
    ["Base.EmptyPetrolCan"] = "GasCan",
    ["Base.Jack"] = "CarJack",
    ["Base.CarBatteryCharger"] = "CarBatteryCharger",
}

local itemsDisplayed = {}
---@param vehicle BaseVehicle
---@param part VehiclePart
function Vehicles.Update.SCKCO_Storage(vehicle, part, elapsedMinutes)
    
    local partTable = part:getTable("partVariation")
    if partTable and partTable.storageAltFunc then Vehicles.Update[partTable.storageAltFunc.update](vehicle, part, elapsedMinutes) end

    local container = part:getItemContainer()

    ---@type VehiclePart
    local trunkDoor = vehicle:getPartById("TrunkDoor")
    local doorObject = trunkDoor:getDoor()

    ---@type ArrayList
    local items = container and container:getItems()
    local slots = {"One","Two","Three","Four","Five"}
    local carID = vehicle:getId()

    itemsDisplayed[carID] = {}

    local slot = vehicle:getPartById("itemSlot")
    if not slot then return end

    slot:setAllModelsVisible(false)

    if doorObject and (not doorObject:isOpen()) then return end

    for i,num in pairs(slots) do
        local model
        for itemNum=items:size()-1, 0, -1 do
            ---@type InventoryItem
            local item = items:get(itemNum)
            local itemID = item:getID()
            local alreadyDisplayed = itemsDisplayed[carID][itemID]
            model = (not alreadyDisplayed) and item and Vehicles.SKCO_itemTypesToModels[item:getFullType()]
            if model then
                itemsDisplayed[carID][itemID] = true
                slot:setModelVisible("Slot"..num.."_"..model, true)
                break
            end
        end
    end
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

    if (not chance) or (chance and (ZombRand(0, 101) <= chance)) then

        SC_applySpecials(vehicle, part, partTable)
        
        local additionalFunc = partTable.additionalVehicleFunc
        local addFunc = (additionalFunc and (Vehicles.Create[additionalFunc])) or Vehicles.Create.Default

        if addFunc then
            --print(" -- additionalFunc: ",additionalFunc)
            addFunc(vehicle, part)
        end
    end
end