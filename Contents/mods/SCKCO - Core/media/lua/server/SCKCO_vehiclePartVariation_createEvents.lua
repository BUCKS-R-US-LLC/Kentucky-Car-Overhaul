---part chance variation by Chuck

---This goes in the part script
--        table partVariation
--            {
--- chances are a list of vehicle IDs and a "default", vehicle IDs will supersede the "default" value
--- if no default is provided a value of 0 is used.
--                chances = {
--                    default = 0,
--                    SC_FordMustang = 50,
--                }
--- additionalVehicleFuncs will look for functions under `Vehicles.Create` if you need to call on those.
--- `Default` (Vehicles.Create.Default) is used if none are applied.
--                additionalVehicleFunc = Default
--            }
--
--		lua { create = Vehicles.Create.SCKCO_VehiclePartVariation, } }

require "Vehicles/Vehicles"

---@param vehicle BaseVehicle
---@param part VehiclePart
function Vehicles.Create.SCKCO_VehiclePartVariation(vehicle, part)

    local vehicleID = vehicle:getScriptName()

    local partTable = part:getTable("partVariation")
    if not partTable then print("ERROR: SCKCO(SCUCK) - No `partVariation` set for ",part:getId()) return end
    local chances = partTable.chances
    local chance = (chances and tonumber(chances[vehicleID] or chances["default"])) --or 0

    --print("vehicleID: ",vehicleID," chance:",chance)

    if chance and (ZombRand(0, 101) <= chance) then

        local additionalFunc = partTable.additionalVehicleFunc
        local addFunc = (additionalFunc and (Vehicles.Create[additionalFunc])) or Vehicles.Create.Default

        if addFunc then
            --print(" -- additionalFunc: ",additionalFunc)
            addFunc(vehicle, part)
        end
    end
end