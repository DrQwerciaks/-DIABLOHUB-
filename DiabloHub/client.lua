local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}
local jobName = nil
local fontId

Citizen.CreateThread(function()
    RegisterFontFile('Poppins-Medium')
    fontId = RegisterFontId('Poppins-Medium') 
end)

exports("getPoppinsFontId", function()
    return fontId
end)

-- ANTY KOLBA 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed( -1 )
        local weapon = GetSelectedPedWeapon(ped)
        
        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
			DisableControlAction(0, 140, true) 
			DisableControlAction(0, 80, true)  
        end
    end
end)

CreateThread(function()
	local minimap = RequestScaleformMovie("minimap")
	while true do
		Wait(0)
		BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
		ScaleformMovieMethodAddParamInt(3)
		EndScaleformMovieMethod()
	end
end)

CreateThread(function()
	for i = 1, 15 do 
		EnableDispatchService(i, false)
	end

	SetMaxWantedLevel(0)
end)

CreateThread(function()
    while (ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil or ESX.GetPlayerData().job.name == nil) do
		Wait(100)
	end

    PlayerData = ESX.GetPlayerData()
    
    jobName = GetJobName()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    jobName = GetJobName()
end)


function GetJobName()
    if (PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name ~= nil) then
        return PlayerData.job.name
	end
	return nil
end


local HUD = {
	Blip = nil,
  }
  
CreateThread(function()
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)

	SetBlipAlpha(GetMainPlayerBlipId(), 0)
	SetBlipAlpha(GetNorthRadarBlip(), 0)
	while true do
		SetRadarZoom(1100)
		local ped = PlayerPedId()
		local heading = GetEntityHeading(ped)
		local vehicle = IsPedInAnyVehicle(ped, false)
		if HUD.Blip and DoesBlipExist(HUD.Blip) then
			RemoveBlip(HUD.Blip)
		end

		HUD.Blip = AddBlipForEntity(ped)
		SetBlipSprite(HUD.Blip, (vehicle and 1 or 1))

		SetBlipScale(HUD.Blip, 1.0)
		SetBlipCategory(HUD.Blip, 1)
		SetBlipPriority(HUD.Blip, 10)
		SetBlipColour(HUD.Blip, 55)
		SetBlipAsShortRange(HUD.Blip, true)

		SetBlipRotation(HUD.Blip, math.ceil(heading))
		ShowHeadingIndicatorOnBlip(HUD.Blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("<font face='Poppins-Medium' size= '11'>Twoja pozycja</font>" )
		EndTextCommandSetBlipName(HUD.Blip)

		Wait(500)
	end
end)

-- SHUFF
local DisableShuffle = true
CreateThread(function()
    while true do
		if DisableShuffle then
			local ped = ESX.PlayerData.ped
			local veh = GetVehiclePedIsIn(ped)
			if IsPedInAnyVehicle(ped, false) then
				if GetPedInVehicleSeat(veh, false, 0) == ped then
					if GetIsTaskActive(ped, 165) then
						SetPedIntoVehicle(ped, veh, 0)
						SetPedConfigFlag(ped, 184, true)
					end
				end
			end
		end
        Wait(5)
	end
end)

RegisterCommand("seat", function(a, args)
	local veh = GetVehiclePedIsIn(ESX.PlayerData.ped)
	if veh ~= 0 then
		SetPedIntoVehicle(ESX.PlayerData.ped, veh, ESX.Math.Round(args[1] - 2))
	end
end)
for i = -1, 10 do
	RegisterCommand("seat" .. (i + 2), function()
		local veh = GetVehiclePedIsIn(ESX.PlayerData.ped)
		if veh ~= 0 then
			SetPedIntoVehicle(ESX.PlayerData.ped, veh, i)
		end
	end)
end


