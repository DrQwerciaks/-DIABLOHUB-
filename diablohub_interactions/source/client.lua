ESX = exports["es_extended"]:getSharedObject()

isDead = false
timeLeft = nil
lastSkin = {}
updatedSkin = {}
newSkin = {}
Handcuffs = {
    Dragged = {
        IsDragged = false,
        AttachedPed = nil
    },
    Prop = {
        Handcuffs = nil,
        Knebel = nil
    }
}
clearSkinMale = {
    ['tshirt_1'] = 15,
    ['tshirt_2'] = 0,
    ['torso_1'] = 15,
    ['torso_2'] = 0,
    ['chain_1'] = 0,
    ['chain_2'] = 0,
    ['arms'] = 15,
    ['arms_2'] = 0,
    ['pants_1'] = 61,
    ['pants_2'] = 0,
    ['shoes_1'] = 34,
    ['shoes_2'] = 0,
    ['helmet_1'] = -1,
    ['helmet_2'] = 0,
    ['ears_1'] = -1,
    ['ears_2'] = 0,
    ['mask_1'] = 0,
    ['mask_2'] = 0,
    ['bproof_1'] = 0,
    ['bproof_2'] = 0,
    ['glasses_1'] = 0,
    ['glasses_2'] = 0,
    ['bags_1'] = 0,
    ['bags_2'] = 0,
    ['watches_1'] = -1,
    ['watches_2'] = 0,
    ['bracelets_1'] = -1,
    ['bracelets_2'] = 0,
    ['decals_1'] = 0,
    ['decals_2'] = 0,
    ["hair_1"] = 0,
    ['hair_2'] = 0
}
clearSkinFemale = {
    ['tshirt_1'] = 14,
    ['tshirt_2'] = 0,
    ['torso_1'] = 15,
    ['torso_2'] = 0,
    ['chain_1'] = 0,
    ['chain_2'] = 0,
    ['arms'] = 15,
    ['arms_2'] = 0,
    ['pants_1'] = 15,
    ['pants_2'] = 0,
    ['shoes_1'] = 35,
    ['shoes_2'] = 0,
    ['helmet_1'] = -1,
    ['helmet_2'] = 0,
    ['ears_1'] = -1,
    ['ears_2'] = 0,
    ['mask_1'] = 0,
    ['mask_2'] = 0,
    ['bproof_1'] = 0,
    ['bproof_2'] = 0,
    ['glasses_1'] = 5,
    ['glasses_2'] = 0,
    ['bags_1'] = 0,
    ['bags_2'] = 0,
    ['watches_1'] = -1,
    ['watches_2'] = 0,
    ['bracelets_1'] = -1,
    ['bracelets_2'] = 0,
    ['decals_1'] = 0,
    ['decals_2'] = 0,
    ["hair_1"] = 0,
    ['hair_2'] = 0
}
newSkinMale = {
	['tshirt_1'] = 15, ['tshirt_2'] = 0,
	['torso_1'] = 15,   ['torso_2'] = 0,
	['pants_1'] = 61,   ['pants_2'] = 1,
	['shoes_1'] = 34,  ['shoes_2'] = 0,
	['bags_1'] = 0,  ['bags_2'] = 0,
	['decals_1'] = 0, ['decals_2'] = 0,
	['mask_1'] = 0, ['mask_2'] = 0,
	['bproof_1'] = 0, ['bproof_2'] = 0,
	['chain_1'] = 0, ['chain_2'] = 0,
	['helmet_1'] = -1, ['helmet_2'] = 0,
	['glasses_1'] = 0, ['glasses_2'] = 0,
	['arms'] = 15
}
newSkinFemale = {
	['tshirt_1'] = 15, ['tshirt_2'] = 0,
	['torso_1'] = 15,   ['torso_2'] = 0,
	['pants_1'] = 61,   ['pants_2'] = 1,
	['shoes_1'] = 34,  ['shoes_2'] = 0,
	['bags_1'] = 0,  ['bags_2'] = 0,
	['decals_1'] = 0, ['decals_2'] = 0,
	['mask_1'] = 0, ['mask_2'] = 0,
	['bproof_1'] = 0, ['bproof_2'] = 0,
	['chain_1'] = 0, ['chain_2'] = 0,
	['helmet_1'] = -1, ['helmet_2'] = 0,
	['glasses_1'] = 0, ['glasses_2'] = 0,
	['arms'] = 15
}

