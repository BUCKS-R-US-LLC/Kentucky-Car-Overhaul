local vehicleSoundController = {}

vehicleSoundController.library = {

    ["AirBrakeSC"] = {

        { sound = "AirBrake",
          speedIsGreaterThan = 0,
          stopSound = true,
          stopWhenNotRunning = true,
        },
    },

    ["DetroitDieselSC"] = {

        { sound = "DetroitDieselIdle",
          speedIsGreaterThan = -1,
          stopWhenNotRunning = true,
        },
    }

}

function vehicleSoundController.handleUpdate(player)
    if not player then return end
    ---@type BaseVehicle
    local vehicle = player:getVehicle()
    if not vehicle then return end

    local vehicleEmitter = vehicle:getEmitter()
    local vehicleSpeed = vehicle:getCurrentSpeedKmHour()

    for partID,soundSet in pairs(vehicleSoundController.library) do

        local part = vehicle:getPartById(partID)
        if part then

            for _,data in pairs(soundSet) do
                if data.sound then

                    local bSpeedLessThan = data.speedIsLessThan and vehicleSpeed < data.speedIsLessThan
                    local bSpeedGreaterThan = data.speedIsGreaterThan and vehicleSpeed > data.speedIsGreaterThan
                    local invertedCase = data.speedIsLessThan and data.speedIsGreaterThan and data.speedIsLessThan > data.speedIsGreaterThan

                    local notValid = (invertedCase and (not bSpeedLessThan or not bSpeedGreaterThan)) or (not bSpeedLessThan and not bSpeedGreaterThan)
                    local stopWhenNotRunning = (data.stopWhenNotRunning and (not vehicle:isEngineRunning()))
                    local stopSound = data.stop or notValid or stopWhenNotRunning
                    
                    if stopSound then
                        if vehicleEmitter:isPlaying(data.sound) then vehicleEmitter:stopSoundByName(data.sound) end
                    else
                        if not vehicleEmitter:isPlaying(data.sound) then vehicleEmitter:playAmbientLoopedImpl(data.sound) end
                    end

                end
            end

        end
    end
end
Events.OnPlayerUpdate.Add(vehicleSoundController.handleUpdate)


return vehicleSoundController