-- GANGI/PEDY/STRZELANIE
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AGGRESSIVE_INVESTIGATE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("LOST"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(5, GetHashKey("SHARK"), GetHashKey('PLAYER'))

-- STAN AFK 

DisableIdleCamera(true)

-- Custom ESC

CreateThread(function()

   AddTextEntryByHash('PM_SCR_MAP', '<font face="Poppins-Medium">Mapa</font>')
   AddTextEntryByHash('PM_SCR_GAM', '<font face="Poppins-Medium">Gra</font>')
   AddTextEntryByHash('PM_SCR_INF', '<font face="Poppins-Medium">Dane</font>')
   AddTextEntryByHash('PM_SCR_STA', '<font face="Poppins-Medium">Statystyki</font>')
   AddTextEntryByHash('PM_SCR_SET', '<font face="Poppins-Medium">Ustawienia</font>')
   AddTextEntryByHash('PM_SCR_GAL', '<font face="Poppins-Medium">Galeria</font>')
   AddTextEntryByHash('PM_SCR_RPL', '<font face="Poppins-Medium">Edytor Rockstar</font>')
end)

-- Tempomat

local Player, tempomat          = nil, false
local CruisedSpeed    = 0
local CruisedSpeedKm  = 0

RegisterCommand("tempomat", function()
	Player = PlayerPedId()
	if IsDriver() and GetIsVehicleEngineRunning(GetVehicle()) then
		TriggerCruiseControl()
	
	end
end)

RegisterKeyMapping("tempomat", "Tempomat", "KEYBOARD", "GRAVE")



CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			exports['diablohub_hud']:UpdateTempomat(tempomat)
		else
			exports['diablohub_hud']:UpdateTempomat(tempomat)
			Citizen.Wait(500)
		end
	end
end)

function TriggerCruiseControl()
	if CruisedSpeed == 0 and IsDriving() then
		if GetVehicleSpeed() > 0 then
			CruisedSpeed = GetVehicleSpeed()
			CruisedSpeedKm = TransformToKm(CruisedSpeed)

			ESX.ShowNotification('Tempomat włączony: ~p~' .. CruisedSpeedKm .. ' km/h')
			tempomat = true
			CreateThread(function ()
				while CruisedSpeed > 0 and IsInVehicle() == Player do
					Citizen.Wait(0)
					if not GetIsVehicleEngineRunning(GetVehicle()) then
						CruisedSpeed = 0
						break
					end

					if not IsTurningOrHandBraking() and GetVehicleSpeed() > (CruisedSpeed + 1.0) then
						CruisedSpeed = 0
						ESX.ShowNotification('Tempomat wyłączony')
						tempomat = false
						Citizen.Wait(2000)
						break
					end

					if not IsTurningOrHandBraking() and IsVehicleOnAllWheels(GetVehicle()) and GetVehicleSpeed() < CruisedSpeed then
						SetEntityMaxSpeed(GetVehicle(), CruisedSpeed)
						--SetVehicleForwardSpeed(GetVehicle(), CruisedSpeed)
					end

					if IsControlJustPressed(0, Keys["~"]) then
						CruisedSpeed = GetVehicleSpeed()
						CruisedSpeedKm = TransformToKm(CruisedSpeed)
					end

					if IsControlJustPressed(2, 72) then
						CruisedSpeed = 0
						ESX.ShowNotification('Tempomat wyłączony')
						resetspeed = 99999.9
						SetEntityMaxSpeed(GetVehicle(), resetspeed)
						tempomat = false
						Citizen.Wait(2000)
						break
					end
				end
			end)
		end
	end
end

function angle(veh)
	if not veh then return false end
	local vx,vy,vz = table.unpack(GetEntityVelocity(veh))
	local modV = math.sqrt(vx*vx + vy*vy)
	
	
	local rx,ry,rz = table.unpack(GetEntityRotation(veh,0))
	local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))
	
	if GetEntitySpeed(veh)* 3.6 < 30 or GetVehicleCurrentGear(veh) == 0 then return 0,modV end --speed over 30 km/h
	
	local cosX = (sn*vx + cs*vy)/modV
	if cosX > 0.966 or cosX < 0 then return 0,modV end
	return math.deg(math.acos(cosX))*0.5, modV
