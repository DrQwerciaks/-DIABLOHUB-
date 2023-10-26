local allPeds = {}

function SpawnPed(pedIndex, ped, coords, pedSettings, animation, weapon)

    Citizen.CreateThread(function()
        
        if allPeds[pedIndex] ~= nil then
            DeletePed(allPeds[pedIndex])
        end

        RequestModel(GetHashKey(ped))
        
        while not HasModelLoaded(GetHashKey(ped)) do
            Wait(1)
        end

        local npc = CreatePed(4, GetHashKey(ped), coords.x, coords.y, coords.z, false, false)
		
        allPeds[pedIndex] = npc
        
        FreezeEntityPosition(npc, pedSettings.FreezeEntityPosition or false)	
        SetEntityHeading(npc, coords.w)
        SetEntityInvincible(npc, pedSettings.SetEntityInvincible or false)
        SetBlockingOfNonTemporaryEvents(npc, pedSettings.SetBlockingOfNonTemporaryEvents or false)

        if animation ~= false then
			RequestAnimDict(animation.AnimationPack)
			while not HasAnimDictLoaded(animation.AnimationPack) do
			Citizen.Wait(1000)
			end
				
	        Citizen.Wait(200)	
			TaskPlayAnim(npc, animation.AnimationPack, animation.Animation, 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
        end
        if weapon ~= false then
            for i=1, #weapon.weapons do
                GiveWeaponToPed(npc, GetHashKey(weapon.weapons[i].Wepon), 0, true, false)
                SetPedAmmo(npc, GetHashKey(weapon.weapons[i].Wepon), weapon.weapons[i].Ammo)
                SetCurrentPedWeapon(npc, GetHashKey(weapon.weapons[i].Wepon), true)
            end
        end 

        
    end)

end

-- SpawnPed('a_f_y_bevhills_04', vec4(-680.597778, 326.848358, 83.081299, 181.417328), {
--     FreezeEntityPosition = true,
--     SetEntityInvincible = true,
--     SetBlockingOfNonTemporaryEvents = true,
-- }, {
--     AnimationPack = "anim@heists@prison_heiststation@cop_reactions",
--     Animation = 'cop_b_reaction',
-- }, {
--     weapons = {
--         {
--             Wepon = "WEAPON_PISTOL",
--             Ammo = 1,
--         }
--     },
--     SetCurrentPedWeapon = "WEAPON_PISTOL",
-- }
-- )