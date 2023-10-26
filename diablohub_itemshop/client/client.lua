-- Chuj wi kto to pisał pierwotnie ale jest spierdolony jak najebana ruska kurwa co go spłodziła GIGA DEVELOPA Z WAITRP stfu
-- Kurwo co mi więcej pracy daje
local staraTablica = ''
CreateThread(function()
    while not ESX.IsPlayerLoaded() do
        Wait(0)
    end
end)

local function RebuildInventory(inventory)
    local tabelka = {}

    for i=1, #inventory do

        tabelka[#tabelka + 1] = {
            item = inventory[i].item,
            amount = inventory[i].amount
        }
    end

    return tabelka
end

RegisterNetEvent('need_itemshop:client:openCase', function(data, data2, returnData, coooout)
    if data == nil or data2 == nil then
        return
    end
    returnData.inventory = RebuildInventory(returnData.inventory)
    Wait(100)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'toggle',
        data = data,
        data2 = data2,
        playerInfo = returnData,
        count = coooout
    })
end)

-- Command
RegisterCommand('sklep', function()
    ESX.TriggerServerCallback('need_itemshop:callback:openShop', function(data)


        data.inventory = RebuildInventory(data.inventory)
        Wait(100)
        SendNUIMessage({
            action = 'openShop',
            data = data
        })
        SetNuiFocus(true, true)
        exports['diablohub_hud']:SwitchHud({
            hudstatus = false,
        })
        -- TriggerScreenblurFadeIn(23213)
        
    end)
end)
-- RegisterKeyMapping('sklep', 'Jebać WaitRP', '')

-- Nuicallback
RegisterNUICallback('buyItem', function(data, cb)
    print(data.item, data.ilosc)
    ESX.TriggerServerCallback("need_itemshop:callback:buyItem", function(returnData)
        returnData.inventory = RebuildInventory(returnData.inventory)
        Wait(100)
        cb(returnData)
    end, data)
end)

RegisterNUICallback('changePhone', function(data, cback)
    local numberek = data.newNumber
    ESX.TriggerServerCallback("need_itemshop:callback:checkPhone", function(cb)
        if cb == 'change' then
            cback('success')
        else
            cback(cb)
        end
    end, numberek)
end)

RegisterNUICallback('zamknij', function()
    SetNuiFocus(false, false)
    exports['diablohub_hud']:SwitchHud({
        hudstatus = true,
    })
    TriggerScreenblurFadeOut(0)
end)

RegisterNUICallback('wylosowal', function(data, cb)
    TriggerServerEvent('need_itemshop:server:giveDrop', data)
end)

RegisterNUICallback('getItemInfo', function(data, cb)
    local tablica = tostring(data.tab)
    staraTablica = tablica
    ESX.TriggerServerCallback('need_itemshop:callback:checkIfPlayerIsOwner', function(isOwner)
        if isOwner then
            cb('owner')
        else
            cb("Nie jestes wlascicielem tego pojazdu")
            return
        end
    end, tablica)
end)

RegisterNUICallback('changerejka', function(data, cb)
    local nowaTablica = tostring(data.tabka)
    local vehicles = ESX.Game.GetVehicles()
    local found = false
    for _, vehicle in ipairs(vehicles) do
        local vehiclePlate = GetVehicleNumberPlateText(vehicle, true)
        if type(vehiclePlate) == 'string' then
            vehiclePlate = vehiclePlate:gsub("%s$", "")
            if vehiclePlate == plate then
                found = true
                break
            end
        end
    end
    if found == true then
        cb('Pojazd musi zostać schowany do garażu')
        return
    else
        ESX.TriggerServerCallback('need_itemshop:callback:isPlateTaken', function(isPlateTaken)
            if not isPlateTaken then
                TriggerServerEvent('need_itemshop:sever:updatePlate', staraTablica, nowaTablica)
                staraTablica = ''
                cb('zmieniono')
            else
                cb('Nie mozesz ustawić takiej tablicy')
                return
            end
        end, newTablica)
    end
end)

RegisterNUICallback('wymiencoin', function(data, cb)
    TriggerServerEvent('need_itemshop:server:changeCoin', data)
end)

RegisterNUICallback('useItem', function(data)
    local item = tostring(data.item)
    if item == 'numer' then
        newData = {
            item = item,
            nowyNumer = data.nowyNumer
        }
        TriggerServerEvent('waitrp_waitcoins:useItem', newData)
    else
        TriggerServerEvent('need_itemshop:server:useItem', item)
    end
end)
