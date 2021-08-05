Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
--Config.BiereblancheEarnings       = {min = 10, max = 20}
--Config.BierebruneEarnings         = {min = 15, max = 25}
Config.EnableSocietyOwnedVehicles = false
Config.Locale                     = 'fr'
Config.MaxInService = 20

Config.EnableJobLogs              = true -- only turn this on if you are using esx_joblogs

Config.Zones = {

	OrgeFarm = {
		Pos   = {x = 333.1918, y = 6629.6157, z = 27.7918},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 237, g = 127, b = 16},
		Name  = "Récolte d'orge",
		Type  = 1,
		Marker = 27
	},
    
    HoublonFarm = {
		Pos   = {x = 1959.1846, y = 4851.8598, z = 44.4433},   
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 237, g = 127, b = 16},
		Name  = "Récolte d'houblon",
		Type  = 1,
		Marker = 27
	},

	TraitementBiereblanche = {
		Pos   = {x = 815.9472, y = -115.4467, z = 79.4598},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 237, g = 127, b = 16},
		Name  = "Traitement des biere blanche",
		Type  = 1,
		Marker = 27
	},

	TraitementBierebrune = {
		Pos   = {x = 822.8637, y = -119.4402, z = 79.4584}, 
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 237, g = 127, b = 16},
		Name  = "Traitement des biere brune",
		Type  = 1,
		Marker = 27
	},
	
	SellFarm = {
		Pos   = {x = -702.94, y = -917.06, z = 19.21},
		Size  = {x = 3.0, y = 3.0, z = 2.0},
		Color = {r = 21, g = 223, b = 27},
		Name  = "Vente des produits",
		Type  = 1,
		Marker = 29
	},

	brasseurActions = {
		Pos   = {x = 346.1686, y = 3406.2124, z = 36.50},        
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 21, g = 223, b = 27},
		Name  = "Point d'action",
		Type  = 0,
		Marker = 24
	 },
	  
	VehicleSpawner = {
		Pos   = {x = 314.0780, y = 3401.5034, z = 36.7465},
		Size = {x = 1.5, y = 3, z = 1.0},
		Color = {r = 26, g = 43, b = 243},
		Name = _U("Garage véhicule"),
		Type = 0,
		Marker = 39
    },

	VehicleSpawnPoint = {
		Pos   = {x = 317.7881, y = 3405.7153, z = 36.7498},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Name = _U("spawn point"),
		Type = -1

    },

	VehicleDeleter = {
		Pos   = {x = 318.8784, y = 3408.2949, z = 36.73},
		Size = {x = 1.5, y = 3, z = 1.0},
		Color = {r = 243, g = 26, b = 26},
		Name = _U("Ranger son véhicules"),
		Type = 0,
		Marker = 39
	}
}    