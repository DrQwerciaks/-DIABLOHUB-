ESX.RegisterServerCallback('woro-lombard-sell:getitem', function(source, cb)
    local elements = {}
    for i=1, #Config.Lombard["sprzedaj"].Items, 1 do
        local item = Config.Lombard["sprzedaj"].Items[i]
        local _source = source
        local xPlayer  = ESX.GetPlayerFromId(_source)
        local oneQuantity = xPlayer.getInventoryItem(item.item).count

        if oneQuantity > 0 then
            table.insert(elements, {
                label      = item.label,
                item       = item.item,
                price      = item.price,
            })
        end
    end
    cb(elements)
end)

RegisterServerEvent('woro-lombard:sprzedaj')
AddEventHandler('woro-lombard:sprzedaj', function(item, label, cena)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local oneQuantity = xPlayer.getInventoryItem(item).count

    if oneQuantity > 0 then
        
        xPlayer.removeInventoryItem(item, 1)
        -- xPlayer.addMoney(cena)
        exports.ox_inventory:AddItem(_source, "money", cena, nil, nil)

        TriggerClientEvent('esx:showNotification', source, "Sprzedałeś "..label.." za "..cena)


    else
        TriggerClientEvent('esx:showNotification', source, "Nie masz "..label)
    end	


end)