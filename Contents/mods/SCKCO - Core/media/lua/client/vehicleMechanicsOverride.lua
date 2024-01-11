require "Vehicles/ISUI/ISVehicleMechanics"

---Chuck says:
-- Technically you can override this while calling on the original, but...
-- it's probably a good chance this part of the UI is not messed with by many mods
-- and if there are mods that mess with it, calling the original may not even help avoid issues.

---local renderCarOverlay = ISVehicleMechanics.renderCarOverlay
function ISVehicleMechanics:renderCarOverlay()
    ---renderCarOverlay(self)

    local scale = 1

    if ISVehicleMechanics.alphaOverlayInc then
        ISVehicleMechanics.alphaOverlay = ISVehicleMechanics.alphaOverlay + 0.08 * (UIManager.getMillisSinceLastRender() / 33.3)
        if ISVehicleMechanics.alphaOverlay >= 1 then
            ISVehicleMechanics.alphaOverlayInc = false
            ISVehicleMechanics.alphaOverlay = 1
        end
    else
        ISVehicleMechanics.alphaOverlay = ISVehicleMechanics.alphaOverlay - 0.08 * (UIManager.getMillisSinceLastRender() / 33.3)
        if ISVehicleMechanics.alphaOverlay <= 0 then
            ISVehicleMechanics.alphaOverlayInc = true
            ISVehicleMechanics.alphaOverlay = 0
        end
    end

    self.hidetooltip = true

    local carMechanicsOverlay = ISCarMechanicsOverlay.CarList[self.vehicle:getScriptName()]
    if carMechanicsOverlay then

        local propsImgPrefix = carMechanicsOverlay.imgPrefix or ""
        local overlayDir = "media/ui/vehicles/mechanic overlay/"

        ---car base texture
        self:drawTextureScaledUniform(getTexture(overlayDir..propsImgPrefix.."base.png"), carMechanicsOverlay.x, carMechanicsOverlay.y, scale,1,1,1,1)

        for i=1, self.vehicle:getPartCount() do
            local part = self.vehicle:getPartByIndex(i-1)
            local partID = part:getId()

            local partOverlays = ISCarMechanicsOverlay.PartList[partID]
            if partOverlays then

                local condRGB = self:getConditionRGB(part:getCondition())
                if not part:getInventoryItem() and part:getTable("install")  then
                    condRGB = self:getConditionRGB(part:getCondition())
                end

                local tmpPrefix = propsImgPrefix

                if carMechanicsOverlay.PartList and carMechanicsOverlay.PartList[partID] then
                    partOverlays = carMechanicsOverlay.PartList[partID]
                elseif partOverlays.vehicles and not partOverlays.vehicles[tmpPrefix] and partOverlays.x and partOverlays.y then
                    tmpPrefix = "_"
                end

                local alpha = 0.9
                if part:getCondition() < 10 or (not part:getInventoryItem() and part:getTable("install")) then
                    alpha = ISVehicleMechanics.alphaOverlay
                end

                if not partOverlays.multipleImg then
                    self:drawTextureScaledUniform(getTexture(overlayDir..tmpPrefix..partOverlays.img..".png"), carMechanicsOverlay.x, carMechanicsOverlay.y, scale,alpha,condRGB.r,condRGB.g,condRGB.b)
                else
                    for _,img in ipairs(partOverlays.img) do
                        self:drawTextureScaledUniform(getTexture(overlayDir..tmpPrefix..img..".png"), carMechanicsOverlay.x, carMechanicsOverlay.y, scale,alpha,condRGB.r,condRGB.g,condRGB.b)
                    end
                end

                if self:renderCarOverlayTooltip(partOverlays, part, tmpPrefix) then
                    self.hidetooltip = false
                end

            end
        end
    end

    if self.hidetooltip and self.tooltip then
        self.tooltip:setVisible(false)
    end
end