ESX = exports["es_extended"]:getSharedObject()


Citizen.CreateThread(function()
    exports.qtarget:AddTargetModel({GetHashKey("p_ld_stinger_s")}, {
        options = {
            {
                event = "krs:getserverusunieciekurwaten",
                icon = "fas fa-circle-minus",
                label = "Zbierz kolczatke",
            }
        },
        distance = 3.0
        })
end)

RegisterNetEvent('krs:postawkolczatke', function()
    local kolczatka = CreateObject(LoadModel("p_ld_stinger_s").model, GetOffsetFromEntityInWorldCoords(PlayerPedId(), -0.2, 2.0, 0.0), true, true, 0)
    SetEntityAsMissionEntity(kolczatka, true, true)
    SetEntityHeading(kolczatka, GetEntityHeading(PlayerPedId()))
    FreezeEntityPosition(kolczatka, true)
    PlaceObjectOnGroundProperly(kolczatka)
    SetEntityVisible(kolczatka, false)

 
    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(PlayerPedId()), GetEntityRotation(PlayerPedId(), 2), 2, false, false, 1065353216, 0, 1.0)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("amb@medic@standing@kneel@enter"), "enter", 8.0, -8.0, 3341, 16, 1148846080, 0)
    NetworkStartSynchronisedScene(scene)

    while not IsSynchronizedSceneRunning(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) do
        Wait(0)
    end
 
    SetSynchronizedSceneRate(NetworkConvertSynchronisedSceneToSynchronizedScene(scene), 3.0)

    while GetSynchronizedScenePhase(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) < 0.14 do
        Wait(0)
    end
   
    NetworkStopSynchronisedScene(scene)

   
    PlayEntityAnim(kolczatka, "P_Stinger_S_Deploy", LoadDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.0, 0)
    while not IsEntityPlayingAnim(kolczatka, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) do
        Wait(0)
    end
    SetEntityVisible(kolczatka, true)
    while IsEntityPlayingAnim(kolczatka, "p_ld_stinger_s", "P_Stinger_S_Deploy", 3) and GetEntityAnimCurrentTime(kolczatka, "p_ld_stinger_s", "P_Stinger_S_Deploy") <= 0.99 do
        Wait(0)
    end
    PlayEntityAnim(kolczatka, "p_stinger_s_idle_deployed", LoadDict("p_ld_stinger_s"), 1000.0, false, true, 0, 0.99, 0)

    return kolczatka
end)

kola = {
    ["wheel_lf"] = 0,
    ["wheel_rf"] = 1,
    ["wheel_rr"] = 5,
    ["wheel_lr"] = 4,
}

CreateThread(function()
    while true do
        local bratzakolkiem = DoesEntityExist(GetVehiclePedIsUsing(PlayerPedId()))
        Wait((bratzakolkiem and 50) or 1000)
        local coords = GetEntityCoords((bratzakolkiem and GetVehiclePedIsUsing(PlayerPedId())) or PlayerPedId())

        local kolczatka = GetClosestObjectOfType(coords, 10.0, GetHashKey("p_ld_stinger_s"), false, false, false)
        if DoesEntityExist(kolczatka) then
            kolczatkablisko = kolczatka
            kolczatkabliskodystans = #(coords - GetEntityCoords(kolczatka))
        end

        if not DoesEntityExist(kolczatkablisko) or #(coords - GetEntityCoords(kolczatkablisko)) > 10.0 then
            kolczatkablisko = 0
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1500)
        while DoesEntityExist(GetVehiclePedIsUsing(PlayerPedId())) do
            Wait(50)
            local vehicle = GetVehiclePedIsUsing(PlayerPedId())
            while DoesEntityExist(kolczatkablisko) and kolczatkabliskodystans <= 5.0 do
                Wait(5)
                if IsEntityTouchingEntity(vehicle, kolczatkablisko) then
                    for boneName, wheelId in pairs(kola) do
                        if not IsVehicleTyreBurst(vehicle, wheelId, false) then
                            if wKolczatce(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, boneName)), kolczatkablisko) then
                                SetVehicleTyreBurst(vehicle, wheelId, 1, 1148846080)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function wKolczatce(coords, stinger)
    local min, max = GetModelDimensions(GetEntityModel(stinger))
    local size = max - min
    local w, l, h = size.x, size.y, size.z

    local offset1 = GetOffsetFromEntityInWorldCoords(stinger, 0.0, l/2, h*-1)
    local offset2 = GetOffsetFromEntityInWorldCoords(stinger, 0.0, l/2 * -1, h)

    return IsPointInAngledArea(coords, offset1, offset2, w*2, 0, false)
end

RegisterNetEvent('krs:usunkolczatke', function()
    if DoesEntityExist(kolczatkablisko) then
        TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
        Wait(4000)
        ClearPedTasks(PlayerPedId())
        NetworkRequestControlOfEntity(kolczatkablisko)
        SetEntityAsMissionEntity(kolczatkablisko, true, true)
        DeleteEntity(kolczatkablisko)
    end
end)


AddEventHandler('krs:getserverusunieciekurwaten', function()
    TriggerServerEvent('krs:zbierzkolczatke')
end)

function LoadDict(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end

    return Dict
end

function LoadModel(model)
    model = type(model) == "string" and GetHashKey(model) or model

    if not HasModelLoaded(model) and IsModelInCdimage(model) then
        local timer = GetGameTimer() + 20000 
        RequestModel(model)
        while not HasModelLoaded(model) and timer >= GetGameTimer() do 
            Wait(50)
        end
    end

    return {loaded = HasModelLoaded(model), model = model}
end

