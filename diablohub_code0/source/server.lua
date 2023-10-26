ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('panicbutton:on') 
AddEventHandler('panicbutton:on', function(kords)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = "["..xPlayer.getJob().odznaka.."] "..xPlayer.getName()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('panicbutton:on', xPlayers[i], _source, kords, name)
        end
    end
end)

ESX.RegisterServerCallback("Panicbutton:sprawdz", function(source, cb)
    cb(ESX.GetPlayerFromId(source).getInventoryItem("panicbutton").count)
end)

