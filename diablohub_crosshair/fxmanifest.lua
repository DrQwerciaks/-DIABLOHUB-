fx_version'cerulean'
game'gta5'

author'At0m_.'
description'Crosshair'
version'1.0.0'

lua54        'yes'
license      'GPL-3.0-or-later'

ui_page'ui/index.html'

server_scripts ({
    "@oxmysql/lib/MySQL.lua",
    'server.lua'
})

shared_script {
    '@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'config.lua'
}

client_script {
    'client.lua',
}

files{
    'ui/*',
}

escrow_ignore{
    'config.lua',
    'client.lua',
}

dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'