Citizen.CreateThread(function()
	LocalPlayer.state:set('IsHandcuffed', false, true)
	LocalPlayer.state:set('Headbag', false, true)

    RequestAnimDict('rcmme_amanda1')
	while not HasAnimDictLoaded('rcmme_amanda1') do
		Citizen.Wait(0)
	end

    RequestAnimDict('mp_arresting')
	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(0)
	end

    RequestAnimDict('missfinale_c2mcs_1')
	while not HasAnimDictLoaded('missfinale_c2mcs_1') do
		Citizen.Wait(0)
	end

	RequestAnimDict('nm')
	while not HasAnimDictLoaded('nm') do
		Citizen.Wait(0)
	end
end)

AddEventHandler('playerSpawned', function() 
	isDead = false

	LocalPlayer.state:set('IsHandcuffed', false, true)
	LocalPlayer.state:set('IsDragged', false, true)
    local Player = {
        Ped = PlayerPedId(),
    }
	if IsEntityPlayingAnim(Player.Ped, 'rcmme_amanda1', 'stand_loop_ama', 3) then
		StopAnimTask(Player.Ped, 'rcmme_amanda1', 'stand_loop_ama', 1.0)
	elseif IsEntityPlayingAnim(Player.Ped, 'mp_arresting', 'idle', 3) then
		StopAnimTask(Player.Ped, 'mp_arresting', 'idle', 1.0)
	elseif IsEntityPlayingAnim(Player.Ped, 'nm', 'firemans_carry', 3) then
		StopAnimTask(Player.Ped, 'nm', 'firemans_carry', 1.0)
	end
	if IsEntityAttached(Player.Ped) then
		DetachEntity(Player.Ped, true, true)
	end
	if Handcuffs.Prop.Handcuffs then
		DetachEntity(Handcuffs.Prop.Handcuffs, true, true)	
	end
	SetEnableHandcuffs(Player.Ped, false)
	DisablePlayerFiring(Player.Ped, false)
    SetPedCanPlayGestureAnims(Player.Ped, true)
	Wait(100)
	ClearPedSecondaryTask(Player.Ped)
end)

AddEventHandler('esx:onPlayerDeath', function() 
	isDead = true 
end)

DrawText3D = function(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 270
	DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if timeLeft then
			local coords = GetEntityCoords(PlayerPedId())	
			DrawText3D(coords.x, coords.y, coords.z + 0.1, timeLeft .. '~g~%', 0.4)
		else
			Citizen.Wait(500)
		end
	end
end)

procent = function(time, cb)
	if cb ~= nil then
		Citizen.CreateThread(function()
			timeLeft = 0
			repeat
				timeLeft = timeLeft + 1
				Citizen.Wait(time)
			until timeLeft == 100
			timeLeft = nil
			cb()
		end)
	else
		timeLeft = 0
		repeat
			timeLeft = timeLeft + 1
			Citizen.Wait(time)
		until timeLeft == 100
		timeLeft = nil
	end
end

RegisterNetEvent("esx_handcuffs:HandcuffsMenu")
AddEventHandler("esx_handcuffs:HandcuffsMenu", function(TargetId)
	HandcuffsMenu()
end)

isPedMoving = function(ped)
	if not IsPedWalking(ped) and not IsPedRunning(ped) and not IsPedSprinting(ped) then
		return false
	end
	return true
end

HandcuffsMenu = function()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title = 'Kajdanki',
		align = 'right',
		elements = {
			{label = 'Zakuj/Rozkuj',   	 	  	value = 'cuff_uncuff'},
			{label = 'Przeszukaj',     		  	value = 'search'},
			{label = 'Przenieś',      		  	value = 'drag'},
			{label = 'Wrzuć do pojazdu',      	value = 'put_in_vehicle'},
			{label = 'Wyciągnij z pojazdu',   	value = 'out_the_vehicle'},
			{label = 'Zdejmij Ciuchy',    		value = 'clothes_menu'},
			{label = 'Przebierz w Ciuchy',    	value = 'clothes'},
			{label = 'Worek',    				value = 'headbag'},
		}
	}, function(data, menu)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			ESX.ShowNotification("~r~Nie można wykonać w aucie")
		-- elseif exports['esx_property']:isInProperty() then
			-- ESX.ShowNotification("~r~Nie można wykonać w mieszkaniu")
		elseif closestPlayer and closestDistance < 2.0 then
			local closestPed = GetPlayerPed(closestPlayer)
			if data.current.value == "cuff_uncuff" then
				if not isPedMoving(PlayerPedId()) then
					if not isPedMoving(closestPed) then
						local targetId = GetPlayerServerId(closestPlayer)
						-- print(Player(targetId).state.IsDead)
						if IsEntityPlayingAnim(closestPed, "dead", "dead_a", 3) or IsPedRagdoll(closestPed) or IsPedBeingStunned(closestPed) or IsEntityPlayingAnim(closestPed, "random@mugging3", "handsup_standing_base", 3) or IsPedCuffed(closestPed) then
							HandlePlayerMenu(data.current.value, targetId, menu)
						else
							ESX.ShowNotification("~r~Ta osoba musisz mieć ręce w górze")
							return
						end
					else
						ESX.ShowNotification('~r~Nie możesz zakuć osoby w ruchu')
						return
					end
				else
					ESX.ShowNotification('~r~Nie możesz zakuwać w ruchu')
					return
				end
			else
				if IsPedCuffed(closestPed) then
					HandlePlayerMenu(data.current.value, GetPlayerServerId(closestPlayer), menu)
				end
			end
		else
			ESX.ShowNotification('~r~Brak obywateli w pobliżu')
		end
    end, function(data, menu)
		menu.close()
	end)
