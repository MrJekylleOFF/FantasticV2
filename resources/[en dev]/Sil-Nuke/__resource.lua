resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_scripts{
    'Config.lua',
    'cl-nuke.lua'
}

server_scripts{
    'Config.lua',
    'sv-nuke.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/sounds/countbeep.ogg',
    'html/sounds/nukeincome.ogg',
    'html/sounds/nukeboom.ogg',
    'tank/handling.meta',
	'tank/vehicles.meta',
	'tank/carcols.meta',
	'tank/carvariations.meta'
}

data_file 'HANDLING_FILE' 			'tank/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 	'tank/vehicles.meta'
data_file 'CARCOLS_FILE' 			'tank/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 	'tank/carvariations.meta'
