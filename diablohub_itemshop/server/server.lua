local items = {
    {item = 'casedaily', price = 0},
    {item = 'tablica', price = 200},
    {item = 'kartasim', price = 200},
    {item = 'skrzynia7', price = 500},
    {item = 'skrzynia2', price = 150},
}

local caseItems = {
    ['casedaily'] = {
        items = {
            {type = "money", drop = 50, name = "money", count = 1000, wymianacoin = 5, color = "darkturquoise", desc = "1000$", label = "Gotówka"},
            {type = "money", drop = 70, name = "money", count = 2500, wymianacoin = 10, color = "purple", desc = "5000$", label = "Gotówka"},
            {type = "money", drop = 80, name = "money", count = 5000, wymianacoin = 20, color = "red", desc = "10000$", label = "Gotówka"},
            {type = "item", drop = 81, name = "bon", count = 1, wymianacoin = 20, color = "gold", desc = "Kod rabatowy 20%", label = "Kod rabatowy"},
        }
    },
    ['skrzynia2'] = {
        items = {
            -- darkturquoise
            {type = "money", drop = 12, name = "money", count = 2000, wymianacoin = 5, color = "darkturquoise", desc = "2000$", label = "Gotówka"},
            {type = "item", drop = 24, name = "bandage", count = 3, wymianacoin = 5, color = "darkturquoise", desc = "Bandaże", label = "Przedmiot"},
            {type = "item", drop = 34, name = "radio", count = 1, wymianacoin = 5, color = "darkturquoise", desc = "Radio", label = "Przedmiot"},
            {type = "item", drop = 44, name = "fixkit", count = 1, wymianacoin = 5, color = "darkturquoise", desc = "Naprawka", label = "Przedmiot"},  
            {type = "item", drop = 54, name = "rope", count = 1, wymianacoin = 5, color = "darkturquoise", desc = "Lina", label = "Przedmiot"},   -- 54% ^_^
            -- deeppink
            {type = "money", drop = 59, name = "money", count = 4000, wymianacoin = 10, color = "deeppink", desc = "4000$", label = "Gotówka"},
            {type = "item", drop = 65, name = "ammo-9", count = 150, wymianacoin = 10, color = "deeppink", desc = "Amunicja X150", label = "Amunicja"},
            {type = "item", drop = 70, name = "weapon_switchblade", count = 1, wymianacoin = 10, color = "deeppink", desc = "Scyzoryk", label = "Broń Biała"},  
            {type = "item", drop = 75, name = "weapon_battleaxe", count = 1, wymianacoin = 10, color = "deeppink", desc = "Toporek", label = "Broń Biała"},   -- 21% ^_^
            -- purple
            {type = "money", drop = 79, name = "money", count = 8000, wymianacoin = 20, color = "purple", desc = "8000$", label = "Gotówka"},
            {type = "item", drop = 83, name = "ammo-9", count = 250, wymianacoin = 20, color = "purple", desc = "Amunicja X250", label = "Amunicja"},
            {type = "item", drop = 87, name = "handcuffs", count = 1, wymianacoin = 20, color = "purple", desc = "Kajdanki", label = "Amunicja"}, -- 12% ^_^
            -- red
            {type = "money", drop = 90, name = "money", count = 15000, wymianacoin = 30, color = "red", desc = "15000$", label = "Gotówka"},
            {type = "item", drop = 93, name = "weapon_stungun", count = 1, wymianacoin = 30, color = "red", desc = "Paralizator", label = "Broń"},
            {type = "item", drop = 95, name = "weapon_pistol", count = 1, wymianacoin = 30, color = "red", desc = "Pistolet", label = "Broń"}, --  9% ^_^
            -- gold
            {type = "item", drop = 98, name = "weapon_vintagepistol", count = 1, wymianacoin = 50, color = "gold", desc = "Pistolet", label = "Broń"},
            {type = "car", drop = 99, name = "komoda", count = 1, wymianacoin = 200, color = "gold", desc = "Komoda", label = "Samochód"},
            {type = "car", drop = 100, name = "zentorno", count = 1, wymianacoin = 200, color = "gold", desc = "Zentorno", label = "Samochód"}, -- 4% ^_^ 
        }
    },
    ['skrzynia7'] = {
        items = {
            -- darkturquoise
            {type = "money", drop = 1, name = "money", count = 4000, wymianacoin = 5, color = "darkturquoise", desc = "4000$", label = "Gotówka"},
            {type = "item", drop = 24, name = "bandage", count = 5, wymianacoin = 5, color = "darkturquoise", desc = "Bandaże", label = "Przedmiot"},
            {type = "item", drop = 34, name = "radio", count = 3, wymianacoin = 5, color = "darkturquoise", desc = "Radio", label = "Przedmiot"},
            {type = "item", drop = 44, name = "fixkit", count = 3, wymianacoin = 5, color = "darkturquoise", desc = "Naprawka", label = "Przedmiot"},  
            {type = "item", drop = 54, name = "rope", count = 3, wymianacoin = 5, color = "darkturquoise", desc = "Lina", label = "Przedmiot"},   
            -- -- deeppink
            {type = "money", drop = 59, name = "money", count = 7000, wymianacoin = 10, color = "deeppink", desc = "7000$", label = "Gotówka"},
            {type = "item", drop = 65, name = "ammo-9", count = 150, wymianacoin = 10, color = "deeppink", desc = "Amunicja X150", label = "Amunicja"},
            {type = "item", drop = 65, name = "medikit", count = 5, wymianacoin = 10, color = "deeppink", desc = "Apteczka", label = "Przedmiot"},
            {type = "item", drop = 70, name = "weapon_switchblade", count = 1, wymianacoin = 10, color = "deeppink", desc = "Scyzoryk", label = "Broń Biała"},  
            {type = "item", drop = 75, name = "weapon_battleaxe", count = 1, wymianacoin = 10, color = "deeppink", desc = "Toporek", label = "Broń Biała"},   -- 21% ^_^
            {type = "item", drop = 81, name = "bon", count = 1, wymianacoin = 20, color = "deeppink", desc = "Kod rabatowy 20%", label = "Kod rabatowy"},
            -- -- purple
            {type = "money", drop = 79, name = "money", count = 12000, wymianacoin = 20, color = "purple", desc = "12000$", label = "Gotówka"},
            {type = "item", drop = 83, name = "ammo-9", count = 250, wymianacoin = 20, color = "purple", desc = "Amunicja X250", label = "Amunicja"},
            {type = "item", drop = 87, name = "handcuffs", count = 3, wymianacoin = 20, color = "purple", desc = "Kajdanki", label = "Amunicja"}, -- 12% ^_^
            -- -- red
            {type = "money", drop = 90, name = "money", count = 15000, wymianacoin = 30, color = "red", desc = "15000$", label = "Gotówka"},
            {type = "item", drop = 93, name = "weapon_stungun", count = 1, wymianacoin = 30, color = "red", desc = "Paralizator", label = "Broń"},
            {type = "item", drop = 95, name = "weapon_pistol", count = 1, wymianacoin = 30, color = "red", desc = "Pistolet", label = "Broń"}, --  9% ^_^
            {type = "item", drop = 98, name = "weapon_vintagepistol", count = 1, wymianacoin = 50, color = "red", desc = "Pistolet", label = "Broń"},
            {type = "item", drop = 92, name = "weapon_combatpistol", count = 1, wymianacoin = 50, color = "red", desc = "Pistolet", label = "Broń"},
            -- -- gold
            {type = "car", drop = 99, name = "rs7abt", count = 1, wymianacoin = 200, color = "gold", desc = "Audi RS7", label = "Samochód"},
            {type = "car", drop = 98, name = "rmodgt63", count = 1, wymianacoin = 200, color = "gold", desc = "Mercedes AMG GT63", label = "Samochód"}, 
            {type = "car", drop = 100, name = "m2f22", count = 1, wymianacoin = 200, color = "gold", desc = "BMW M2F22", label = "Samochód"},
        }
    }
}