end
	

function IsTurningOrHandBraking ()
	return IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64) or IsControlPressed(2, 71) or angle(GetVehicle()) > 2.5
end

function IsDriving ()
  return IsPedInAnyVehicle(Player, false)
end

function GetVehicle ()
  local vehicle = GetVehiclePedIsIn(Player, false)
  if (GetVehicleClass(vehicle) >= 0 and GetVehicleClass(vehicle) <= 12) or GetVehicleClass(vehicle) == 17 or GetVehicleClass(vehicle) == 18 or GetVehicleClass(vehicle) == 20 then
	return vehicle
  end
end

function IsInVehicle ()
  return GetPedInVehicleSeat(GetVehicle(), -1)
end

function IsDriver ()
  return GetPedInVehicleSeat(GetVehiclePedIsIn(Player, false), -1) == Player
end

function GetVehicleSpeed ()
  local vehicle = GetVehicle()
  local speed = GetEntitySpeed(vehicle)
  return GetVehicleCurrentGear(vehicle) > 0 and speed or (speed * -1)
end

function TransformToKm (speed)
  return math.floor(speed * 3.6 + 0.5)
end

function IsEnabled()
  return CruisedSpeed ~= 0
end

-- Minimapka

Citizen.CreateThread(
    function()
        RequestStreamedTextureDict("trianglemap", false)
        while not HasStreamedTextureDictLoaded("trianglemap") do
            Wait(100)
        end

        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "trianglemap", "radarmasksm")

        SetMinimapClipType(1)
        SetMinimapComponentPosition("minimap", "L", "B", startMinimapX, startMinimapY, 0.153, 0.20)
        SetMinimapComponentPosition("minimap_mask", "L", "B", startMinimapX, startMinimapY, 0.193, 0.164)
        SetMinimapComponentPosition("minimap_blur", "L", "B", startMinimapX, startMinimapY, 0.229, 0.310)

        local minimap = RequestScaleformMovie("minimap")

    end
)

-- DriveBy

local passengerDriveBy = true 


Citizen.CreateThread(function()
    while true do
        Wait(1)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local speed = GetEntitySpeed(vehicle)
        local kmh = 3.6
        local vehicleClass = GetVehicleClass(vehicle)


        if vehicleClass ~= 15 and 16 then
        GetEntitySpeed(GetPedInVehicleSeat(PlayerPedId(), false)) 
        if math.floor(speed*kmh) > 60 then --- tutaj ustawiasz do ilu max km/h mozna robić driveby 
                SetPlayerCanDoDriveBy(PlayerId(), false)
            elseif passengerDriveBy then
                SetPlayerCanDoDriveBy(PlayerId(), true)
            else
                SetPlayerCanDoDriveBy(PlayerId(), false)
            end
        end
    end
end)

