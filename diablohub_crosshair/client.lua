local crosshair_disable = true
RegisterCommand(config.commandName, function()
    SendNUIMessage({
        action = "crosshairPanel"
    })
    SetNuiFocus(true,true)
end)

CreateThread(function()
    while true do
        if IsAimCamActive() and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= config.exeption["weapons"][1] and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= config.exeption["weapons"][2] and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= config.exeption["weapons"][3] and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= config.exeption["weapons"][4] and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= config.exeption["weapons"][5] then 
            SendNUIMessage({
                action = "crosshairEnable"
            })
        else
            SendNUIMessage({
                action = "crosshairDisable"
            })
        end
        Wait(0)
    end
end)

function closePanel()
    SetNuiFocus(false,false)
end

function basicCrosshair_enable()
    crosshair_disable = false
end

function basicCrosshair_disable()
    crosshair_disable = true
end

CreateThread(function()
    while true do 
        while crosshair_disable do
            HideHudComponentThisFrame(14)
            Wait(0)
        end 

        while crosshair_disable == false and IsAimCamActive() do
            ShowHudComponentThisFrame(14)
            Wait(0)
        end
        Wait(0)
    end
end)

RegisterNUICallback("closePanel",closePanel)
RegisterNUICallback("basicCrosshair_enable",basicCrosshair_enable)
RegisterNUICallback("basicCrosshair_disable",basicCrosshair_disable)