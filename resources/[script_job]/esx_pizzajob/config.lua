Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {
    { name = 'faggio',  label = 'Scooter de livraison'},
}

Config.Blips = {
    
    Blip = {
        Pos     = { x = 284.58, y = -970.804, z = 29.87 },
        Sprite  = 103,
        Display = 4,
        Scale   = 0.9,
        Colour  = 59,
      },
  
  }

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = 288.37, y = -974.26, z = 28.87 },
        Size  = { x = 1.5, y = 1.5, z = 0.3 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
    },

    Vaults = {
        Pos   = { x = 282.262, y = -975.73, z = 28.87 },
        Size  = { x = 1.5, y = 1.5, z = 0.3 },
        Color = { r = 0, g = 248, b = 0 },
        Type  = 1,
    },

    Fridge = {
        Pos   = { x = 271.94, y = -975.30, z = 28.86 },
        Size  = { x = 1.6, y = 1.6, z = 0.3 },
        Color = { r = 0, g = 248, b = 0 },
        Type  = 1,
    },

    Vehicles = {
        Pos          = { x = 299.525, y = -963.077, z = 28.41 },
        SpawnPoint   = { x = 306.99, y = -957.06, z = 28.27 },
        Size         = { x = 1.8, y = 1.8, z = 0.3 },
        Color        = { r = 0, g = 255, b = 0 },
        Type         = 1,
        Heading      = 269.71,
    },

    VehicleDeleters = {
        Pos   = { x = 306.99, y = -957.06, z = 28.27 },
        Size  = { x = 3.0, y = 3.0, z = 0.5 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
    },

    BossActions = {
        Pos   = { x = 285.85, y = -977.96, z = 28.871 },
        Size  = { x = 1.5, y = 1.5, z = 0.3 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = 274.88, y = -975.34, z = 28.86 },
        Size  = { x = 1.6, y = 1.6, z = 0.3 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
        Items = {
            { name = 'pate',         label = _U('pate'),        price = 2 },
            { name = 'ing',   label = _U('ing'),        price = 8 },
        },
    },

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  pizza_outfit = {
   male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 281,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 27,   ['pants_2'] = 1,
        ['shoes_1'] = 7,    ['shoes_2'] = 8,
        ['chain_1'] = 0,    ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 13,  ['tshirt_2'] = 0,
        ['torso_1'] = 294,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 112,   ['pants_2'] = 1,
        ['shoes_1'] = 81,   ['shoes_2'] = 12,
        ['chain_1'] = 0,  ['chain_2'] = 0
    }
  }
}
