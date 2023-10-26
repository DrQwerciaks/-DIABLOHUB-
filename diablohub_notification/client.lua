local blackList = {
    "~g~",
    "~r~",
    "~s~",
    "~v~",
    "~u~",
    "~w~",
    "~b~",
    "~f~",
    "~y~",
    "~o~",
    "~t~",
    "~p~",
    "~q~",
    "~d~",	
    
}

AddNotification = function(message, type, time, title)
    print(message, type, time, title)
    title = (title or "Powiadomienie")
    for i=1, #blackList do 
        if string.find(message, blackList[i]) then
            message = message:gsub(blackList[i], "")
        end
    end
    for i=1, #blackList do 
        if string.find(title, blackList[i]) then
            title = title:gsub(blackList[i], "")
        end
    end
    type = (type or "alert")
    if type == 1 then 
        type = "alert"
    end
    SendNUIMessage({
        action = "AddNotification",
        time = (time or 5000),
        image = Config.NotificationConfig[type].image or "fa-solid fa-bell",
        color = Config.NotificationConfig[type].color or "#ff8400",
        title = title,
        message = message
    })
end

RegisterNetEvent("diablohub_notification:AddNotification", AddNotification)
exports("AddNotification", AddNotification)

AddEventHandler("onClientResourceStart", function(res)
    if res == GetCurrentResourceName() then
        Wait(0)
        SendNUIMessage({
            action = "SetPosition",
            inCar = IsPedInAnyVehicle(PlayerPedId())
        })
    end
end)

lib.onCache('vehicle', function(value)
    SendNUIMessage({
        action = "SetPosition",
        inCar = value
    })
end)