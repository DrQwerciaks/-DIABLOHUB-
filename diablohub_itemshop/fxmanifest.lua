fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
lua54 'yes'

name 'need-itemshop'
author 'NeedRP'
version '1.0.0'

shared_script {'@es_extended/imports.lua'}

server_scripts {'@oxmysql/lib/MySQL.lua', 'server/server.lua'}

client_scripts {'client/client.lua'}

ui_page 'html/index.html'

files {'html/**'}
