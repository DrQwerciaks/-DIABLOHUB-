local juzGada = false
local BlacklistedPeds = {
	[GetHashKey("u_f_m_casinocash_01")] = true,
	[GetHashKey("csb_trafficwarden")] = true,
	[GetHashKey("u_m_y_burgerdrug_01")] = true,
	[GetHashKey("s_m_y_xmech_01")] = true,
	[GetHashKey("s_m_m_lathandy_01")] = true,
	[GetHashKey("u_f_y_danceburl_01")] = true,
	[GetHashKey("ig_andreas")] = true,
	[GetHashKey("mp_m_shopkeep_01")] = true,
	[GetHashKey("u_m_m_jewelsec_01")] = true,
	[GetHashKey("a_m_m_business_01")] = true,
	[GetHashKey("s_m_m_autoshop_01")] = true,
    [GetHashKey("s_m_m_doctor_01")] = true,
    [GetHashKey("a_c_cow")] = true,
    [GetHashKey("a_c_boar")] = true,
    [GetHashKey("a_c_cat_01")] = true,
    [GetHashKey("a_c_chickenhawk")] = true,
    [GetHashKey("a_c_chimp")] = true,
    [GetHashKey("a_c_chop")] = true,
    [GetHashKey("a_c_crow")] = true,
    [GetHashKey("a_c_deer")] = true,
    [GetHashKey("a_c_husky")] = true,
    [GetHashKey("a_c_mtlion")] = true,
    [GetHashKey("a_c_pig")] = true,
    [GetHashKey("a_c_pigeon")] = true,
    [GetHashKey("a_c_poodle")] = true,
    [GetHashKey("a_c_pug")] = true,
    [GetHashKey("a_c_rabbit_01")] = true,
    [GetHashKey("a_c_rat")] = true,
    [GetHashKey("a_c_retriever")] = true,
    [GetHashKey("a_c_rhesus")] = true,
    [GetHashKey("a_c_rottweiler")] = true,
    [GetHashKey("a_c_seagull")] = true,
    [GetHashKey("a_c_shepherd")] = true,
    [GetHashKey("a_f_y_business_02")] = true,
    [GetHashKey("a_c_westy")] = true,
}

Citizen.CreateThread(function()
    exports.qtarget:Ped({
        options = {
            {
                icon = "fas fa-cannabis",
                label = "Zagadaj",
                distance = 1.5,
                action = function(data)
                    if IsPedAPlayer(data.entity) then return false end
                    TriggerEvent("need_selldrugs:cops", NetworkGetNetworkIdFromEntity(data.entity))
                end,
                canInteract = function(entity)
                    if BlacklistedPeds[GetEntityModel(entity)] == true then
						return false
                    end

                    if juzGada then
                        return false
                    end

                    if IsPedAPlayer(entity) then
                        return false
                    end

                    if Entity(entity).state.drugSell == true then
                        return false
                    end

                    local can = false
                    local search = exports.ox_inventory:Search('count', Config.ItemsToSell)

                    for k,v in pairs(search) do
                        if v > 0 then
                            can = true
                            break
                        end
                    end

                    return can
                end
            }
        },
        distance = 2.5
    })
end)

RegisterNetEvent("need_selldrugs:cops", function(ped)
    ESX.TriggerServerCallback("esx_scoreboard:getConnectedCops", function(MisiaczekPlayers)
        if MisiaczekPlayers then
            print(MisiaczekPlayers['police'])
            if MisiaczekPlayers['police'] >= 1 then
                TriggerServerEvent("need_selldrugs:trySell", ped)
                juzGada = true
            else
                ESX.ShowNotification("~b~Musi być minimum 1 funkcjonariuszy na służbie, aby sprzedawać narkotyki!")
            end
        end
    end)
end)

