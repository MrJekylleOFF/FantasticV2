server_only 'yes'

description 'Vote plugin pour Top-Serveurs (top-serveurs.net)'

server_script "lib/VotePlugin.net.dll"

server_script "example_esx.lua"

server_script '@mysql-async/lib/MySQL.lua'