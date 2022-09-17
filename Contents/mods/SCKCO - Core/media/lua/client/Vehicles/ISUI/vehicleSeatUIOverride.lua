require "Vehicles/ISUI/ISVehicleSeatUI"

local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

local ImageScale = {}
ImageScale["4door_"] = 1.0
ImageScale["offroad_"] = 1.0
ImageScale["smallcar_"] = 1.1
ImageScale["sportscar_"] = 1.15
ImageScale["stationwagon_"] = 1.15
ImageScale["suv_"] = 1.0
ImageScale["truck_"] = 1.1
ImageScale["van_"] = 1.1

local SeatOffsetY = {}
SeatOffsetY["Base.CarNormal"] = 4
SeatOffsetY["Base.CarTaxi"] = SeatOffsetY["Base.CarNormal"]
SeatOffsetY["Base.CarTaxi2"] = SeatOffsetY["Base.CarNormal"]
SeatOffsetY["Base.PickUpTruck"] = 3
SeatOffsetY["Base.PickUpVan"] = SeatOffsetY["Base.PickUpTruck"]
SeatOffsetY["Base.PickUpVanLights"] = SeatOffsetY["Base.PickUpTruck"]
SeatOffsetY["Base.PickUpVanLightsFire"] = SeatOffsetY["Base.PickUpTruck"]
SeatOffsetY["Base.PickUpTruckLightsFire"] = SeatOffsetY["Base.PickUpTruck"]
SeatOffsetY["Base.PickUpTruckLights"] = SeatOffsetY["Base.PickUpTruck"]
SeatOffsetY["Base.SmallCar"] = 15
SeatOffsetY["Base.SmallCar02"] = 0
SeatOffsetY["Base.CarStationWagon"] = -9
SeatOffsetY["Base.CarLuxury"] = 0
SeatOffsetY["Base.SportsCar"] = -6
SeatOffsetY["Base.StepVan"] = -3
SeatOffsetY["Base.Van"] = 3
SeatOffsetY["Base.VanAmbulance"] = SeatOffsetY["Base.Van"]
SeatOffsetY["Base.VanSeats"] = SeatOffsetY["Base.StepVan"]
SeatOffsetY["Base.ModernCar"] = 7
SeatOffsetY["Base.ModernCar02"] = 15
SeatOffsetY["Base.SUV"] = -2
SeatOffsetY["Base.OffRoad"] = 30

SeatOffsetY["Base.SC_M35A1"] = -100

local SeatOffsetX = {}
SeatOffsetX["Base.PickUpTruck"] = 0
SeatOffsetX["Base.PickUpVan"] = SeatOffsetX["Base.PickUpTruck"]
SeatOffsetX["Base.PickUpVanLights"] = SeatOffsetX["Base.PickUpTruck"]
SeatOffsetX["Base.PickUpVanLightsFire"] = SeatOffsetX["Base.PickUpTruck"]
SeatOffsetX["Base.PickUpTruckLightsFire"] = SeatOffsetX["Base.PickUpTruck"]
SeatOffsetX["Base.PickUpTruckLights"] = SeatOffsetX["Base.PickUpTruck"]
SeatOffsetX["Base.SmallCar"] = 0
SeatOffsetX["Base.SmallCar02"] = SeatOffsetX["Base.SmallCar"]
SeatOffsetX["Base.CarStationWagon"] = 0
SeatOffsetX["Base.CarNormal"] = 0
SeatOffsetX["Base.CarTaxi"] = SeatOffsetX["Base.CarNormal"]
SeatOffsetX["Base.CarTaxi2"] = SeatOffsetX["Base.CarNormal"]
SeatOffsetX["Base.StepVan"] = 0
SeatOffsetX["Base.Van"] = 0
SeatOffsetX["Base.VanSeats"] = SeatOffsetX["Base.StepVan"]
SeatOffsetX["Base.VanAmbulance"] = SeatOffsetX["Base.Van"]
SeatOffsetX["Base.CarLuxury"] = 0
SeatOffsetX["Base.SportsCar"] = 0
SeatOffsetX["Base.ModernCar"] = 0
SeatOffsetX["Base.ModernCar02"] = SeatOffsetX["Base.ModernCar"]
SeatOffsetX["Base.SUV"] = 0
SeatOffsetX["Base.OffRoad"] = 2


