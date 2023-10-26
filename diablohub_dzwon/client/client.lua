oldVehicle = nil
oldDamage = 0
injuredTime = 0

isBlackedOut = false
isInjured = false
dzwonCalled = false

beltOn = false
beltStatus = true
beltCalled = false

local effect = false

function DisableDzwon()
	effect = true
end

function EnableDzwon() 
	effect = false
end

AddEventHandler('inter:pasy', function(status)
	beltStatus = status
end)

function pasyState()
	return beltOn
end

-- RegisterNetEvent('inter:dzwon')
-- AddEventHandler('inter:dzwon', function(damage)
-- 	isBlackedOut = true
-- 	dzwonCalled = false
-- 	CreateThread(function()
-- 		-- TriggerEvent('esx_voice:setMute', true)
-- 		SendNUIMessage({
-- 			transaction = 'play'
-- 		})

-- 		if not effect then
-- 			StartScreenEffect('DeathFailOut', 0, true)
-- 			if not exports['esx_basicinters']:IsDrunk() then
-- 				SetTimecycleModifier("hud_def_blur")
-- 			end
-- 		end
		
-- 		-- SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
-- 		ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
-- 		Citizen.Wait(500)

-- 		ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
-- 		Citizen.Wait(500)

-- 		ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
-- 		Citizen.Wait(500)
-- 		if not effect then
-- 			StopScreenEffect('DeathFailOut')
-- 		end

-- 		-- TriggerEvent('esx_voice:setMute', false)
-- 		isInjured = false
-- 		injuredTime = math.min(20, damage)
-- 		isBlackedOut = false
-- 	end)
-- end)

CreateThread(function()
	while true do
		Citizen.Wait(0)
		sleep = true
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) then
			sleep = false
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			local exists = DoesEntityExist(vehicle)

			local driver
			if exists then
				driver = GetPedInVehicleSeat(vehicle, -1)
			end

			if (exists and (not driver or driver == 0 or driver == playerPed)) or (not exists and DoesEntityExist(oldVehicle)) then
				local fall = true
				if exists then
					oldVehicle = vehicle
					fall = false
				end

				if not GetPlayerInvincible(PlayerId()) and not dzwonCalled then
					if IsCar(oldVehicle, false) then
						local currentDamage = GetVehicleEngineHealth(oldVehicle)
						if not isBlackedOut then
							local speed, vehicleClass = math.floor(GetEntitySpeed(oldVehicle) * 3.6 + 0.5), GetVehicleClass(oldVehicle)
							if (currentDamage < oldDamage and (oldDamage - currentDamage) >= 300) or (fall and speed > (vehicleClass == 8 and 50 or 250)) then
								local damage
								if not fall then
									damage = math.floor((oldDamage - currentDamage) / 20 + 0.5)
								else
									damage = math.floor(speed / 10 + 0.5)
								end

								local list = {}
								if oldVehicle == vehicle and driver == playerPed then
									local tmp = {}
									for _, player in ipairs(GetActivePlayers()) do
										tmp[Citizen.InvokeNative(0x43A66C31C68491C0, player)] = GetPlayerServerId(player)
									end

									for i = 0, GetVehicleNumberOfPassengers(oldVehicle) do
										local ped = GetPedInVehicleSeat(oldVehicle, i)
										if ped and ped ~= 0 then
											table.insert(list, tmp[ped])
										end
									end
								end

								dzwonCalled = true
								TriggerServerEvent('inter:dzwon', list, damage)
							end
						end

						if not fall then
							oldDamage = currentDamage
						end
					end
				end

				if fall then
					oldVehicle = nil
					oldDamage = 0
				end
			else
				oldDamage = 0
			end
		else
			oldDamage = 0
		end

		if isBlackedOut then
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			DisableControlAction(0,288,true) -- disable phone
			DisableControlAction(0,75,true) -- disable exit vehicle
		end

		if injuredTime > 0 and not isInjured then
			isInjured = true
			CreateThread(function()
				if not effect then
					ShakeGameplayCam("DRUNK_SHAKE", 5.0)
				end
				
				local reset = false
				repeat
					injuredTime = injuredTime - 1

					if not effect and not exports['esx_basicinters']:IsDrunk() then
						if not reset then
							reset = true
						end
						
						SetPedMovementClipset(playerPed, "move_m@injured", 1.0)
						SetTimecycleModifier("hud_def_blur")
					end
					
					Citizen.Wait(400)
				until injuredTime == 0
				
				if not effect then
					StopGameplayCamShaking(true)
					if reset then
						ClearTimecycleModifier()
					end

					ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
					if not exports['esx_basicinters']:IsDrunk() then
						ResetPedMovementClipset(playerPed, 0.0)
					end
				end

				SendNUIMessage({
					transaction = 'fade',
					time = 1000
				})
				isInjured = false
			end)
		end
		if sleep then
		Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('inter:impact')
