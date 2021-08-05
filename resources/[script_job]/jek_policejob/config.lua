Config                            = {}

Config.DrawDistance               = 8.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.MaxInService               = 40
Config.Locale = 'fr'

Config.PoliceStation = {

	LSPD = {

		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Scale   = 0.9,
			Colour  = 12,
		},

		Cloakrooms = {
			{ x = -441.375, y = 6002.535, z = 30.71 },
			{ x = 452.600, y = -993.306, z = 29.750 },
		},

		Stocks = {
			{x= 461.21, y= -979.79, z= 29.68}
		},

		Armories = {
			{ x = -448.51467, y = 6009.388, z = 31.71538 },
			{ x = 452.32196044922, y = -980.03033447266, z = 30.689582824707 },
		},

		
		Vehicles = {
			{
				Spawner    = { x = -455.246, y = 6019.278, z = 31.490 },
				SpawnPoint = { x = -463.346, y = 6021.499, z = 30.340 },
				Heading    = 276.11
			},
			{
				Spawner    = { x = 458.87, y = -1008.03, z = 28.430 },
				SpawnPoint = { x = 452.04, y = -997.05, z = 25.76 },
				Heading    = 175.0
			},
		},

		Helicopters = {
			{
				Spawner    = { x = -449.928, y = 6003.42, z = 31.49 },
				Spawner2   = { x = 463.534, y = -982.175, z = 43.69 },
				SpawnPoint = { x = -480.211, y = 5995.938, z = 30.33 },
				SpawnPoint2 = { x = -466.182, y = 5980.779, z = 30.33 },
				SpawnPoint3 = { x = 450.04, y = -981.14, z = 42.691 },
				Heading    = 137.79,
				Heading2    = 0.0
			},
		},

		


		VehicleDeleters = {
			{ x = -478.110, y = 6023.381, z = 30.80 },
			{ x = -475.466, y = 5988.168, z = 30.80 },
			{ x = 462.74, y = -1014.4, z = 27.065 },
			{ x = 462.40, y = -1019.7, z = 27.104 },
			{ x = 469.12, y = -1024.52, z = 27.20 }
		},

		BossActions = {
			{ x = 448.77, y = -973.22, z = 29.69 }
		},

		

	},

}

