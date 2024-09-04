SCKCO_VisualStorage = {}

SCKCO_VisualStorage.itemTypesToModels = {

    ["Base.PetrolCan"] = "GasCan",
    ["Base.EmptyPetrolCan"] = "GasCan",
    ["Base.Jack"] = "CarJack",
    ["Base.CarBatteryCharger"] = "CarBatteryCharger",
}

local itemsDisplayed = {}
---@param vehicle BaseVehicle
---@param trunkDoor VehiclePart
---@param trunk VehiclePart
function SCKCO_VisualStorage.update(vehicle, trunkDoor, trunk, inverseCheck)

    trunk = trunk or vehicle:getPartById("TruckBed")
    local container = trunk and trunk:getItemContainer()

    ---@type VehiclePart
    local slot = vehicle:getPartById("itemSlot")
    if not slot then return end
    slot:setAllModelsVisible(false)

    if not container then return end

    trunkDoor = trunkDoor or vehicle:getPartById("TrunkDoor")
    local doorObject = trunkDoor:getDoor()

    if inverseCheck then
        if (doorObject and doorObject:isOpen()) then return end
    else
        if doorObject and (not doorObject:isOpen()) then return end
    end

    ---@type ArrayList
    local items = container and container:getItems()
    local slots = {"One","Two","Three","Four","Five"}
    local carID = vehicle:getId()
    itemsDisplayed[carID] = {}

    for i,num in pairs(slots) do
        local model
        for itemNum=items:size()-1, 0, -1 do
            ---@type InventoryItem
            local item = items:get(itemNum)
            local itemID = item:getID()
            local alreadyDisplayed = itemsDisplayed[carID][itemID]
            model = (not alreadyDisplayed) and item and SCKCO_VisualStorage.itemTypesToModels[item:getFullType()]
            if model then
                itemsDisplayed[carID][itemID] = true
                slot:setModelVisible("Slot"..num.."_"..model, true)
                break
            end
        end
    end
end