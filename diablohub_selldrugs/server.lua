local Peds = {}
local CanSell = {}

RegisterNetEvent("need_selldrugs:trySell", function(netId)
    Entity(NetworkGetEntityFromNetworkId(netId)).state:set('drugSell', true, true)
    local _source = source

    CanSell[_source] = true
    TriggerClientEvent("need_selldrugs:sell", _source, netId, 5000, math.random(0, 1) > 0)
end)

RegisterNetEvent("need_selldrugs:sell", function(netId)
    local _source = source
    local search = exports.ox_inventory:Search(_source, 'count', Config.ItemsToSell)
    local itemToSell = nil
    local itemCountToSell = nil
    for k,v in pairs(search) do
        if v > 0 then
            itemToSell = k
            itemCountToSell = math.random(1, 4)
            break
        end
    end

    if CanSell[_source] and itemToSell ~= nil and itemCountToSell ~= nil then
        exports.ox_inventory:RemoveItem(_source, itemToSell, itemCountToSell)
        CanSell[_source] = nil
    end

    local itemConfig = Config.Drugs[itemToSell]
    if itemConfig ~= nil then
        local moneyZa1 = math.random(itemConfig.min, itemConfig.max)
        local money = moneyZa1 * itemCountToSell
        exports.ox_inventory:AddItem(_source, "money", money, nil, nil)
        exports['diablohub_logs']:SendLog(_source, '```'..GetPlayerName(_source)..' sprzedał '..itemToSell..' w ilość x'..itemCountToSell..' za $'..money..'```', 'nowe-selldrugs')
    end
end)

RegisterNetEvent("need_selldrugs:setBlip", function(coords)
    local _source = source
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
      local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

      if xPlayer.getJob().name == "police" then
        TriggerClientEvent('need_selldrugs:setBlip', xPlayers[i], _source, coords, os.date("%H:%M"))
print("1")
      end
    
    end

    -- for k,v in pairs(xPlayers) do
    --     if v.job == 'police' then
    --         print("Chuj")
    --         TriggerClientEvent('need_selldrugs:setBlip', v.id, coords)
    --     end
    -- end
end)