end

HandlePlayerMenu = function(evt, TargetId, parent)
	local Player = {
        Ped = PlayerPedId()
    }
    Target = {
        Ped = GetPlayerPed(GetPlayerFromServerId(TargetId))
    }
	if evt == "search" then
		RequestAnimDict('amb@prop_human_bum_bin@idle_a')
		while not HasAnimDictLoaded('amb@prop_human_bum_bin@idle_a') do
			Citizen.Wait(10)
		end
		TaskPlayAnim(GetPlayerPed(-1), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 40, 0, 0, 0, 0)
		procent(15, function()
		parent.close()
		OpenBodySearchMenu(TargetId)
		ESX.ShowNotification('~r~Przeszukujesz ~p~' .. TargetId)
		end)
	elseif evt == "cuff_uncuff" then
		TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 1.0, -3.0, 1500, 0, 0, false, false, false)
		Wait(500)
		ESX.ShowNotification('~r~Zakułeś/Rozkułeś ~p~' .. TargetId)
		TriggerServerEvent("esx_handcuffs:cuff_uncuff", TargetId)
	elseif evt == "drag" then
		TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 1.0, 50, 0, false, false, false)
		ESX.ShowNotification('~r~Przenosisz ~p~' .. TargetId)
		TriggerServerEvent("esx_handcuffs:drag", TargetId)
	elseif evt == "put_in_vehicle" then
		ESX.ShowNotification('~r~Wsadzasz do pojazdu ~p~' .. TargetId)
		TriggerServerEvent("esx_handcuffs:put_in_vehicle", TargetId)
	elseif evt == "out_the_vehicle" then
		ESX.ShowNotification('~r~Wyciągasz z pojazdu ~p~' .. TargetId)
		TriggerServerEvent("esx_handcuffs:out_the_vehicle", TargetId)
	elseif evt == "clothes_menu" then
		ESX.ShowNotification('~r~Wysłano prośbę o zgodę dla ~p~' .. TargetId)
		TriggerServerEvent("esx_handcuffs:ProsbaOZgodeNaCiuchyLazenDevelopa", TargetId, "clothes2")
	elseif evt == "clothes" then
		ESX.ShowNotification('~r~Wysłano prośbę o zgodę dla ~p~' .. TargetId)
		TriggerServerEvent("esx_handcuffs:ProsbaOZgodeNaCiuchyLazenDevelopa", TargetId, "clothes")
	elseif evt == "headbag" then
		TriggerServerEvent("esx_handcuffs:headbag", TargetId)
	end
end

RegisterNetEvent("esx_handcuffs:cuff_uncuff")
AddEventHandler("esx_handcuffs:cuff_uncuff", function(TargetId)
	if LocalPlayer.state.IsHandcuffed then
		TriggerEvent("esx_handcuffs:uncuff", TargetId)
	else
		TriggerEvent("esx_handcuffs:cuff", TargetId)
	end
end)

