local voiceMode, isPaused, carhudDisplay, phoneStatus, radarDisplay, camStatus = 2, false, false, false, true, false
local zones = { ['AIRP'] = "Lotnisko LS", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "Klub Golfowy", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port LS", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N ', [45] = 'NW  ', [90] = 'W ', [135] = 'SW ', [180] = 'S ', [225] = 'SE ', [270] = 'E ', [315] = 'NE ', [360] = 'N ', }
local Vehicle = {
    isInside, 
}

--Update PlayerPed
local playerPed
Citizen.CreateThread(function()
    playerPed = PlayerPedId()
    Citizen.Wait(1000*5)
    while true do
        playerPed = PlayerPedId()
        Citizen.Wait(1000*60)
    end
end)

local function SetupHud()
    SendNUIMessage({
        action = "setuphud",
    })
end
local function UpdateWatermark()
    SendNUIMessage({
        action = "updatewatermark",
        watermark = {
            playerId = GetPlayerServerId(PlayerId()),
            playerName = GetPlayerName(PlayerId()),
        }
    })
end
local hudMenu = false
local function OpenHudSettings()
    if hudMenu then
        hudMenu = false
        SendNUIMessage({
            action = "closeui",
        })
        SetNuiFocus(false, false)
    else
        hudMenu = true
        SendNUIMessage({
            action = "openui",
        })
        SetNuiFocus(true, true)
    end 
end

local function SetDataSpeedometr(data)
    local speed1 = 0
    local speed2 = 0
    local speed3 = 0
    local speed = tostring(math.ceil(data.speed * 3.6))
    if #speed == 1 then
        speed3 = speed
    elseif #speed == 2 then
        local int = 2
        for letter in speed:gmatch(".") do 
            if int == 2 then
                speed2 = letter
                int = 3
            elseif int == 3 then
                speed3 = letter
            end
        end
    elseif #speed == 3 then
        local int = 1
        for letter in speed:gmatch(".") do 
            if int == 1 then
                speed1 = letter
                int = 2
            elseif int == 2 then
                speed2 = letter
                int = 3
            elseif int == 3 then
                speed3 = letter
            end
        end
    end
    -- if data.percentRPM == 0 then
    --     data.percentRPM = 5
    -- end


    SendNUIMessage({
        action = 'updatespeedometer',
        car = {
            percentRPM = data.rpm,
            speed1 = speed1,
            speed2 = speed2,
            speed3 = speed3,
            fuel = data.fuel,
        },
    })
end

local function SetEngineStatus(status)
    SendNUIMessage({
        action = 'setenginestatus',
        engine = status,
    })
end


local function SetBeltStatus(status) 
    SendNUIMessage({
        action = 'setbeltstatus',
        belt = status,
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if Vehicle.isInside then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            -- local rpm_show = GetVehicleCurrentRpm(vehicle)
            local rpm_show = GetVehicleCurrentRpm(vehicle)
            local speed = GetEntitySpeed(vehicle)
            local fuelamount = math.floor(GetVehicleFuelLevel(vehicle) or 0)

            SetEngineStatus(GetIsVehicleEngineRunning(vehicle))
            SetDataSpeedometr({speed = speed, rpm = rpm_show, fuel = fuelamount})
        end
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
        if camStatus == false then
            if IsPauseMenuActive() and not isPaused then
                isPaused = true
                SendNUIMessage({action = 'switchhud', switchHud = {
                    pausemenu = false,
                }})
            elseif not IsPauseMenuActive() and isPaused then
                isPaused = false
                SendNUIMessage({action = 'switchhud', switchHud = {
                    pausemenu = true,
                }})
            end

            Vehicle.isInside = IsPedInAnyVehicle(playerPed, false)

            if not isPaused and not phoneStatus then
                SendNUIMessage({
                    action = "updatevehicle",
                    vehicle = Vehicle.isInside,
                })
            end 

            -- phoneStatus = exports['qs-smartphone']:isPhoneOpen()

            if phoneStatus then
                if radarDisplay then
                    DisplayRadar(true, true)
                end
                SendNUIMessage({action = 'switchhud', switchHud = {
                    hud = false,
                    speedometer = false,
                    streetlabael = false,
                }})
            else
                if radarDisplay then
                    DisplayRadar(false, false)
                end
                SendNUIMessage({action = 'switchhud', switchHud = {
                    hud = true,
                    speedometer = Vehicle.isInside,
                    streetlabael = Vehicle.isInside,
                }})
            end

            if Vehicle.isInside then
                if radarDisplay then
                    DisplayRadar(true, true)
                end
                local pos = GetEntityCoords(playerPed)
                local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
                local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
        


                for k,v in pairs(directions)do
                    direction = GetEntityHeading(playerPed)
                    if(math.abs(direction - k) < 22.5)then
                        direction = v
                        break;
                    end
                end
        
                if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z)) then
                    if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1))) then
                        tekstLokalizacji = tostring(GetStreetNameFromHashKey(var1))
                        tekstkierunek = direction

                        SendNUIMessage({
                            action = "updatestreetlabael",
                            label = tekstkierunek .." | ".. tekstLokalizacji,
                        })
                    end
                end
            end
            TriggerEvent("woro-hud:client:updatehud")
        end
	end
