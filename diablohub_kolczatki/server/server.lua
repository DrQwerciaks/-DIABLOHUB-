ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem('kolczatka', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('kolczatka', 1)
   xPlayer.triggerEvent('krs:postawkolczatke')
end)

RegisterServerEvent('krs:zbierzkolczatke', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xxx = math.random(1, 2)
    if xxx == 1 then
        xPlayer.triggerEvent('krs:usunkolczatke')
        Wait(4000)
        xPlayer.addInventoryItem('kolczatka', 1)
        xPlayer.showNotification('Zebrałes kolczatke')
        xPlayer.triggerEvent('krs:usunkolczatke')
    else
        if xxx == 2 then
            xPlayer.triggerEvent('krs:usunkolczatke')
            Wait(4000)
            xPlayer.showNotification('Kolczatka rozwaliła się podczas zbioru')
        end
    end
end)
