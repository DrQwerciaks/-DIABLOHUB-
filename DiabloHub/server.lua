

local identifiers = {discord = "", steam = "", license = "", ip = "", live = "", xbl = ""}
local dono = "TwojSerwerRP | LogSystem"
local communtiylogo = "https://cdn.discordapp.com/attachments/763451376159424523/1063504809619103774/1080x1080.png"  

-- Logi Join
ESX.RegisterServerCallback('gcphone:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end
end)


AddEventHandler('playerConnecting', function()
    local num = GetNumPlayerIdentifiers(source)
	for i = 0, num-1 do
		local a = GetPlayerIdentifier(source, i)
		local f = string.find(a, ":")
		if f then
			local b = string.sub(a, 1, f-1)
			identifiers[b] = a
		end
	end

	local israel = GetPlayerName(source)
	local adamtest = GetPlayerLastMsg(source)
	local guid = GetPlayerGuid(source)
	local ping = GetPlayerPing(source)

	if guid ~= nil then
		local connect = {
			{
				["color"] = "16745472",
				["title"] = 'Gracz łączy się z serwerem',
				["description"] = "[Nick] **"..israel.."**\n[IP]: **"..identifiers.ip.."**\n[Hex]: **"..identifiers.steam.."**\n[SID64]: **"..guid.."**\n [Licencja]: **"..identifiers.license.."**\n [Discord]: **"..identifiers.discord.."**\n[Live id]: **"..identifiers.live.."**\n[xbl id]: **"..identifiers.xbl.."**",
				["footer"] = {
					["text"] = dono,
					["icon_url"] = communtiylogo,
				},
			}
		}
		local connect2 = {
			{
				["color"] = "16745472",
				["title"] = 'Gracz łączy się z serwerem',
				["description"] = "[Nick] **"..israel.."**\n[Hex]: **"..identifiers.steam.."**\n[SID64]: **"..guid.."**\n [Licencja]: **"..identifiers.license.."**\n [Discord]: **"..identifiers.discord.."**\n[Live id]: **"..identifiers.live.."**\n[xbl id]: **"..identifiers.xbl.."**",
				["footer"] = {
					["text"] = dono,
					["icon_url"] = communtiylogo,
				},
			}
		}
		
		local webhook = 'https://discord.com/api/webhooks/1010170444386672671/sHBogU3zBG7EON87_4oaoUQj9yy5yKFh_nnW61sIuj4ms4Lf8b6xslWpDrwx_TcYHosD'
		local webhook2 = 'https://discord.com/api/webhooks/1010170551974764654/5iTajg0cHeubXvkqGSAYtjGHZOIxd3ucGulIgWFKIiaOuqjRcB3n4o6WfsEOun3zIn5j'
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "TwojSerwerRP | Wejścia", iconurl = "https://cdn.discordapp.com/attachments/763451376159424523/1063504809619103774/1080x1080.png" , embeds = connect}), { ['Content-Type'] = 'application/json' })
		PerformHttpRequest(webhook2, function(err, text, headers) end, 'POST', json.encode({username = "TwojSerwerRP | Wejścia", embeds = connect2}), { ['Content-Type'] = 'application/json' })
	end
end)

-- Logi Leave

AddEventHandler('playerDropped', function(reason)
    local num = GetNumPlayerIdentifiers(source)
	for i = 0, num-1 do
		local a = GetPlayerIdentifier(source, i)
		local f = string.find(a, ":")
		if f then
			local b = string.sub(a, 1, f-1)
			identifiers[b] = a
		end
	end
	local israel = GetPlayerName(source)
	local adamtest = GetPlayerLastMsg(source)
	local guid = GetPlayerGuid(source)
	local ping = GetPlayerPing(source)
	
	if guid ~= nil then
		local connect = {
			{
				["color"] = "16745472",
				["title"] = "Gracz odłączył się od serwera!",
				["description"] = "[ID]: **"..source.."**\n[Nick]: **"..israel.."** \n [Powód]: **"..reason.."** \n[IP]: **"..identifiers.ip.."**\n[Hex]: **"..identifiers.steam.."**\n[SID64]: **"..guid.."**\n [Licencja]: **"..identifiers.license.."**\n [Discord]: **"..identifiers.discord.."**\n[Live id]: **"..identifiers.live.."**\n[xbl id]: **"..identifiers.xbl.."**",
				["footer"] = {
					["text"] = dono,
					["icon_url"] = communtiylogo,
				},
			}
		}
		local connect2 = {
			{
				["color"] = "16745472",
				["title"] = "Gracz odłączył się od serwera!",
				["description"] = "[ID]: **"..source.."**\n[Nick]: **"..israel.."** \n [Powód]: **"..reason.."** \n[Hex]: **"..identifiers.steam.."**\n[SID64]: **"..guid.."**\n [Licencja]: **"..identifiers.license.."**\n [Discord]: **"..identifiers.discord.."**\n[Live id]: **"..identifiers.live.."**\n[xbl id]: **"..identifiers.xbl.."**",
				["footer"] = {
					["text"] = dono,
					["icon_url"] = communtiylogo,
				},
			}
		}

		local webhook = 'https://discord.com/api/webhooks/1011503048918564905/M7hRcud-tr7VLVBtB2brcdm6H6P1icYZnCfzzr7yAUDTMd_rt0JdOV-2G9ARdN3C5M0d'
		local webhook2 = 'https://discord.com/api/webhooks/1011503126622244864/MOnySzvujsHdJEE4AJBDso2QIb5Up5fgUCQJOWOojVWqgnnqSLrq1Suqd6VNmpMvuHLW'
		
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "TwojSerwerRP | Wyjścia", iconurl = "https://cdn.discordapp.com/attachments/763451376159424523/1063504809619103774/1080x1080.png", embeds = connect}), { ['Content-Type'] = 'application/json' })
		PerformHttpRequest(webhook2, function(err, text, headers) end, 'POST', json.encode({username = "TwojSerwerRP | Wyjścia", embeds = connect2}), { ['Content-Type'] = 'application/json' })
	end
