fx_version 'cerulean'
games { 'gta5' }

shared_script '@es_extended/imports.lua'

client_script 'client/*.lua'


server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua'
} 
