Config = {}
local server = GetConvar("bez_nazwy-1", "1")
local printServ = "Polski Serwer!"
local tekstAsset = "https://discord.gg/diablohub"
local onlinePlayers = 0
local onlineEms = 0
local onlineLspd = 0
local onlinelscm = 0 
local name = GetPlayerName(PlayerId())


  
RegisterNetEvent('top_discordpresence:frakcjeliczba')
AddEventHandler('top_discordpresence:frakcjeliczba', function(policja, medycy, mechanicy, players)
	onlinePlayers = players
	onlineEms = medycy
   	onlineLspd = policja
	onlinelscm = mechanicy
end)


  Citizen.CreateThread(function()
	
	while true do 
		Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', "<font face='Poppins-Medium' size= '24'>~r~ DiabloHub.PL ~w~| ~w~https://discord.gg/diablohub ~w~| ~o~ID: ".. GetPlayerServerId(PlayerId()) .." ~w~| " .. name .. "")
		SetDiscordAppId(936800739982983228)

		SetDiscordRichPresenceAsset('bez_nazwy-1')
		SetDiscordRichPresenceAssetText(tekstAsset);
		SetDiscordRichPresenceAssetSmall('polska')
		SetDiscordRichPresenceAssetSmallText(printServ);
		SetDiscordRichPresenceAction(1, "Discord!", "https://discord.gg/diablohub")

		name = GetPlayerName(PlayerId())
        id = GetPlayerServerId(PlayerId())

		SetRichPresence("🕵️‍♂️ Graczy: " .. onlinePlayers .."/64 | " .. name .." | ID: " .. id .. "")
		Citizen.Wait(5000)
	end
end)