AddEventHandler('inter:impact', function(speedBuffer, velocityBuffer)
	CreateThread(function()
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local vehicle = GetVehiclePedIsIn(ped, false)

			local pass = nil
			if not beltOn then
				pass = GetEntityHealth(ped)
			end
			
			if pass then
				local hr = GetEntityHeading(vehicle) + 90.0
				if hr < 0.0 then
					hr = 360.0 + hr
				end

				hr = hr * 0.0174533
				local forward = { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
				local coords = GetEntityCoords(ped)

				SetEntityCoords(ped, coords.x + forward.x, coords.y + forward.y, coords.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velocityBuffer[2].x, velocityBuffer[2].y, velocityBuffer[2].z)
				Citizen.Wait(0)

				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
				if not beltOn then
					local speed = math.floor(speedBuffer[2] * 3.6 + 0.5)
					if speed > 120 then
						Citizen.Wait(500)
						Citizen.InvokeNative(0x6B76DC1F3AE6E6A3, ped, math.floor(math.max(99, (pass - (speed - 100))) + 0.5))
					end
				end
			end
		end

		beltCalled = false
	end)
end)


AddEventHandler('inter:belt', function(status)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		beltOn = status

		local tmp = {}
		for _, player in ipairs(GetActivePlayers()) do
			tmp[Citizen.InvokeNative(0x43A66C31C68491C0, player)] = GetPlayerServerId(player)
		end

		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		for i = -1, GetVehicleNumberOfPassengers(vehicle) do
			local ped = GetPedInVehicleSeat(vehicle, i)
			if ped and ped ~= 0 then
				TriggerServerEvent('InteractSound_SV:PlayOnOne', tmp[ped], (beltOn and 'belton' or 'beltoff'), 0.35)
				TriggerEvent("es_extended:updateBeltStatus", beltOn)
			end
		end
	end
end)

CreateThread(function()

    --[[RequestStreamedTextureDict('mpinventory')
    while not HasStreamedTextureDictLoaded('mpinventory') do
        Citizen.Wait(0)
    end]]
	
	local speedBuffer = {}
	local velocityBuffer = {}

	local timer = GetGameTimer()
	while true do
		Citizen.Wait(0)
		sleep = true
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			sleep = false
			local vehicle = GetVehiclePedIsIn(ped, false)
			if vehicle ~= 0 and IsCar(vehicle, true) then
				if IsControlJustReleased(0, 29) then
					TriggerEvent('inter:belt', not beltOn)
				end

				if not beltStatus then

				elseif beltOn then
					DisableControlAction(0, 75)
					--DrawSprite('mpinventory', 'mp_specitem_ped', 0.199, 0.948, 0.015, 0.025, 0.0, 255, 255, 255, 255)
					--DrawSprite('mpinventory', 'mp_specitem_partnericon', 0.199, 0.948, 0.01, 0.02, 0.0, 0, 255, 0, 255)
				else
					--DrawSprite('mpinventory', 'mp_specitem_ped', 0.199, 0.948, 0.015, 0.025, 0.0, 255, 255, 255, 255)
					local tmp = GetGameTimer() - timer
					if tmp > 1000 then
						timer = GetGameTimer()
					elseif tmp > 500 then
						--DrawSprite('mpinventory', 'mp_specitem_partnericon', 0.199, 0.948, 0.01, 0.02, 0.0, 255, 0, 0, 255)
					end
				end

				if GetPedInVehicleSeat(vehicle, -1) == ped then
					speedBuffer[2] = speedBuffer[1]
					speedBuffer[1] = GetEntitySpeed(vehicle)
					if speedBuffer[2] ~= nil and not beltCalled and speedBuffer[2] > 27.77 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.25) and not GetPlayerInvincible(PlayerId()) and GetEntitySpeedVector(vehicle, true).y > 1.0 then
						local tmp = {}
						for _, player in ipairs(GetActivePlayers()) do
							tmp[Citizen.InvokeNative(0x43A66C31C68491C0, player)] = GetPlayerServerId(player)
						end

						local list = {}
						for i = 0, GetVehicleNumberOfPassengers(vehicle) do
							local ped = GetPedInVehicleSeat(vehicle, i)
							if ped and ped ~= 0 then
								table.insert(list, tmp[ped])
							end
						end

						local str = "^2Wypadek lub kolizja"
						local coords = GetEntityCoords(ped, false)

						local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
						if s1 ~= 0 and s2 ~= 0 then
							str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1) .. "^2 na skrzyżowaniu z ^0" .. GetStreetNameFromHashKey(s2)
						elseif s1 ~= 0 then
							str = str .. " przy ^0" .. GetStreetNameFromHashKey(s1)
						end

						TriggerServerEvent('notifyAccident', {x = coords.x, y = coords.y, z = coords.y}, str)
						
						
						
						dzwonCalled = true
						beltCalled = true

						TriggerServerEvent('inter:dzwon', list, 10)
						TriggerServerEvent('inter:impact', list, speedBuffer, velocityBuffer)
					end

					velocityBuffer[2] = velocityBuffer[1]
					velocityBuffer[1] = GetEntityVelocity(vehicle)
				else
					speedBuffer[1], speedBuffer[2], velocityBuffer[1], velocityBuffer[2] = 0.0, nil, 0.0, nil
				end
			else
				speedBuffer[1], speedBuffer[2], velocityBuffer[1], velocityBuffer[2] = 0.0, nil, 0.0, nil
			end
		else
			beltOn = false
			speedBuffer[1], speedBuffer[2], velocityBuffer[1], velocityBuffer[2] = 0.0, nil, 0.0, nil
		end
		if sleep then
		Citizen.Wait(500)
		
		end
	end
end)

function IsCar(v, ignoreBikes)
	if ignoreBikes and (IsThisModelABike(GetEntityModel(v)) or IsThisModelAQuadbike(GetEntityModel(v))) then
		return false
	end

	local vc = GetVehicleClass(v)
	return (vc >= 0 and vc <= 12) or vc == 17 or vc == 18 or vc == 20
end

function IsAffected()
	return isBlackedOut or isInjured
end