RegisterNetEvent("esx_handcuffs:cuff")
AddEventHandler("esx_handcuffs:cuff", function(TargetId)
    local Player = {
        Ped = PlayerPedId(),
        Heading = GetEntityHeading(PlayerPedId())
    }
    Target = {
        Ped = GetPlayerPed(TargetId),
        Heading = GetEntityHeading(GetPlayerPed(TargetId)),
        ServerId = TargetId
    }
    local roznica = math.abs(Player.Heading - Target.Heading)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'cuff', 0.4)
    if roznica > 90 then
		LocalPlayer.state:set('IsHandcuffed', "front", true)
        Handcuffs.Prop.Handcuffs = CreateObject(GetHashKey(''), GetEntityCoords(Player.Ped), true)
		AttachEntityToEntity(Handcuffs.Prop.Handcuffs, Player.Ped, GetPedBoneIndex(Player.Ped, 60309), -0.030, 0.0, 0.070, 110.0, 90.0, 100.0, 1, 0, 0, 0, 0, 1)
        TaskPlayAnim(Player.Ped, 'rcmme_amanda1', 'stand_loop_ama', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
    else
		LocalPlayer.state:set('IsHandcuffed', "back", true)
		Handcuffs.Prop.Handcuffs = CreateObject(GetHashKey(''), GetEntityCoords(Player.Ped), true)
		AttachEntityToEntity(Handcuffs.Prop.Handcuffs, Player.Ped, GetPedBoneIndex(Player.Ped, 60309), -0.030, 0.055, 0.028, 110.0, -22.5, 75.0, 1, 0, 0, 0, 0, 1)
        TaskPlayAnim(Player.Ped, 'mp_arresting', 'idle', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
    end
	ESX.UI.Menu.CloseAll()

            SetCurrentPedWeapon(Player.Ped, `WEAPON_UNARMED`, true)
            DisablePlayerFiring(Player.Ped, true)
            SetEnableHandcuffs(Player.Ped, true)
            SetPedCanPlayGestureAnims(Player.Ped, false)
	ESX.ShowNotification('~r~Zostałeś zakuty przez ~p~' ..Target.ServerId)
end)

RegisterNetEvent("esx_handcuffs:uncuff")
AddEventHandler("esx_handcuffs:uncuff", function(TargetId)
	LocalPlayer.state:set('IsHandcuffed', false, true)
	LocalPlayer.state:set('IsDragged', false, true)
	local playerPed = PlayerPedId()
	DetachEntity(playerPed)
	StopAnimTask(playerPed, 'nm', 'firemans_carry', 1.0)
    local Player = {
        Ped = PlayerPedId(),
    }
    Target = {
        Ped = GetPlayerPed(TargetId),
        ServerId = TargetId
    }
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'uncuff', 0.4)
	if IsEntityPlayingAnim(Player.Ped, 'rcmme_amanda1', 'stand_loop_ama', 3) then
		StopAnimTask(Player.Ped, 'rcmme_amanda1', 'stand_loop_ama', 1.0)
	elseif IsEntityPlayingAnim(Player.Ped, 'mp_arresting', 'idle', 3) then
		StopAnimTask(Player.Ped, 'mp_arresting', 'idle', 1.0)
	elseif IsEntityPlayingAnim(Player.Ped, 'nm', 'firemans_carry', 3) then
		StopAnimTask(Player.Ped, 'nm', 'firemans_carry', 1.0)
	end
	if IsEntityAttached(Player.Ped) then
		DetachEntity(Player.Ped, true, true)
	end
	if Handcuffs.Prop.Handcuffs then
		DetachEntity(Handcuffs.Prop.Handcuffs, true, true)	
	end
	SetEnableHandcuffs(Player.Ped, false)
            DisablePlayerFiring(Player.Ped, false)
            SetPedCanPlayGestureAnims(Player.Ped, true)
	ESX.ShowNotification('~r~Zostałeś rozkuty przez ~p~' ..Target.ServerId)
	TriggerServerEvent("esx_handcuffs:stopanimka", TargetId, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0)
	Wait(100)
	ClearPedSecondaryTask(PlayerPedId())	
end)

