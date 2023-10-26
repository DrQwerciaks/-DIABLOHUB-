
local TakenKeys, zacmienie, keys = {}, {}, {}

ESX.RegisterServerCallback('Akira-Base:callback:checkOwner', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plate = string.lower(plate)
    local src = source
    local hasOwner = false

    local taken = false

    for i,v in pairs(TakenKeys) do
        if i == plate then
            taken = true
            break
        end
    end


    if not taken then
        local result = MySQL.Sync.fetchScalar('SELECT plate FROM owned_vehicles WHERE plate = @plate', {
            ['plate'] = plate
        })

        if result then
            taken = true
        end
    end

    cb(taken)
end)

RegisterNetEvent('Akira-Base:server:LockKey', function(plate)
    TakenKeys[plate] = 'locked'
end)

RegisterNetEvent('Akira-Base:server:RestoreCarKeys', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('Akira-Base:client:SendKeys', xPlayer.source, keys[xPlayer.identifier])
end)

RegisterNetEvent('Akira-Base:server:AddKey', function(plate, target)
    if target ~= nil then
        xPlayer = ESX.GetPlayerFromId(target)
    else  
        xPlayer = ESX.GetPlayerFromId(source)
    end

    if keys[xPlayer.identifier] == nil then
        keys[xPlayer.identifier] = {}
    end

    keys[xPlayer.identifier][plate] = true
    TakenKeys[plate] = true

    TriggerClientEvent('Akira-Base:client:SendKeys', xPlayer.source, keys[xPlayer.identifier])
    TriggerEvent("esx:giveInventoryItem", xPlayer.source, keys[xPlayer.identifier], 'iron', 1) 
    xPlayer.showNotification('Twój kluczyk do pojazdu o Nr. Rej ' ..plate.. ' został dodany!')
end)

RegisterNetEvent('Akira-Base:server:RemoveKey', function(plate, target)
    if target ~= nil then
        xPlayer = ESX.GetPlayerFromId(target)
    else  
        xPlayer = ESX.GetPlayerFromId(source)
    end

    keys[xPlayer.identifier][plate] = nil
    --TriggerClientEvent('inventory:refresh')
    xPlayer.showNotification('Twój kluczyk do pojazdu o Nr. Rej ' ..plate.. ' został usunięty!')
    TriggerClientEvent('Akira-Base:client:SendKeys', xPlayer.source, keys[xPlayer.identifier])
end)

function GetPlayerCarKeys(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if keys[xPlayer.identifier] then
        return keys[xPlayer.identifier]
    else
        return {}
    end
end

function GiveOtherPlayerPlayer(src, player2, plate)
    local xPlayer = ESX.GetPlayerFromId(src)
    local xPlayer2 = ESX.GetPlayerFromId(player2)
    if not xPlayer or not xPlayer2 then return end
    if keys[xPlayer.identifier] then
        if keys[xPlayer.identifier][plate] then
            keys[xPlayer.identifier][plate] = nil
            if not keys[xPlayer2.identifier] then
                keys[xPlayer2.identifier] = {}
            end
            keys[xPlayer2.identifier][plate] = true
        end
    end

    TriggerClientEvent('Akira-Base:client:SendKeys', xPlayer.source, keys[xPlayer.identifier])
    TriggerClientEvent('Akira-Base:client:SendKeys', xPlayer2.source, keys[xPlayer2.identifier])
end 

function SetPlayerKeys(src, plate, value)
    local xPlayer = ESX.GetPlayerFromId(src)
    keys[xPlayer.identifier][plate] = value
    TriggerClientEvent('Akira-Base:client:SendKeys', xPlayer.source, keys[xPlayer.identifier])
end

exports('GetPlayerCarKeys', GetPlayerCarKeys)
exports('GiveOtherPlayerPlayer', GiveOtherPlayerPlayer)
exports('SetPlayerKeys', SetPlayerKeys)