local PlayerMultipier = {}

for k, v in pairs(Config.Rewards) do
    v.chance = 200 - v.chance
end

table.sort(Config.Baits, function (item1, item2)
    return item1.multiplier > item2.multiplier
end)

table.sort(Config.Rewards, function (item1, item2)
    return item1.chance < item2.chance
end)

ESX.RegisterUsableItem("fishingrod", function(source)
	TriggerClientEvent("realm_fishing:start", source)
end)

ESX.RegisterServerCallback("realm_fishing:canCatch", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    PlayerMultipier[source] = 0
    for k, v in pairs(Config.Baits) do
        local item = xPlayer.getInventoryItem(k)
        if item and item.count > 0 then
            PlayerMultipier[source] = v.multiplier
            break
        end
    end
    cb(PlayerMultipier[source] ~= 0)
end)

RegisterNetEvent("realm_fishing:catch", function()
    local _source = source
    if PlayerMultipier[_source] == 0 then
        return
    end

    local xPlayer = ESX.GetPlayerFromId(_source)
    local diabloToRandomNN = math.random(0, 150) * PlayerMultipier[_source]
    local reward = nil
    for k, v in pairs(Config.Rewards) do
        local hasitem = false
        if v.baits then
            for item, _ in pairs(v.baits) do
                local item = xPlayer.getInventoryItem(item)
                if item and item.count > 0 then
                    hasitem = item
                    break
                end
            end
        else
            hasitem = true
        end
        if hasitem and v.chance < diabloToRandomNN then
            reward = k
            if hasitem ~= true then
                exports.ox_inventory:RemoveItem(_source, hasitem, 1)
            end
            break
        end
    end
    if not reward then
        return
    end
    exports.ox_inventory:AddItem(_source, reward, 1)
end)

RegisterNetEvent("realm_fishing:break", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem("fishingrod", 1)
end)