OpenUndressPlayerClothes = function(TargetId)
	ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title = 'Kajdanki',
		align = 'right',
		elements = {
			{label = 'Czapka / Kask', value = 'helmet_1', value2 = 'helmet_2'},
            {label = 'Kolczyki / Akcesoria', value = 'ears_1', value2 = 'ears_2'},
            {label = 'Maska', value = 'mask_1', value2 = 'mask_2'},
            {label = 'Okulary', value = 'glasses_1', value2 = 'glasses_2'},
            {label = 'Tors / Rece', value = 'tshirt_1', value2 = 'tshirt_2'},
            {label = 'Kamizelka', value = 'bproof_1', value2 = 'bproof_2'},
            {label = 'Szyja', value = 'chain_1', value2 = 'chain_2'},
            {label = 'Zegarek', value = 'watches_1', value2 = 'watches_2'},
            {label = 'Bransoletka', value = 'bracelets_1', value2 = 'bracelets_2'},
            {label = 'Spodnie', value = 'pants_1', value2 = 'pants_2'},
            {label = 'Buty', value = 'shoes_1', value2 = 'shoes_2'},
            {label = 'Torba / Plecak', value = 'bags_1', value2 = 'bags_2'},
		}
    }, function(data, menu)
		TriggerServerEvent("esx_handcuffs:UndressPlayerClothes", TargetId, data.current.value, data.current.value2)
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_handcuffs:UndressPlayerClothesdsadhuasdgiys')
AddEventHandler('esx_handcuffs:UndressPlayerClothesdsadhuasdgiys', function(TargetId, evt)
	if evt == "clothes2" then
		OpenUndressPlayerClothes(TargetId)
	elseif evt == "clothes" then
		ESX.TriggerServerCallback('esx_handcuffs:getPlayerSkinID', function(skin)
			local cuffskin = skin
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(myskin)
				if myskin.sex == cuffskin.sex then
					TriggerServerEvent("esx_handcuffs:clothes", TargetId)
					Citizen.Wait(100)
					local newskin = {
						['tshirt_1'] = cuffskin.tshirt_1, ['tshirt_2'] = cuffskin.tshirt_2,
						['torso_1'] = cuffskin.torso_1,   ['torso_2'] = cuffskin.torso_2,
						['pants_1'] = cuffskin.pants_1,   ['pants_2'] = cuffskin.pants_2,
						['shoes_1'] = cuffskin.shoes_1,  ['shoes_2'] = cuffskin.shoes_2,
						['bags_1'] = cuffskin.bags_1,  ['bags_2'] = cuffskin.bags_2,
						['decals_1'] = cuffskin.decals_1, ['decals_2'] = cuffskin.decals_2,
						['mask_1'] = cuffskin.mask_1, ['mask_2'] = cuffskin.mask_2,
						['bproof_1'] = cuffskin.bproof_1, ['bproof_2'] = cuffskin.bproof_2,
						['chain_1'] = cuffskin.chain_1, ['chain_2'] = cuffskin.chain_2,
						['helmet_1'] = cuffskin.helmet_1, ['helmet_2'] = cuffskin.helmet_2,
						['glasses_1'] = cuffskin.glasses_1, ['glasses_2'] = cuffskin.glasses_2,
						['arms'] = cuffskin.arms
					}
					TriggerEvent('skinchanger:loadClothes', myskin, newskin)
					Citizen.Wait(25)
					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
					end)
				else
					ESX.ShowNotification('~r~Te ciuchy nie pasują na ciebie')
				end
			end)
		end, TargetId)
		ESX.ShowNotification('~r~Zabierasz ciuchy dla ~p~' .. TargetId)
	end
end)

