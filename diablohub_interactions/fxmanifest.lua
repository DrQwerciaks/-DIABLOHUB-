fx_version 'cerulean'
lua54 'yes'
game 'gta5'

-- NAJLEPSZY DEVELOPER IN POLSKA
author 'diablo#6666'
description 'Skrypt stworzony dla NeedRP.eu'

ui_page "index.html"

server_scripts {
    'source/server.lua',
    '@oxmysql/lib/MySQL.lua'
}

files {
	"index.html"
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { "source/client.lua" }

shared_script '@es_extended/imports.lua'
