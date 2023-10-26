
Citizen.CreateThread(function()
    local blipson = AddBlipForCoord(-264.58932495117, -964.53527832031, 31.223501205444) 
    SetBlipSprite (blipson, 431)
		SetBlipDisplay(blipson, 4)
		SetBlipScale  (blipson, 0.8)
		SetBlipColour (blipson, 6)
		SetBlipAsShortRange(blipson, true)
		BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("<font face='Poppins-Medium' size= '11'>Centrum Pracy</font>" )
		EndTextCommandSetBlipName(blipson)
end)

exports['DiabloHub']:SpawnPed("urzad-pracy", 'u_m_y_chip', vec4(-264.58932495117, -964.53527832031, 30.223501205444, 204.417328), {
    FreezeEntityPosition = true,
    SetEntityInvincible = true,
    SetBlockingOfNonTemporaryEvents = true,
}, false, false)


exports.qtarget:AddTargetModel({0x24604B2B}, {
		options = {
		{
			event = "needrp_urzad:otworz",
			icon = "fas fa-briefcase",
			label = "Zatrudnij się",
		}
		-- {
		-- 	event = "flux_garages:OpenCoOwnerMenu",
		-- 	icon = "fas fa-car",
		-- 	label = "Zarządzaj pojazdem",
		-- },
		-- {
		-- 	event = "wait_garages:OpenContractBuyMenu",
		-- 	icon = "fas fa-car",
		-- 	label = "Zakup umowę sprzedaży pojazdu [500$]",
		-- }
	},
	distance = 2.0
})

RegisterNetEvent('needrp_urzad:otworz', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'open'
    })
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())
    ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 1.0, 0)
end)

RegisterNUICallback("setjob", function(data)
    SetNuiFocus(false, false)
    ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 1.0, 0)
    TriggerServerEvent('needrp_urzad:zatrudnijSie', data.praca)
end)