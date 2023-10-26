local Open = function()
    SetNuiFocus(true, true)
    exports['diablohub_hud']:SwitchHud({
        hudstatus = false,
    })
    SendNUIMessage({
        type = "open"
    })
end
RegisterNetEvent("need_radio:open", Open)

local Close = function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "close"
    })
end
exports("Close", Close)
RegisterNetEvent("need_radio:close", Open)

RegisterNetEvent("esx:setJob", function(job)
    local channel = exports["pma-voice"]:getRadioChannel()
    if channel > 0 then
        local channelCfg = Config.RestrictedChannels[channel]
        local can = false
        if channelCfg then
            for i = 1, #(channelCfg) do
                if ESX.PlayerData.job.name == channelCfg[i] then
                    can = true
                    break
                end
            end
        else
            can = true
        end

        if not can then
            exports['pma-voice']:setVoiceProperty('radioEnabled', false)
            exports['pma-voice']:setRadioChannel(0)
        end
    end
end)

RegisterNUICallback("close", function()
    exports['diablohub_hud']:SwitchHud({
        hudstatus = true,
    })
    SetNuiFocus(false, false)
end)

local PlayersOnRadio = {}

local UpdateUsers = function()
    local channel = exports["pma-voice"]:getRadioChannel()
    local add = channel > 0 and Config.ListShow[channel]
    if add then
        SendNUIMessage({
            type = "update",
            show = true,
            users = PlayersOnRadio,
            name = Config.ChannelName[channel] or channel,
            number = ""
        })
    else
        SendNUIMessage({
            type = "update",
            show = false
        })
    end
end

local ChannelJoin = function(channel)
    exports['pma-voice']:setVoiceProperty('radioEnabled', true)
    exports['pma-voice']:setRadioChannel(channel)

    ESX.TriggerServerCallback("need_radio:GetUsersData", function(data)
        PlayersOnRadio = data
        UpdateUsers()
    end, channel)
end

RegisterNUICallback("join", function(data)
    local channel = tonumber(data.channel)
    local channelCfg = Config.RestrictedChannels[channel]
    local can = false
    if channelCfg then
        for i = 1, #(channelCfg) do
            if ESX.PlayerData.job.name == channelCfg[i] then
                can = true
                break
            end
        end
    else
        can = true
    end

    if not can then
        lib.notify({
            description = "Ta częstotliwość jest szyfrowana"
        })
        return
    end

    ChannelJoin(channel)
end)

RegisterNUICallback("leave", function()
    exports['pma-voice']:setVoiceProperty('radioEnabled', false)
    exports['pma-voice']:setRadioChannel(0)
end)

RegisterNetEvent("pma-voice:addPlayerToRadio", function(source)
    ESX.TriggerServerCallback("need_radio:GetUserData", function(data)
        PlayersOnRadio[source] = data
        UpdateUsers()
    end, source)
end)

RegisterNetEvent("pma-voice:removePlayerFromRadio", function(source)
    PlayersOnRadio[source] = nil
    UpdateUsers()
end)

RegisterNetEvent("pma-voice:setTalkingOnRadio", function(source, talking)
    PlayersOnRadio[source].active = talking
    UpdateUsers()
end)

RegisterNetEvent("pma-voice:radioActive", function(talking)
    PlayersOnRadio[GetPlayerServerId(PlayerId())].active = talking
    UpdateUsers()
end)

AddEventHandler("onResourceStop", function(res)
    if res == GetCurrentResourceName() then
        exports['pma-voice']:setVoiceProperty('radioEnabled', false)
        exports['pma-voice']:setRadioChannel(0)
    end
end)

RegisterNetEvent("need_radialmenu:setRadioChannel", function(data)
    ChannelJoin(data.channel)
end)