local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for _, iter in ipairs({1, 2, 3, 4, 6, 7, 8, 9, 13, 17, 18}) do
			HideHudComponentThisFrame(iter)
		end

		local ped = PlayerPedId()

		local inVehicle = IsPedInAnyVehicle(ped, false)
		if not show then
			-- HideHudComponentThisFrame(14)
			local aiming, shooting = IsControlPressed(0, 25), IsPedShooting(ped)
			local nothing, weapon = GetCurrentPedWeapon(ped, true)
			if aiming or shooting then
				if shooting and not aiming then
					isShooting = true
					aimTimer = 0
				else
					isShooting = false
				end

				if not isAiming then
					isAiming = true

					lastCamera = GetFollowPedCamViewMode()
					if lastCamera ~= 4 then
						if weapon == GetHashKey('WEAPON_UNARMED') or weapon == GetHashKey('WEAPON_MACHETE') or weapon == GetHashKey('WEAPON_KNIFE') or weapon == GetHashKey('WEAPON_SWITCHBLADE') or weapon == GetHashKey('WEAPON_BATTLEAXE') or weapon == GetHashKey('WEAPON_NIGHTSTICK') or weapon == GetHashKey('WEAPON_BAT') then
							SetFollowPedCamViewMode(4)
						else
							SetFollowPedCamViewMode(2)
						end
						
					end
				elseif GetFollowPedCamViewMode() ~= 4 then
						if weapon == GetHashKey('WEAPON_UNARMED') or weapon == GetHashKey('WEAPON_MACHETE') or weapon == GetHashKey('WEAPON_KNIFE') or weapon == GetHashKey('WEAPON_SWITCHBLADE') or weapon == GetHashKey('WEAPON_BATTLEAXE') or weapon == GetHashKey('WEAPON_NIGHTSTICK') or weapon == GetHashKey('WEAPON_BAT') then
						SetFollowPedCamViewMode(4)
					else
						SetFollowPedCamViewMode(2)
					end
				end
			elseif isAiming then
				local off = true
				if isShooting then
					off = false
					aimTimer = aimTimer + 20
					if aimTimer == 3000 then
						isShooting = false
						aimTimer = 0
						off = true
					end
				end

				if off then
					isAiming = false
					if lastCamera ~= 4 then
						SetFollowPedCamViewMode(lastCamera)
					end
				end
			elseif not inVehicle then
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 141, true)
				DisableControlAction(0, 142, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 263, true)
				DisableControlAction(0, 264, true)
			end
		end

		if inVehicle then
			local vehicle = GetVehiclePedIsIn(ped, false)
			if DoesVehicleHaveWeapons(vehicle) == 1 then
				local vehicleWeapon, vehicleWeaponHash = GetCurrentPedVehicleWeapon(playerped)
				if vehicleWeapon == 1 then
					DisableVehicleWeapon(true, vehicleWeaponHash, vehicle, playerPed)
					SetCurrentPedVehicleWeapon(playerPed, `WEAPON_UNARMED`)
				end
			end

			DisableControlAction(0, 354, true)
			DisableControlAction(0, 351, true)
			DisableControlAction(0, 350, true)
			DisableControlAction(0, 357, true)
		end
	end
end)

-- QUIT


RegisterNetEvent("quit:sync")
AddEventHandler("quit:sync", function(id, coords, name, reason)
    Display(id, coords, name, reason)
end)

function Display(id, coords2, name, reason)
    local display = true
	local _reason = reason or ""

    CreateThread(function()
        Citizen.Wait(30000)
        display = false
    end)
	
	while display do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId())
		if #(coords - coords2) < 15.0 and LocalPlayer.state.DisplayScoreboard ~= nil then
			DrawText3Ds(coords2, 'Obywatel opuścił rozgrywkę~n~ID: '..id..'~n~Nick: '..name..'~n~Powód: '.._reason, { 255, 255, 255 }, 0.3, {0.003, 0.02, 325})
		else
			Citizen.Wait(2000)
		end
	end
end

function DrawText3Ds(coords, text, color, size, rect)
	size = size or 0.4
	rect = rect or {0.005, 0.03, 250}

    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px, py, pz) - coords)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
	SetTextScale(size, size)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(color[1], color[2], color[3], 215)
	SetTextCentre(1)

	SetTextEntry("STRING")
	AddTextComponentString(text)
	local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
	DrawText(_x,_y)

	DrawRect(_x, _y + 0.0385, rect[1] + 0.10, rect[2] + 0.06, 41, 11, 41, 68)
end

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)


