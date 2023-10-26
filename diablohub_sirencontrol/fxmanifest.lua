fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

server_scripts {
    "server.lua"
}

ui_page "html/ui.html"
files {
    "html/ui.html",
    "html/ui.css",
    "html/ui.js"
}

client_script '@diablohub_loader/c_loader.lua'
server_script '@diablohub_loader/s_loader.lua'
my_data 'client_files' { "client.lua" }