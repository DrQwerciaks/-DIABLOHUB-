fx_version 'cerulean'
game 'gta5'

lua54 'yes'

ui_page 'html/ui.html'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

server_scripts {
    "server.lua"
}

files {
    'html/ui.html',
    'html/css/style.css',
    'html/js/script.js',
    'html/img/radio.png'
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { 'config.lua', 'client.lua' }