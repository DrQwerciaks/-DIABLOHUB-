ESX.RegisterUsableItem("radio", function(source)
    TriggerClientEvent("need_radio:open", source)
end)

ESX.RegisterServerCallback("need_radio:GetUsersData", function(source, cb, channel)
    local elements = {}
    local players = exports['pma-voice']:getPlayersInRadioChannel(channel)
    for player, active in pairs(players) do
        print("x")
        local xTarget = ESX.GetPlayerFromId(player)
        local data = {
            active = active,
            label = "[" .. (xTarget.job.odznaka or "BRAK") .. "] " .. xTarget.get("firstName") .. " " .. xTarget.get("lastName")
        }
        elements[player] = data
    end

    Wait(500)

    cb(elements)
end)

ESX.RegisterServerCallback("need_radio:GetUserData", function(source, cb, player)
    local xTarget = ESX.GetPlayerFromId(player)
    local data = {
        active = false,
        label = "[" .. (xTarget.job.odznaka or "BRAK") .. "] " .. xTarget.get("firstName") .. " " .. xTarget.get("lastName")
    }
    cb(data)
end)