local requestedIpl = {"h4_islandairstrip", "h4_islandairstrip_props", "h4_islandx_mansion", "h4_islandx_mansion_props", "h4_islandx_props", "h4_islandxdock", "h4_islandxdock_props", "h4_islandxdock_props_2", "h4_islandxtower", "h4_islandx_maindock", "h4_islandx_maindock_props", "h4_islandx_maindock_props_2", "h4_IslandX_Mansion_Vault", "h4_islandairstrip_propsb", "h4_beach", "h4_beach_props", "h4_beach_bar_props", "h4_islandx_barrack_props", "h4_islandx_checkpoint", "h4_islandx_checkpoint_props", "h4_islandx_Mansion_Office", "h4_islandx_Mansion_LockUp_01", "h4_islandx_Mansion_LockUp_02", "h4_islandx_Mansion_LockUp_03", "h4_islandairstrip_hangar_props", "h4_IslandX_Mansion_B", "h4_islandairstrip_doorsclosed", "h4_Underwater_Gate_Closed", "h4_mansion_gate_closed", "h4_aa_guns", "h4_IslandX_Mansion_GuardFence", "h4_IslandX_Mansion_Entrance_Fence", "h4_IslandX_Mansion_B_Side_Fence", "h4_IslandX_Mansion_Lights", "h4_islandxcanal_props", "h4_beach_props_party", "h4_islandX_Terrain_props_06_a", "h4_islandX_Terrain_props_06_b", "h4_islandX_Terrain_props_06_c", "h4_islandX_Terrain_props_05_a", "h4_islandX_Terrain_props_05_b", "h4_islandX_Terrain_props_05_c", "h4_islandX_Terrain_props_05_d", "h4_islandX_Terrain_props_05_e", "h4_islandX_Terrain_props_05_f", "H4_islandx_terrain_01", "H4_islandx_terrain_02", "H4_islandx_terrain_03", "H4_islandx_terrain_04", "H4_islandx_terrain_05", "H4_islandx_terrain_06", "h4_ne_ipl_00", "h4_ne_ipl_01", "h4_ne_ipl_02", "h4_ne_ipl_03", "h4_ne_ipl_04", "h4_ne_ipl_05", "h4_ne_ipl_06", "h4_ne_ipl_07", "h4_ne_ipl_08", "h4_ne_ipl_09", "h4_nw_ipl_00", "h4_nw_ipl_01", "h4_nw_ipl_02", "h4_nw_ipl_03", "h4_nw_ipl_04", "h4_nw_ipl_05", "h4_nw_ipl_06", "h4_nw_ipl_07", "h4_nw_ipl_08", "h4_nw_ipl_09", "h4_se_ipl_00", "h4_se_ipl_01", "h4_se_ipl_02", "h4_se_ipl_03", "h4_se_ipl_04", "h4_se_ipl_05", "h4_se_ipl_06", "h4_se_ipl_07", "h4_se_ipl_08", "h4_se_ipl_09", "h4_sw_ipl_00", "h4_sw_ipl_01", "h4_sw_ipl_02", "h4_sw_ipl_03", "h4_sw_ipl_04", "h4_sw_ipl_05", "h4_sw_ipl_06", "h4_sw_ipl_07", "h4_sw_ipl_08", "h4_sw_ipl_09", "h4_islandx_mansion", "h4_islandxtower_veg", "h4_islandx_sea_mines", "h4_islandx", "h4_islandx_barrack_hatch", "h4_islandxdock_water_hatch", "h4_beach_party"}

CreateThread(function()
    for i = #requestedIpl, 1, -1 do
        RequestIpl(requestedIpl[i])
        requestedIpl[i] = nil
    end
    requestedIpl = nil
end)

CreateThread(function()
    while true do
        SetRadarAsExteriorThisFrame()
        SetRadarAsInteriorThisFrame(`h4_fake_islandx`, vec(4700.0, -5145.0), 0, 0)
        Wait(0)
    end
end)

CreateThread(function()
    Wait(2500)
    local islandLoaded = false
    local islandCoords = vector3(4840.571, -5174.425, 2.0)
    SetDeepOceanScaler(0.0)
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        if #(pCoords - islandCoords) < 2000.0 then
            if not islandLoaded then
                islandLoaded = true
                Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 1)
            end
        else
            if islandLoaded then
                islandLoaded = false
                Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 0)
            end
        end
        Wait(5000)
    end
end)

