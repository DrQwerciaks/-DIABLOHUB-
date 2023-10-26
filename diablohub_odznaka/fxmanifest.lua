fx_version 'cerulean'
game 'gta5'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server.lua',
}

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/images/*.png',
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { "client.lua" }

lua54 'yes'

shared_script '@es_extended/imports.lua'