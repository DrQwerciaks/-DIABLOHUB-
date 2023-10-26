

local currentPed = nil
local loaded = false
local setped = true

RegisterNetEvent('Tomci0:SetPedToUser')
AddEventHandler('Tomci0:SetPedToUser', function(model)

	local ped = model
	local hash = GetHashKey(ped)

	RequestModel(hash)

	while not HasModelLoaded(hash) do 
		RequestModel(hash)
		Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), hash)
end)

function OpenPedMenu(currentLabel)

	if currentLabel == nil then
		currentLabel = 'Brak'
	end

	local elements = {
		{label = '| LUDZIE |', model = nil},
		{label = 'Młodziutki', model = 'Baby-102'},
		{label = 'Ped diabl', model = 'u_m_y_antonb'},
		{label = 'Młodziutki', model = 'baby-27'},
		{label = 'Młodziutki', model = 'Baby0096'},
		{label = 'Młodziutki', model = 'BabyLuizaG'},
		{label = 'Młodziutki', model = 'BabyFloraG'},
		{label = 'Pies', model = 'a_c_shepherd'},
		{label = '|----------------------------|', model = nil},
		{label = 'Wybierz: ' ..currentLabel, model = 'wybierz'},
		
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_menu', {
		title    = "Menu Pedów",
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.model == 'wybierz' then
			menu.close()
			TriggerServerEvent('Tomci0:SavePed', currentPed)
		else
			TriggerEvent('Tomci0:SetPedToUser', data.current.model)
			OpenPedMenu(data.current.label)
			currentPed = data.current.model
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('Tomci0:OpenPedMenu')
AddEventHandler('Tomci0:OpenPedMenu', function()
	OpenPedMenu(nil)
end)



AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent('Tomci0:CheckPed')
end)