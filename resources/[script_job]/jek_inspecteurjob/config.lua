Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = 30
Config.Locale                     = 'fr'

Config.inspecteurStations = {

	INSP = {

		Cloakrooms = {
			{ x = -437.7, y = 5988.2, z = 31.7 },
		},

		Armories = {
			{ x = -440.04, y = 5991.7, z = 31.7 },
		},

		Vehicles = {
			{
				Spawner    = { x = -475.2, y = 5988.5, z = 31.3 },
				SpawnPoints = {
					{ x = -467.2, y = 6009.5, z = 31.3, heading = 28.298, radius = 0.0 },
				}
			}
		},

		Helicopters = {
			{
				Spawner    = { x = 1906.406, y = 580.51, z = 176.292 },
				SpawnPoint = { x = 1912.553, y = 589.478, z = 180.500 },
				Heading    = 189.12
			}
		},

		VehicleDeleters = {
			{ x = -460.2, y = 6041.3, z = 31.3 },
		},

		BossActions = {
			{ x = -433.2, y = 6001.7, z = 31.7 }
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'vortex',
			label = 'Vortex'
		},
		{
			model = 'fbi',
			label = 'Fbi'
		},
		{
			model = 'fbi2',
			label = 'Fbi 2'
		},
		{
			model = "police4",
			label = 'Fbi 3'
		}, 
		{
			model = 'baller6',
			label = 'Baller 6'
		},
		{
			model = 'riot',
			label = 'Riot 1'
		},
		{
			model = 'riot2',
			label = 'Riot 2'
		}
	},

	special = {
		
	},

	executif = {

	},

	responsable = {

	},

	boss = {

	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	special_wear = {
		male = {
			['tshirt_1'] = 33,  ['tshirt_2'] = 0,
			['torso_1'] = 31,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 22,
			['pants_1'] = 28,   ['pants_2'] = 0,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['chain_1'] = 125,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['glasses_1'] = 5,   ['glasses_2'] = 6
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	executif_wear = {
		male = {
			['tshirt_1'] = 35, ['tshirt_2'] = 0,
			['torso_1'] = 32, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 1, ['arms_2'] = 0,
			['pants_1'] = 28, ['pants_2'] = 0,
			['shoes_1'] = 40, ['shoes_2'] = 9,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['chain_1'] = 128, ['chain_2'] = 0,
			['ears_1'] = 0, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 41, ['tshirt_2'] = 2,
			['torso_1'] = 58, ['torso_2'] = 0,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 1,  ['arms_2'] = 0,
			['pants_1'] = 37, ['pants_2'] = 0,
			['shoes_1'] = 42, ['shoes_2'] = 2,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['chain_1'] = 98,
			['ears_1'] = 0, ['ears_2'] = 0
		}
	},
	responsable_wear = {
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['mask_1'] = 121
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as intendent_wear
	male = {
		['tshirt_1'] = 33,  ['tshirt_2'] = 0,
		['torso_1'] = 31,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 22,
		['pants_1'] = 28,   ['pants_2'] = 0,
		['shoes_1'] = 10,   ['shoes_2'] = 0,
		['helmet_1'] = 61,  ['helmet_2'] = 8,
		['chain_1'] = 125,    ['chain_2'] = 0,
		['ears_1'] = 2,     ['ears_2'] = 0,
		['glasses_1'] = 5,   ['glasses_2'] = 6
	},
	female = {
		['tshirt_1'] = 35,  ['tshirt_2'] = 0,
		['torso_1'] = 48,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 44,
		['pants_1'] = 34,   ['pants_2'] = 0,
		['shoes_1'] = 27,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 2,     ['ears_2'] = 0
	}
	},
	chapeau_wear = {
		male = {
			['helmet_1'] = 61,  ['helmet_2'] = 8
		},
		female = {
			['helmet_1'] = -1,  ['helmet_2'] = 0,
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 7,  ['bproof_2'] = 3
		}
	},
	bullet1_wear = {
		male = {
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	sac_wear = {
		male = {
			['bags_1'] = 44,  ['bags_2'] = 0
		},
		female = {
			['bags_1'] = 44,  ['bags_2'] = 0
		}
	},
	sac1_wear = {
		male = {
			['bags_1'] = 0,  ['bags_2'] = 0
		},
		female = {
			['bags_1'] = 0,  ['bags_2'] = 0
		}
	},
	casque_wear = {
		male = {
			['helmet_1'] = 117,  ['helmet_2'] = 0
		},
		female = {
			['bags_1'] = 0,  ['bags_2'] = 0
		}
	},
	casque1_wear =  {
		male = {
			['helmet_1'] = -1, ['helmet_2'] = 0
		},
		female = {
			['helmet_1'] = -1, ['helmet_2'] = 0
		}
	},
	cagoule_wear = {
		male = {
			['mask_1'] = 52, ['mask_2'] = 0
		},
		female = {
			['mask_1'] = 0, ['mask_2'] = 0
		}
	},
	cagoule1_wear = {
		male = {
			['mask_1'] = 0, ['mask_2'] = 0
		},
		female = {
			['mask_1'] = 0, ['mask_2'] = 0
		}
	},
	luno_wear = {
		male = {
			['glasses_1'] = 25, ['glasses_2'] = 4
		},
		female = {
			['mask_1'] = 0, ['mask_2'] = 0
		}
	},
	luno1_wear = {
		male = {
			['glasses_1'] = 0, ['glasses_2'] = 0
		},
		female = {
			['mask_1'] = 0, ['mask_2'] = 0
		}
	},
}