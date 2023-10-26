fx_version 'adamant'
game 'gta5'
lua54 "yes"
shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua'
}
client_scripts {
	'config.lua',
	'client.lua'
}
ui_page {
	'html/ui.html'
}
exports {
	'AddNotification',
}
files {
	'html/ui.html',
	'html/ui.css',
	'html/ui.js',
	'html/intuition.mp3'
}