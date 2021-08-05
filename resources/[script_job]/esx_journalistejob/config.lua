Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true


Config.EnableJobBlip              = false -- enable blips for cops on duty, requires esx_society
Config.EnableCustomPeds           = false -- enable custom peds in cloak room? See Config.CustomPeds below to customize peds

Config.EnableESXService           = true -- enable esx service?
Config.MaxInService               = 10

Config.Locale                     = 'fr'

Config.journalisteStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(-1063.14, -242.87, 44.06),
			Sprite  = 459,
			Display = 4,
			Scale   = 1.2,
			Colour  = 1
		},

		Cloakrooms = {
			vector3(-1068.69, -241.9, 39.73)
		},

		Armories = {
			vector3(-1045.57, -240.11, 37.87)
		},

		Helicopters = {
			{
				Spawner = vector3(-1058.9981, -241.7252, 54.0051),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 26.1523, radius = 10.0}
				}
			}
		},

		Vehicles = {
			{
			Spawner = vector3(-1093.9252, -262.9530, 37.7262)
			}
		},

		VehicleDeleters = {
			vector3(-1045.5615, -235.0065, 53.5118),
			vector3(-1098.8500, -256.40, 37.70)
		},

		BossActions = {
			vector3(-1056.9576, -233.1479, 44.0211)
		}

	}

}

Config.AuthorizedVehicles = {
		{
			label = 'Véhicule journaliste',
			model = 'rumpo'
		},
		{
			label = 'Véhicule patron',
			model = 'gresley'
		}
}