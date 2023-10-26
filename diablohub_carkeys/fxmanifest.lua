fx_version "cerulean"
game "gta5"
lua54 "yes"

-- NAJLEPSZY DEVELOPER IN POLSKA
author 'diablo#6666'
description 'Skrypt stworzony dla NeedRP.eu'

shared_scripts {
	'@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

client_scripts {
    -- "client/main.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/main.lua",
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { 'client/main.lua' }