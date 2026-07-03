-- media/lua/server/SCKCO_BackfireServer.lua
-- Authoritative side of the backfire: applies part damage, emits the world sound zombies path
-- toward, and broadcasts the audio to nearby clients. Driven by the driver client's "pop" command.
local MODULE = "SCKCO_Backfire"
local SOUND  = "SCKCO_Backfire"

local function getVehicleById(id)
    local cell = getCell()
    if not cell then return nil end
    local list = cell:getVehicles()
    for i = 0, list:size() - 1 do
        local v = list:get(i)
        if v:getId() == id then return v end
    end
    return nil
end

local function damagePart(vehicle, id, amount)
    if amount <= 0 then return end
    local part = vehicle:getPartById(id)
    if not part then return end
    local cond = part:getCondition() - amount
    part:setCondition(cond < 0 and 0 or cond)
end

local function onClientCommand(module, command, player, args)
    if module ~= MODULE or command ~= "pop" then return end

    local vehicle = getVehicleById(args.id)
    if vehicle then
        damagePart(vehicle, "Muffler", args.muff)
        damagePart(vehicle, "Engine", args.eng)
    end

    -- server-simulated zombies react to this
    getWorldSoundManager():addSound(vehicle, args.x, args.y, args.z, args.r, args.r)

    -- clients play the audio locally via OnServerCommand
    sendServerCommand(MODULE, "sound", { x = args.x, y = args.y, z = args.z })
end

Events.OnClientCommand.Add(onClientCommand)