local curWeapon = nil
local ox_inventory = exports.ox_inventory
local ped = cache.ped
local playerLoaded = false
local Weapons = {
    [`weapon_assaultshotgun`] = { object = `w_sg_assaultshotgun`, item = 'WEAPON_ASSAULTSHOTGUN', rot = vector3(0,0,0)},
    [`weapon_combatpdw`] = { object = `w_sb_pdw`, item = 'WEAPON_COMBATPDW', rot = vector3(0,0,0)},
    [`weapon_pumpshotgun`] = {object = `w_sg_pumpshotgun`, item = 'WEAPON_PUMPSHOTGUN', rot = vector3(0,0,0)},
    [`weapon_assaultrifle`] = {object = `w_ar_assaultrifle`, item = 'WEAPON_ASSAULTRIFLE', rot = vector3(0,0,0)},
    [`WEAPON_590`] = {object = `w_sg_590`, item = 'WEAPON_590', rot = vector3(0,0,0)},
    [`WEAPON_SWEEPERSHOTGUN`] = {object = `w_sg_sweeper`, item = 'WEAPON_SWEEPERSHOTGUN', rot = vector3(0,0,0)},
    [`WEAPON_SPECIALCARBINE_MK2`] = {object = `w_ar_specialcarbinemk2`, item = 'WEAPON_SPECIALCARBINE_MK2', rot = vector3(0,0,0)},
    [`WEAPON_M4`] = {object = `w_ar_m4`, item = 'WEAPON_M4', rot = vector3(0,0,0)},
    [`WEAPON_M16`] = {object = `w_ar_m16`, item = 'WEAPON_M16', rot = vector3(0,0,0)},
    [`WEAPON_AR15`] = {object = `w_ar_ar15`, item = 'WEAPON_AR15', rot = vector3(0,0,0)},
    [`WEAPON_SPECIALCARBINE`] = {object = `w_ar_specialcarbine`, item = 'WEAPON_SPECIALCARBINE', rot = vector3(0,0,0)},
    [`WEAPON_SNIPERRIFLE`] = {object = `w_sr_sniperrifle`, item = 'WEAPON_SNIPERRIFLE', rot = vector3(0,0,0)},
    [`WEAPON_SMG_MK2`] = {object = `w_sb_smgmk2`, item = 'WEAPON_SMG_MK2', rot = vector3(0,0,0)},
    [`WEAPON_SMG`] = {object = `w_sb_smg`, item = 'WEAPON_SMG', rot = vector3(0,0,0)},
    [`WEAPON_PUMPSHOTGUN_MK2`] = {object = `w_sg_pumpshotgunmk2`, item = 'WEAPON_PUMPSHOTGUN_MK2', rot = vector3(0,0,0)},
    [`WEAPON_POOLCUE`] = {object = `w_me_poolcue`, item = 'WEAPON_POOLCUE', rot = vector3(0,92.5,0)},
    [`WEAPON_MUSKET`] = {object = `w_ar_musket`, item = 'WEAPON_MUSKET', rot = vector3(0,0,0)},
    [`WEAPON_MILITARYRIFLE`] = {object = `w_ar_specialcarbine`, item = 'WEAPON_MILITARYRIFLE', rot = vector3(0,0,0)},
    [`WEAPON_MG`] = {object = `w_mg_mg`, item = 'WEAPON_MG', rot = vector3(0,0,0)},
    [`WEAPON_MARKSMANRIFLE_MK2`] = {object = `w_sr_marksmanriflemk2`, item = 'WEAPON_MARKSMANRIFLE_MK2', rot = vector3(0,0,0)},
    [`WEAPON_MARKSMANRIFLE`] = {object = `w_sr_marksmanrifle`, item = 'WEAPON_MARKSMANRIFLE', rot = vector3(0,0,0)},
    [`WEAPON_HEAVYSNIPER`] = {object = `w_sr_heavysniper`, item = 'WEAPON_HEAVYSNIPER', rot = vector3(0,0,0)},
    [`WEAPON_HEAVYSHOTGUN`] = {object = `w_sg_heavyshotgun`, item = 'WEAPON_HEAVYSHOTGUN', rot = vector3(0,0,0)},
    [`WEAPON_GOLFCLUB`] = {object = `w_me_golfclub`, item = 'WEAPON_GOLFCLUB', rot = vector3(0,92.5,0)},
    [`WEAPON_FIREEXTINGUISHER`] = {object = `w_am_fire_exting`, item = 'WEAPON_FIREEXTINGUISHER', rot = vector3(0,92.5,0)}, 
    [`WEAPON_CROWBAR`] = {object = `w_me_crowbar`, item = 'WEAPON_CROWBAR', rot = vector3(0,92.5,0)},
    [`WEAPON_COMPACTRIFLE`] = {object = `w_ar_assaultrifle_smg`, item = 'WEAPON_COMPACTRIFLE', rot = vector3(0,0,0)},
    [`WEAPON_COMBATSHOTGUN`] = {object = `w_sg_pumpshotgunh4`, item = 'WEAPON_COMBATSHOTGUN', rot = vector3(0,0,0)},
    [`WEAPON_MPX`] = {object = `w_ar_mpx`, item = 'WEAPON_MPX', rot = vector3(0,0,0)},
    [`WEAPON_UZI`] = {object = `w_sb_uzi`, item = 'WEAPON_UZI', rot = vector3(0,0,0)},
    [`WEAPON_MP7`] = {object = `w_sb_mp7`, item = 'WEAPON_MP7', rot = vector3(0,0,0)},
    [`WEAPON_COMBATMG_MK2`] = {object = `w_mg_combatmgmk2`, item = 'WEAPON_COMBATMG_MK2', rot = vector3(0,0,0)},
    [`WEAPON_COMBATMG`] = {object = `w_mg_combatmg`, item = 'WEAPON_COMBATMG', rot = vector3(0,0,0)},
    [`WEAPON_CARBINERIFLE_MK2`] = {object = `w_ar_carbineriflemk2`, item = 'WEAPON_CARBINERIFLE_MK2', rot = vector3(0,0,0)},
    [`WEAPON_CARBINERIFLE`] = {object = `w_ar_carbinerifle`, item = 'WEAPON_CARBINERIFLE', rot = vector3(0,0,0)},
    [`WEAPON_BULLPUPSHOTGUN`] = {object = `w_sg_bullpupshotgun`, item = 'WEAPON_BULLPUPSHOTGUN', rot = vector3(0,0,0)},
    [`WEAPON_BULLPUPRIFLE_MK2`] = {object = `w_ar_bullpupriflemk2`, item = 'WEAPON_BULLPUPRIFLE_MK2', rot = vector3(0,0,0)},
    [`WEAPON_BULLPUPRIFLE`] = {object = `w_ar_bullpuprifle`, item = 'WEAPON_BULLPUPRIFLE', rot = vector3(0,0,0)},
    [`WEAPON_BATTLEAXE`] = {object = `w_me_battleaxe`, item = 'WEAPON_BATTLEAXE', rot = vector3(0,92.5,0)},
    [`WEAPON_BAT`] = {object = `w_me_bat`, item = 'WEAPON_BAT', rot = vector3(0,92.5,0)},
    [`WEAPON_ASSAULTSMG`] = {object = `w_sb_assaultsmg`, item = 'WEAPON_ASSAULTSMG', rot = vector3(0,0,0)},
    [`WEAPON_ASSAULTRIFLE_MK2`] = {object = `w_ar_assaultriflemk2`, item = 'WEAPON_ASSAULTRIFLE_MK2', rot = vector3(0,0,0)},
    [`WEAPON_ADVANCEDRIFLE`] = {object = `w_ar_advancedrifle`, item = 'WEAPON_ADVANCEDRIFLE', rot = vector3(0,0,0)},
    [`WEAPON_RPG`] = {object = `w_lr_rpg`, item = 'WEAPON_RPG', rot = vector3(0,0,0)}
}

