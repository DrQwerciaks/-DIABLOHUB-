local isDead, isBusy = false, false
local CurrentTask = {}
local TuningZones = {}
lockpickTimeout = false

local accessJob = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function setUniform(maleConfig, femaleConfig)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if maleConfig ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, maleConfig)
			end
		else
			if femaleConfig ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, femaleConfig)
			end
		end
	end)
end

function SetVehicleMaxMods(vehicle)
	local t = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modArmor        = 4,
		modXenon        = true,
		modTurbo        = true,
		dirtLevel       = 0
	}

	ESX.Game.SetVehicleProperties(vehicle, t)
end

function OpenExtras()
	local elements1 = {}
	local Gracz = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(Gracz, false)

	for ExtraID=0, 20 do
		if DoesExtraExist(vehicle, ExtraID) then
			if IsVehicleExtraTurnedOn(vehicle, ExtraID) == 1 then
				local tekstlabel = 'Dodatek '..tostring(ExtraID)..' - Zdemontuj'
				table.insert(elements1, {label = tekstlabel, posiada = true, value = ExtraID})
			elseif IsVehicleExtraTurnedOn(vehicle, ExtraID) == false then
				local tekstlabel = 'Dodatek '..tostring(ExtraID)..' - Podgląd'
				table.insert(elements1, {label = tekstlabel, posiada = false, value = ExtraID})
			end
		end
	end

	if #elements1 == 0 then
		table.insert(elements1, {label = 'Ten pojazd nie posiada dodatków!', posiada = nil, value = nil})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sklep_dodatki_policja', {
		title    = 'Dodatki - Sklep',
		align    = 'left',
		elements = elements1
	}, function(data, menu)
		local dodatek2 = data.current.value
		if dodatek2 ~= nil then
			local dodatekTekst = 'extra'..dodatek2
			local posiada = data.current.posiada
			if posiada then
				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sklep_dodatki_policja_usun', {
					title    = 'Zdemontować dodatek?',
					align    = 'left',
					elements = {
						{label = "Tak", value = "tak"},
						{label = "Nie", value = "nie"},
					}
				}, function(data2, menu2)
					local akcja = data2.current.value
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					local tablica = vehicleProps.plate
					if akcja == 'tak' then
						SetVehicleExtra(vehicle, dodatek2, 1)
					elseif akcja == 'nie' then
						SetVehicleExtra(vehicle, dodatek2, 0)
					end
					menu2.close()
					Citizen.Wait(200)
					OpenDodatkiGarazMenu()
				end, function(data2, menu2)
					menu2.close()
				end)
				
			elseif posiada == false then
				SetVehicleExtra(vehicle, dodatek2, 0)
				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sklep_dodatki_policja_kup', {
					title = 'Potwierdzić montaż?',
					align = 'left',
					elements = {
						{label = "Tak - Zamontuj", value = "tak"},
						{label = "Nie - Anuluj", value = "nie"},
					}
				}, function(data3, menu3)
					local akcja = data3.current.value
					local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
					local tablica = vehicleProps.plate
					if akcja == 'tak' then
					elseif akcja == 'nie' then
						SetVehicleExtra(vehicle, dodatek2, 1)
					end
					
					menu3.close()
					Citizen.Wait(200)
					OpenDodatkiGarazMenu()
				end, function(data3, menu3)
					menu3.close()
				end)
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMechanicBossMenu()
	if ESX.PlayerData.job.grade_name == "boss" or ESX.PlayerData.job.grade_name == "chief" then
		TriggerEvent('esx_society:openBossMenu', ESX.PlayerData.job.name, function(data, menu)
			menu.close()
		end, { showmoney = true, withdraw = true, deposit = true, wash = false, employees = true })
	else
		TriggerEvent('esx_society:openBossMenu', ESX.PlayerData.job.name, function(data, menu)
			menu.close()
		end, { showmoney = false, withdraw = false, deposit = true, wash = false, employees = false })
	end
end

function OpenVehicleSpawnerMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',{
		title		= ('Garaż mechaników'),
		align		= 'center',
		elements	= Config.AuthorizedVehicles[ESX.PlayerData.job.grade]
	}, function(data, menu)
		menu.close()
		ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.PosSpawnPoint, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
			local playerPed = PlayerPedId()
			ESX.Game.SetVehicleProperties(vehicle, data.current.model)
			SetVehicleMaxMods(vehicle)
			plate = "MECH " .. math.random(100,999)
			SetVehicleNumberPlateText(vehicle, plate)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			exports['diablohub_carkeys']:addKey(plate)
		end)
	end, function(data, menu)
		menu.close()
	end)
