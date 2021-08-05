Config                            = {}
Config.DrawDistance               = 600.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.8 }
Config.MarkerColor                = { r = 0, g = 50, b = 20 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.ArmyStations = {

  ARMY = {

    Blip = {
      Pos     = { x = -2307.806, y = 3390.877, z = 30.989 },
      Sprite  = 358,
      Display = 4,
      Scale   = 1.2,
--      Colour  = 29,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_NIGHTSTICK',       price = 2000 },
      { name = 'WEAPON_COMBATPISTOL',     price = 300000 },
      { name = 'WEAPON_ASSAULTSMG',       price = 1250000 },
      { name = 'WEAPON_ASSAULTRIFLE',     price = 1500000},
      { name = 'WEAPON_PUMPSHOTGUN',      price = 600000 },
      { name = 'WEAPON_STUNGUN',          price = 50000 },
      { name = 'WEAPON_FLASHLIGHT',       price = 800 },
      { name = 'WEAPON_FIREEXTINGUISHER', price = 12000 },
      { name = 'WEAPON_FLAREGUN',         price = 60000 },
      { name = 'WEAPON_STICKYBOMB',       price = 250000 },
      { name = 'WEAPON_KNIFE',            price = 2000 },
      { name = 'WEAPON_CROWBAR',          price = 3000 },
      { name = 'WEAPON_PISTOL',           price = 125000 },
      { name = 'WEAPON_PISTOL50',         price = 150000 },
      { name = 'WEAPON_MG',               price = 600000 },
      { name = 'WEAPON_STINGER',          price = 120000 },
      { name = 'WEAPON_BULLPUPRIFLE',     price = 600000 },
      { name = 'WEAPON_HEAVYSHOTGUN',     price = 250000 },
      { name = 'WEAPON_HEAVYSNIPER',      price = 2500000 },
      { name = 'WEAPON_MARKSMANRIFLE',    price = 2000000 },
      { name = 'WEAPON_AUTOSHOTGUN',      price = 1250000 },
      { name = 'WEAPON_ASSAULTRIFLE',     price = 1500000 },
      { name = 'WEAPON_REMOTESNIPER',     price = 1500000 },
      { name = 'GADGET_PARACHUTE',        price = 3000 },
    },

	AuthorizedVehicles = {
		{name = 'apc' , label = 'Transport blindé Tout-Terrain'},
		{name = 'barracks', label = 'Convoi'},
		{name = 'barracks2', label = 'Convoi sans remorque'},
		{name = 'crusader', label = 'Transport de Troupes'},
		--{name = 'rhino', label = 'Tank'},
		{name = 'hauler2', label = 'Transport'},
	--{name = 'phantom2', label = 'Transport'},
		{name = 'insurgent', label = 'Véhicule de combat blindé Tout-Terrain'},
		{name = 'insurgent2', label = 'Véhicule de transport blindé Tout-Terrain'},
		{name = 'insurgent3', label = 'Véhicule de combat blindé Tout-Terrain'},
		{name = 'savage', label = 'Hélicoptère de combat lourd'},
		{name = 'buzzard', label = 'Hélicoptère de combat'},
		{name = 'annihilator', label = 'Hélicoptère de combat mitrailleur'},
		{name = 'cargobob', label = 'Transport Aérien'},
	},

    Cloakrooms = {
      { x = -2115.95, y = 2815.78, z = 31.67 },
    },

    Armories = {
      { x = -2111.83, y = 2815.35, z = 31.67 },
    },

    Vehicles = {
      {
        Spawner    = { x = -2129.61, y = 2830.23, z = 31.96 },
        SpawnPoint = { x = -2107.45, y = 2845.89, z = 31.830 },
        Heading    = 29.36,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = -2399.345, y = 3273.080, z = 31.977 },
        SpawnPoint = { x = -2019.129, y = 2865.339, z = 31.906 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = -2104.87, y = 2831.02, z = 31.9 },
       { x = -2107.45, y = 2845.89, z = 31.830 },
      { x = -2413.052, y = 3287.123, z = 32.830 },
    },

    BossActions = {
      { x = -2116.0939, y = 2824.97, z = 31.67 }
    },

  },

}
