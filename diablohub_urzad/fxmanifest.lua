fx_version 'cerulean'
game 'gta5'

server_script 'server/main.lua'

ui_page 'html/index.html'

files{
    'html/index.html',
    'html/style.css'
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { "client/main.lua" }

lua54 'yes'

shared_script '@es_extended/imports.lua'