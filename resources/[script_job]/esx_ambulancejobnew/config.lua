Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'fr'

Config.EarlyRespawnTimer          = 60000 * 10  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 15 -- time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = false

Config.MaxInService = 20

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 300

Config.RespawnPoint = {coords = vector3(320.477, -583.95, 43.28), heading = 68.87}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(274.61, -577.111, 43.16),
			sprite = 61,
			scale  = 0.9,
			color  = 2
		},

		AmbulanceActions = {
			vector3(299.018, -598.803, 42.285)
		},

		Pharmacies = {
			vector3(311.727, -562.94, 42.29)
		},

		Vehicles = {
			{
				Spawner = vector3(299.27, -572.590, 43.26),
				Deleter = vector3(295.06, -607.8, 43.33),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = { x = 292.130, y = -572.41, z = 43.18 },
			},
			{
				Spawner = vector3(00.27, -572.200, 43.26),
				Deleter = vector3(351.16, -588.1, 74.16),
				Marker = {type = 34, x = 3.0, y = 5.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = { x = 00.130, y = -572.41, z = 43.18 },
			}
		},

		Helicopters = {
			{
				Spawner = vector3(339.45, -589.01, 74.17),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.38, -588.32, 74.17), heading = 338.5, radius = 10.0}
				}
			}
		},

		FastTravels = {
			{
				From = vector3(339.6, -584.14, 73.16),
				To = {coords = vector3(329.9, -601.09, 42.28), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},
			{
				From = vector3(331.85, -595.3, 42.28),
				To = {coords = vector3(345.96, -578.74, 73.16), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},
			{
				From = vector3(327.28, -603.46, 42.28),
				To = {coords = vector3(275.66, -1360.1, 24.54), heading = 0.0},
				Marker = {type = 1, x = 1.2, y = 1.2, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},
			{
				From = vector3(274.3, -1362.1, 23.54),
				To = {coords = vector3(329.62, -600.9, 42.28), heading = 0.0},
				Marker = {type = 1, x = 1.2, y = 1.2, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},
		},

		FastTravelsPrompt = {
		}

	}
}

Config.AuthorizedVehicles = {
	{
		model = 'ambulance',
		label = 'Ambulance'
	},
	{
		model = 'ambulance1',
		label = 'Ambulance 2'
	},
	{
		model = 'sams1',
		label = 'Ambulance 3'
	},
	{
		model = 'qrv',
		label = 'Ambulance 4x4'
	}	
}

