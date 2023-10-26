RegisterNetEvent("need_odznaka:odznaka", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == "police" then
		local imie = xPlayer.get("firstName")
		local nazwisko = xPlayer.get("lastName")
		local stopien = xPlayer.job.grade_label
		TriggerClientEvent('need_odznaka:showOdznaka', -1, _source, imie, nazwisko, stopien)
	end
end)