function ISVehicleSeatUI:render()
    ISPanelJoypad.render(self)

    self.mouseOverSeat = nil
    self.mouseOverExit = nil

    if not self.vehicle then return end

    local script = self.vehicle:getScript()
    local scriptName = self.vehicle:getScriptName()

    local extents = script:getExtents()
    local ratio = extents:x() / extents:z() + 0.0
    local height = self.height * 0.7
    local width = height * ratio
    local ex = (self.width - width) / 2
    local ey = (self.height - height) / 2
    local props = ISCarMechanicsOverlay.CarList[scriptName]
    if props and props.imgPrefix then
        local tex = getTexture("media/ui/vehicles/seatui/" .. props.imgPrefix .. "base_small.png")
        if tex then
            local imageScale = ImageScale[props.imgPrefix] or 1.0
            self:drawTextureScaledUniform(tex,
                    (self.width - tex:getWidthOrig() * imageScale) / 2,
                    (self.height - tex:getHeightOrig() * imageScale) / 2,
                    imageScale, 1,1,1,1)
        else
            self:drawRect(ex, ey, width, height, 0.8, 0.0, 0.0, 0.0)
            self:drawRectBorder(ex, ey, width, height, 1.0, 1.0, 1.0, 1.0)
        end
    else
        self:drawRect(ex, ey, width, height, 0.8, 0.0, 0.0, 0.0)
        self:drawRectBorder(ex, ey, width, height, 1.0, 1.0, 1.0, 1.0)
    end

    local playerSeat = self.vehicle:getSeat(self.character)

    local shiftKey = isKeyDown(Keyboard.KEY_LSHIFT) or isKeyDown(Keyboard.KEY_RSHIFT)

    local scale = height / extents:z()
    local sizeX,sizeY = 41,59

    local driver = script:getPassenger(0)
    local driverPos = driver:getPositionById("inside")
    if driverPos then
        local offset = driverPos:getOffset()
        local x = self:getWidth() / 2 - offset:get(0) * scale - sizeX / 2
        local y = self:getHeight() / 2 - offset:get(2) * scale - sizeY / 2
        y = y + (SeatOffsetY[scriptName] or 0.0)
        x = x + (SeatOffsetX[scriptName] or 0.0)

        sizeY = math.min(sizeY, ((height-y)/(self.vehicle:getMaxPassengers()/2)))
    end

    local previousSeats = {}

