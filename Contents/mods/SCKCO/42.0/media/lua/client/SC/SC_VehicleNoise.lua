-- media/lua/client/SCKCO_VehicleNoise.lua
-- Detects vehicle noise events (backfire lift-off, worn-exhaust cruise, engine start) from one
-- sampler and routes them through the shared server bus (SCKCO_VehicleNoiseServer.lua).
-- Single-player applies effects locally since there is no server loop to round-trip through.
local MODULE      = "SCKCO_Noise"
local SND_POP     = "SCKCO_Backfire"
local SAMPLE_MS   = 250    -- real-time gate: decel measured over wall-clock, not framerate
local COOLDOWN_MS = 1500   -- backfire-only: min gap between pops
local CRUISE_MS   = 1500   -- worn-exhaust re-ping cadence while driving

local C
local lastSpeed  = 0
local lastMs     = 0
local nextOkMs   = 0
local nextCruise = 0
local armed      = false   -- backfire edge trigger: one lift-off = one roll
local wasRunning = false   -- for off->on start detection

-- Diesel is compression-ignition: no exhaust afterfire, so backfire is suppressed for these.
-- Cruise/start noise still apply (a straight-piped diesel is loud). Stem substring covers camo
-- variants and the optional Base. prefix. M151A2 is gasoline and intentionally absent.
local DIESEL = {
    "SC_AMGeneralM35",   -- M35A2 multifuel
    "SC_AMGeneralM997",  -- HMMWV ambulance
    "SC_AMGeneralM998",  -- HMMWV
    "SC_AMGeneralM1025", -- HMMWV armament carrier
    "SC_AMGeneralM1097", -- HMMWV heavy troop carrier
    "SC_ChevroletM1008", -- CUCV pickup
    "SC_ChevroletM1009", -- CUCV Blazer
    "SC_ChevroletM1010", -- CUCV ambulance
}

local function isDiesel(name)
    for i = 1, #DIESEL do
        if string.find(name, DIESEL[i], 1, true) then return true end
    end
    return false
end

local function damagePart(vehicle, id, amount)
    if amount <= 0 then return end
    local part = vehicle:getPartById(id)
    if not part then return end
    local cond = part:getCondition() - amount
    part:setCondition(cond < 0 and 0 or cond)
end

-- radius <= 0 disables the effect. sound nil = zombie-draw only, no new audio.
local function dispatch(vehicle, x, y, z, muffDmg, engDmg, radius, sound)
    if radius <= 0 then return end
    if isClient() then
        sendClientCommand(getPlayer(), MODULE, "noise",
            { id = vehicle:getId(), muff = muffDmg, eng = engDmg, x = x, y = y, z = z, r = radius, sound = sound })
    else
        damagePart(vehicle, "Muffler", muffDmg)
        damagePart(vehicle, "Engine", engDmg)
        getWorldSoundManager():addSound(vehicle, x, y, z, radius, radius)
        if sound then vehicle:playSound(sound) end
    end
end

local function sample()
    local now = getTimestampMs()
    if now - lastMs < SAMPLE_MS then return end
    lastMs = now

    local player = getPlayer()
    if not player then return end

    local vehicle = player:getVehicle()
    if not vehicle then lastSpeed, armed, wasRunning = 0, false, false; return end
    if vehicle:getDriver() ~= player then return end

    local sq = vehicle:getSquare()
    if not sq then return end
    local x, y, z  = sq:getX(), sq:getY(), sq:getZ()
    local running  = vehicle:isEngineRunning()
    local eng      = vehicle:getPartById("Engine")
    local muff     = vehicle:getPartById("Muffler")
    local engWear  = eng  and (100 - eng:getCondition())  or 0
    local muffWear = muff and (100 - muff:getCondition()) or 0

    -- ENGINE START: off -> on. Louder with a worn engine. Diesels included.
    if running and not wasRunning then
        dispatch(vehicle, x, y, z, 0, 0, C.startRadius * (1 + engWear / 100), nil)
    end
    wasRunning = running

    if not running then lastSpeed, armed = 0, false; return end

    local prev  = lastSpeed
    local speed = vehicle:getCurrentSpeedKmHour()
    lastSpeed   = speed
    local decel = prev - speed

    -- re-arm once decel drops below half the trigger (hysteresis: prevents re-fire mid-brake)
    if decel < C.decelDrop * 0.5 then armed = true end

    -- BACKFIRE: spark-ignition only, cooldown-gated
    if not isDiesel(vehicle:getScriptName()) and now >= nextOkMs then
        local popRadius = C.noiseRadius * (1 + muffWear / 100) -- blown muffler carries further
        if armed and prev >= C.minSpeed and decel >= C.decelDrop then
            armed = false
            if ZombRand(100) < C.decelBase + engWear * C.wearScale then
                local sev = math.min(decel / C.decelDrop, 3)
                dispatch(vehicle, x, y, z, C.muffDmg * sev, C.engDmg, popRadius, SND_POP)
                nextOkMs = now + COOLDOWN_MS
            end
        -- sputter is a closed/steady-throttle event on a worn engine; never under acceleration
        elseif C.ambient and engWear >= C.sputterMinWear and speed <= prev
            and ZombRand(1000) < engWear * C.ambScale * 10 then
            dispatch(vehicle, x, y, z, C.muffDmg * 0.25, C.engDmg * 0.5, popRadius, SND_POP)
            nextOkMs = now + COOLDOWN_MS
        end
    end

    -- CRUISE: worn exhaust draws zombies while moving. Diesels included.
    if muffWear >= C.cruiseMinWear and speed >= C.minSpeed and now >= nextCruise then
        dispatch(vehicle, x, y, z, 0, 0, C.cruiseRadius * (muffWear / 100), nil)
        nextCruise = now + CRUISE_MS
    end
end

-- shared: play any broadcast noise that carried an audio id, at its source tile
local function onServerCommand(module, command, args)
    if module ~= MODULE or command ~= "play" then return end
    if not args.sound then return end
    if not getCell():getGridSquare(args.x, args.y, args.z) then return end
    getWorld():getFreeEmitter(args.x, args.y, args.z):playSound(args.sound)
end

local function start()
    local s = SandboxVars.SCKCO or {}
    C = {
        enabled       = s.BackfireEnabled ~= false,
        minSpeed      = s.BackfireMinSpeed      or 20,
        decelDrop     = s.BackfireDecelDrop     or 6,
        decelBase     = s.BackfireDecelChance   or 12,
        wearScale     = s.BackfireWearScale     or 0.25,
        ambient       = s.BackfireAmbient ~= false,
        ambScale      = s.BackfireAmbientScale  or 0.02,
        sputterMinWear= s.BackfireSputterMinWear or 50,
        muffDmg       = s.BackfireMufflerDamage or 3,
        engDmg        = s.BackfireEngineDamage  or 1,
        noiseRadius   = s.BackfireNoiseRadius   or 30,
        cruiseRadius  = s.CruiseNoiseRadius     or 25,
        cruiseMinWear = s.CruiseNoiseMinWear    or 40,
        startRadius   = s.StartNoiseRadius      or 20,
    }
    lastSpeed, lastMs, nextOkMs, nextCruise, armed, wasRunning = 0, 0, 0, 0, false, false
    if C.enabled then
        Events.OnTick.Add(sample)
        Events.OnServerCommand.Add(onServerCommand)
    end
end

Events.OnGameStart.Add(start)
