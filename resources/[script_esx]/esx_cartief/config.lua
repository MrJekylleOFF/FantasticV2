Config                  = {}
Config.DrawDistance     = 100.0
Config.CopsRequired     = 0
Config.BlipUpdateTime   = 40000
Config.CooldownMinutes  = 10
Config.Locale 			= 'fr'
Config.PlateLetters  	= 4
Config.PlateNumbers  	= 4
Config.PlateUseSpace 	= false

Config.Zones = {
	VehicleSpawner = {
		Pos       = {x = 759.01, y = -3195.18, z = 4.97},
		Size      = {x = 1.5, y = 1.5, z = 0.2},
		Color     = {r = 204, g = 0, b = 0},
		Type  	  = 1,
		Colour    = 6, 		--BLIP
		Id        = 229, 	--BLIP
	},
}

Config.VehicleSpawnPoint = {
      Pos   = {x = 767.71, y = -3195.20, z = 5.50, alpha = 0.00},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Type  = -1,
}

Config.Delivery = {
	--Desert
	--Trevor Airfield 9.22KM
	Delivery1 = {
		Pos   = {x = 2130.68, y = 4781.32, z = 39.87},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Cars  = {'emperor','issi2','sultan','brioso','prairie'},
	},
	--Lighthouse 9.61KM
	Delivery4 = {
		Pos   = {x = 3333.51, y = 5159.91, z = 17.20},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Cars  = {'felon','blista2','rhapsody','zion','vader'},
	},
	--House in Paleto 12.94KM
	Delivery7 = {
		Pos   = {x = -437.56, y = 6254.53, z = 29.02},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Cars  = {'felon2','zion2','ruiner','sabregt2','tampa'},
	},
	--Great Ocean Highway 10.47KM
	Delivery10 = {
		Pos    = {x = -2177.51, y = 4269.51, z = 47.93},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Color  = {r = 204, g = 204, b = 0},
		Type   = 1,
		Cars   = {'dubsta2','serrano','asterope','surge','washington'},
	},
	--Marina Drive Desert 8.15KM
	Delivery13 = {
		Pos   = {x = 895.02, y = 3603.87, z = 31.72},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Cars  = {'gresley','contender','baller','tailgater','banshee2'},
	},
}