local SECONDS_IN_A_DAY = 60 * 60
local function parseDate (str)
  local y, m, d, H, M = string.match(str, "(%d+)-(%d+)-(%d+)-(%d+)-(%d+)")

  return os.time({year = y, month = m, day = d, hour = H, min = M})
end

local function getPlayetData(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    local inventory = {}

    for i=1, #items do
        local item = xPlayer.getInventoryItem(items[i].item)

        inventory[#inventory + 1] = {
            item = items[i].item,
            amount = item.count,
        }
        
    end 
    
    return {
        coins = 0,
        inventory = inventory,
        timeformat = 24
    }
end

ESX.RegisterServerCallback('need_itemshop:callback:openShop', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    local callback = getPlayetData(source)  
    local sql_done = false

    MySQL.query("SELECT coins, DATE_FORMAT(casetime, '%Y-%m-%d-%H-%i') casetime FROM `users` WHERE identifier = ?", 
    {
        xPlayer.getIdentifier(),
    },
    function(result)
        callback.coins = result[1].coins

        local d1 = parseDate(result[1].casetime)
        local d2 = parseDate(os.date('%Y-%m-%d-%H-%M'))

        -- print(d1, d2)

        local diff = math.ceil(os.difftime(d2, d1) / SECONDS_IN_A_DAY)


        if diff > 24 then
            diff = 0
        elseif diff == 0 then
            diff = 24
        elseif diff == 1 then
            diff = 23
        elseif diff == 2 then
            diff = 22
        elseif diff == 3 then
            diff = 21
        elseif diff == 4 then
            diff = 20
        elseif diff == 5 then
            diff = 19
        elseif diff == 6 then
            diff = 18        
        elseif diff == 7 then
            diff = 17        
        elseif diff == 8 then
            diff = 16        
        elseif diff == 9 then
            diff = 15        
        elseif diff == 10 then
            diff = 14
        elseif diff == 11 then
            diff = 13
        elseif diff == 12 then
            diff = 12
        elseif diff == 13 then
            diff = 11
        elseif diff == 14 then
            diff = 10
        elseif diff == 15 then
            diff = 9
        elseif diff == 16 then
            diff = 8
        elseif diff == 17 then
            diff = 7
        elseif diff == 18 then
            diff = 6
        elseif diff == 19 then
            diff = 5
        elseif diff == 20 then
            diff = 4
        elseif diff == 21 then
            diff = 3
        elseif diff == 22 then
            diff = 2
        elseif diff == 23 then
            diff = 1
        elseif diff == 24 then
            diff = 1
        end

        -- print(os.difftime(d2, d1), os.difftime(d2, d1) / )

        callback.timeformat = diff
        sql_done = true
    end) 
    while not sql_done do 
        Citizen.Wait(10)
    end

    cb(callback)
end)
ESX.RegisterServerCallback('need_itemshop:callback:checkPhone', function(source, cb, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    nowyNumer = tonumber(number)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE charinfo LIKE '%".. '"phone":' ..nowyNumer.."%' LIMIT 1", {}, function(result)
        if result and result[1] == nil then
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.identifier
            }, function(result2)
                if result2 and result2[1] ~= nil then
                    
                    
                    --TriggerClientEvent('esx:showNotification', _source, 'Numer telefonu został pomyślnie zmieniony na '..nowyNumer..'!')
                    cb('change')
                    local siuu = json.decode(result2[1].charinfo)
                    siuu.phone = nowyNumer
                    identifier = xPlayer.identifier

                    xPlayer.removeInventoryItem("kartasim", 1)

                    TriggerClientEvent('esx:showNotification', source, "Aktywowano kartę SIM: "..nowyNumer.." aby numer sie odświerzył wejdź ponownie na serwer")

                    Citizen.Wait(1000)
                    xPlayer.showNotification("Zostaniesz wyrzucony z servera za 5s!")
                    Citizen.Wait(1000)
                    xPlayer.showNotification("Zostaniesz wyrzucony z servera za 4s!")
                    Citizen.Wait(1000)
                    xPlayer.showNotification("Zostaniesz wyrzucony z servera za 3s!")
                    Citizen.Wait(1000)
                    xPlayer.showNotification("Zostaniesz wyrzucony z servera za 2s!")
                    Citizen.Wait(1000)
                    xPlayer.showNotification("Zostaniesz wyrzucony z servera za 1s!")
                    Citizen.Wait(1000)
                    TriggerClientEvent('qs-smartphone:RefreshContacts', _source)

                    DropPlayer(_source, "Numer został zmieniony, zapraszamy na server")

                    Citizen.Wait(2000)
                    MySQL.Async.execute("UPDATE `users` SET charinfo = @charinfo WHERE identifier = @identifier", {
                        ["@identifier"] = identifier,
                        ["@charinfo"] = json.encode(siuu)
                    })
                    


                else
                    cb('Nie można pobrać twojego numeru telefonu!')
                    --TriggerClientEvent('esx:showNotification', _source, 'ERROR: Nie można pobrać twojego numeru telefonu!')
                end
            end)
        else
            cb('Numer '..nowyNumer..' jest już zajęty!')
            --TriggerClientEvent('esx:showNotification', _source, 'Numer '..nowyNumer..' jest już zajęty!')
        end
    end)