RegisterNetEvent("esx_handcuffs:ProsbaOZgodeNaCiuchyLazenDevelopa")
AddEventHandler("esx_handcuffs:ProsbaOZgodeNaCiuchyLazenDevelopa", function(TargetId, menue)
	ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title = 'Prośba o akceptacje zdjęcia ubrań',
		align = 'center',
		elements = {
			{ label = '<span style="color: lightgreen">Zaakceptuj</span>', value = true },
			{ label = '<span style="color: lightcoral">Odrzuć</span>', value = false },
		}
	}, function(data, menu)
		menu.close()
		TriggerServerEvent('esx_handcuffs:UndressPlayerClothesdsadhuasdgiys', TargetId, data.current.value, menue)
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('esx_handcuffs:UndressPlayerClothes')
AddEventHandler('esx_handcuffs:UndressPlayerClothes', function(TargetId, value1, value2)
	UpdateSkin()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.sex == 0 and (updatedSkin[value1] ~= clearSkinMale[value1] or value1 == 'tshirt_1' and updatedSkin[value1] == 15 and updatedSkin['torso_1'] ~= 15) then
				newSkin[value1] = clearSkinMale[value1]
				if value1 == 'tshirt_1' then
					newSkin['arms'] = clearSkinMale['arms']
					newSkin['arms_2'] = clearSkinMale['arms_2']
					newSkin['torso_1'] = clearSkinMale['torso_1']
					newSkin['torso_2'] = clearSkinMale['torso_2']
					newSkin['decals_1'] = clearSkinMale['decals_1']
					newSkin['decals_2'] = clearSkinMale['decals_2']
				end
				if value1 == 'bproof_1' then
					newSkin['bproof_2'] = clearSkinMale[value2]
				end
				if value1 == 'shoes_1' then
					newSkin['shoes_2'] = clearSkinMale[value2]
				end
				if value1 == 'watches_1' then
					newSkin['watches_2'] = clearSkinMale[value2]
				end
				if value1 == 'helmet_1' then
					newSkin['helmet_2'] = clearSkinMale[value2]
				end
				if value1 == 'ears_1' then
					newSkin['ears_2'] = clearSkinMale[value2]
				end
				if value1 == 'mask_1' then
					newSkin['mask_2'] = clearSkinMale[value2]
				end
				if value1 == 'glasses_1' then
					newSkin['glasses_2'] = clearSkinMale[value2]
				end
				if value1 == 'hair_1' then
					newSkin['hair_1'] = clearSkinMale[value2]
				end
				if value1 == 'bracelets_1' then
					newSkin['bracelets_2'] = clearSkinMale[value2]
				end
				if value1 == 'tshirt_1' and updatedSkin[value1] == 15 and updatedSkin['torso_1'] ~= 15 then
					newSkin['torso_1'] = clearSkinMale['torso_1']
					newSkin['torso_2'] = clearSkinMale['torso_2']
				end
				if value2 ~= '' and  value2 ~= 'tshirt_1' then
					newSkin[value2] = clearSkinMale[value2]
				end
       elseif skin.sex == 1 and (updatedSkin[value1] ~= clearSkinFemale[value1] or value1 == 'tshirt_1' and updatedSkin[value1] == 14 and updatedSkin['torso_1'] ~= 15) then
				newSkin[value1] = clearSkinFemale[value1]
				if value1 == 'tshirt_1' then
					newSkin['arms'] = clearSkinFemale['arms']
					newSkin['arms_2'] = clearSkinFemale['arms_2']
					newSkin['torso_1'] = clearSkinFemale['torso_1']
					newSkin['torso_2'] = clearSkinFemale['torso_2']
					newSkin['decals_1'] = clearSkinFemale['decals_1']
					newSkin['decals_2'] = clearSkinFemale['decals_2']
				end
				if value1 == 'hair_1' then
					newSkin['hair_1'] = clearSkinMale[value2]
				end
				if value1 == 'bproof_1' then
					newSkin['bproof_2'] = clearSkinFemale[value2]
				end
				if value1 == 'shoes_1' then
					newSkin['shoes_2'] = clearSkinFemale[value2]
				end
				if value1 == 'watches_1' then
					newSkin['watches_2'] = clearSkinFemale[value2]
				end
				if value1 == 'helmet_1' then
					newSkin['helmet_2'] = clearSkinFemale[value2]
				end
				if value1 == 'ears_1' then
					newSkin['ears_2'] = clearSkinFemale[value2]
				end
				if value1 == 'mask_1' then
					newSkin['mask_2'] = clearSkinFemale[value2]
				end
				if value1 == 'glasses_1' then
					newSkin['glasses_2'] = clearSkinFemale[value2]
				end
				if value1 == 'bracelets_1' then
					newSkin['bracelets_2'] = clearSkinFemale[value2]
				end
				if value2 ~= '' then
					newSkin[value2] = clearSkinFemale[value2]
				end
				if value1 == 'tshirt_1' and updatedSkin[value1] == 14 and updatedSkin['torso_1'] ~= 15 then
					newSkin['torso_1'] = clearSkinFemale['torso_1']
					newSkin['torso_1'] = clearSkinFemale['torso_2']
				end
			else
				newSkin[value1] = lastSkin[value1]
				if value1 == 'tshirt_1' then
					newSkin['torso_1'] = lastSkin['torso_1']
					newSkin['torso_2'] = lastSkin['torso_2']
					newSkin['arms'] = lastSkin['arms']
					newSkin['arms_2'] = lastSkin['arms_2']
					newSkin['decals_1'] = lastSkin['decals_1']
					newSkin['decals_2'] = lastSkin['decals_2']

				end
				if value2 ~= '' then
					local replaceValue = value2
					replaceValue = replaceValue:gsub("1", "2")
					newSkin[value2] = lastSkin[value2]
					newSkin[replaceValue] = lastSkin[replaceValue]
			end
		end
		Wait(1000)
		TriggerEvent('skinchanger:loadClothes', skin, newSkin)
    end)
end)

UpdateSkin = function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		updatedSkin = skin
		newSkin = skin
		if skin.sex == 0 then
			for i in pairs(skin) do
				if lastSkin[i] == nil then
					lastSkin[i] = skin[i]
				elseif clearSkinMale[i] ~= nil and skin[i] ~= clearSkinMale[i] then
					lastSkin[i] = skin[i]
				end
			end
		else
			for i in pairs(skin) do
				if lastSkin[i] == nil then
					lastSkin[i] = skin[i]
				elseif clearSkinFemale[i] ~= nil and skin[i] ~= clearSkinFemale[i] then
					lastSkin[i] = skin[i]
				end
			end
		end
	end)
end

RegisterNetEvent("esx_handcuffs:stopanimka")
AddEventHandler("esx_handcuffs:stopanimka", function(k, value1, value2, value3)
	StopAnimTask(PlayerPedId(), value1, value2, value3)
end)