end

function VehicleDeletersFunction(station)
	local found1 = nil
	local playerVeh = GetVehiclePedIsIn(ESX.PlayerData.ped, true)
	
	local vehicle = ESX.Game.GetVehiclesInArea(Config.Zones.VehicleSpawnPoint.PosSpawnPoint, 2)
	if #vehicle > 0 then
		for j=1, #vehicle, 1 do
			if playerVeh == vehicle[j] then
				exports['diablohub_carkeys']:removeKey(GetVehicleNumberPlateText(vehicle[j], true))
				ESX.Game.DeleteVehicle(vehicle[j])
				found1 = true
				break
			end
		end
	end

	if found1 then
		ESX.ShowNotification("Pojazd został schowany!")
	else
		ESX.ShowNotification("Nie znaleziono twojego pojazdu na miejscu parkingowym!<br/>Wsiądź do niego i spróbuj ponownie.")
	end
end

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)

	for jobName, jobConfig in pairs(Config.Mechanics) do
		local v = jobConfig.blip
		local blip = AddBlipForCoord(v.coords)

		SetBlipSprite (blip, v.sprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, v.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName("<font face='Poppins-Medium' size= '11'>".. v.label .."</font>" ) 
		EndTextCommandSetBlipName(blip)
	end

	for jobName, jobConfig in pairs(Config.Mechanics) do
		for k, conf in pairs(jobConfig) do
			if k ~= "tuneZone" and k ~= "blip" and k ~= "clothes" and conf.options then
				for j, d in pairs(conf.options) do
					d.job = jobName
				end
			end
		end
	end

	Citizen.Wait(1000)

	for jobName, jobConfig in pairs(Config.Mechanics) do
		for k, conf in pairs(jobConfig) do
			if k ~= "tuneZone" and k ~= "blip" and k ~= "clothes" then
				exports.qtarget:AddBoxZone(k..jobName, conf.coords, conf.length, conf.width, {
					name = k..jobName,
					heading = conf.coords[4],
					debugPoly = false,
					minZ = conf.minZ,
					maxZ = conf.maxZ,
				}, {
					options = conf.options,
					distance = 2
				})
			end
		end
	end

	for jobName, jobConfig in pairs(Config.Mechanics) do
		for k, conf in pairs(jobConfig) do
			if k == "tuneZone" then
				TuningZones[jobName] = BoxZone:Create(conf.coords, conf.length, conf.width, {
					name = k,
					heading = conf.coords[4],
					debugPoly = false,
					minZ = conf.minZ,
					maxZ = conf.maxZ,
				})
			end
		end
	end

	for jobName, jobConfig in pairs(Config.Mechanics) do
		accessJob[jobName] = 0
	end
	
	for _, jobName in pairs(Config.AddRemoveObjectsJobs) do
		accessJob[jobName] = 0
	end
	

	exports.qtarget:Vehicle({
		options = {
			{
				event = "need_mechanics:Carokit",
				icon = "fas fa-wrench",
				label = "Napraw blacharkę",
				job = accessJob,
				canInteract = function()
					return not IsBusy
				end
			},
			{
				event = "need_mechanics:Fixkit",
				icon = "fas fa-wrench",
				label = "Napraw pojazd",
				canInteract = function()
					local hasJob = false
					for jobName in pairs(Config.Mechanics) do
						if jobName == ESX.PlayerData.job.name then
							hasJob = true
						end
					end
					return not IsBusy and (exports.ox_inventory:Search('count', 'fixkit') > 0 or hasJob)
				end
			},
			{
				event = "need_mechanics:CleanVehicle",
				icon = "fas fa-hand-sparkles",
				label = "Umyj pojazd",
				job = accessJob,
				canInteract = function()
					return not IsBusy
				end
			},
			{
				event = "need_mechanics:UnlockVehicle",
				icon = "fas fa-unlock-alt",
				label = "Odblokuj pojazd",
				job = accessJob,
				canInteract = function()
					return not IsBusy
				end
			},
			{
				event = "need_mechanics:ImpoundVehicle",
				icon = "fas fa-lock",
				label = "Odholuj pojazd",
				job = accessJob,
				canInteract = function()
					return true
				end
			},
		},
		distance = 2
	})
end)

RegisterNetEvent("need_mechanics:openStash", function()
	local ox_inventory = exports.ox_inventory

    if ox_inventory:openInventory('stash', {id = ESX.PlayerData.job.name}) == false then
        TriggerServerEvent('need_mechanics:loadStash')
        ox_inventory:openInventory('stash', {id = ESX.PlayerData.job.name})
    end
end)

