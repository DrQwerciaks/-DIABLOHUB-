local itemNotification = function(itemName, title, fullName, amount)
	SendNUIMessage({
		action = "itemNotification",
		itemName = itemName,
		title = title,
		fullName = fullName,
		amount = amount
	})
end

RegisterNetEvent("diablohub_notifications:itemNotification", itemNotification)
exports("itemNotification", itemNotification)

local HideAlways = false
local BodyCamVisible = false
local lastState = nil
CreateThread(function()
	while true do
		local thisState = not IsPauseMenuActive() and BodyCamVisible and not HideAlways
		if thisState ~= lastState then
			SendNUIMessage({
				action = "toggleBodycam",
				state = thisState,
			})
			lastState = thisState
		end
		Wait(250)
	end
end)

local ToggleBodyCam = function(state, name, department)
	BodyCamVisible = state
	SendNUIMessage({
		action = "updateBodycamData",
		data = {
			name = name,
			department = department
		}
	})
end

exports("HideBodyCam", function(state)
	HideAlways = state
end)
exports("itemNotification", itemNotification)
RegisterNetEvent("diablohub_notifications:ToggleBodyCam", ToggleBodyCam)

local policeNotifications = {}
local hasNotify = 0

AcceptPoliceNotification = function(id, notif)
	local data = policeNotifications[id or #policeNotifications]
	SetNewWaypoint(data.coords.x, data.coords.y)
	if notif then
		TriggerServerEvent("diablohub_notifications:notifyAccept", data.playerId)
	end
end

CreateThread(function()
	while true do
		if hasNotify > 0 then
			ESX.ShowHelpNotification("Naciśnij <h1>E</h1> aby zaakceptować zgłoszenie")
			if IsControlJustReleased(0, 38) then
				AcceptPoliceNotification(nil, true)
				hasNotify = 0
			end
		end
		Wait(0)
	end
end)

CreateThread(function()
	while true do
		if hasNotify > 0 then
			hasNotify = hasNotify - 1000
		end
		Wait(1000)
	end
end)

local SoundEnable = true
local policeNotification = function(data)
	data.id = #policeNotifications + 1

	if data.coords then
		data.isPinable = true
		policeNotifications[data.id] = {coords = data.coords, playerId = data.playerId}
	end

	SendNUIMessage({
		action = "showFactionNotification",
		data = data
	})
	
	hasNotify = 5000

	if SoundEnable and data.sound then
		TriggerServerEvent("InteractSound_SV:PlayOnSource", data.sound.file, data.sound.volume)
	end

	if data.blip then
		local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
		SetBlipSprite(blip, data.blip.sprite)
		SetBlipScale(blip, data.blip.scale)
		SetBlipColour(blip, data.blip.colour)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("<font face='Poppins-Medium' size= '11'>".. data.blip.name .."</font>")
		EndTextCommandSetBlipName(blip)

		if data.blip.pulse then
			PulseBlip(blip)
		end

		if data.blip.route then
			SetBlipRoute(blip, true)
		end

		Wait(data.blip.timeToDelete)
		RemoveBlip(blip)
	end
end

RegisterCommand("togglesound", function()
	SoundEnable = not SoundEnable
	ESX.ShowNotification(SoundEnable and "Włączyłeś dzwięki z powiadomień frakcyjnych" or "Wyłączyłeś dzwięki z powiadomień frakcyjnych")
end)

exports("policeNotify", policeNotification)
RegisterNetEvent("diablo_hub:policeNotify", policeNotification)