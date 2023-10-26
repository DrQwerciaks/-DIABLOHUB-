fx_version 'adamant'
game 'gta5'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
}

server_scripts {
    'server/server.lua',
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { "client/main.lua" }