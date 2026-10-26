-- ONE-OFF DEV TOOL. Spawns each vanilla vehicle locally (not networked), reads
-- its handling from the game, deletes it, and streams the records to the server.
local running = false
local CHUNK = 20
local LOAD_TIMEOUT_MS = 6000

local function log(msg) print(('[handlingdump] %s'):format(msg)) end

local function readVehicle(veh)
    return HandlingFields.readRecord(
        function(f) return GetVehicleHandlingFloat(veh, 'CHandlingData', f) end,
        function(f) return GetVehicleHandlingInt(veh, 'CHandlingData', f) end,
        function(f) return GetVehicleHandlingVector(veh, 'CHandlingData', f) end
    )
end

local function dumpOne(model, coords, heading)
    local hash = joaat(model)
    if not IsModelInCdimage(hash) or not IsModelAVehicle(hash) then
        return nil, 'not a vehicle model on this build'
    end
    RequestModel(hash)
    local deadline = GetGameTimer() + LOAD_TIMEOUT_MS
    while not HasModelLoaded(hash) do
        if GetGameTimer() > deadline then return nil, 'model load timeout' end
        Wait(0)
    end
    local veh = CreateVehicle(hash, coords.x, coords.y, coords.z + 1.0, heading, false, false)
    if not veh or veh == 0 or not DoesEntityExist(veh) then
        SetModelAsNoLongerNeeded(hash)
        return nil, 'CreateVehicle failed'
    end
    SetEntityAsMissionEntity(veh, true, true)
    FreezeEntityPosition(veh, true)
    Wait(0)
    local rec = readVehicle(veh)
    rec.class = GetVehicleClass(veh)
    rec.type = GetVehicleType and GetVehicleType(veh) or nil
    local ok, dispName = pcall(GetDisplayNameFromVehicleModel, hash)
    rec.displayName = ok and dispName or nil
    DeleteVehicle(veh)
    SetModelAsNoLongerNeeded(hash)
    return rec
end

RegisterNetEvent('dps-handlingdump:start', function(models)
    if running then log('already running') return end
    running = true
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped) + GetEntityForwardVector(ped) * 8.0
    local heading = GetEntityHeading(ped)
    log(('starting: %d models'):format(#models))

    local batch, missing, done = {}, {}, 0
    for i, model in ipairs(models) do
        local rec, err = dumpOne(model, coords, heading)
        if rec then
            batch[model] = rec
        else
            missing[#missing + 1] = { model = model, reason = err }
        end
        done = done + 1
        if done % CHUNK == 0 or i == #models then
            TriggerServerEvent('dps-handlingdump:chunk', batch, missing)
            batch, missing = {}, {}
        end
        if done % 50 == 0 then log(('%d / %d'):format(done, #models)) end
        Wait(50)
    end
    TriggerServerEvent('dps-handlingdump:done', done)
    log(('finished: %d models attempted'):format(done))
    running = false
end)
