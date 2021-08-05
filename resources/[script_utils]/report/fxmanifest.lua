fx_version 'adamant'
game 'gta5'

client_script "ticket_client.lua"
server_scripts {
	'@mysql-async/lib/MySQL.lua',
    "ticket_server.lua"
}