local slots = {
    [1] = {
        pos = vec3(0.13, -0.19, -0.04), -- Center Of Back
        entity = nil,
        hash = nil,
        wep = nil
    },
    [2] = {
        pos = vec3(0.13, -0.15, -0.16), -- Center-Right
        entity = nil,
        hash = nil,
        wep = nil
    },
    [3] = {
        pos = vec3(0.13, -0.15, 0.07), -- Center-Left
        entity = nil,
        hash = nil,
        wep = nil
    },
}

local function clearSlot(i)
    DetachEntity(slots[i].entity)
    DeleteEntity(slots[i].entity)
    slots[i].entity = nil
    slots[i].hash = nil
    slots[i].wep = nil
end

local function removeFromSlot(hash)
    if Weapons[hash] == nil then return end
    local whatItem = Weapons[hash].item
    local count = ox_inventory:Search(2, whatItem)
    for i = 1, #slots do
        if slots[i].hash == hash then
            if not count or count <= 0 or hash == curWeapon then
                clearSlot(i)
            end
        end
    end
end

local function removeWeapon(hash)
    if Weapons[hash] then
        removeFromSlot(hash)
    end
end

local function removeFromInv(hash)
    removeFromSlot(hash)
end

local function checkForSlot(hash)
    for i = 1, #slots do
        if slots[i].hash == hash then return false end
    end
    for i = 1, #slots do
        local slot = slots[i]
        if not slot.entity then
            return i
        end
    end
    return false
