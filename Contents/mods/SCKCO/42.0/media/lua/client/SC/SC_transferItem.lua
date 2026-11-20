require "TimedActions/ISInventoryTransferAction.lua"
local action = ISInventoryTransferAction.perform

-- In MP the server applies the transfer and the client's copy of the container lands a few
-- ticks later, so a refresh straight after perform can still see the old contents. Each
-- touched vehicle gets one refresh now and one again after REFRESH_DELAY ticks.
local REFRESH_DELAY = 30
local pending = {}

local function truckBedVehicle(container)
    if not container then return nil end
    local parent = container:getParent()
    if parent and instanceof(parent, "BaseVehicle") and container:getType() == "TruckBed" then
        return parent
    end
end

local function onTick()
    for vehicle, ticks in pairs(pending) do
        if ticks <= 0 then
            pending[vehicle] = nil
            SCKCO_VisualStorage.update(vehicle, nil, nil)
        else
            pending[vehicle] = ticks - 1
        end
    end
    if next(pending) == nil then Events.OnTick.Remove(onTick) end
end

local function queueRefresh(vehicle)
    if next(pending) == nil then Events.OnTick.Add(onTick) end
    pending[vehicle] = REFRESH_DELAY
end

function ISInventoryTransferAction:perform()
    local dest = truckBedVehicle(self.destContainer)
    local src = truckBedVehicle(self.srcContainer)

    action(self)

    if dest then SCKCO_VisualStorage.update(dest, nil, nil); queueRefresh(dest) end
    if src and src ~= dest then SCKCO_VisualStorage.update(src, nil, nil); queueRefresh(src) end
end
