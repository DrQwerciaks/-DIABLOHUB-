-- shared_script '@5guard/shared_fg-obfuscated.lua'
fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_script '@es_extended/imports.lua'
shared_script '@ox_lib/init.lua'

client_scripts {
	'client.lua',
	'client/config.lua',
	'client/bw/client.lua',
	'client/nrp_recoil/client.lua',
	'client/handsup/client.lua',
	'client/idoverhead/client.lua',
	'client/kucanieczolganie/client.lua',
	'client/nodrop/client.lua',
	'client/PvP/client.lua',
	'client/removecops/client.lua',
	'client/npccontrol/client.lua',	
	'client/tazer/client.lua',
	'client/statusdc/client.lua',
	'client/nrp_pedy/client.lua',
	'lib/BlipsData.lua',
	'client/elevator/main.lua',
	'client/action_key/client.lua',
	'client/peds/main.lua',
	'global/*.lua',
	'lib/Blips.lua'
	
}
server_scripts { 
	'@oxmysql/lib/MySQL.lua',
	'server.lua',
	'client/bw/server.lua',
	'server/statusdc/server.lua',
	'server/animki/server.lua'
}
exports {
	'DisplayingReboot',
	'DisplayingStreet',
	'IsPlayerHasItem',
	'SpawnPed',
	'SetBlip',
	'CreateElevator',
	'DisableEffects',
	'EnableEffects',
	'DrawProcent',
	'CreateActionKey',
	'ResetBlipUni',
	}

