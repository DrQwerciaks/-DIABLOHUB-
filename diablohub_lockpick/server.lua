
ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem('lockpick', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("welldone_lockpick:open", xPlayer.source)
end)

RegisterServerEvent('welldone_lockpick:add')
AddEventHandler('welldone_lockpick:add', function(source, item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	exports.ox_inventory:AddItem(_source, "lockpick", 1)
end)

RegisterServerEvent('welldone_lockpick:remove')
AddEventHandler('welldone_lockpick:remove', function(item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lockpick', 1)
	-- exports.ox_inventory:RemoveItem(_source, "lockpick", 1)
end)