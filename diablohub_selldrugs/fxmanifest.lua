fx_version "bodacious"
games {"gta5"}
lua54 'yes'
server_scripts {
	'server.lua',
	'config.lua'
}
client_script {
	'config.lua',
	'client.lua'
}



-- client_script '@diablohub_loader/c_loader.lua'
-- server_script '@diablohub_loader/s_loader.lua'
-- my_data 'client_files' { "client.lua" }
shared_script '@es_extended/imports.lua'

