Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = true
Config.EnableMoneyWash            = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {
    { name = 'rumpo',  label = 'Camionette WEAZEL-NEWS' },
    { name = 'mule4',  label = 'Camion Transport' },
    { name = 'rentalbus',  label = 'Vanilla Unicorn Bus' },
    { name = 'tourbus',  label = 'Bus VINEWOOD' },
    { name = 'pbus2',  label = 'Festival Bus' },
    { name = 'stretch',  label = 'Limousine' },
    { name = 'patriot2',  label = 'Patriot Stretch-Limo' },
    { name = '',  label = '-----EVENT-----' },
}

Config.Blips = {
    
    Blip = {
            Pos     = { x = -3009.36, y = 65.0120, z = 22.01 },
            Sprite  = 136,
            Display = 4,
            Scale   = 0.6,
            Colour  = 27,
          },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = -1619.75, y = -3020.03, z = -76.20 },
        Size  = { x = 1.5, y = 1.5, z = 0.4 },
        Color = { r = 255, g = 0, b = 255 },
        Type  = 1,
    },

    Vaults = {
        Pos   = { x = -1610.66, y = -3018.91, z = -76.21 },
        Size  = { x = 1.3, y = 1.3, z = 0.4 },
        Color = { r = 255, g = 225, b = 0 },
        Type  = 1,
    },

    Fridge = {
        Pos   = { x = -1583.04, y = -3013.95, z = -77.00 },
        Size  = { x = 1.6, y = 1.6, z = 0.4 },
        Color = { r = 0, g = 255, b = 255 },
        Type  = 1,
    },

    Vehicles = {
        Pos          = { x = -2963.18, y = 65.51, z = 10.61 },
        SpawnPoint   = { x = -2973.94, y = 70.86, z = 10.61 },
        Size         = { x = 1.8, y = 1.8, z = 0.4 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 1,
        Heading      = 50.41,
    },

    VehicleDeleters = {
        Pos   = { x = -2958.12, y = 59.48, z = 10.61 },
        Size  = { x = 3.0, y = 3.0, z = 0.4 },
        Color = { r = 255, g = 0, b = 0 },
        Type  = 1,
    },

    Helicopters = {
        Pos          = { x = 246.20, y = -3250.52, z = 39.55 },
        SpawnPoint   = { x = 235.35, y = -3260.38, z = 39.54 },
        Size         = { x = 1.8, y = 1.8, z = 0.4 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 207.43,
    },

    HelicopterDeleters = {
        Pos   = { x = 212.21, y = -3256.65, z = 39.53 },
        Size  = { x = 3.0, y = 3.0, z = 0.4 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },

    BossActions = {
        Pos   = { x = -1619.52, y = -3010.86, z = -75.20 },
        Size  = { x = 1.5, y = 1.5, z = 0.4 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = -1634.8, y = -2997.4, z = -79.14 },
        Size  = { x = 1.6, y = 1.6, z = 0.4 },
        Color = { r = 255, g = 0, b = 255 },
        Type  = 1,
        Items = {
            { name = 'jager',      label = _U('jager'),   price = 3 },
            { name = 'vodka',      label = _U('vodka'),   price = 3 },
            { name = 'rhum',       label = _U('rhum'),    price = 3 },
            { name = 'whisky',     label = _U('whisky'),  price = 3 },
            { name = 'tequila',    label = _U('tequila'), price = 3 }
        },
    },

    NoAlcool = {
        Pos   = { x = -84.12, y = 6497.56, z = 30.49 },
        Size  = { x = 1.6, y = 1.6, z = 0.4 },
        Color = { r = 0, g = 130, b = 255 },
        Type  = 1,
        Items = {
            { name = 'soda',        label = _U('soda'),     price = 2 },
            { name = 'jusfruit',    label = _U('jusfruit'), price = 2 },
            { name = 'icetea',      label = _U('icetea'),   price = 2 },
            { name = 'energy',      label = _U('energy'),   price = 2 },
            { name = 'limonade',    label = _U('limonade'), price = 2 }
        },
    },

    Apero = {
        Pos   = { x = -1044.19, y = -234.8, z = 36.96 },
        Size  = { x = 1.6, y = 1.6, z = 0.4 },
        Color = { r = 142, g = 125, b = 76 },
        Type  = 1,
        Items = {
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 2 },
            { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 2 },
            { name = 'bolpistache',     label = _U('bolpistache'),      price = 2 },
            { name = 'bolchips',        label = _U('bolchips'),         price = 2 },
            { name = 'saucisson',       label = _U('saucisson'),        price = 2 },
            { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 2 }
        },
    },

    Ice = {
        Pos   = { x = -1578.83, y = -3018.17, z = -80.01 },
        Size  = { x = 1.6, y = 1.6, z = 0.4 },
        Color = { r = 0, g = 255, b = 255 },
        Type  = 1,
        Items = {
            { name = 'ice',     label = _U('ice'),      price = 1 },
            { name = 'menthe',  label = _U('menthe'),   price = 1 }
        },
    },

}


-----------------------
----- TELEPORTERS -----

Config.TeleportZones = {
  --EnterBuilding = {
    --Pos       = { x = 132.608, y = -1293.978, z = 28.269 },
    --Size      = { x = 1.2, y = 1.2, z = 0.1 },
    --Color     = { r = 128, g = 128, b = 128 },
    --Marker    = 1,
    --Hint      = _U('e_to_enter_1'),
    --Teleport  = { x = 126.742, y = -1278.386, z = 28.569 }
  --},

  --ExitBuilding = {
    --Pos       = { x = 132.517, y = -1290.901, z = 28.269 },
    --Size      = { x = 1.2, y = 1.2, z = 0.1 },
    --Color     = { r = 128, g = 128, b = 128 },
    --Marker    = 1,
    --Hint      = _U('e_to_exit_1'),
    --Teleport  = { x = 131.175, y = -1295.598, z = 28.569 },
  --},

  EnterHeliport = {
    --Pos       = { x = -1639.80, y = -3012.08, z = -79.14 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2'),
    Teleport  = { x = 250.75, y = -3258.82, z = 40.50 }
  },

  ExitHeliport = {
    --Pos       = { x = 256.48, y = -3255.79, z = 39.47 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = -1641.18, y = -3004.89, z = -80.10 },
  },
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  barman_outfit = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 40,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 28,   ['pants_2'] = 2,
        ['shoes_1'] = 38,   ['shoes_2'] = 4,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 8,    ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 44,   ['pants_2'] = 4,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 2
    }
  },
  dancer_outfit_1 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 9,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 22,   ['pants_2'] = 0,
        ['shoes_1'] = 18,   ['shoes_2'] = 0,
        ['chain_1'] = 61,   ['chain_2'] = 1
    }
  },
  dancer_outfit_2 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 62,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 20,   ['pants_2'] = 2,
        ['shoes_1'] = 18,   ['shoes_2'] = 2,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_3 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 19,   ['pants_2'] = 1,
        ['shoes_1'] = 19,   ['shoes_2'] = 3,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_4 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 61,   ['pants_2'] = 5,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 82,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 11,
        ['shoes_1'] = 41,   ['shoes_2'] = 11,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_5 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 21,   ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 5,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 2,
        ['shoes_1'] = 41,   ['shoes_2'] = 2,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_6 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 81,   ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 18,   ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 10,
        ['shoes_1'] = 41,   ['shoes_2'] = 10,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_7 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 9,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 111,  ['torso_2'] = 6,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 6,
        ['shoes_1'] = 41,   ['shoes_2'] = 6,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  }
}

-- markers
Config.zones = {

    NightclubEnter = {
        x = -3024.54,
        y = 80.04,
        z = 10.90,
        w = 1.5,
        h = 0.3,        
        visible = false,
        t = 1,
        color = {
            r = 220,
            g = 0,
            b = 255
        }
    },
    
    NightclubExit = {
        x = -1569.54,
        y = -3017.46,
        z = -74.30,
        w = 1.5,
        h = 0.5,        
        visible = false,
        t = 1,
        color = {
            r = 220,
            g = 0,
            b = 255
        }
    },
}

-- Landing point,
Config.point = {

    NightclubEnter = {
        x = -1569.86,
        y = -3015.50,
        z = -74.40
    },
    
    NightclubExit = {
        x = -3022.85,
        y = 81.999,
        z = 10.60
    }
}


-- Automatic teleport list
Config.auto = {
	'Nightclub',
	'NightclubEnter',
	'NightclubExit'
}