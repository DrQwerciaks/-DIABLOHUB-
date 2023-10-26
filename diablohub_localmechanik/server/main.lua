RegisterNetEvent("woro-ziutek:server:fixvehicle:pay", function(garageId)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()
    

    MySQL.Async.fetchAll('SELECT * FROM `user_licenses` WHERE type = "oc" AND owner = @identifier', { ['@identifier'] = identifier }, function(result)

        local price = Config.Garage[garageId].price

        if result[1] ~= nil then
            price = Config.Garage[garageId].ocPrice
        end

        if xPlayer.getAccount("money").money >= price then
            xPlayer.removeAccountMoney("money", price)
            TriggerClientEvent("woro-ziutek:client:fixvehicle", _source, garageId)
            -- xPlayer.showNotification("Zara ci naprawie")
        elseif xPlayer.getAccount("bank").money >= price then
            xPlayer.removeAccountMoney("bank", price)
            TriggerClientEvent("woro-ziutek:client:fixvehicle", _source, garageId)
            -- xPlayer.showNotification("Zara ci naprawie")
        else
            xPlayer.showNotification("Nie masz pieniędzy")
        end
    end)
end)