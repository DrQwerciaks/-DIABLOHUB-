local fishing = false
local cancel = false
local fishProp = nil

local CatchCancel = function()
    ESX.ShowNotification("Przerwano łowienie.")
    SetNuiFocus(false, false)
    fishing = false

    DetachEntity(fishProp)
    DeleteEntity(fishProp)
    fishProp = nil
end

local TryCatch = function()
    if LocalPlayer.state.injured then
        return
    end

    local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
    local canFishing = false

    for k, v in pairs(Config.Zones) do
        if v.CreatedPoly and v.CreatedPoly:isPointInside(playerCoords) then
            canFishing = true
            break
        end
    end

    if canFishing then
        ESX.TriggerServerCallback("realm_fishing:canCatch", function(can)
            if not can then
                ESX.ShowNotification("Nie posiadasz żadnej przynęty!")
                return
            end
            if fishing then
                return
            end
        
            fishing = 1
            CreateThread(function()
                ESX.Game.SpawnObject('prop_fishing_rod_01', {
                    x = playerCoords.x,
                    y = playerCoords.y,
                    z = playerCoords.z - 3
                }, function(obj)
                    fishProp = obj
                    AttachEntityToEntity(fishProp, ESX.PlayerData.ped, GetPedBoneIndex(ESX.PlayerData.ped, 18905), 0.18, 0.13, 0.0, 55.0, 100.0, 180.0, true, true, false, true, 1, true)
                end)

                RequestAnimDict('amb@world_human_stand_fishing@base')
                while not HasAnimDictLoaded('amb@world_human_stand_fishing@base') do
                    Citizen.Wait(0)
                end

                while fishing == 1 do
                    if not IsEntityPlayingAnim(ESX.PlayerData.ped, "amb@world_human_stand_fishing@base", "base", 3) then
                        TaskPlayAnim(ESX.PlayerData.ped, 'amb@world_human_stand_fishing@base', 'base', 1.0, -1.0, -1, 49, 1, false, false, false)
                    end

                    DisableControlAction(0, 22, true)
                    ESX.ShowHelpNotification("Naciśnij ~INPUT_VEH_DUCK~ aby przerwać łowienie")
                    if IsControlJustPressed(0, 73) then
                        CatchCancel()
                        break
                    end
                    Wait(0)
                end

                ClearPedTasks(ESX.PlayerData.ped)
            end)
        
            local timeToWait = math.random(Config.Fishing.minTime, Config.Fishing.maxTime)
            Wait(timeToWait)
        
            if fishing then
                fishing = 2

                CreateThread(function()
                    RequestAnimDict('amb@world_human_stand_fishing@idle_a')
                    while not HasAnimDictLoaded('amb@world_human_stand_fishing@idle_a') do
                        Citizen.Wait(0)
                    end
                    while fishing == 2 do
                        if not IsEntityPlayingAnim(ESX.PlayerData.ped, "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
                            TaskPlayAnim(ESX.PlayerData.ped, 'amb@world_human_stand_fishing@idle_a', 'idle_c', 1.0, -1.0, -1, 49, 1, false, false, false)
                        end
                        ESX.ShowHelpNotification("Naciśnij ~INPUT_VEH_DUCK~ aby przerwać łowienie")
                        Wait(0)
                    end
        
                    ClearPedTasks(ESX.PlayerData.ped)
                end)

                SendNUIMessage({
                    type = "open"
                })
                SetNuiFocus(true, false)
            else
                DetachEntity(fishProp)
                DeleteEntity(fishProp)
                fishProp = nil
            end
        end)
    else
        ESX.ShowNotification("W tym miejscu nie możesz łowić ryb!")
    end
end

for k, v in pairs(Config.Zones) do
    v.CreatedPoly = PolyZone:Create(v.Coords, {
      name = "fishing-zone-" .. k,
      debugGrid = false,
      gridDivisions = 25
    })
end

local StartFishing = function()
    TryCatch()
end

AddEventHandler("onResourceStop", function(res)
    if res == GetCurrentResourceName() and fishProp then
        DetachEntity(fishProp)
        DeleteEntity(fishProp)
        fishProp = nil
    end
end)

RegisterNUICallback("fishingStatus", function(data)
    local catch = data.result
    local wedkaBreak = math.random(0, 100)
    if catch == "cancel" then
        CatchCancel()
    elseif catch == "false" and wedkaBreak < Config.Fishing.chanceToBreak then
        ESX.ShowNotification("Twoja wędka się złamała.")
        TriggerServerEvent("realm_fishing:break")

        DetachEntity(fishProp)
        DeleteEntity(fishProp)
        fishProp = nil
    else
        fishing = 3

        CreateThread(function()
            RequestAnimDict('amb@world_human_stand_fishing@base')
            while not HasAnimDictLoaded('amb@world_human_stand_fishing@base') do
                Citizen.Wait(0)
            end
    
            while fishing == 3 do
                DisableControlAction(0, 22, true)
                if not IsEntityPlayingAnim(ESX.PlayerData.ped, "amb@world_human_stand_fishing@base", "base", 3) then
                    TaskPlayAnim(ESX.PlayerData.ped, 'amb@world_human_stand_fishing@base', 'base', 1.0, -1.0, -1, 49, 1, false, false, false)
                end
                Wait(0)
            end
    
            DetachEntity(fishProp)
            DeleteEntity(fishProp)
            fishProp = nil

            ClearPedTasks(ESX.PlayerData.ped)
        end)
    
        Wait(1000)
    
        SetNuiFocus(false, false)
    
        fishing = false
    
        Wait(250)
    
        if catch == "true" then
            TriggerServerEvent("realm_fishing:catch")
        end

        Wait(1000)

        TryCatch()
    end

    wykonany = false
end)

RegisterNetEvent("realm_fishing:start", StartFishing)