end)

ESX.RegisterServerCallback('need_itemshop:callback:checkIfPlayerIsOwner', function (source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	MySQL.Async.fetchAll(
	'SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND owner_type = 1',
	{ 
		['@owner'] = identifier,
		['@plate'] = plate
	},
	function (result2)
		if result2[1] ~= nil then
			cb(true)
		else
			cb(false)
		end
	end
	)
end)

ESX.RegisterServerCallback('need_itemshop:callback:buyItem', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerCoins = 0

    local currentItem = data.item

    if data.item == 'casedaily' then
        local time = nil
        local sql_done = false

        MySQL.query("SELECT coins, DATE_FORMAT(casetime, '%Y-%m-%d-%H-%i') casetime FROM `users` WHERE identifier = ?", 
        {
            xPlayer.getIdentifier(),
        },
        function(result)
    
            local d1 = parseDate(result[1].casetime)
            local d2 = parseDate(os.date('%Y-%m-%d-%H-%M'))
    
            local diff = math.ceil(os.difftime(d2, d1) / SECONDS_IN_A_DAY)
    
            time = 1

            if diff > 24 then
                time = 0
            elseif diff < 24 then 
                time = 1
            end 
            
            playerCoins = result[1].coins

            sql_done = true
        end) 
        while not sql_done do 
            Citizen.Wait(10)
        end

        if time == 0 then
            MySQL.update('UPDATE `users` SET `casetime` = ? WHERE `identifier` = ?', {

				os.date('%Y-%m-%d %H:%M:00'),
                xPlayer.getIdentifier(),
			})
        else
            return
        end

    end

    local ExistItem = false
    local CurrentPrice
    for i=1, #items do
        if items[i].item == data.item then
            ExistItem = true
            CurrentPrice = items[i].price * data.ilosc
            break
        end
    end

    if ExistItem then
        local sql_done = false
        MySQL.query("SELECT coins FROM `users` WHERE identifier = ?", 
        {
            xPlayer.getIdentifier(),
        },
        function(result)
    
            if result[1].coins < CurrentPrice then
                return
            end

            MySQL.update('UPDATE `users` SET `coins` = ? WHERE `identifier` = ?', {
                result[1].coins - CurrentPrice,
                xPlayer.getIdentifier(),
            })

            playerCoins = result[1].coins - CurrentPrice
            sql_done = true
        end) 
        while not sql_done do 
            Citizen.Wait(10)
        end

        xPlayer.addInventoryItem(data.item, data.ilosc)
    end
    
    local callback = getPlayetData(source)
    callback.coins = playerCoins
    cb(callback)
end)



local currentCase = {}
local random = {}
local function DropRandomitem(item)
    local randomNum = math.random(1, 100)
    local dropItem = 1
    for i=1, #item do
        if item[i].drop <= randomNum then
            dropItem = i
        end
    end 
    Citizen.Wait(50)

    return dropItem
end
RegisterNetEvent('need_itemshop:server:useItem', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.removeInventoryItem(item, 1)

    currentCase[_source] = item
    random[_source] = DropRandomitem(caseItems[item].items)



    local playerData = getPlayetData(_source)
    local sql_done = false

    MySQL.query("SELECT coins, DATE_FORMAT(casetime, '%Y-%m-%d-%H-%i') casetime FROM `users` WHERE identifier = ?", 
    {
        xPlayer.getIdentifier(),
    },
    function(result)
        playerData.coins = result[1].coins

        local d1 = parseDate(result[1].casetime)
        local d2 = parseDate(os.date('%Y-%m-%d-%H-%M'))

        -- print(d1, d2)

        local diff = math.ceil(os.difftime(d2, d1) / SECONDS_IN_A_DAY)


        if diff > 24 then
            diff = 0
        elseif diff == 0 then
            diff = 24
        elseif diff == 1 then
            diff = 23
        elseif diff == 2 then
            diff = 22
        elseif diff == 3 then
            diff = 21
        elseif diff == 4 then
            diff = 20
        elseif diff == 5 then
            diff = 19
        elseif diff == 6 then
            diff = 18        
        elseif diff == 7 then
            diff = 17        
        elseif diff == 8 then
            diff = 16        
        elseif diff == 9 then
            diff = 15        
        elseif diff == 10 then
            diff = 14
        elseif diff == 11 then
            diff = 13
        elseif diff == 12 then
            diff = 12
        elseif diff == 13 then
            diff = 11
        elseif diff == 14 then
            diff = 10
        elseif diff == 15 then
            diff = 9
        elseif diff == 16 then
            diff = 8
        elseif diff == 17 then
            diff = 7
        elseif diff == 18 then
            diff = 6
        elseif diff == 19 then
            diff = 5
        elseif diff == 20 then
            diff = 4
        elseif diff == 21 then
            diff = 3
        elseif diff == 22 then
            diff = 2
        elseif diff == 23 then
            diff = 1
        elseif diff == 24 then
            diff = 1
        end

        -- print(os.difftime(d2, d1), os.difftime(d2, d1) / )

        playerData.timeformat = diff
        sql_done = true
    end) 
    while not sql_done do 
        Citizen.Wait(10)
    end

    TriggerClientEvent('need_itemshop:client:openCase', _source, caseItems[item].items, random[_source], playerData, 1)
end)

RegisterNetEvent('need_itemshop:server:giveDrop', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)

    if currentCase[source] == nil then
        return
    end
    if random[source] == nil then
        return
    end

    -- print(caseItems[currentCase[source]].items[random[source]].type)
    if caseItems[currentCase[source]].items[random[source]].type == "money" then
        xPlayer.addAccountMoney("money", caseItems[currentCase[source]].items[random[source]].count)
    elseif caseItems[currentCase[source]].items[random[source]].type == "item" then
        -- print(caseItems[currentCase[source]].items[random[source]].item, caseItems[currentCase[source]].items[random[source]].count)
        xPlayer.addInventoryItem(caseItems[currentCase[source]].items[random[source]].name, caseItems[currentCase[source]].items[random[source]].count)
    elseif caseItems[currentCase[source]].items[random[source]].type == "car" then
        -- xPlayer.addInventoryItem(caseItems[currentCase].items[random].item, caseItems[currentCase].items[random].count)
        TriggerClientEvent('esx_vehicleshop:client:givecar', source, caseItems[currentCase[source]].items[random[source]].name)
    end

    currentCase[source] = nil
    random[source] = nil
end)

