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
    { name = 'mule',  label = 'Camion de livraison'},
}

Config.Blips = {
    
    Blip = {
        Pos     = { x = -1843.03, y = 3100.94, z = 32.86 },
        Sprite  = 537,
        Display = 4,
        Scale   = 0.9,
        Colour  = 1,
      },
  
  }

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = -1846.27, y = 3102.47, z = 31.86 },
        Size  = { x = 1.5, y = 1.5, z = 0.3 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
    },

    Vaults = {
        Pos   = { x = -1840.1, y = 3099.24, z = 31.86 },
        Size  = { x = 1.5, y = 1.5, z = 0.3 },
        Color = { r = 0, g = 248, b = 0 },
        Type  = 1,
    },

    Fridge = {
        Pos   = { x = -1844.32, y = 3104.75, z = 31.86 },
        Size  = { x = 1.6, y = 1.6, z = 0.3 },
        Color = { r = 0, g = 248, b = 0 },
        Type  = 1,
    },

    Vehicles = {
        Pos          = { x = -1826.16, y = 3132.86, z = 31.81 },
        SpawnPoint   = { x = -1812.88, y = 3138.13, z = 31.81 },
        Size         = { x = 1.8, y = 1.8, z = 0.3 },
        Color        = { r = 0, g = 255, b = 0 },
        Type         = 1,
        Heading      = 238.64,
    },

    VehicleDeleters = {
        Pos   = { x = -1812.88, y = 3138.13, z = 31.81 },
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
        Pos   = { x = -1842.67, y = 3100.66, z = 31.86 },
        Size  = { x = 1.6, y = 1.6, z = 0.3 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
        Items = {
            { name = 'pate',        label = 'Pate',                     price = 0 },
            { name = 'compote',     label = 'Compote a la pomme',       price = 0 },
            { name = 'puree',       label = 'Purée',                    price = 0 },
            { name = 'soupe',       label = 'Soupe',                    price = 0 },
            { name = 'frite',       label = 'Frite',                    price = 0 },
            { name = 'lentilles',   label = 'Lentilles',                price = 0 },
            { name = 'salade',      label = 'Salade',                   price = 0 },
        },
    },

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  cuisinier_outfit = {
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
