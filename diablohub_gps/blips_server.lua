

local blips = config.blip_types

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    for k, v in pairs(blips) do
        if not v.members then blips[k].members = { } end
    end
end) 

RegisterNetEvent('badBlips:server:registerPlayerBlipGroup')
AddEventHandler('badBlips:server:registerPlayerBlipGroup', function(source, group)
    local xPlayer = ESX.GetPlayerFromId(source)
    local userData = getPlayer(xPlayer.identifier)
    while userData == nil do
        Citizen.Wait(10)
    end
    if not blips[group] then
        blips[group] = { members = { } }
    end

    doDebug('Registering player blip group for source', source)
    blips[group].members[source] = { is_member = true, data = userData }
end)

RegisterNetEvent('need_gps:refreshGPS')
AddEventHandler('need_gps:refreshGPS', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    for blip_name, blip in pairs(blips) do
        for member_source, data in pairs(blip.members) do
            if source == member_source then
                blips[blip_name].members[source] = nil
            end
        end
    end
    local group = 'unknown'
    if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'mechanik' then
        group = xPlayer.job.name
    end

    if xPlayer ~= nil then
        TriggerEvent('badBlips:server:registerPlayerBlipGroup', source, group)
        TriggerClientEvent('esx:showNotification', _source, '~g~Uruchomiono GPS')
    end
end)

RegisterNetEvent('need_gps:destroyGPS')
AddEventHandler('need_gps:destroyGPS', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local gpsCount = xPlayer.getInventoryItem('gps').count

    if gpsCount > 0 then
        xPlayer.removeInventoryItem('gps', 1)
        TriggerClientEvent('esx:showNotification', _source, '~r~Zniszczono GPS')
    end
end)

RegisterNetEvent('badBlips:server:removePlayerBlipGroup')
AddEventHandler('badBlips:server:removePlayerBlipGroup', function(source, group)
    if blips[group].members[source] then
        doDebug('Unregistering player blip group for source', source)
        blips[group].members[source] = nil
    end
end)

RegisterNetEvent('badBlips:server:registerPlayerTempBlipGroup')
AddEventHandler('badBlips:server:registerPlayerTempBlipGroup', function(source, group, time)
    TriggerEvent('badBlips:server:registerPlayerBlipGroup', source, 'police')
    SetTimeout(time, function()
        TriggerEvent('badBlips:server:removePlayerBlipGroup', source, 'police')
    end)
end)


AddEventHandler('playerDropped', function()
    local source = source

    doDebug('Starting loop over groups', json.encode(blips))
    for blip_name, blip in pairs(blips) do
        for member_source, data in pairs(blip.members) do
            if source == member_source then
                blips[blip_name].members[source] = source
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(config.client_update_interval)

        for blip_name, blip in pairs(blips) do
            local blips_data = { }


            if blip._can_see then
                for _, can_see_group_name in pairs(blip._can_see) do
                    for source, data in pairs(blips[can_see_group_name].members) do
                        if data then
                            local ped = GetPlayerPed(source)
                            if DoesEntityExist(ped) then
                                local pos = GetEntityCoords(ped)
                                blips_data = appendBlipsPacket(blips_data, can_see_group_name, source, pos, blips[can_see_group_name].members[source].data)
                            end
                        end
                    end
                end
            end

            for source, data in pairs(blip.members) do
                if data then
                    local ped = GetPlayerPed(source)
                    if DoesEntityExist(ped) then
                        local pos = GetEntityCoords(ped)
                        blips_data = appendBlipsPacket(blips_data, blip_name, source, pos, blips[blip_name].members[source].data)
                    end
                end
            end

            Citizen.CreateThread(function()
                for source, is_valid_member in pairs(blip.members) do
                    if is_valid_member then
                        TriggerClientEvent('badBlips:client:syncMyBlips', source, blips_data, "Funkcjonariusz | ")
                        Citizen.Wait(100)
                    end
                end
            end)

            Citizen.Wait(config.wait_between_group_in_thread)
        end
    end
end)

function appendBlipsPacket(blips_data, blip_name, source, position, userData)
    doDebug('creating blip packet for source', blip_name, source)
    local x, y, z = table.unpack(position)
    local xPlayer = ESX.GetPlayerFromId(source)

    local blipLabel = xPlayer.getName()

    local playerJob = xPlayer.getJob()

    local odznaka = playerJob.odznaka or "BRAK"

    if playerJob.name == "police" then
        blipLabel = "LSPD |".." "..odznaka.." | "..blipLabel
    elseif playerJob.name == "ambulance" then
        blipLabel = "EMS |".." "..odznaka.." | "..blipLabel
    elseif playerJob.name == "mechanik" then
        blipLabel = "LSCM |".." "..odznaka.." | "..blipLabel
    end

    table.insert(blips_data, {
        x, -- [1]
        y, -- [2]
        z, -- [3]
        blip_name, -- [4]
        source, -- [5]
        plate, -- [6]
        blipLabel,
    })

    return blips_data
end

function getPlayer(identifier)
    local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]
        return {
            firstname = identity['firstname'],
            lastname = identity['lastname'],
        }
    else
        return {
            firstname = 'Brak',
            lastname = 'Brak',
       }
    end
end

function getID(_source, callback)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blipLabel = xPlayer.getName()
    local playerJob = xPlayer.getJob()

    local odznaka = playerJob.odznaka or "BRAK"

    blipLabel = "["..odznaka.."] "..blipLabel

    callback(blipLabel)
	-- MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
	-- {
	-- 	['@identifier'] = steamid
	-- }, function(result)
	-- 	if result[1] ~= nil then
	-- 		local data = {
	-- 			identifier	= identifier,
	-- 			firstname	= result[1]['firstname'],
	-- 			lastname	= result[1]['lastname'],

	-- 		}
			
	-- 		callback(data)
	-- 	else	
	-- 		local data = {
	-- 			identifier 	= '',
	-- 			firstname 	= '',
	-- 			lastname 	= ''
	-- 		}
			
	-- 		callback(data)
	-- 	end
	-- end)
end

function doDebug(...)
    if config.debug then
        print(...)
    end
end

AddEventHandler('need_gps:onAddInventoryItem', function(item, count)
    if item == 'gps' and count > 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local group = 'unknown'

        if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'mechanik' then
            group = xPlayer.job.name
        end

        if xPlayer ~= nil then
            TriggerEvent('badBlips:server:registerPlayerBlipGroup', source, group)
        end

        Citizen.Wait(500)
    end
end)

RegisterNetEvent('need_gps:onRemoveInventoryItem', function(item, count)
    local _source = source
    if item == 'gps' and count < 1 then
        local xPlayer = ESX.GetPlayerFromId(source)
        for blip_name, blip in pairs(blips) do
            for member_source, data in pairs(blip.members) do
                if source == member_source then
                    blips[blip_name].members[source] = nil
                end
            end
        end
        Citizen.Wait(500)

        if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
            local coords = xPlayer.getCoords(true)
            getID(_source, function(data)
                if data ~= nil then
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do
                        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                        local playerJob = xPlayer.getJob()

                        if playerJob.name == "police" or playerJob.name == "ambulance" then
                            TriggerClientEvent('need_gps:lostGPS', xPlayers[i], data, coords, hour)
                        end
                    end
                end
            end)
        end
    end
end)


ESX.RegisterUsableItem('gps', function(source)
	TriggerClientEvent('need_gps:openMenu', source)
	Citizen.Wait(100)
end)