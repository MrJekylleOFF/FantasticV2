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
    { name = 'stanier',  label = 'Vehicule de livraison'},
}

Config.Blips = {
    
    Blip = {
        Pos     = { x = 263.73, y = -821.56, z = 29.44 },
        Sprite  = 89,
        Display = 4,
        Scale   = 0.9,
        Colour  = 59,
      },
  
  }

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = -143.3, y = -245.21, z = 43.05 },
        Size  = { x = 1.5, y = 1.5, z = 0.1 },
        Color = { r = 100, g = 0, b = 0 },
        Type  = 1,
    },

    Vaults = {
        Pos   = { x = -158.94, y = -239.94, z = 43.45 },
        Size  = { x = 1.5, y = 1.5, z = 0.1 },
        Color = { r = 100, g = 248, b = 0 },
        Type  = 1,
    },

    Fridge = {
        Pos   = { x = -163.06, y = -238.28, z = 43.45 },
        Size  = { x = 1.6, y = 1.6, z = 0.1 },
        Color = { r = 0, g = 100, b = 100 },
        Type  = 1,
    },

    Vehicles = {
        Pos          = { x = -137.93, y = -256.29, z = 42.6 },
        SpawnPoint   = { x = -130.27, y = -256.2, z = 43.06 },
        Size         = { x = 1.8, y = 1.8, z = 0.3 },
        Color        = { r = 200, g = 255, b = 0 },
        Type         = 1,
        Heading      = 343.82,
    },

    VehicleDeleters = {
        Pos         = { x = -130.27, y = -256.2, z = 43.06 },
        Size  = { x = 3.0, y = 3.0, z = 0.5 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
    },

    BossActions = {
        Pos   = { x = -161.51, y = -240.59, z = 43.45 },
        Size  = { x = 1.5, y = 1.5, z = 0.1 },
        Color = { r = 0, g = 0, b = 200 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = -162.0, y = -239.22, z = 43.45 },
        Size  = { x = 1.3, y = 1.3, z = 0.1 },
        Color = { r = 200, g = 30, b = 200 },
        Type  = 1,
        Items = {
            { name = 'bigmac',          label = _U('bigmac'),               price = 2 },
            { name = 'coca',            label = _U('coca'),                 price = 5 },
            { name = 'frite',           label = _U('frite'),                price = 1 },
            { name = 'icetea',          label = _U('icetea'),               price = 1 },
            { name = 'bolchips',        label = _U('bolchips'),             price = 3 },
            { name = 'jusfruit',        label = _U('jusfruit'),             price = 1 }, 
        },
    },

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    bowling_outfit = {
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
