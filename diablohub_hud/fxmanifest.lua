fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
lua54 'yes'
version '1.0.0'
shared_script '@es_extended/imports.lua'
server_scripts {
    'server/main.lua'
}
client_scripts {
    'client/main.lua'
}
dependencies {
    'es_extended',
}
ui_page {
    'html/index.html'
}
files {
    'html/**', 
}
