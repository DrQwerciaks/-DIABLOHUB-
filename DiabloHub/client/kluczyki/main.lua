
local vehicles = {}
local dict = "anim@mp_player_intmenu@key_fob@"
local wait = 0.0


AddEventHandler("playerSpawned", function()
    TriggerServerEvent('Akira-Base:server:RestoreCarKeys')
end)

RegisterNetEvent('Akira-Base:client:SendKeys', function(data)
    vehicles = data
end)

Citizen.CreateThread(function()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
end)

RegisterCommand('togglelock', function()
    local ply = PlayerPedId()
    local pCoords = GetEntityCoords(ply)
    isInside = false

    if IsPedInAnyVehicle(ply, true) then
        localVehId = GetVehiclePedIsIn(ply, false)
        isInside = true
    else
        localVehId = GetTargetedVehicle(pCoords, ply)
    end

	local vehcoords = GetEntityCoords(localVehId)
	local dystans = #(pCoords - vehcoords)
	if dystans > 10.0 then
		return
	end

    if localVehId and localVehId ~= 0 then
        localVehPlate = string.lower(GetVehicleNumberPlateText(localVehId))
        localVehLockStatus = GetVehicleDoorLockStatus(localVehId)
        local hasKey = false

        if IsHasCarKey(localVehPlate) then
            hasKey = true
            if wait <= 0.0 then
                wait = 2.0

                CreateThread(function()
                    while wait > 0 do
                        Wait(100)
                        wait = wait - 0.1
                    end
                end)

                local status = 0

                if localVehLockStatus <= 2 then
                    if not isInside then
                        TaskPlayAnim(ply, dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                    end

                    SetVehicleDoorsLocked(localVehId, 4)
                    SetVehicleDoorsLockedForAllPlayers(localVehId, true)

                    ESX.ShowNotification('Pojazd o Nr. Rej. ' ..GetVehicleNumberPlateText(localVehId).. ' został <b><span style="color:LightCoral">zamknięty </span></b>')

                    Wait(500)
                    StartVehicleHorn(localVehId, 50, 'HELDDOWN')
                    SetVehicleLights(localVehId, 2)
        
                    Wait(100)
        
                    SetVehicleLights(localVehId, 0)
        
                    Wait(100)
        
                    StartVehicleHorn(localVehId, 50, 'HELDDOWN')
                    SetVehicleLights(localVehId, 2)
        
                    Wait(100)
        
                    SetVehicleLights(localVehId, 0)
                    
                elseif localVehLockStatus > 2 then
                    if not isInside then
                        TaskPlayAnim(ply, dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                    end
                    SetVehicleDoorsLocked(localVehId, 1)
                    SetVehicleDoorsLockedForAllPlayers(localVehId, false)
                    ESX.ShowNotification('Pojazd o Nr. Rej. ' ..GetVehicleNumberPlateText(localVehId).. ' <b><span style="color:LightGreen">otwarty</span></b>')

                    Wait(500)

                    StartVehicleHorn(localVehId, 200, 'HELDDOWN')
                    SetVehicleLights(localVehId, 2)
        
                    Wait(200)
        
                    SetVehicleLights(localVehId, 0)
                end
            else
                ESX.ShowNotification('Poczekaj ' ..wait.. ' sekund!')
            end
        elseif isInside then
            if wait <= 0.0 then
                wait = 2.0

                CreateThread(function()
                    while wait > 0 do
                        Wait(100)
                        wait = wait - 0.1
                    end
                end)

                ESX.TriggerServerCallback('Akira-Base:callback:checkOwner', function(cb)
                    if not cb then
                        TriggerServerEvent('Akira-Base:server:AddKey', localVehPlate)
                        ShowNotification('Wyjąłeś klucze ze stacyjki.')
                    else
                        ShowNotification('Nie ma kluczyków w stacyjce.')
                    end
                end, localVehPlate)
            else    
                ESX.ShowNotification('Poczekaj ' ..wait.. ' sekund!')
            end
        end
    end
end)

RegisterKeyMapping('togglelock', 'Otwieranie/Zamykanie Pojazdów', 'keyboard', 'U')

---- Timer
Citizen.CreateThread(function()
    timer = 1000
    time = 0
	while true do
		Wait(1000)
		time = time + 1000
	end
end)

function IsHasCarKey(plate)
    if vehicles ~= nil then
        for i,v in pairs(vehicles) do
            if i == plate then
                return true
            end
        end
    end
    return false
end

function ShowNotification(msg)
    ESX.ShowNotification(msg)
end

function GetVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function GetTargetedVehicle(pCoords, ply)
    for i = 1, 200 do
        coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, (6.281)/i, 0.0)
        targetedVehicle = GetVehicleInDirection(pCoords, coordB)
        if(targetedVehicle ~= nil and targetedVehicle ~= 0)then
            return targetedVehicle
        end
    end
    return
end

exports('IsHasCarKey', IsHasCarKey)