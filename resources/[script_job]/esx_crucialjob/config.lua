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
    { name = 'sultan',  label = 'Vehicule de livraison'},
}

Config.Blips = {
    
    Blip = {
        Pos     = { x = 263.73, y = -821.56, z = 29.44 },
        Sprite  = 89,
        Display = 4,
        Scale   = 0.6,
        Colour  = 59,
      },
  
  }

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = 267.76, y = -819.53, z = 28.44 },
        Size  = { x = 1.5, y = 1.5, z = 0.1 },
        Color = { r = 100, g = 0, b = 0 },
        Type  = 1,
    },

    Vaults = {
        Pos   = { x = 261.18, y = -816.03, z = 28.44 },
        Size  = { x = 1.5, y = 1.5, z = 0.1 },
        Color = { r = 100, g = 248, b = 0 },
        Type  = 1,
    },

    Fridge = {
        Pos   = { x = 260.34, y = -820.99, z = 28.44 },
        Size  = { x = 1.6, y = 1.6, z = 0.1 },
        Color = { r = 0, g = 100, b = 100 },
        Type  = 1,
    },

    Vehicles = {
        Pos          = { x = 215.82, y = -810.59, z = 29.72 },
        SpawnPoint   = { x = 221.74, y = -804.01, z = 30.68 },
        Size         = { x = 1.8, y = 1.8, z = 0.3 },
        Color        = { r = 200, g = 255, b = 0 },
        Type         = 1,
        Heading      = 343.82,
    },

    VehicleDeleters = {
        Pos         = { x = 221.74, y = -804.01, z = 29.68 },
        Size  = { x = 3.0, y = 3.0, z = 0.5 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
    },

    BossActions = {
        Pos   = { x = 263.85, y = -818.23, z = 28.44 },
        Size  = { x = 1.5, y = 1.5, z = 0.1 },
        Color = { r = 0, g = 0, b = 200 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = 263.77, y = -821.51, z = 28.44 },
        Size  = { x = 2.0, y = 2.0, z = 0.1 },
        Color = { r = 200, g = 30, b = 200 },
        Type  = 1,
        Items = {
            { name = 'nachos',          label = _U('nachos'),           price = 2 },
            { name = 'taco',            label = _U('tacos'),            price = 2 },
            { name = 'buritto',         label = _U('buritto'),          price = 5 },
            { name = 'salade',          label = _U('salade'),           price = 1 },
            { name = 'donut',           label = _U('donuts'),           price = 1 },
            { name = 'soda',            label = _U('soda'),             price = 3 },
            { name = 'coffe',           label = _U('coffe'),            price = 1 },
            { name = 'chocolate',        label = _U('chocolate'),        price = 2 },
            { name = 'tea',        label = _U('tea'),        price = 1 },
          --  { name = 'coca',       label = _U('coca'),             price = 5 },
          --  { name = 'frite',           label = _U('frite'),           price = 1 },
           -- { name = 'icetea',          label = _U('icetea'),           price = 1 },
          --  { name = 'bolchips',    label = _U('bolchips'),             price = 3 },
          --  { name = 'jusfruit',    label = _U('jusfruit'),            price = 1 },
            { name = 'sandwich',    label = _U('sandwich'),            price = 1 },     
        },
    },

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    crucial_outfit = {
   male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 281,   ['torso_2'] = 6,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 26,   ['pants_2'] = 0,
        ['shoes_1'] = 4,    ['shoes_2'] = 4,
        ['chain_1'] = 0,    ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 8,  ['tshirt_2'] = 0,
        ['torso_1'] = 141,   ['torso_2'] = 4,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 27,   ['pants_2'] = 0,
        ['shoes_1'] = 3,   ['shoes_2'] = 2,
        ['chain_1'] = 0,  ['chain_2'] = 0
    }
  }
}
