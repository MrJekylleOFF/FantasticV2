Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 0, g = 0, b = 255 }
Config.EnablePlayerManagement     = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'fr'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

    ShopEntering = {
        Pos   = { x =  965.55, y = -3003.6, z = -40.64 },
        Size  = { x = 1.5, y = 1.5, z = 0.4 },
        Type  = 1
    },

    ShopInside = {
        Pos     = { x = 978.23, y = -3001.97, z = -39.6 },
        Size    = { x = 1.5, y = 1.5, z = 0.4 },
        Heading = 278.11,
        Type    = -1
    },

    ShopOutside = {
        Pos     = { x = 971.71, y = -2991.46, z = -39.70 },
        Size    = { x = 1.5, y = 1.5, z = 0.4 },
        Heading = 181.12,
        Type    = -1
    },

    BossActions = {
        Pos   = { x = 963.2, y = -2994.7, z = -40.65 },
        Size  = { x = 1.5, y = 1.5, z = 0.4 },
        Type  = 1
    },

    --[[GiveBackVehicle = {
        Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
        Size  = { x = 3.0, y = 3.0, z = 1.0 },
        Type  = (Config.EnablePlayerManagement and 1 or -1)
    },]]--

    --[[ResellVehicle = {
        Pos   = { x = -44.630, y = -1080.738, z = 25.683 },
        Size  = { x = 3.0, y = 3.0, z = 1.0 },
        Type  = 1
    }]]--

}
