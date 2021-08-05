Config                            = {}
Config.DrawDistance               = 100
Config.MarkerColor                = {r = 120, g = 120, b = 240}
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.ResellPercentage           = 50

Config.Locale                     = 'fr'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = vector3(206.9, -176.78, 53.61),
		Size  = {x = 1.5, y = 1.5, z = 0.3},
		Type  = 1
	},

	ShopInside = {
		Pos     = vector3(196.88, -184.02, 53.13),
		Size    = {x = 1.5, y = 1.5, z = 0.3},
		Heading = 160.23,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(218.46, -187.63, 54.61),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 158.92,
		Type    = -1
	},

	BossActions = {
		Pos   = vector3(227.71, -181.03, 53.61),
		Size  = {x = 1.5, y = 1.5, z = 0.3},
		Type  = 1
	},

--	GiveBackVehicle = {
--		Pos   = vector3(-18.2, -1078.5, 25.6),
--		Size  = {x = 3.0, y = 3.0, z = 1.0},
--		Type  = (Config.EnablePlayerManagement and 1 or -1)
--	},

--	ResellVehicle = {
--		Pos   = vector3(-44.6, -1080.7, 25.6),
--		Size  = {x = 3.0, y = 3.0, z = 1.0},
--		Type  = 1
--	}

}