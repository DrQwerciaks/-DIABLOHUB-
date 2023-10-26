for jobName in pairs(Config.Mechanics) do
	-- TriggerEvent('esx_society:registerSociety', jobName, 'Mechanik', 'society_' .. jobName, 'society_' .. jobName, 'society_' .. jobName, {type = 'private'})
	TriggerEvent('esx_society:registerSociety', 'mechanik', 'Mechanik', 'society_mechanik', 'society_mechanik', 'society_mechanik', {type = 'public'})
end

RegisterNetEvent("need_mechanics:loadStash", function()
    local _source = source
    exports.ox_inventory:RegisterStash(ESX.GetPlayerFromId(_source).job.name, ESX.GetPlayerFromId(_source).job.label, 50, 100000, false, false, vec3(-821.9, 3474.27, 159.18))
end)

RegisterNetEvent("need_mechanics:createLockpick", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem("lockpick_parts", 5)
	xPlayer.addInventoryItem("lockpick", 1)
end)

RegisterNetEvent('need_mechanics:giveitem', function(item)
  	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local hasJob = false

	for jobName in pairs(Config.Mechanics) do
		if jobName == xPlayer.job.name then
			hasJob = true
			break
		end
	end

	if hasJob then
		exports.ox_inventory:AddItem(_source, item, 1, nil, nil, function(success, reason)
			if not success then
				if reason == "inventory_full" then
					TriggerClientEvent('esx:showNotification', _source, "Brak miejsca w eq")
				end
			end
		end)
	end
end)

RegisterNetEvent("need_mechanics:RemoveFixKit", function()
	local _source = source
	exports.ox_inventory:RemoveItem(_source, 'fixkit', 1)
end)

ESX.RegisterServerCallback('need_mechanics:getMoney', function(source, cb, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getMoney() >= amount then
			xPlayer.removeMoney(amount)
			xPlayer.showNotification('Zapłciłeś $'..amount)
			cb(true)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)