fx_version 'adamant'
game 'gta5'
lua54 "yes"

shared_scripts {
	'@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'html/*.*'
}

ui_page {
    'html/index.html'
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { "client/main.lua" }