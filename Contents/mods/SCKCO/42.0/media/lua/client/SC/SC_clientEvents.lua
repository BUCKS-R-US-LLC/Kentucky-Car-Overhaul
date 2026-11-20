local vehicleSoundController = require("SC/SC_vehicleSoundController.lua")
Events.OnPlayerUpdate.Add(vehicleSoundController.handleUpdate)

require "Vehicles/ISUI/ISVehicleDashboard"

-- Military ignition dashboard (moved from server/SC_vehiclePartVariation_createEvents.lua)
local SC_militaryIgnitionUI = {}
SC_militaryIgnitionUI.knob = getTexture("media/ui/militaryIgnitionUI.png")
SC_militaryIgnitionUI.panel = {}
SC_militaryIgnitionUI.panel.texture = getTexture("media/ui/militaryIgnitionUI_panel.png")
if SC_militaryIgnitionUI.panel.texture then
    SC_militaryIgnitionUI.panel.width = SC_militaryIgnitionUI.panel.texture:getWidth()
    SC_militaryIgnitionUI.panel.height = SC_militaryIgnitionUI.panel.texture:getHeight()
end

-- nil when the vehicle has no Engine part (trailers, towed wrecks)
local function militaryIgnition(vehicle)
    local part = vehicle:getPartById("Engine")
    local partTable = part and part:getTable("partVariation")
    return partTable and partTable.militaryIgnition
end


local ISVehicleDashboard_prerender = ISVehicleDashboard.prerender
function ISVehicleDashboard:prerender()
    if not self.vehicle or not ISUIHandler.allUIVisible then return end
    ISVehicleDashboard_prerender(self)

    if militaryIgnition(self.vehicle) then
        self.ignitionTex.texture = SC_militaryIgnitionUI.knob
        self.ignitionTex.mouseovertext = getText("Tooltip_MilitaryIgnition")
    end
end


local ISVehicleDashboard_render = ISVehicleDashboard.render
function ISVehicleDashboard:render()
    if not self.vehicle then return end

    local panel = SC_militaryIgnitionUI.panel
    if panel.texture and militaryIgnition(self.vehicle) then
        self:drawTexture(panel.texture,
                self.ignitionTex.x-8,
                self.ignitionTex.y-8,
                1, 1, 1, 1)
    end

    ISVehicleDashboard_render(self)
end