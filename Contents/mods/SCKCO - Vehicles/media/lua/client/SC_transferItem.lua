require "TimedActions/ISInventoryTransferAction.lua"
local action = ISInventoryTransferAction.perform

function ISInventoryTransferAction:perform()

    local destContParent = self.destContainer:getParent()
    if destContParent and instanceof(destContParent, "BaseVehicle") then

        local partID = self.destContainer:getType()
        if partID == "TruckBed" then SC_VisualStorage.update(destContParent, nil, nil) end
    end

    local srcContParent = self.srcContainer:getParent()
    if srcContParent and instanceof(srcContParent, "BaseVehicle") then
        local partID = self.srcContainer:getType()
        if partID == "TruckBed" then SC_VisualStorage.update(srcContParent, nil, nil) end
    end

    action(self)
end