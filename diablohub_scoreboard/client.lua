local timer = false
local scoreboard = false
local ShowPlayers = {}
local PoppinsFontId = exports["DiabloHub"]:getPoppinsFontId()

local DrawHeadText = function(x, y, z, text, r, g, b)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * 0.6

    if onScreen then
        SetTextScale(0.0 * scale, 1.05 * scale)
        SetTextFont(PoppinsFontId)
        SetTextProportional(1)
        SetTextColour(r, g, b, 150)
        SetTextDropshadow(3, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        World3dToScreen2d(x, y, z, 0)
        DrawText(_x, _y)
    end
end

RegisterNetEvent("need_scoreboard:show", function(playerId, boolean)
    ShowPlayers[playerId] = boolean
end)

CreateThread(function()
    while true do
        local sleep = true
        local players = 0
        for _, _2 in pairs(ShowPlayers) do
            players = players + 1
        end
        if players > 0 then
            for _, player in ipairs(GetActivePlayers()) do
                local playerId = GetPlayerServerId(player)
                if ShowPlayers[playerId] then
                    local playerCoords = GetEntityCoords(GetPlayerPed(player))
                    if #(playerCoords - GetEntityCoords(ESX.PlayerData.ped)) < 15.0 then
                        sleep = false
                        DrawHeadText(playerCoords.x, playerCoords.y, playerCoords.z + (scoreboard and 1.12 or 1.0), "!", 255, 0, 0)
                    end
                end
            end
        end

        if sleep then
            Wait(200)
        end
        Wait(0)
    end
end)

RegisterNetEvent('esx:setOrganisation', function(org)
    ESX.PlayerData.organisation = org
end)

RegisterCommand("+showscoreboard", function()
    if timer then
        return
    end

    scoreboard = true

    SendNUIMessage({
        action = 'toggle',
        state = true
    })

    TriggerServerEvent("need_scoreboard:show")

    ESX.TriggerServerCallback("need_scoreboard:get", function(players, ThreatCode)
    
            SendNUIMessage({
                action = "updateJob", 
                praca = ESX.PlayerData.job.label .. " - " .. ESX.PlayerData.job.grade_label,
            })

        SendNUIMessage({
            action = "updatePlayerJobs", 
            jobs = players
        })

        SendNUIMessage({
            action = "updateCode", 
            code = ThreatCode
        })
    end)

    while scoreboard do
        for _, player in ipairs(GetActivePlayers()) do
            local playerId = GetPlayerServerId(player)
            local playerCoords = GetEntityCoords(GetPlayerPed(player))
            if #(playerCoords - GetEntityCoords(ESX.PlayerData.ped)) < 15.0 then
                sleep = false
                DrawHeadText(playerCoords.x, playerCoords.y, playerCoords.z + 1.0, playerId, 255, 255, 255)
            end
        end
        Wait(0)
    end
    
    SendNUIMessage({
        action = 'toggle',
        state = false
    })

    TriggerServerEvent("need_scoreboard:hide")
    timer = true
    Wait(1000)
    timer = false
end)
RegisterCommand("-showscoreboard", function()
    scoreboard = false
end)
RegisterKeyMapping("+showscoreboard", "Lista graczy", "keyboard", "z")