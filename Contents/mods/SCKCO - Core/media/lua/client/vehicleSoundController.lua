local vehicleSoundController = {}

vehicleSoundController.library = {

    ["CUCVSoundPart"] = {---Not all params need-to or should-be defined

        { sound = "DetroitDieselIdle", --soundFile or soundScript
          speedNeeded = 0, --if abs(speed) < stop sound OR >= start sound
        },

       { sound = "TruckAirbrake", --soundFile or soundScript
         stop = true, --if true/present will stop sound
         speedNeeded = 0, --if abs(speed) < stop sound
       },

    }---

}


function vehicleSoundController.handleUpdate(player)
    if not player then return end
    local vehicle = player:getVehicle()
    if not vehicle then return end

    local vehicleEmitter = vehicle:getEmitter()
    local vehicleSpeed = math.abs(vehicle:getCurrentSpeedKmHour())

    for partID,soundSet in pairs(vehicleSoundController.library) do

        local part = vehicle:getPartById(partID)
        if part then

            for _,data in pairs(soundSet) do
                if data.sound then

                    local stopSpeedTriggered = data.speedNeeded and vehicleSpeed < data.speedNeeded

                    if data.stop or stopSpeedTriggered then
                        if vehicleEmitter:isPlaying(data.sound) then vehicleEmitter:stopSoundByName(data.sound) end
                        
                    elseif data.speedNeeded and vehicleSpeed >= data.speedNeeded then
                        if not vehicleEmitter:isPlaying(data.sound) then vehicleEmitter:playAmbientLoopedImpl(data.sound) end
                    end

                end
            end

        end
    end
end
Events.OnPlayerUpdate.Add(vehicleSoundController.handleUpdate)


return vehicleSoundController