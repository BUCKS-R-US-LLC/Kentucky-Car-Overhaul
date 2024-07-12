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


require "Vehicles/Vehicles"


local SCKCO_militaryEngineTexture = getTexture("media/ui/militaryIgnitionUI.png")
local ISVehicleDashboard_prerender = ISVehicleDashboard.prerender
function ISVehicleDashboard:prerender()
    if not self.vehicle or not ISUIHandler.allUIVisible then return end
    ISVehicleDashboard_prerender(self)

    local part = self.vehicle:getPartById("Engine")
    local partTable = part:getTable("partVariation")
    if partTable and partTable.militaryIgnition then
        self.ignitionTex.texture = SCKCO_militaryEngineTexture
        self.ignitionTex.mouseovertext = getText("Tooltip_MilitaryIgnition")
    end
end


---@param vehicle BaseVehicle
function Vehicles.Update.SCKCO_militaryEngine(vehicle, part, elapsedMinutes)
    if not vehicle:isHotwired() then
        local partTable = part:getTable("partVariation")
        if partTable and partTable.militaryIgnition then
            vehicle:setHotwired(true)
        end
    end
    Vehicles.Update.Engine(vehicle, part, elapsedMinutes)
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

    print("vehicleID: ",vehicleID," part:", part:getId(), " chance:",chance)

    if (not chance) or (chance and (ZombRand(0, 101) <= chance)) then

        local milIgn = partTable and partTable.militaryIgnition
        if milIgn then
            print(" --- --- milIgn")
            vehicle:setHotwired(true)
            --vehicle:setHotwiredBroken(true)
        end
        
        local additionalFunc = partTable.additionalVehicleFunc
        local addFunc = (additionalFunc and (Vehicles.Create[additionalFunc])) or Vehicles.Create.Default

        if addFunc then
            --print(" -- additionalFunc: ",additionalFunc)
            addFunc(vehicle, part)
        end
    end
end