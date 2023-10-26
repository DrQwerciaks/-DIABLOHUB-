fx_version 'adamant'
game 'gta5'

-- NAJLEPSZY DEVELOPER IN POLSKA
author 'diablo#6666'
description 'Skrypt stworzony dla NeedRP.eu'

server_scripts {
    '@es_extended/locale.lua',
    '@es_extended/imports.lua',
    'locales/en.lua',
    'server/main.lua',
    'server/utils.lua',
    'config.lua'
}
client_script {
    '@es_extended/locale.lua',
    '@es_extended/imports.lua',
    'client/main.lua',
    'client/utils.lua',
    'locales/en.lua',
    'config.lua'
}
dependencies {
    'es_extended',
    'xsound'
}
