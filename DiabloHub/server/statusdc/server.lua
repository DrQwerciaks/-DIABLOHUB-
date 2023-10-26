Citizen.CreateThread(function()
	while true do
		local xPlayers = ESX.GetPlayers()
		local EMSConnected = 0
		local PoliceConnected = 0
		local LSCMConnected = 0 

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])	
			if xPlayer.job.name == 'police' then
				PoliceConnected = PoliceConnected + 1
			end
			if xPlayer.job.name == 'ambulance' then
				EMSConnected = EMSConnected + 1
			end
			if xPlayer.job.name == 'mechanik' then
				LSCMConnected = LSCMConnected + 1
			end
			
		end
		
		TriggerClientEvent('top_discordpresence:frakcjeliczba', -1, PoliceConnected, EMSConnected, LSCMConnected, #xPlayers)
		Wait(1000*60)
	end
end)