end)


AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == (30 * 60) then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 30 minut!**', 16745472)
    elseif eventData.secondsRemaining == (15 * 60) then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 15 minut!**', 16745472)
    elseif eventData.secondsRemaining == (10 * 60) then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 10 minut!**', 16745472)
    elseif eventData.secondsRemaining == (5 * 60) then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 5 minut!**', 16745472)
    elseif eventData.secondsRemaining == (4 * 60) then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 4 minut!**', 16745472)
    elseif eventData.secondsRemaining == (3 * 60) then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 3 minut!**', 16745472)
    elseif eventData.secondsRemaining == (2 * 60) then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 2 minut!**', 16745472)
    end
    if eventData.secondsRemaining == 60 then
        sendInformation('**Serwer ma zaplanowany restart w ciągu 1 minuty!**', 16745472)
        CreateThread(function()
            Wait(45000)
            ESX.SavePlayers()
			ESX.SaveItems()
			isRestarting = true
			local xPlayers = ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				DropPlayer(xPlayer.source, "Restart! Zapraszamy ponownie za chwilę!")
			end
        end)
    end
end)

MySQL.ready(function()
	sendInformation(':white_sun_small_cloud: **Serwer** wraca po restarcie \nRestart serwera **powiodł się**!\n\n**Automatyczne cykliczne restarty:**\n\n• :alarm_clock: • 6:00\n• :alarm_clock: • 14:00 \n\n**``F8 -> TwojSerwerRP -> ENTER``**\n<@&920433242593689614>`')
	wiadomosc = ""
end)

function sendInformation(text, color, content)
    embed = {
        {
            ["color"] = color,
            ["title"] = "TwojSerwerRP",
            ["description"] = text,
            ["thumbnail"]=  { 
			["url"] = "https://cdn.discordapp.com/emojis/856565080157061131.webp?size=96&quality=lossless",},
            ["footer"] = {
                ["text"] = os.date(),
            },
        }
    }
    PerformHttpRequest('https://discord.com/api/webhooks/1068936239614525532/ygxmAWK6VLCU8A7zhIKwoyh-cc_0nmAPnlENyqoXlu7ZJg4GNNd_VJyVN92LNeGJYmwW', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterCommand("zmiendane", function(src, args, raw)
	local _source = src
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getGroup() == 'best' then
			if args[1] and args[2] and args[3] then
                local xPlayere = ESX.GetPlayerFromId(tonumber(args[1])).identifier
                MySQL.Async.execute("UPDATE `users` SET firstname = @fisrtname, lastname = @lastname WHERE identifier LIKE '"..xPlayere.."'", {
                    ["@fisrtname"] = args[2],
                    ["@lastname"] = args[3]
                })
                exports['diablohub_logs']:SendLog(_source, 'Zmienił dane graczowi ID:'..args[1].." "..GetPlayerName(tonumber(args[1])).." nowe dane: Imie: "..args[2].." Nazwisko: "..args[3], 'zmianadanych')
			else
				xPlayer.showNotification('Podaj: ID, Nowe imie, Nowe nazwisko!')
			end
		end
	end
end, false)
--Ragdoll
-- RegisterServerEvent('CrashTackle')
-- AddEventHandler('CrashTackle', function(target)
--     TriggerClientEvent("playerTackled", target)
-- end)


RegisterCommand("giveitemall", function(src, args, raw)
    local _source = src
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer then
        if xPlayer.getGroup() == 'best' then
            if args[1] then
                if tonumber(args[2]) then
                    item = args[1]
                    ilosc = tonumber(args[2])
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do
                        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                        xPlayer.addInventoryItem(item, ilosc)
                    end
                else
                    xPlayer.showNotification('podaj ilosc!')
                end
            else
                xPlayer.showNotification('podaj item!')
            end
        end
    end
end, false)