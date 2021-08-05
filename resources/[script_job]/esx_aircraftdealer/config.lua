Config                            = {}
Config.DrawDistance               = 10.0
Config.MarkerColor                = { r = 255, g = 50, b = 50 }
Config.EnablePlayerManagement     = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'fr'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 4
Config.PlateNumbers  = 4
Config.PlateUseSpace = false

Config.Zones = {

	ShopEntering = {
		Pos   = vector3(-941.4, -2955.02, 12.95),
		Size  = {x = 1.5, y = 1.5, z = 0.3},
		Type  = 1
	},

	ShopInside = {
		Pos     = vector3(-885.74, -3203.03, 13.52),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 63.77,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(-885.74, -3203.03, 13.52),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 61.2,
		Type    = -1
	},

	BossActions = {
		Pos   = vector3(-937.37, -2931.17, 12.95),
		Size  = {x = 1.5, y = 1.5, z = 0.3},
		Type  = 1
	},

}
