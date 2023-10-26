fx_version 'adamant'
games { 'gta5' }
lua54 'yes'
client_script 'config.lua'
client_script 'blips_client.lua'

shared_scripts {
    '@es_extended/imports.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'blips_server.lua'
}


