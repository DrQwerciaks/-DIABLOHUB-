local ped

Citizen.CreateThread(function()
  while true do
    ped = PlayerPedId() 
    Citizen.Wait(1000*60)
   end
end)

Citizen.CreateThread(function()
    for i=1, #Config.Garage do
        exports['DiabloHub']:CreateActionKey("ziutekgarage-"..i, Config.Garage[i].coords, 5, {
            inVehicle = true,
        }, {
            eventName = "woro-ziutek:client:fixvehicle:actionkey",
            args = { ziutekId = i },
        }, {
            label = "Kliknik ~o~E~s~ aby poprosić ziutka pomoc",
        })

        local blip = AddBlipForCoord(Config.Garage[i].coords.x, Config.Garage[i].coords.y, Config.Garage[i].coords.z)
        SetBlipSprite(blip, Config.Garage[i].blipId)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.Garage[i].scale)
        SetBlipColour(blip, Config.Garage[i].color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        -- AddTextComponentString(Config.Garage[i].title)
        AddTextComponentString("<font face='Poppins-Medium' size= '11'>".. Config.Garage[i].title .."</font>" )
        EndTextCommandSetBlipName(blip)
    end
end) 

RegisterNetEvent('woro-ziutek:client:fixvehicle:actionkey', function(data)
    local ziutekCoords = Config.Garage[data.ziutekId].coords
    
    local coords = GetEntityCoords(ped)
    local distance = #(coords - ziutekCoords)

    if distance >= 10 then
        return
    end

    TriggerServerEvent("woro-ziutek:server:fixvehicle:pay", data.ziutekId)
end)

RegisterNetEvent("woro-ziutek:client:fixvehicle", function(garageId)
    local ziutekCoords = Config.Garage[garageId].coords
    
    local coords = GetEntityCoords(ped)
    local distance = #(coords - ziutekCoords)
    local vehicle = GetVehiclePedIsUsing(ped)


    if distance >= 10 then
        return
    end

    TriggerEvent("need_taskbar:progress", {
        name = "ziutek",
        duration = 1000 * Config.Garage[garageId].time,
        label = "Naprawianie Auta",
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
      }, function(wasCancelled)
        if not wasCancelled then
            SetVehicleEngineHealth(vehicle, 100)
            SetVehicleFixed(vehicle)
        end
    end)


end)

AddEventHandler('esx:playerLoaded', function()
    ped = PlayerPedId() 
end)