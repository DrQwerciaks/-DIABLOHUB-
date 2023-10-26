ESX = exports["es_extended"]:getSharedObject()
local SearchTable = {}


ESX.RegisterUsableItem("handcuffs", function(source)
	TriggerClientEvent("esx_handcuffs:HandcuffsMenu", source)
end)

ESX.RegisterServerCallback("esx_handcuffs:checkItems", function(source, cb)
    cb(ESX.GetPlayerFromId(source).getInventoryItem("handcuffs").count)
end)

RegisterServerEvent("esx_handcuffs:cuff_uncuff")
AddEventHandler("esx_handcuffs:cuff_uncuff", function(id)
	if id == -1 then 
        return
    end
    local source = source
	TriggerClientEvent("esx_handcuffs:cuff_uncuff", id, source)
end)

RegisterServerEvent("esx_handcuffs:drag")
AddEventHandler("esx_handcuffs:drag", function(id)
    if id == -1 then 
        return
    end
	local source = source
	TriggerClientEvent("esx_handcuffs:drag", id, source)
end)

RegisterServerEvent("esx_handcuffs:stopanimka")
AddEventHandler("esx_handcuffs:stopanimka", function(id, value1, value2, value3)
    if id == -1 then 
        return
    end
	local source = source
	TriggerClientEvent("esx_handcuffs:stopanimka", id, source, value1, value2, value3)
end)

RegisterServerEvent("esx_handcuffs:put_in_vehicle")
AddEventHandler("esx_handcuffs:put_in_vehicle", function(id)
    if id == -1 then 
        return
    end
	local source = source
	TriggerClientEvent("esx_handcuffs:put_in_vehicle", id, source)
end)

RegisterServerEvent("esx_handcuffs:out_the_vehicle")
AddEventHandler("esx_handcuffs:out_the_vehicle", function(id)
    if id == -1 then 
        return
    end
	local source = source
	TriggerClientEvent("esx_handcuffs:out_the_vehicle", id, source)
end)

RegisterServerEvent("esx_handcuffs:UndressPlayerClothes")
AddEventHandler("esx_handcuffs:UndressPlayerClothes", function(id, value1, value2)
    if id == -1 then 
        return
    end
	local source = source
	TriggerClientEvent("esx_handcuffs:UndressPlayerClothes", id, source, value1, value2)
end)

RegisterServerEvent("esx_handcuffs:ProsbaOZgodeNaCiuchyLazenDevelopa")
AddEventHandler("esx_handcuffs:ProsbaOZgodeNaCiuchyLazenDevelopa", function(id, menu)
    if id == -1 then 
        return
    end
	local source = source
	TriggerClientEvent("esx_handcuffs:ProsbaOZgodeNaCiuchyLazenDevelopa", id, source, menu)
end)

RegisterServerEvent("esx_handcuffs:UndressPlayerClothesdsadhuasdgiys")
AddEventHandler("esx_handcuffs:UndressPlayerClothesdsadhuasdgiys", function(id, bool, menu)
    if id == -1 then 
        return
    end
	local source = source
	if bool then
		TriggerClientEvent("esx_handcuffs:UndressPlayerClothesdsadhuasdgiys", id, source, menu)
	else
		TriggerClientEvent("esx:showNotification", id, "~r~Twoja prośba nie została zaakceptowana")
	end
end)

RegisterServerEvent("esx_handcuffs:clothes")
AddEventHandler("esx_handcuffs:clothes", function(id)
    if id == -1 then 
        return
    end
	local source = source
	TriggerClientEvent("esx_handcuffs:clothes", id, source)
end)

RegisterServerEvent("esx_handcuffs:headbag")
AddEventHandler("esx_handcuffs:headbag", function(id)
    if id == -1 then 
        return
    end
	local xPlayer = ESX.GetPlayerFromId(source)
	local headbag = xPlayer.getInventoryItem("headbag")
	if headbag then
		if headbag.count > 0 then
			TriggerClientEvent("esx_handcuffs:headbag", id, source)
			TriggerClientEvent("esx:showNotification", source, "~r~Zakładasz worek dla ~p~"..id)
		else
			TriggerClientEvent("esx:showNotification", source, "~r~Nie masz worka przy sobie")
		end
	else
		TriggerClientEvent("esx:showNotification", source, "~r~Nie masz worka przy sobie")
	end
end)



ESX.RegisterServerCallback('esx_handcuffs:getPlayerSkinID', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(id)

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(users)
        local user = users[1]
        local skin = nil

        local jobSkin = {
            skin_male   = xPlayer.job.skin_male,
            skin_female = xPlayer.job.skin_female
        }

        if user.skin ~= nil then
            skin = json.decode(user.skin)
        end

		cb(skin, jobSkin)
	end)
end)

-- ESX.RegisterServerCallback('esx_policejob:checkSearch', function(source, cb, target)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     if SearchTable[target] ~= nil then
--         if SearchTable[target] == xPlayer.identifier then
--             cb(false)
--         else
--             cb(true)
--         end
--     else
--         cb(false)
--     end
-- end)
 
-- ESX.RegisterServerCallback('esx_policejob:checkSearch2', function(source, cb, target)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     if SearchTable[target] ~= nil then
--         if SearchTable[target] == xPlayer.identifier then
--             cb(true)
--         else
--             cb(false)
--         end
--     else
--         cb(true)
--     end
-- end)
 
-- RegisterServerEvent('esx_policejob:isSearching')
-- AddEventHandler('esx_policejob:isSearching', function(target, boolean)
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--     if boolean == nil then
--         SearchTable[target] = xPlayer.identifier
--     else
--         SearchTable[target] = nil
--     end
-- end)