end)




RegisterNetEvent("woro-hud:client:updatehud", function()
    if ESX.PlayerLoaded and camStatus == false then
        local health = GetEntityHealth(playerPed, false) - 100
        local hunger, thirst, drunk
        local armor = GetPedArmour(playerPed)

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
            if hunger == 10 then
                ESX.ShowNotification("Uwaga, zaczyna burczeć ci w brzuchu")
            end
        end)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
            if thirst == 10 then 
                ESX.ShowNotification("Uwaga, odwadniasz się!")
            end
        end)

        SendNUIMessage({
            action = "updatehud",
            hud = {
                health = health,
                hunger = hunger,
                thirst = thirst,
                voice = voiceMode,
                armor = armor,
            }
        })
    end
end)

AddEventHandler('pma-voice:setTalkingMode', function(newTalkingRange) 
    voiceMode = newTalkingRange

    TriggerEvent("woro-hud:client:updatehud")
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        local isPlayerSpeaking = NetworkIsPlayerTalking(PlayerId())

        SendNUIMessage({
            action = "updatevoice",
            voice = isPlayerSpeaking
        }) 
    end
end)

AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded = true
    playerPed = PlayerPedId()
    
    SetupHud()
    UpdateWatermark()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    ESX.PlayerLoaded = true

    Citizen.Wait(3000)
    SetupHud()
    UpdateWatermark()
end)

RegisterCommand("hud", function()
    OpenHudSettings()
end)

RegisterNUICallback('closemenu', function()
    hudMenu = false
	SetNuiFocus(false, false)
end)


AddEventHandler("es_extended:updateBeltStatus", function(status)
    SetBeltStatus(status)
end)


Citizen.CreateThread(function()
    exports("UpdateTempomat", function(value)
        if value ~= nil then
            SendNUIMessage({
                action = "updatetempomat",
                status = value
            })
        end
    end)
end)


RegisterCommand("cam", function()
    if camStatus then
		SendNUIMessage({
			action = "setcam",
            status = false,
		})
        camStatus = false
        radarDisplay = true
        exports["diablohub_notifications"]:HideBodyCam(false)
    else    
		SendNUIMessage({
			action = "setcam",
            status = true,
		})
        camStatus = true
        radarDisplay = false
        DisplayRadar(false, false)
        exports["diablohub_notifications"]:HideBodyCam(true)

    end
end)
RegisterNUICallback("cam", function(data)
    SendNUIMessage({
        action = "setcam",
        status = data.cam,
    })
    camStatus = data.cam
	exports["diablohub_notifications"]:HideBodyCam(data.cam)
    if data.cam then
        DisplayRadar(false, false)
    end
end)

function SwitchHud(data)
    SendNUIMessage({action = 'switchhud', switchHud = data})
end


exports("SwitchHud", SwitchHud)