RegisterNetEvent('need_itemshop:server:changeCoin', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if currentCase[_source] == nil then
        return
    end
    if random[_source] == nil then
        return
    end

    MySQL.query("SELECT coins FROM `users` WHERE identifier = ?", 
    {
        xPlayer.getIdentifier(),
    },
    function(result)

        MySQL.update('UPDATE `users` SET `coins` = ? WHERE `identifier` = ?', {
            result[1].coins + caseItems[currentCase[_source]].items[random[_source]].wymianacoin,
            xPlayer.getIdentifier(),
        })
        
        
        currentCase[_source] = nil
        random[_source] = nil
    end)
end)


RegisterNetEvent('need_itemshop:sever:updatePlate', function(staraTablica, nowaTablica)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local item = xPlayer.getInventoryItem('tablice')

    if nowaTablica.len(nowaTablica) > 8 then
        return
    end

    if item.count >= 1 then
        xPlayer.removeInventoryItem("tablice", 1)

        MySQL.Async.fetchAll(
        'SELECT plate, vehicle FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND owner_type = 1',
        { 
            ['@owner'] = xPlayer.getIdentifier(),
            ['@plate'] = staraTablica
        },
        function (result2)
            if result2[1] ~= nil then

                local jsonTable = json.decode(result2[1].vehicle)
                jsonTable.plate = nowaTablica
                
                

                MySQL.update('UPDATE owned_vehicles SET plate = ?, vehicle = ? WHERE owner = ? AND plate = ?', {
                    nowaTablica,
                    json.encode(jsonTable),
                    xPlayer.getIdentifier(),
                    staraTablica,
                }) 
            end
        end
        )
    end

end)




RegisterCommand("setcoins", function(source, args, rawCommand)
    if source ~= 0 then
        return
    end

    local xPlayer = ESX.GetPlayerFromId(args[1])

    local coins = tonumber(args[2])

    MySQL.query("SELECT coins FROM `users` WHERE identifier = ?", 
    {
        xPlayer.getIdentifier(),
    },
    function(result)

        MySQL.update('UPDATE `users` SET `coins` = ? WHERE `identifier` = ?', {
            result[1].coins + coins,
            xPlayer.getIdentifier(),
        })
    end)

end, true)




ESX.RegisterServerCallback('need_itemshop:callback:isPlateTaken', function (source, cb, plate)
    exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        cb(result[1] ~= nil)
    end)
end)