RegisterNetEvent("need_selldrugs:sell", function(netId, time, success)
    if not time then
        time = 1000
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local target = NetworkGetEntityFromNetworkId(netId)
    TaskPause(target, time)
    SetPedFleeAttributes(target, 0, false)
    TaskLookAtEntity(target, ped, time, 2048, 3)
    TaskTurnPedToFaceEntity(target, ped, time)

    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
    local heading = (GetEntityHeading(ped) + 180.0)
    ClearPedTasksImmediately(ped)
    SetEntityCoordsNoOffset(target, coords, 0.0, 0.0, 0.0)
    SetEntityHeading(target, heading)
    PlayPedAmbientSpeechNative(target, "GENERIC_BUY", "SPEECH_PARAMS_FORCE")

    SetBlockingOfNonTemporaryEvents(target, true)
    TaskStandStill(target, -1)
	FreezeEntityPosition(target, true)

    RequestAnimDict("missfbi3_party_b")
    while not HasAnimDictLoaded("missfbi3_party_b") do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), "missfbi3_party_b", "talk_inside_loop_male1", 1.0, -1.0, -1, 0, 1, 0, 0, 0)

    Wait(time)

    ClearPedTasksImmediately(PlayerPedId())

    if success then
        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do Citizen.Wait(0) end
        TaskPlayAnim(target, "mp_common", "givetake1_b", 2.0, 2.0, 3000, 0, 0, false, false, false)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 2.0, 2.0, 3000, 0, 0, false, false, false)

        Wait(3000)

        FreezeEntityPosition(target, false)
        SetBlockingOfNonTemporaryEvents(target, false)
        SetEntityAsMissionEntity(target, false, true)
        ClearPedTasksImmediately(target)

        TriggerServerEvent("need_selldrugs:sell", netId)
    else
        RequestAnimDict("divined@fndances2@new")
        while not HasAnimDictLoaded("divined@fndances2@new") do Citizen.Wait(0) end
        TaskPlayAnim(target, "divined@fndances2@new", "dfdance20", 2.0, 2.0, -1, 0, 0, false, false, false)

        Wait(1500)
        
        FreezeEntityPosition(target, false)
        SetBlockingOfNonTemporaryEvents(target, false)
        SetEntityAsMissionEntity(target, false, true)
        ClearPedTasksImmediately(target)
        TaskSmartFleePed(target, ped, 30.0, 5.0)

        local chance = GetRandomIntInRange(1, 3)
        if chance == 1 then
            ESX.ShowNotification("Obywatel odrzucił propozycję sprzedaży")
        elseif chance == 2 then
            ESX.ShowNotification("Obywatel odrzucił propozycję sprzedaży i zadzwonił na policję")
            TriggerServerEvent('need_selldrugs:setBlip', coords)
        elseif chance == 3 then
            ESX.ShowNotification("Obywatel odrzucił propozycję sprzedaży")
        end
    end
    juzGada = false
end)

RegisterNetEvent("need_selldrugs:setBlip", function(target, coords, hour)
    -- PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
    -- TriggerEvent("esx_rpchat:sendProximityMessage", "centrala", -1, nil, { 'Sprzedaż narkotyków' })
    -- local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	-- SetBlipSprite(blip, 51)
	-- SetBlipColour(blip, 4)
	-- SetBlipAlpha(blip, 250)
	-- SetBlipAsShortRange(blip, 1)
	-- BeginTextCommandSetBlipName("STRING")
	-- AddTextComponentString('# Sprzedaż narkotyków')
	-- EndTextCommandSetBlipName(blip)
	-- CreateThread(function()
	-- 	local alpha = 250
	-- 	while true do
	-- 		Citizen.Wait(180 * 4)
	-- 		SetBlipAlpha(blip, alpha)
	-- 		alpha = alpha - 1
	-- 		if alpha == 0 then
	-- 			RemoveBlip(blip)
	-- 			break
	-- 		end
	-- 	end
	-- end)
	local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    exports["diablohub_notifications"]:policeNotify({
        playerId = target,
        coords = coords,
        textColor = "#fff",
        bgColor = "#06a5ff",
        title1 = "10-72",
        title2 = "Sprzedaż narkotyków",
        blip = {
            name = "Sprzedaż narkotyków",
            sprite = 51,
            scale = 0.9,
            colour = 250,
            timeToDelete = 30000
        },
        sound = {
            file = "POLDrugDeal",
            volume = 0.3
        },
        content = {
            {
                type = "location",
                text = GetStreetNameFromHashKey(s1)
            },
            {
                type = "msg",
                text = "Godzina zgłoszenia: " .. hour
            }
        }
    })
end)