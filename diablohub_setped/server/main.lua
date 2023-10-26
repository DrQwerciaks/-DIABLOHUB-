RegisterCommand('setped', function(source, args)
	local id = args[1]
	if source == 0 then
		
		if id then
			local tPlayer = ESX.GetPlayerFromId(id)

			if tPlayer ~= nil then
				TriggerClientEvent('Tomci0:OpenPedMenu', id)
			else
				xPlayer.showNotification('Nie ma takiego gracza!')
			end
		end
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		

		if xPlayer.group == 'moderator' or xPlayer.group == 'admin' or xPlayer.group == 'superadmin' then
			if id then
				local tPlayer = ESX.GetPlayerFromId(id)
	
				if tPlayer ~= nil then
					TriggerClientEvent('Tomci0:OpenPedMenu', id)
				else
					xPlayer.showNotification('Nie ma takiego gracza!')
				end
			else
				TriggerClientEvent('Tomci0:OpenPedMenu', source)
			end
		else
			xPlayer.showNotification('Nie posiadasz uprawnień!')
		end
	end
end)

RegisterNetEvent('Tomci0:SavePed')
AddEventHandler('Tomci0:SavePed', function(ped)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier

	local a = MySQL.Sync.fetchScalar("SELECT ped FROM user_pedy WHERE identifier = @identifier", {
		['@identifier'] = identifier,
	});

	if not a then
		MySQL.Async.insert('INSERT INTO user_pedy (identifier, ped) VALUES (@id, @ped)', {
			['@id'] = identifier,
			['@ped'] = ped
		}, function()
			print('[Tomci0-Pedy] Ustawiono peda ' ..ped.. ' dla gracza ' ..GetPlayerName(xPlayer.source))
		end)
	else
		MySQL.Async.execute('UPDATE user_pedy SET ped=@ped WHERE identifier=@id', {
			['@id'] = identifier,
			['@ped'] = ped
		}, function()
			print('[Tomci0-Pedy] Ustawiono peda ' ..ped.. ' dla gracza ' ..GetPlayerName(xPlayer.source))
		end)
	end
end)

RegisterNetEvent('Tomci0:CheckPed')
AddEventHandler('Tomci0:CheckPed', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier

	local a = MySQL.Sync.fetchScalar("SELECT ped FROM user_pedy WHERE identifier = @identifier", {
		['@identifier'] = identifier,
	});

	if a then 
		Wait(5000)
		TriggerClientEvent('Tomci0:SetPedToUser', _source, a)
	end
end)
