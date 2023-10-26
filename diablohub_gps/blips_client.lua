
local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
  while true do
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(1000*60)
   end
end)

local displayGPS = false
local blips_cache = { }
local server_has_heartbeat = false
local blip_types = config.blip_types
--[[
AddEventHandler('esx:playerLoaded', function()
    TriggerServerEvent('esx:getmyload')
end)]]
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15 * 1000)
        server_has_heartbeat = false
        SetTimeout(5 * 1000, function()
            if not server_has_heartbeat then
                for check_follow_id_key, data in pairs(blips_cache) do
                    if not blips_cache[check_follow_id_key].has_server_validated then
                        RemoveBlip(data.blip_id)
                        RemoveBlip(data.synced_blip_id)
                        blips_cache[check_follow_id_key] = nil
                    end
                end
            end
        end)
    end
end)

local passes = 0

RegisterNetEvent('badBlips:client:syncMyBlips')
AddEventHandler('badBlips:client:syncMyBlips', function(blips, charinfo)
    local me_ped = PlayerPedId()
    server_has_heartbeat = true
    for _, properties in ipairs(blips) do
        local follow_on_source = properties[5]
        local follow_id_key = properties[4] .. '_' .. properties[5]

        if not blips_cache[follow_id_key] then
            blips_cache[follow_id_key] = { properties = { } }
        end

        blips_cache[follow_id_key].needs_server = true

        local is_networked = NetworkIsPlayerActive(GetPlayerFromServerId(follow_on_source))
        if is_networked then
            local me_player = GetPlayerServerId(PlayerId())
            if config.hide_own_blip and follow_on_source == me_player then
                blips_cache[follow_id_key].ignored = true
            end
            blips_cache[follow_id_key].needs_server = false
            blips_cache[follow_id_key].player_ped = GetPlayerPed(GetPlayerFromServerId(follow_on_source))
        end

        if not blips_cache[follow_id_key].ignored then
            if blips_cache[follow_id_key].is_created and not blips_cache[follow_id_key].needs_removal then
                local blip_id = blips_cache[follow_id_key].blip_id
                blips_cache[follow_id_key].properties = properties
                blips_cache[follow_id_key].has_server_validated = true
                doUpdateBlip(follow_id_key, blip_id, properties, charinfo)
            else
                local blip_id = doAddBlip(properties, charinfo)
                blips_cache[follow_id_key].is_created = true
                blips_cache[follow_id_key].blip_id = blip_id
                blips_cache[follow_id_key].properties = properties
                blips_cache[follow_id_key].has_server_validated = true
            end
        end
    end

    for _, __ in pairs(blips_cache) do

        if not blips_cache[_].has_server_validated then

            if blips_cache[_].synced_blip_id then
                RemoveBlip(blips_cache[_].synced_blip_id)
                blips_cache[_].synced_blip_id = false
            end

            if blips_cache[_].blip_id then
                RemoveBlip(blips_cache[_].blip_id)
                blips_cache[_].blip_id = false
            end

            blips_cache[_] = nil
        end

        if blips_cache[_] then
            blips_cache[_].has_server_validated = false
        end
    end
end)



RegisterNetEvent('need_gps:openMenu')
AddEventHandler('need_gps:openMenu', function()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gpsmen',
	{
		title    = 'GPS',
		align    = 'center',
		elements = {
			{label = 'Uruchom GPS', value = '111'},
			{label = 'Zniszcz GPS', value = '222'},
		}
	}, function(data2, menu2)
		if data2.current.value == '111' then
			menu2.close()
			TriggerServerEvent("need_gps:refreshGPS")
            TriggerEvent('esx_policejob:displayGPS')
			Citizen.Wait(1500)
		elseif data2.current.value == '222' then
			menu2.close()
			TriggerServerEvent("need_gps:destroyGPS")
			Citizen.Wait(1500)
		end
	end, function(data2, menu2)
		menu2.close()
    end)
end)

RegisterNetEvent('need_gps:lostGPS')
AddEventHandler('need_gps:lostGPS', function(name, coords)
    -- local kupcia = "Ostantia lokalizacja: " .. characterInfo
    -- ESX.ShowNotification("Utracono połączenie z nadajnikiem " .. characterInfo)
    -- local alpha = 250
	-- local gpsBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
	-- SetBlipSprite(gpsBlip, 280)
	-- SetBlipColour(gpsBlip, 3)
	-- SetBlipAlpha(gpsBlip, alpha)
	-- SetBlipScale(gpsBlip, 1.2)
	-- SetBlipAsShortRange(gpsBlip, false)
	-- SetBlipCategory(gpsBlip, 15)
	-- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString("<font face='Poppins-Medium' size= '11'>".. characterInfo .."</font>" )

	-- EndTextCommandSetBlipName(gpsBlip)
	-- for i=1, 5, 1 do
	-- 	PlaySound(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0, 0, 0.3)
	-- 	Wait(300)
	-- 	PlaySound(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0, 0, 0.3)
	-- 	Wait(300)
	-- end
	-- while alpha ~= 0 do
	-- 	Citizen.Wait(180 * 4)
	-- 	alpha = alpha - 1
	-- 	SetBlipAlpha(gpsBlip, alpha)
	-- 	if alpha == 0 then
	-- 		RemoveBlip(gpsBlip)
	-- 		return
	-- 	end
	-- end
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
	exports["diablohub_notifications"]:policeNotify({
		playerId = target,
		coords = coords,
		textColor = "#fff",
		bgColor = "#C30000",
		title1 = "10-1",
		title2 = "Lost GPS signal!",
		blip = {
			name = "# Ostatnia lokalizacja oficera",
			sprite = 458,
			scale = 0.9,
			colour = 73,
			timeToDelete = 180000
		},
		sound = {
			file = "POLICEOfficerGpsLost",
			volume = 0.3
		},
		content = {
			{
				type = "location",
				text = GetStreetNameFromHashKey(s1)
			},
			{
				type = "guard",
				text = name
			},
		}
	})
end)

