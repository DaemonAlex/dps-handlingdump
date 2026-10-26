-- ONE-OFF DEV TOOL. /handlingdump (admin 'command' ace, same gate as dps-carmenu)
-- sends the vanilla model list to the caller; records come back in chunks and are
-- written to out/vanilla-handling.json inside this resource.
local RES = GetCurrentResourceName()
local session = nil   -- source of the player currently dumping
local records, missing = {}, {}

local function log(msg) print(('^3[handlingdump]^7 %s'):format(msg)) end

local function loadModels()
    local raw = LoadResourceFile(RES, 'data/models.json')
    if not raw then return nil end
    local ok, list = pcall(json.decode, raw)
    if not ok or type(list) ~= 'table' then return nil end
    return list
end

RegisterCommand('handlingdump', function(src)
    if src == 0 then log('run this from in game') return end
    if not IsPlayerAceAllowed(src, 'command') then return end
    if session then log(('already running for %s'):format(session)) return end
    local models = loadModels()
    if not models then log('data/models.json missing or invalid') return end
    session = src
    records, missing = {}, {}
    log(('started by %s (%d models)'):format(GetPlayerName(src), #models))
    TriggerClientEvent('dps-handlingdump:start', src, models)
end, true)

RegisterNetEvent('dps-handlingdump:chunk', function(batch, miss)
    local src = source
    if src ~= session then return end
    if type(batch) == 'table' then
        for model, rec in pairs(batch) do records[model] = rec end
    end
    if type(miss) == 'table' then
        for _, m in ipairs(miss) do missing[#missing + 1] = m end
    end
end)

RegisterNetEvent('dps-handlingdump:done', function(attempted)
    local src = source
    if src ~= session then return end
    local n = 0
    for _ in pairs(records) do n = n + 1 end
    local out = {
        generatedAt = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        gameBuild = GetConvarInt('sv_enforceGameBuild', 0),
        attempted = attempted,
        count = n,
        missing = missing,
        vehicles = records,
    }
    local ok = SaveResourceFile(RES, 'out/vanilla-handling.json', json.encode(out), -1)
    log(('finished: %d records, %d missing, attempted %s, saved=%s'):format(n, #missing, tostring(attempted), tostring(ok)))
    for _, m in ipairs(missing) do log(('  missing %s: %s'):format(m.model, m.reason)) end
    session = nil
end)
