fx_version 'adamant'
game 'gta5'

author 'Morow'

ui_page 'ui.html'

files {
	'ui.html',
	'ui/fantastic.png',
	'ui/app.js'
}

server_scripts {
	 '@mysql-async/lib/MySQL.lua',
	'server/server.lua'
}

client_scripts {
	'client/client.lua'
}