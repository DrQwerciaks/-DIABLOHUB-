local recoils = {
	[`WEAPON_STUNGUN`] = {0.1, 1.1}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.9, 1.9}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {1.0, 2.0}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {1.0, 2.0}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {1.0, 2.0}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {1.0, 2.0}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {1.0, 2.0}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {1.0, 2.0}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {1.0, 2.0}, -- COMBAT PISTOL
	[`WEAPON_HEAVYPISTOL`] = {1.0, 2.0}, -- HEAVY PISTOL
	[`WEAPON_PISTOL50`] = {1.0, 2.0}, -- Deagle
	[`WEAPON_REVOLVER`] = {1.0, 2.0}, -- Revolver MK2
	[`WEAPON_REVOLVER_MK2`] = {1.0, 2.0}, -- Revolver MK2
	[`WEAPON_GLOCK`] = {1.0, 2.0}, -- Revolver MK2
	[`WEAPON_CERAMICPISTOL`] = {1.0, 2.0}, -- Revolver MK2

	[`WEAPON_DBSHOTGUN`] = {1.0, 2.0}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {1.0, 2.0}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {1.0, 2.0}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {1.0, 2.0}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {1.0, 2.0}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {1.0, 2.0}, -- MICRO SMG (UZI)
	[`WEAPON_MACHINEPISTOL`] = {0.25, 0.50}, -- TEC-9
	[`WEAPON_MINISMG`] = {0.10, 0.15}, -- SMG
	[`WEAPON_SMG`] = {1.0, 2.0}, -- SMG
	[`WEAPON_SMG_MK2`] = {1.0, 2.0}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {1.0, 2.0}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {1.0, 2.0}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {1.0, 2.0}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {1.0, 2.0}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {1.0, 2.0}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {1.0, 2.0}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {1.0, 2.0}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {1.0, 2.0}, -- SNIPER RIFLE

	[`WEAPON_1911PISTOL`] = {4.0, 4.5} -- 1911 PISTOL
}

local effects = {
	[`WEAPON_STUNGUN`] = {0.05, 0.05}, -- STUN GUN
	[`WEAPON_FLAREGUN`] = {0.01, 0.02}, -- FLARE GUN

	[`WEAPON_SNSPISTOL`] = {0.05, 0.05}, -- SNS PISTOL
	[`WEAPON_SNSPISTOL_MK2`] = {0.05, 0.05}, -- SNS PISTOL MK2
	[`WEAPON_VINTAGEPISTOL`] = {0.05, 0.05}, -- VINTAGE PISTOL
	[`WEAPON_PISTOL`] = {0.05, 0.05}, -- PISTOL
	[`WEAPON_PISTOL_MK2`] = {0.05, 0.05}, -- PISTOL MK2
	[`WEAPON_DOUBLEACTION`] = {0.05, 0.05}, -- DOUBLE ACTION REVOLVER
	[`WEAPON_COMBATPISTOL`] = {0.05, 0.05}, -- COMBAT PISTOL
	[`WEAPON_HEAVYPISTOL`] = {0.05, 0.05}, -- HEAVY PISTOL
	[`WEAPON_PISTOL50`] = {0.05, 0.05}, -- HEAVY PISTOL
	[`WEAPON_REVOLVER`] = {0.05, 0.05}, -- HEAVY PISTOL
	[`WEAPON_REVOLVER_MK2`] = {0.05, 0.05}, -- HEAVY PISTOL
	[`WEAPON_GLOCK`] = {0.05, 0.05}, -- HEAVY PISTOL
	[`WEAPON_CERAMICPISTOL`] = {0.05, 0.05}, -- HEAVY PISTOL


	[`WEAPON_DBSHOTGUN`] = {0.05, 0.05}, -- DOUBLE BARREL SHOTGUN
	[`WEAPON_SAWNOFFSHOTGUN`] = {0.095, 0.19}, -- SAWNOFF SHOTGUN
	[`WEAPON_PUMPSHOTGUN`] = {0.09, 0.18}, -- PUMP SHOTGUN
	[`WEAPON_PUMPSHOTGUN_MK2`] = {0.09, 0.18}, -- PUMP SHOTGUN MK2
	[`WEAPON_BULLPUPSHOTGUN`] = {0.085, 0.19}, -- BULLPUP SHOTGUN

	[`WEAPON_MICROSMG`] = {0.5, 0.10}, -- MICRO SMG (UZI)
	[`WEAPON_MACHINEPISTOL`] = {0.05, 0.05}, -- MICRO SMG (UZI)
	[`WEAPON_MINISMG`] = {0.05, 0.05}, -- SMG
	[`WEAPON_SMG`] = {0.05, 0.05}, -- SMG
	[`WEAPON_SMG_MK2`] = {0.02, 0.05}, -- SMG MK2
	[`WEAPON_ASSAULTSMG`] = {0.035, 0.07}, -- ASSAULT SMG
	[`WEAPON_COMBATPDW`] = {0.035, 0.07}, -- COMBAT PDW
	[`WEAPON_GUSENBERG`] = {0.035, 0.07}, -- GUSENBERG

	[`WEAPON_COMPACTRIFLE`] = {0.05, 0.05}, -- COMPACT RIFLE
	[`WEAPON_ASSAULTRIFLE`] = {0.05, 0.05}, -- ASSAULT RIFLE
	[`WEAPON_CARBINERIFLE`] = {0.05, 0.05}, -- CARBINE RIFLE

	[`WEAPON_MARKSMANRIFLE`] = {0.025, 0.05}, -- MARKSMAN RIFLE
	[`WEAPON_SNIPERRIFLE`] = {0.025, 0.05}, -- SNIPER RIFLE	

	[`WEAPON_1911PISTOL`] = {0.05, 0.05}, -- 1911 PISTOL
	[`WEAPON_FIREWORK`] = {1.0, 2.0} -- FIREWORKS
}
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			DisplayAmmoThisFrame(false)
	
			local ped = PlayerPedId()
			if DoesEntityExist(ped) then
				local status, weapon = GetCurrentPedWeapon(ped, true)
				if status == 1 then
					if weapon == `WEAPON_FIREEXTINGUISHER` then
						SetPedInfiniteAmmo(ped, true, `WEAPON_FIREEXTINGUISHER`)
					elseif IsPedShooting(ped) then
						local inVehicle = IsPedInAnyVehicle(ped, false)
	
						local recoil = recoils[weapon]
						if recoil and #recoil > 0 then
							local i, tv = (inVehicle and 2 or 1), 0
							if GetFollowPedCamViewMode() ~= 4 then
							else
								repeat
									local t = GetRandomFloatInRange(0.1, recoil[i])
									SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + t, (recoil[i] > 0.1 and 1.2 or 0.333))
									tv = tv + t
									Citizen.Wait(0)
								until tv >= recoil[i]
							end
						end
	
						local effect = effects[weapon]
						if effect and #effect > 0 then
							ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', (inVehicle and (effect[1] * 3) or effect[2]))
						end
					end
				end
			end
		end
	end)