fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
  "config.lua"
}

server_scripts {
  'server.lua',
  '@oxmysql/lib/MySQL.lua'
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { "client.lua" }
server_script 'html/lib.js'