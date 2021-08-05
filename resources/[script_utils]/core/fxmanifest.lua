fx_version 'adamant'
game 'gta5'

ui_page "index.html"


files {

	"fart.ogg",
	"index.html"
}

client_scripts{
	"main.lua",
	--"ped.lua",
	"inconcient.lua",
	"tp.lua",
	"cam.lua",
	"tpcode.lua",
	--"firework.lua"
}

server_scripts{
	'@mysql-async/lib/MySQL.lua',
	"server.lua"
}



