local ThreatCode = "🟢"
local Players = {
    ["police"] = 0,
    ["ambulance"] = 0,
    ["mechanik"] = 0,
    ["fire"] = 0,

    ["players"] = GetNumPlayerIndices()
}

MySQL.ready(function()
    local data = MySQL.scalar.await("SELECT code_type FROM kod_zagrozenia", {})

    if data == 1 then
        ThreatCode = "🟢"
    elseif data == 2 then
        ThreatCode = "🟠"
    elseif data == 3 then
        ThreatCode = "🔴"
    elseif data == 4 then
        ThreatCode = "⚫"
    end
end)

RegisterNetEvent("woro-scoreboard:server:setCode", function(data)
    MySQL.update('UPDATE kod_zagrozenia SET code_type = ?', {data})

    if data == 1 then
        ThreatCode = "🟢"
    elseif data == 2 then
        ThreatCode = "🟠"
    elseif data == 3 then
        ThreatCode = "🔴"
    elseif data == 4 then
        ThreatCode = "⚫"
    end

    TriggerClientEvent("chat:addMessage", -1, { 
        template = '<div class="new_chat_template" style="background-color: rgba(0, 0, 0, 0.6); border-radius: 10px;"><div class="image" style="background-color: rgba(233, 66, 245, 0.5);"><i class="fas fa-house-user"></i></i></div><div class="args"><div class="title">[{0}] </div><div class="content"> {1} </div></div></div>',
        args = { "Uwaga Obywatele", "Poziom zagrożenia został zmieniony przez LSPD obserwuj gazety" }
    })
end)

RegisterNetEvent("esx:playerLoaded", function(playerId, xPlayer)
    Players["players"] = GetNumPlayerIndices()

    if Players[xPlayer.job.name] then
        local xPlayers = ESX.GetExtendedPlayers("job", xPlayer.job.name)
        Players[xPlayer.job.name] = #xPlayers
    end
end)

RegisterNetEvent("esx:playerDropped", function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)

    Wait(5000)

    if Players[xPlayer.job.name] then
        local xPlayers = ESX.GetExtendedPlayers("job", xPlayer.job.name)
        Players[xPlayer.job.name] = #xPlayers
    end

    Players["players"] = GetNumPlayerIndices()
end)

RegisterNetEvent("esx:setJob", function(playerId, job, lastjob)
    if Players[job.name] then
        local xPlayers = ESX.GetExtendedPlayers("job", job.name)
        Players[job.name] = #xPlayers
    end

    if Players[lastjob.name] then
        local xPlayers = ESX.GetExtendedPlayers("job", lastjob.name)
        Players[lastjob.name] = #xPlayers
    end
end)

ESX.RegisterServerCallback("need_scoreboard:get", function(source, cb)
    cb(Players, ThreatCode)
end)

ESX.RegisterServerCallback("esx_scoreboard:getConnectedCops", function(source, cb)
    cb(Players)
end)

RegisterNetEvent("need_scoreboard:show", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.group == "best" then
        return
    end
    TriggerClientEvent("need_scoreboard:show", -1, source, true)
end)

RegisterNetEvent("need_scoreboard:hide", function()
    local source = source
    TriggerClientEvent("need_scoreboard:show", -1, source, nil)
end)