end


local function putOnBack(hash)
    local whatSlot = checkForSlot(hash)
    if whatSlot then
        curWeapon = nil
        local object = Weapons[hash].object
        local item = Weapons[hash].item
        lib.requestModel(object, 500)
        local coords = GetEntityCoords(ped)
        local prop = CreateObject(object, coords.x, coords.y, coords.z,  true,  true, true)
        slots[whatSlot].entity = prop
        slots[whatSlot].hash = hash
        slots[whatSlot].wep = item
        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 24816), slots[whatSlot].pos.x, slots[whatSlot].pos.y, slots[whatSlot].pos.z, Weapons[hash].rot.x, Weapons[hash].rot.y, Weapons[hash].rot.z, true, true, false, true, 2, true)
    end
end

local function respawningCheckWeapon()
    for i = 1, #slots do
        local slot = slots[i]
        if slot.entity ~= nil then
            if DoesEntityExist(slot.entity) then
                DeleteEntity(slot.entity)
            end
            local whatItem = Weapons[slot.hash].item
            local count = ox_inventory:Search(2, whatItem)
            local oldHash = slot.hash
            slots[i].entity = nil
            slots[i].hash = nil
            if count > 0 then
                putOnBack(oldHash)
            end
        end
    end
end

AddEventHandler('ox_inventory:currentWeapon', function(data)
    if data then
        if Weapons[data.hash] then
            putOnBack(curWeapon)
            curWeapon = data.hash
            removeWeapon(data.hash)
        end
    else
        if curWeapon then
            putOnBack(curWeapon)
        end
    end
end)



AddEventHandler('ox_inventory:updateInventory', function(changes)
    playerLoaded = true
    for k, v in pairs(changes) do
        if type(v) == 'table' then
            local hash = joaat(v.name)
            if Weapons[hash] then
                if curWeapon ~= hash then
                    putOnBack(hash)
                else
                    removeFromInv(hash)
                end
            end
        end
        if type(v) == 'boolean' then
            for i = 1, #slots do
                local count = ox_inventory:Search(2, slots[i].wep)
                if not count or count <= 0 then
                    removeFromInv(slots[i].hash)
                end
            end
        end
    end
end)

lib.onCache('vehicle', function(value)
    if value then
        for i = 1, #slots do
            clearSlot(i)
        end
    else
        if GetResourceState('ox_inventory') ~= 'started' or not playerLoaded then return end
        for k, v in pairs(Weapons) do
            local count = ox_inventory:Search(2, v.item)
            if count and count >= 1 then
                putOnBack(k)
            end
        end
    end
end)

lib.onCache('ped', function(value)
    ped = value
end)