function doUpdateBlip(follow_id_key, blip_id, properties, charinfo)
    if blips_cache[follow_id_key].needs_server then 
        if not blips_cache[follow_id_key].blip_id then
            RemoveBlip(blips_cache[follow_id_key].synced_blip_id)
            local new_blip_id = doAddBlip(properties, charinfo)
            blips_cache[follow_id_key].synced_blip_id = nil
            blips_cache[follow_id_key].blip_id = new_blip_id
        end

        if blips_cache[follow_id_key].blip_id then
            if DoesBlipExist(blips_cache[follow_id_key].blip_id) then
                SetBlipCoords(blip_id, properties[1] + 0.001,properties[2] + 0.001,properties[3] + 0.001)
            end
        end
    end
end

local chujdupa = ""
function doAddBlip(properties, charinfo)
    local blip_id = AddBlipForCoord(properties[1] + 0.001,properties[2] + 0.001,properties[3] + 0.001)
    chujdupa = charinfo

    setBlipProperties(blip_id, properties, charinfo)
    return blip_id
end

Citizen.CreateThread(function()
    while PlayerData.job == nil do
        Wait(100)
    end
    while true do
        Citizen.Wait(1000)
        for follow_id_key, data in pairs(blips_cache) do
            if not blips_cache[follow_id_key].needs_server and not blips_cache[follow_id_key].needs_removal then

                if not blips_cache[follow_id_key].synced_blip_id then
                    if blips_cache[follow_id_key].blip_id then
                        RemoveBlip(blips_cache[follow_id_key].blip_id)
                        blips_cache[follow_id_key].blip_id = nil
                    end

                    if DoesEntityExist(blips_cache[follow_id_key].player_ped) then
                        local new_blip_id = AddBlipForEntity(blips_cache[follow_id_key].player_ped)
                        blips_cache[follow_id_key].synced_blip_id = new_blip_id
                    end
                end

                if GetBlipFromEntity(data.player_ped) then
                    local blip_id = blips_cache[follow_id_key].synced_blip_id

                    local veh = GetVehiclePedIsIn(data.player_ped, false)

                    if veh ~= 0 then
                        SetBlipRotation(blip_id, math.ceil(GetEntityHeading(veh)))
                    end
                    
                    setBlipProperties(blips_cache[follow_id_key].synced_blip_id, data.properties, chujdupa)
                end
            end
        end
    end
end)

function setBlipProperties(blip_id, properties, characterInfo)
    while PlayerData.job == nil do
        Citizen.Wait(100)
    end
    local current_type = GetBlipSprite(blip_id)
    local current_color = GetBlipColour(blip_id)
    local template_type = properties[4]

    local type = config.default_type._type
    local color = config.default_type._color
    local scale = config.default_type._scale
    local alpha = config.default_type._alpha
    local show_local_indicator = config.default_type._show_local_direction
    local show_off_screen = config.default_type._show_off_screen
    local label = config.default_type._label

    if blip_types[template_type]._type then type = blip_types[template_type]._type end
    if blip_types[template_type]._color then color = blip_types[template_type]._color end
    if blip_types[template_type]._scale then scale = blip_types[template_type]._scale end
    if blip_types[template_type]._alpha then alpha = blip_types[template_type]._alpha end
    if blip_types[template_type]._show_local_direction then show_local_indicator = blip_types[template_type]._show_local_direction end
    if blip_types[template_type]._show_off_screen then show_off_screen = blip_types[template_type]._show_off_screen end
    if blip_types[template_type]._label then _label = blip_types[template_type]._label end

    -- print(1)

    if current_type ~= type or current_color ~= color then
        SetBlipSprite(blip_id, type)
        SetBlipColour(blip_id, color)
        SetBlipScale(blip_id, scale)
        SetBlipAlpha(blip_id, alpha)
        SetBlipAsShortRange(blip_id, true)

        if show_local_indicator then
            ShowHeadingIndicatorOnBlip(blip_id, true)
        end


        if properties[4] == 'unknown' then
            SetBlipHiddenOnLegend(blip_id)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString('Nieznany')
            EndTextCommandSetBlipName(blip_id)
        else
            -- local str = "[" .. _label .. "] [" .. properties[6]  .. "] " .. properties[7] .. " " .. properties[8] .. ""
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("<font face='Poppins-Medium' size= '11'>"..properties[7].."</font>")
            EndTextCommandSetBlipName(blip_id)
        end
    end
end

AddEventHandler("esx:addInventoryItem", function(item, count)
    TriggerServerEvent("need_gps:addInventoryItem", item, count)
end)
AddEventHandler("esx:removeInventoryItem", function(item, count)
    print("chuj")
    TriggerServerEvent("need_gps:onRemoveInventoryItem", item, count)
end)