--[[
    if not self.setShiftedHeight then
        self.setShiftedHeight = true
        self:setHeight(self:getHeight()+100)
        --self:setHeight(self:getHeight()+yOffset)
    end
--]]
    for seat=1,self.vehicle:getMaxPassengers() do
        local pngr = script:getPassenger(seat-1)
        local posn = pngr:getPositionById("inside")
        if posn then
            local offset = posn:getOffset()
            local x = self:getWidth() / 2 - offset:get(0) * scale - sizeX / 2
            local y = self:getHeight() / 2 - offset:get(2) * scale - sizeY / 2
            y = y + (SeatOffsetY[scriptName] or 0.0)
            x = x + (SeatOffsetX[scriptName] or 0.0)

            if previousSeats[x] then
                for _,seatXY in pairs(previousSeats[x]) do
                    local seatX, seatY = seatXY[1], seatXY[2]
                    --if x > seatX and x < seatX+sizeX then x = seatX+sizeX+2 end
                    if y >= seatY and y <= seatY+sizeY then
                        local oldY = y
                        y = math.max(y, seatY+sizeY+3)
                    end
                end
            end
            previousSeats[x] = previousSeats[x] or {}
            table.insert(previousSeats[x], {x, y})


            local mouseOver = (self:getMouseX() >= x and self:getMouseX() < x + sizeX and
                    self:getMouseY() >= y and self:getMouseY() < y + sizeY) or
                    (self.joyfocus and self.joypadSeat == seat)
            if mouseOver then
                self.mouseOverSeat = seat - 1
            end

            local fillR, fillG, fillB = 0.0, 0.0, 0.0
            local outlineR, outlineG, outlineB = 0.0, 1.0, 0.0
            local texName = "icon_vehicle_empty.png"
            local textRGB = 1.0
            local canSwitch = false
            if self.vehicle:isSeatOccupied(seat-1) then
                if self.vehicle:getCharacter(seat-1) then
                    texName = "icon_vehicle_person.png"
                    fillR = 0.0
                    fillG = 0.0
                    fillB = 1.0
                else
                    fillR, fillG, fillB = 1.0, 1.0, 1.0
                    textRGB = 0.0 -- black text on white background
                    texName = "icon_vehicle_stuff.png"
                    if ISVehicleMenu.moveItemsFromSeat(self.character, self.vehicle, seat-1, false, false) then
                        canSwitch = true
                    else

                    end
                end
                if mouseOver then
                    outlineR = 1.0
                    outlineG = 0.0
                    outlineB = 0.0
                end
            elseif self.vehicle:getPartForSeatContainer(seat-1) and
                    not self.vehicle:getPartForSeatContainer(seat-1):getInventoryItem() then
                texName = "icon_vehicle_uninstalled.png"
                fillR = 0.5
                fillG = 0.5
                fillB = 0.5
                if mouseOver then
                    outlineR = 1.0
                    outlineG = 0.0
                    outlineB = 0.0
                end
            else
                canSwitch = true
            end

            local seatRGB = 1.0
            if (playerSeat ~= -1) and (playerSeat ~= seat-1) and not self.vehicle:canSwitchSeat(playerSeat, seat - 1) then
                seatRGB = 0.5
                textRGB = textRGB * 0.5
            end

            local tex = getTexture("media/ui/vehicles/seatui/" .. texName)
            if tex then
                self:drawTextureScaled(tex, x, y, sizeX, sizeY, 1.0, seatRGB, seatRGB, seatRGB)
            else
                self:drawRect(x, y, sizeX, sizeY, 1.0, fillR, fillG, fillB)
                self:drawRectBorder(x, y, sizeX, sizeY, 1.0, 1.0, 1.0, 1.0)
            end

            if not shiftKey and canSwitch and not self.joyfocus then
                self:drawTextCentre(tostring(seat), x + sizeX / 2, y + sizeY / 2 - FONT_HGT_LARGE / 2, textRGB, textRGB, textRGB, 1, UIFont.Large)
            end

            if mouseOver then
                self:drawRectBorder(x - 2, y - 2, sizeX + 4, sizeY + 4, 1.0, outlineR, outlineG, outlineB)
            end

            if canSwitch and self.joyfocus and self.joypadSeat == seat then
                local tex = Joypad.Texture.AButton
                local texW,texH = tex:getWidth(),tex:getHeight()
                local x = self:getWidth() / 2 - offset:get(0) * scale - texW / 2
                local y = self:getHeight() / 2 - offset:get(2) * scale - texH / 2
                x = x + (SeatOffsetX[scriptName] or 0.0)
                y = y + (SeatOffsetY[scriptName] or 0.0)
                self:drawTextureScaledUniform(tex, x, y, 1, 1,1,1,1)
            end
        end

        -- Display available exits when inside.
        if playerSeat ~= -1 and not self.joyfocus then
            local canSwitch = self.vehicle:canSwitchSeat(playerSeat, seat - 1)
            if self.vehicle:isSeatOccupied(seat - 1) then
                canSwitch = false
                -- if you can't switch because of item we check you can still move them
                if not self.vehicle:getCharacter(seat-1) then
                    canSwitch = ISVehicleMenu.moveItemsFromSeat(self.character, self.vehicle, seat-1, false, false)
                end
            end
            if playerSeat == seat - 1 then canSwitch = true end
            self.vehicle:updateHasExtendOffsetForExit(self.character)
            if self.vehicle:isExitBlocked(self.character, seat - 1) then canSwitch = false end
            self.vehicle:updateHasExtendOffsetForExitEnd(self.character)
            posn = pngr:getPositionById("outside")
            if canSwitch and posn then
                local offset = posn:getOffset()
                local tex = getTexture("media/ui/vehicles/vehicle_exit.png")
                local texW,texH = tex:getWidthOrig(),tex:getHeightOrig()
                local x = self:getWidth() / 2 - offset:get(0) * scale - texW / 2
                local y = self:getHeight() / 2 - offset:get(2) * scale - texH / 2
                y = y + (SeatOffsetY[scriptName] or 0.0)

                local mouseOver = (self:getMouseX() >= x and self:getMouseX() < x + texW and
                        self:getMouseY() >= y and self:getMouseY() < y + texH) or
                        (self.joyfocus and self.joypadSeat == seat)
                if mouseOver then
                    self.mouseOverExit = seat - 1
                end

                if mouseOver or shiftKey then
                    self:drawTextureScaledUniform(tex, x, y, 1, 1,1,1,1)
                else
                    self:drawTextureScaledUniform(tex, x, y, 1, 0.2,1,1,1)
                end

                if shiftKey then
                    self:drawRect(x + texW / 2 - 8, y + texH / 2 - FONT_HGT_LARGE / 2, 16, FONT_HGT_LARGE, 1, 0.1, 0.1, 0.1)
                    self:drawTextCentre(tostring(seat), x + texW / 2, y + texH / 2 - FONT_HGT_LARGE / 2, 1, 1, 1, 1, UIFont.Large)
                end
            end
        end
        if playerSeat ~= -1 and self.joyfocus and seat == self.joypadSeat then
            local canSwitch = self.vehicle:canSwitchSeat(playerSeat, seat - 1)
            if self.vehicle:isSeatOccupied(seat - 1) then
                canSwitch = false
                -- if you can't switch because of item we check you can still move them
                if not self.vehicle:getCharacter(seat-1) then
                    canSwitch = ISVehicleMenu.moveItemsFromSeat(self.character, self.vehicle, seat-1, false, false)
                end
            end
            if playerSeat == seat - 1 then canSwitch = true end
            self.vehicle:updateHasExtendOffsetForExit(self.character)
            if self.vehicle:isExitBlocked(self.character, seat - 1) then canSwitch = false end
            self.vehicle:updateHasExtendOffsetForExitEnd(self.character)
            posn = pngr:getPositionById("outside")
            if canSwitch and posn then
                local offset = posn:getOffset()
                local tex = Joypad.Texture.XButton
                local texW,texH = tex:getWidthOrig(),tex:getHeightOrig()
                local x = self:getWidth() / 2 - offset:get(0) * scale - texW / 2
                local y = self:getHeight() / 2 - offset:get(2) * scale - texH / 2
                y = y + (SeatOffsetY[scriptName] or 0.0)
                self:drawTextureScaledUniform(tex, x, y, 1, 1,1,1,1)
            end
        end
    end

    -- TODO: Allow choosing a seat to exit from
end