RegisterNetEvent("need_mechanics:openJobClothes", function()
	local elements = {}
	for k, v in pairs(Config.Mechanics[ESX.PlayerData.job.name].clothes) do
		local hasDostep = false
		for a, b in pairs(v.grades) do
			if b == ESX.PlayerData.job.grade then
				hasDostep = true
				break
			end
		end
		if hasDostep then
			elements[#elements + 1] = {label = v.title, male = v.male, female = v.female}
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fraction_clothes', {
		title    = 'Ubrania frakcyjne',
		align    = 'left',
		elements = elements
	}, function(data, menu)
		setUniform(data.current.male, data.current.female)
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("need_mechanics:returnLastSkin", function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

RegisterNetEvent("need_mechanics:bossMenu", function()
	OpenMechanicBossMenu()
end)

RegisterNetEvent("need_mechanics:createLockpick", function()
	if lockpickTimeout then
		return
	end
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
	TriggerEvent("need_taskbar:progress", {
		name = "lockpick_create",
		duration = 120000,
		label = "Tworzenie wytrychu",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}
	}, function(wasCancelled)
		if not wasCancelled then
			if exports.ox_inventory:Search('count', 'lockpick_parts') > 5 then
				TriggerServerEvent("need_mechanics:createLockpick")
				lockpickTimeout = true
				Wait(5 * 60000)
				lockpickTimeout = false
			end
		end
	end)
end)

RegisterNetEvent("need_mechanics:Carokit", function(data)
	local playerPed = PlayerPedId()
	local vehicle   = data.entity
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if DoesEntityExist(vehicle) then
		-- ESX.TriggerServerCallback('need_mechanics:getMoney', function(cb)
		-- 	if cb then
				IsBusy = true
				TaskTurnPedToFaceCoord(playerPed, GetEntityCoords(vehicle))
				Citizen.Wait(1000)
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HAMMERING", 0, true)
				TriggerEvent("need_taskbar:progress", {
					name = "carokit",
					duration = Config.FixBodyVehicle.timeToFix,
					label = "Naprawa karoserii",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
				}, function(wasCancelled)
					if not wasCancelled then
						local id = NetworkGetNetworkIdFromEntity(vehicle)
						SetNetworkIdCanMigrate(id, false)
		
						local tries = 0
						while not NetworkHasControlOfNetworkId(id) and tries < 20 do
							tries = tries + 1
							NetworkRequestControlOfNetworkId(id)
							Citizen.Wait(50)
						end
		
						SetVehicleBodyHealth(vehicle, 1000.0)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleFixed(vehicle)
		
						SetNetworkIdCanMigrate(id, true)
						ClearPedTasksImmediately(playerPed)
						IsBusy = false
					end
				end)
		-- 	else
		-- 		ESX.ShowNotification("Nie posiadasz wystarczającej ilość gotówki!")
		-- 	end
		-- end, 1000)
	end
end)

RegisterNetEvent("need_mechanics:Fixkit", function(data)
	local playerPed = PlayerPedId()
	local vehicle   = data.entity
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if DoesEntityExist(vehicle) then
		-- ESX.TriggerServerCallback('need_mechanics:getMoney', function(cb)
			-- if cb then
				IsBusy = true
				TaskTurnPedToFaceCoord(playerPed, GetEntityCoords(vehicle))
				Citizen.Wait(1000)
				TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
				TriggerEvent("need_taskbar:progress", {
					name = "vehicleFix",
					duration = Config.FixEngineVehicle.timeToFix,
					label = "Naprawa silnika",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
				}, function(wasCancelled)
					if not wasCancelled then
						TriggerServerEvent("need_mechanics:RemoveFixKit")
		
						local id = NetworkGetNetworkIdFromEntity(vehicle)
						SetNetworkIdCanMigrate(id, false)
		
						local tries = 0
						while not NetworkHasControlOfNetworkId(id) and tries < 20 do
							tries = tries + 1
							NetworkRequestControlOfNetworkId(id)
							Citizen.Wait(50)
						end
		
						local first = true
						while first or not GetIsVehicleEngineRunning(vehicle) do
							SetVehicleEngineHealth(vehicle, 1000.0)
							SetVehicleUndriveable(vehicle, false)
		
							SetVehicleEngineOn(vehicle, true, true)
							first = false
							Citizen.Wait(0)
						end
		
						SetNetworkIdCanMigrate(id, true)
						ClearPedTasksImmediately(playerPed)
						IsBusy = false
					end
				end)
		-- 	else
		-- 		ESX.ShowNotification("Nie posiadasz wystarczającej ilość gotówki!")
		-- 	end
		-- end, 500)
	end
end)

RegisterNetEvent("need_mechanics:UnlockVehicle", function(data)
	local playerPed = PlayerPedId()
	local vehicle   = data.entity
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		if DoesEntityExist(vehicle) then
			-- ESX.TriggerServerCallback('need_mechanics:getMoney', function(cb)
				-- if cb then
					IsBusy = true
					TaskTurnPedToFaceCoord(playerPed, GetEntityCoords(vehicle))
					Citizen.Wait(1000)
					local model = GetEntityModel(vehicle)
					if not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABoat(model) then
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
						TriggerEvent("need_taskbar:progress", {
							name = "unlockVehicle",
							duration = 20000,
							label = "Odblokowywanie pojazdu",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
						}, function(wasCancelled)
							if not wasCancelled then
								local id = NetworkGetNetworkIdFromEntity(vehicle)
								SetNetworkIdCanMigrate(id, false)

								local tries = 0
								while not NetworkHasControlOfNetworkId(id) and tries < 20 do
									tries = tries + 1
									NetworkRequestControlOfNetworkId(id)
									Citizen.Wait(50)
								end

								while GetVehicleDoorsLockedForPlayer(vehicle, PlayerId()) ~= false do
									SetVehicleDoorsLocked(vehicle, 1)
									SetVehicleDoorsLockedForAllPlayers(vehicle, false)
									Citizen.Wait(0)
								end

								SetNetworkIdCanMigrate(id, true)
								ClearPedTasksImmediately(playerPed)
								IsBusy = false
							end
						end)
					end
			-- 	else
			-- 		ESX.ShowNotification("Nie posiadasz wystarczającej ilość gotówki!")
			-- 	end
			-- end, 100)
		end
	end
end)

RegisterNetEvent("need_mechanics:CleanVehicle", function(data)
	local playerPed = PlayerPedId()
	local vehicle   = data.entity
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if DoesEntityExist(vehicle) then
		IsBusy = true
		TaskTurnPedToFaceCoord(playerPed, GetEntityCoords(vehicle))
		Citizen.Wait(1000)
		TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)

		TriggerEvent("need_taskbar:progress", {
			name = "cleanVehicle",
			duration = Config.WashVehicle.timeToWash,
			label = "Mycie pojazdu",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		}, function(wasCancelled)
			if not wasCancelled then
				local id = NetworkGetNetworkIdFromEntity(vehicle)
				SetNetworkIdCanMigrate(id, false)

				local tries = 0
				while not NetworkHasControlOfNetworkId(id) and tries < 20 do
					tries = tries + 1
					NetworkRequestControlOfNetworkId(id)
					Citizen.Wait(50)
				end

				WashDecalsFromVehicle(vehicle, 1.0)
				SetVehicleDirtLevel(vehicle)

				SetNetworkIdCanMigrate(id, true)
				ClearPedTasksImmediately(playerPed)
				IsBusy = false
			end
		end)
	end
end)

