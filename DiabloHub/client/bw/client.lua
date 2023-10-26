local lastPosition = nil
local lastVehicle = nil
local lastSeat = nil
isDead = false
local firstLoop = false

RegisterNetEvent("esx:onPlayerDeath")

PlayerKilledByPlayer = function(killerServerId, killerClientId, killerWeapon)
	local victimCoords = GetEntityCoords(ESX.PlayerData.ped)
	local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
	local distance     = #(victimCoords - killerCoords)

	local data = {
		victimCoords 	= victimCoords,
		killerCoords	= killerCoords,
		killedByPlayer 	= true,
		deathCause     	= killerWeapon,
		distance       	= distance,
		killerServerId 	= killerServerId,
		killerClientId 	= killerClientId
	}

	TriggerEvent('esx:onPlayerDeath', data)
	TriggerServerEvent('esx:onPlayerDeath', data)
end

PlayerKilled = function()
	local playerPed = ESX.PlayerData.ped
	local victimCoords = GetEntityCoords(ESX.PlayerData.ped)

	local data = {
		victimCoords 	= victimCoords,
		killedByPlayer 	= false,
		deathCause     	= GetPedCauseOfDeath(playerPed)
	}

	TriggerEvent('esx:onPlayerDeath', data)
	TriggerServerEvent('esx:onPlayerDeath', data)
end

Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Citizen.Wait(0)
	end

	LocalPlayer.state:set('IsDead', false, true)
	while true do
		if NetworkIsPlayerActive(PlayerId()) then
			local playerPed = ESX.PlayerData.ped
			local coords = GetEntityCoords(playerPed, false)
			lastPosition = {x = coords.x, y = coords.y, z = coords.z, heading = GetEntityHeading(playerPed)}

			lastVehicle = GetVehiclePedIsIn(playerPed, false)
			if lastVehicle and lastVehicle ~= 0 then
				for i = GetVehicleMaxNumberOfPassengers(lastVehicle), -1, -1 do
					if GetPedInVehicleSeat(lastVehicle, i) == playerPed then
						lastSeat = i
						break
					end
				end
			else
				lastVehicle = nil
			end
		end

		Citizen.Wait(200)
	end
end)

RegisterNetEvent("gameEventTriggered", function(name, data)
	if name == "CEventNetworkEntityDamage" then
		local playerPed = ESX.PlayerData.ped
		if data[1] == playerPed then
			local player = PlayerId()
			if NetworkIsPlayerActive(player) then
				if IsPedFatallyInjured(playerPed) and not isDead then
					isDead = true
					
					local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
					local killerServerId = NetworkGetPlayerIndexFromPed(killer)
			
					if killer ~= playerPed and killerServerId ~= nil and NetworkIsPlayerActive(killerServerId) then
						PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
					else
						PlayerKilled()
					end

					TriggerEvent('baseevents:injury', lastPosition, lastVehicle, lastSeat)
				end
			end
		end
	end
end)

RegisterNetEvent('baseevents:injury')
AddEventHandler('baseevents:injury', function(position, vehicle, seat)
	Citizen.CreateThreadNow(function()
		LocalPlayer.state:set('IsDead', true, true)
		SetPlayerInvincible(PlayerId(), true)
		
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		
		while isDead do
			local playerPed = ESX.PlayerData.ped
			if not firstLoop then
				firstLoop = true
				if not vehicle then
					while IsPedRunningRagdollTask(playerPed) and isDead do
						Citizen.Wait(50)
					end
				else
					SetVehicleUndriveable(vehicle, true)
				end

				SetPedCanRagdoll(playerPed, false)
				Citizen.Wait(0)

				NetworkResurrectLocalPlayer(position.x, position.y, position.z, position.heading, true, false)
				diedAt = nil
				Citizen.Wait(0)

				playerPed = ESX.PlayerData.ped
				SetPedMaxHealth(playerPed, 200)
				SetEntityHealth(playerPed, 101)

				SetPlayerInvincible(PlayerId(), true)
				if vehicle then
					local model = GetEntityModel(vehicle)
					if (IsThisModelACar(model) or IsThisModelAnAmphibiousCar(model) or IsThisModelABoat(model)) and GetVehiclePedIsIn(playerPed, false) ~= vehicle then
						repeat
							SetPedIntoVehicle(playerPed, vehicle, seat)
							Citizen.Wait(0)
							playerPed = ESX.PlayerData.ped
						until IsPedInAnyVehicle(playerPed, false)
						SetVehicleUndriveable(vehicle, false)
						TaskPlayAnim(playerPed, 'mp_sleep', 'sleep_intro', 8.0, 1.0, -1, 18, 1.0, 0, 0, 0)
					end
				end
			elseif IsPedInAnyVehicle(playerPed, false) then
				if not IsEntityPlayingAnim(playerPed, 'mp_sleep', 'sleep_intro', 3) then
					TaskPlayAnim(playerPed, 'mp_sleep', 'sleep_intro', 8.0, 1.0, -1, 18, 1.0, 0, 0, 0)
				end
			elseif not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3) and not IsEntityPlayingAnim(playerPed, 'nm', 'firemans_carry', 3) and not IsEntityPlayingAnim(playerPed, 'missfinale_c1@', 'lying_dead_player0', 3) and not IsEntityPlayingAnim(playerPed, "fin_ext_p1-7", "cs_devin_dual-7", 3) then
				TaskPlayAnim(playerPed, 'dead', 'dead_a', 1.0, 1.0, -1, 2, 0, 0, 0, 0)
			end
			Citizen.Wait(0)
		end
		
		local playerPed = ESX.PlayerData.ped
		SetEntityHealth(playerPed, 200)
		SetPedCanRagdoll(playerPed, true)
		ClearPedBloodDamage(playerPed)
		
		SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)

		local pid = PlayerId()
		SetPlayerInvincible(pid, false)
		DisablePlayerFiring(pid, false)

		LocalPlayer.state:set('IsDead', false, true)
		TriggerServerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:onPlayerSpawn')
		TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
		
		firstLoop = false
		
		if not IsEntityPlayingAnim(playerPed, 'mp_sleep', 'sleep_intro', 3) then
			ClearPedTasksImmediately(playerPed)
		else
			ClearPedTasks(playerPed)
		end
	end)
end)

RegisterNetEvent("esx_ambulancejob:revive", function()
	isDead = false
	TriggerEvent("baseevents:injury")
end)