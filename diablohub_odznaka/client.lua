RegisterNetEvent('need_odznaka:showOdznaka', function(id, imie, nazwisko, stopien)
    local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
        SendNUIMessage({
            action = 'showODZ',
            imie = imie or "Brak",
            nazwisko = nazwisko or "Brak",
            stopien = stopien or "Nieznany",
        })
	elseif #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(pid))) < 7.5 and NetworkIsPlayerActive(pid) then
        SendNUIMessage({
            action = 'showODZ',
            imie = imie or "Brak",
            nazwisko = nazwisko or "Brak",
            stopien = stopien or "Nieznany",
        })
	end
end)