RegisterNetEvent("esx_handcuffs:drag")
AddEventHandler("esx_handcuffs:drag", function(TargetId)
	if LocalPlayer.state.IsDragged then
		LocalPlayer.state:set("IsDragged", false, true)
		LocalPlayer.state:set("AttachedPed", nil, true)
		local playerPed = PlayerPedId()
		DetachEntity(playerPed)
		StopAnimTask(playerPed, 'nm', 'firemans_carry', 1.0)
		if LocalPlayer.state.IsHandcuffed == "front" then
			TaskPlayAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
		elseif LocalPlayer.state.IsHandcuffed == "back" then
			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
		end
		TriggerServerEvent("esx_handcuffs:stopanimka", TargetId, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0)
	else
		LocalPlayer.state:set("IsDragged", true, true)
		LocalPlayer.state:set("AttachedPed", TargetId, true)
		Wait(100)
		local playerPed = PlayerPedId()
		StopAnimTask(playerPed, 'mp_arresting', 'idle', 1.0)
		AttachEntityToEntity(playerPed, GetPlayerPed(GetPlayerFromServerId(TargetId)), 0, 0.15, 0.27, 0.63, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
		TaskPlayAnim(playerPed, 'nm', 'firemans_carry', 8.0, -8.0, 1.0, 2, 0, false, false, false)
	end
end)

RegisterNetEvent('esx_handcuffs:clothes')
AddEventHandler('esx_handcuffs:clothes', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, newSkinMale)
        else
            TriggerEvent('skinchanger:loadClothes', skin, newSkinFemale)
        end
    end)
	Citizen.Wait(25)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)

local HasWorek = nil
RegisterNetEvent("esx_handcuffs:headbag")
AddEventHandler("esx_handcuffs:headbag", function(TargetId)
	if LocalPlayer.state.Headbag then
		LocalPlayer.state:set('Headbag', false, true)
		SendNUIMessage({
			action = "worek_off"
		})
		DeleteEntity(HasWorek)
	else
		LocalPlayer.state:set('Headbag', true, true)
		SendNUIMessage({
			action = "worek_on"
		})
		HasWorek = CreateObject(`prop_money_bag_01`, 0, 0, 0, true, true, true)
		local ped = PlayerPedId()
		AttachEntityToEntity(HasWorek, ped, GetPedBoneIndex(ped, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
	end
end)


RegisterCommand("worek", function()
	if LocalPlayer.state.Headbag then
		LocalPlayer.state:set('Headbag', false, true)
		SendNUIMessage({
			action = "worek_off"
		})
		ESX.ShowNotification("Zjeb")
	else
		LocalPlayer.state:set('Headbag', true, true)
		SendNUIMessage({
			action = "worek_on"
		})
		ESX.ShowNotification("Draxer")
	end
end)

RegisterNetEvent("esx_handcuffs:put_in_vehicle")
AddEventHandler("esx_handcuffs:put_in_vehicle", function(TargetId)
	if not LocalPlayer.state.IsHandcuffed then
		return
	end
	
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
  
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
  
	  local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)
  
	  if DoesEntityExist(vehicle) then
  
		local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
		local freeSeat = nil
  
		for i=maxSeats - 1, 0, -1 do
		  if IsVehicleSeatFree(vehicle,  i) then
			freeSeat = i
			break
		  end
		end
  
		if freeSeat ~= nil then
		  TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
		  LocalPlayer.state:set("IsDragged", false, true)
		  StopAnimTask(playerPed, 'nm', 'firemans_carry', 3) 
		end
  
	  end
  
	end
end)

RegisterNetEvent("esx_handcuffs:out_the_vehicle")
AddEventHandler("esx_handcuffs:out_the_vehicle", function(TargetId)
	if not LocalPlayer.state.IsHandcuffed and not IsPedInAnyVehicle(PlayerPedId(), false) then
		return
	end
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	TaskLeaveVehicle(PlayerPedId(), vehicle, 256)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
		local sleep = true
		if LocalPlayer.state.IsHandcuffed then
			sleep = false
			DisableControlAction(0, 23, true)      -- INPUT_ENTER (F)
			DisableControlAction(0, 24, true)      -- INPUT_ATTACK (LPM)
			DisableControlAction(0, 25, true)      -- INPUT_AIM (PPM)
			DisableControlAction(0, 29, true)      -- INPUT_SPECIAL_ABILITY_SECONDARY (B)
			DisableControlAction(2, 36, true)     -- INPUT_DUCK (LCTRL)
			DisableControlAction(0, 37, true)     -- INPUT_SELECT_WEAPON (TAB)
			DisableControlAction(0, 44, true)      -- INPUT_COVER (Q)
			DisableControlAction(0, 45, true)      -- INPUT_RELOAD (R)
			DisableControlAction(0, 47, true)      -- INPUT_DETONATE (G)
			DisableControlAction(0, 59, true)     -- INPUT_VEH_MOVE_LR (D)
			DisableControlAction(0, 63, true)     -- INPUT_VEH_MOVE_LEFT_ONLY (A)
			DisableControlAction(0, 64, true)     -- INPUT_VEH_MOVE_RIGHT_ONLY (D)
			DisableControlAction(0, 71, true)     -- INPUT_VEH_ACCELERATE (W)
			DisableControlAction(0, 72, true)     -- INPUT_VEH_BRAKE (S)
			DisableControlAction(0, 75, true)     -- INPUT_VEH_EXIT (F)
			DisableControlAction(27, 75, true)     -- INPUT_VEH_EXIT (F)
			DisableControlAction(0, 140, true)     -- INPUT_MELEE_ATTACK_LIGHT (R)
			DisableControlAction(0, 141, true)     -- INPUT_MELEE_ATTACK_HEAVY (Q)
			DisableControlAction(0, 142, true)     -- INPUT_MELEE_ATTACK_ALTERNATE (LPM)
			DisableControlAction(0, 143, true)     -- INPUT_MELEE_BLOCK (SPACEBAR)
			DisableControlAction(0, 167, true)    -- INPUT_SELECT_CHARACTER_FRANKLIN (F6)
			DisableControlAction(0, 168, true)     -- INPUT_SELECT_CHARACTER_TREVOR (F7)
			DisableControlAction(0, 170, true)     -- INPUT_SAVE_REPLAY_CLIP (F3)
			DisableControlAction(0, 257, true)     -- INPUT_ATTACK2 (LPM)
			DisableControlAction(0, 263, true)     -- INPUT_MELEE_ATTACK1 (R)
			DisableControlAction(0, 264, true)     -- INPUT_MELEE_ATTACK2 (Q)
			DisableControlAction(0, 288,  true) -- INPUT_REPLAY_START_STOP_RECORDING (F1)
			DisableControlAction(0, 289, true)     -- INPUT_REPLAY_START_STOP_RECORDING_SECONDARY (F2)
		end

        if LocalPlayer.state.IsHandcuffed and not LocalPlayer.state.IsDragged then
			sleep = false
            if LocalPlayer.state.IsHandcuffed == "front" then
                if not IsEntityPlayingAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 3) then
					TaskPlayAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
				end
            elseif LocalPlayer.state.IsHandcuffed == "back" then
                if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, 3.0, -1, 50, 0, 0, 0, 0)
				end
            end
        elseif LocalPlayer.state.IsDragged then
			sleep = false
            if not IsEntityPlayingAnim(playerPed, 'nm', 'firemans_carry', 3) then
                TaskPlayAnim(playerPed, 'nm', 'firemans_carry', 8.0, -8.0, 1.0, 2, 0, false, false, false)
            end
            if not IsEntityAttached(playerPed) then
                AttachEntityToEntity(LocalPlayer.state.AttachedPed, playerPed, 0, 0.15, 0.27, 0.63, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
            end
            if IsEntityPlayingAnim(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 3) then
                StopAnimTask(playerPed, 'rcmme_amanda1', 'stand_loop_ama', 1.0)
            elseif IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
                StopAnimTask(playerPed, 'mp_arresting', 'idle', 1.0)
            end
		end

		if sleep then
            Citizen.Wait(500)
        end
    end
end)

