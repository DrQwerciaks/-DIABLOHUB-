ESX.RegisterCommand('givecar', 'best', function(xPlayer, args, showError)
	TriggerClientEvent('esx_vehicleshop:client:givecar', args.playerId, args.vehicle, args.rejestracja)
	exports['diablohub_logs']:SendLog(xPlayer.source, "Użyto komendy /givecar " .. args.playerId .. " " .. args.vehicle .. " " .. args.rejestracja, "givecar")
end, true, {help = "Zjebek ju ar", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'number'},
	{name = 'vehicle', help = "Auto", type = 'string'},
	{name = 'rejestracja', help = "Rejestracja", type = 'string'}
}})