RegisterNetEvent("need_mechanics:ImpoundVehicle", function(data)
	local playerPed = PlayerPedId()
	local vehicle   = data.entity
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if DoesEntityExist(vehicle) then
		IsBusy = true

		TaskTurnPedToFaceCoord(playerPed, GetEntityCoords(vehicle))
		Citizen.Wait(1000)

		TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

		TriggerEvent("need_taskbar:progress", {
			name = "impoundVehicle",
			duration = Config.RemoveVehicle.timeToWash,
			label = "Odholywanie pojazdu",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		}, function(wasCancelled)
			if not wasCancelled then
				local plate = GetVehicleNumberPlateText(vehicle)
				TriggerServerEvent("ls:removeKeysFromAllPlayers", tostring(string.lower(plate)))
				ESX.Game.DeleteVehicle(vehicle)
				IsBusy = false
			end
		end)
	end
end)

RegisterNetEvent("need_mechanics:SpawnObject", function(data)
	local playerPed = PlayerPedId()
	-- if data.entity == "p_ld_stinger_s" then
		-- local stinger = CreateObject(LoadModel("p_ld_stinger_s").model, GetOffsetFromEntityInWorldCoords(playerPed, -0.2, 2.0, 0.0), true, true, 0)
		-- SetEntityAsMissionEntity(stinger, true, true)
		-- SetEntityHeading(stinger, GetEntityHeading(playerPed))
		-- FreezeEntityPosition(stinger, true)
		-- PlaceObjectOnGroundProperly(stinger)
		-- SetEntityVisible(stinger, false)
		
		-- local scene = NetworkCreateSynchronisedScene(GetEntityCoords(playerPed), GetEntityRotation(playerPed, 2), 2, false, false, 1065353216, 0, 1.0)
		-- NetworkAddPedToSynchronisedScene(playerPed, scene, LoadDict("amb@medic@standing@kneel@enter"), "enter", 8.0, -8.0, 3341, 16, 1148846080, 0)
		-- NetworkStartSynchronisedScene(scene)
		
		-- while not IsSynchronizedSceneRunning(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) do
			-- Wait(0)
		-- end
		
		-- SetSynchronizedSceneRate(NetworkConvertSynchronisedSceneToSynchronizedScene(scene), 3.0)
	
		-- while GetSynchronizedScenePhase(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) < 0.14 do
			-- Wait(0)
		-- end
		
		-- NetworkStopSynchronisedScene(scene)
		
		-- PlayEntityAnim(stinger, "P_Stinger_S_Deploy", LoadDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.0, 0)
		-- while not IsEntityPlayingAnim(stinger, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) do
			-- Wait(0)
		-- end
		-- SetEntityVisible(stinger, true)
		-- while IsEntityPlayingAnim(stinger, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) and GetEntityAnimCurrentTime(stinger, "p_ld_stinger_s", "P_Stinger_S_Deploy") <= 0.99 do
			-- Wait(0)
		-- end
		-- PlayEntityAnim(stinger, "p_stinger_s_idle_deployed", LoadDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.99, 0)
		-- FreezeEntityPosition(stinger, true)

		exports.qtarget:AddTargetEntity(stinger, {
			options = {
				{
					
					event = "need_mechanics:DeleteObject",
					icon = "fas fa-circle-minus",
					label = "Usuń obiekt",
					job = accessJob,
				},
			},
			distance = 2
		})
	-- else
		TaskPlayAnim(playerPed, LoadDict("random@domestic"), "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
		Wait(1000)
		local Object = CreateObject(LoadModel(data.entity).model, GetOffsetFromEntityInWorldCoords(playerPed, -0.1, 1.0, 0.0), true, true, 0)
		SetEntityAsMissionEntity(Object, true, true)
		SetEntityHeading(Object, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(Object)
		ClearPedTasks(playerPed)
		FreezeEntityPosition(Object, true)

		exports.qtarget:AddTargetEntity(Object, {
			options = {
				{
					
					event = "need_mechanics:DeleteObject",
					icon = "fas fa-circle-minus",
					label = "Usuń obiekt",
					job = accessJob,
				},
			},
			distance = 2
		})
	-- end
end)

RegisterNetEvent("need_mechanics:DeleteObject", function(data)
	local closestEntity = data.entity
	if DoesEntityExist(closestEntity) then
		TaskPlayAnim(PlayerPedId(), LoadDict("random@domestic"), "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
		Wait(1000)
		NetworkRequestControlOfEntity(closestEntity)
		SetEntityAsMissionEntity(closestEntity, true, true)
		DeleteEntity(closestEntity)
		ClearPedTasks(PlayerPedId())
	end
end)

exports("checkTuningZone", function()
	return IsPedInAnyVehicle(PlayerPedId()) and (TuningZones[ESX.PlayerData.job.name] and TuningZones[ESX.PlayerData.job.name]:isPointInside(GetEntityCoords(GetVehiclePedIsIn(PlayerPedId()))))
end)

RegisterNetEvent("need_mechanics:ExtrasMenu", OpenExtras)

LoadDict = function(Dict)
	while not HasAnimDictLoaded(Dict) do 
		Wait(0)
		RequestAnimDict(Dict)
	end
	
	return Dict
end

LoadModel = function(model)
	model = type(model) == "string" and joaat(model) or model
	
	if not HasModelLoaded(model) and IsModelInCdimage(model) then
		local timer = GetGameTimer() + 20000 -- 20 seconds to load
		RequestModel(model)
		while not HasModelLoaded(model) and timer >= GetGameTimer() do -- wait for the model to load
			Wait(50)
		end
	end
	
	return {loaded = HasModelLoaded(model), model = model}
end

exports.qtarget:AddTargetModel({-261389155}, {
	options = {
		{
			event = "wyciongnijkurwiefure",
            icon = "fas fa-car",
            label = "Wyciągnij pojazd",
            job = 'mechanik',
		},
		{
			event = "showaikurwiefure",
            icon = "fas fa-car",
            label = "Schowaj pojazd",
            job = 'mechanik',
		},
	},
	distance = 2
})

RegisterNetEvent('wyciongnijkurwiefure', function()
	OpenVehicleSpawnerMenu()
end)

RegisterNetEvent('showaikurwiefure', function()
	VehicleDeletersFunction()
end)