function OpenBodySearchMenu(player)
	exports.ox_inventory:openInventory("player", player)

end

RegisterKeyMapping("handcuff-menu", "Menu Kajdanek | SHIFT + ", "keyboard", "H")
RegisterCommand("handcuff-menu", function()
    if IsControlPressed(0, 21) and not isDead and not LocalPlayer.state.IsHandcuffed then
        ESX.TriggerServerCallback("esx_handcuffs:checkItems", function(bool)
            if bool > 0 then
                HandcuffsMenu()
				ESX.ShowNotification("Otworzono Menu Kajdanek")
			else
				ESX.ShowNotification("~r~Nie masz kajdanek")
            end
        end)
    end
end)
Citizen.CreateThread(function()
    TriggerEvent("chat:removeSuggestion", "/handcuff-menu")
end)


CreateThread(function()
	exports.qtarget:Player({
		options = {
			{
				event = "zakujchuja",
				icon = "fas fa-hands",
				label = "Kajdanki",
			},
		}, 
		distance = 1.0
	})
	end)
	
RegisterNetEvent('zakujchuja', function()
	ESX.TriggerServerCallback("esx_handcuffs:checkItems", function(bool)
		if bool > 0 then
			HandcuffsMenu()
			ESX.ShowNotification("Otworzono Menu Kajdanek")
		else
			ESX.ShowNotification("~r~Nie masz kajdanek")
		end
	end)
end)