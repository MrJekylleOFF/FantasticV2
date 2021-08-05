Config = {}


Config.EnableShops                = true    -- If true spawn Some Shop & Interior NPCs

--Cops--
Config.EnableCops                 = true    -- If true spawn All Cops at Departments
--Cops--

--Nightclub--
Config.EnableNightclubs           = true    -- If true spawn Nightclub NPCs (Need a IPL Loader https://github.com/Bob74/bob74_ipl or other) (After Hours DLC)
Config.EnableSolomun              = false    -- If true spawn Solomun at Nightclub DJ
Config.EnableDixon                = false   -- If true spawn Dixon at Nightclub DJ
Config.EnableMairie				  = true
--Nightclub--

--Biker DLC--
Config.EnableDrugs                = false    -- If true spawn NPCs & Guards at Druglabors (Biker DLC)
Config.EnableWeapons              = false    -- If true spawn Guards with Weapons (can change in main.lua)
--Biker DLC--



-------------------------------------RANDOMSHOPS-------------------------------------
Config.Locations1 = { -- Some Shop & Interior NPCs
	{ x = 440.85,   y = -978.41,  z = 29.69, heading = 165.95 },    -- PD Main Welcome
	{ x = 458.97,   y = -1017.28, z = 27.16, heading = 93.50 },    -- PD Main Garage
	{ x = -1117.15, y = -503.20,  z = 34.81, heading = 294.48 },    -- Moneywash Moveact
	{ x = -705.93,  y = -914.33,  z = 18.22, heading = 81.50 },    -- LT Gasoline1
	{ x = -47.14,   y = -1758.82, z = 28.42, heading = 46.58 },    -- LT Gasoline2
	{ x = 2678.57,  y = 3278.88,  z = 54.24, heading = 337.70 },    -- 24/7 Freeway
	{ x = 1960.20,  y = 3739.33,  z = 31.34, heading = 296.50 },    -- 24/7 Sandy Shores
	{ x = -32.94,   y = -1103.65, z = 25.42, heading = 77.25 },    -- Cardealer1
	{ x = 1224.68,  y = 2728.74,  z = 37.01, heading = 178.82 },    -- Cardealer2
	{ x = 1133.87,  y = -983.21,  z = 45.42, heading = 274.80 },    -- EL Rancho Robs Li
	{ x = 85.88,    y = -1959.85, z = 20.12, heading = 27.20 },    -- Grove Str Cannabis Dealer
	{ x = 6.80,     y = 6468.32,  z = 30.43, heading = 51.28 },    -- Paleto Bay Meth Dealer
	{ x = -3155.14, y = 1126.35,  z = 19.86, heading = 42.10 },    -- Cusmash opium Dealer
	{ x = 959.31,   y = -121.22,  z = 73.96, heading = 185.45 },    -- Vinewood Coke Dealer
	{ x = 408.06,   y = -1623.68, z = 28.29, heading = 219.45 },    -- Vehicle Impound
	{ x = 24.20,    y = -1347.60, z = 28.50, heading = 271.32 },    -- Strawberry 24/7
	{ x = 1165.09,  y = -323.51,  z = 69.21, heading = 93.72 },    -- LT Gasoline3
	{ x = -1486.41, y = -377.33,  z = 39.16, heading = 138.12 },    -- Morningwood Robs Li
	{ x = 1165.15,  y = 2711.11,  z = 37.16, heading = 176.58 },    -- Route 68 Robs Li
	{ x = 2557.46,  y = 380.49,   z = 107.62,heading = 4.25 },    -- Mountains Freeway 24/7
	{ x = 1391.82,  y = 3606.29,  z = 33.98, heading = 204.25 },    -- Sandy Shores ACE
	{ x = 549.27,   y = 2671.82,  z = 41.16, heading = 100.35 },    -- Sandy Shores 24/7
	{ x = 1697.35,  y = 4923.32,  z = 41.06, heading = 332.42 },    -- Sandy Shores LT Gasoline4
	{ x = 1727.62,  y = 6415.18,  z = 34.04, heading = 241.98 },    -- Chilliad Freeway 24/7
	{ x = -3241.96, y = 999.86,   z = 11.83, heading = 4.68 },    -- cumash Freeway 24/7
	{ x = -3038.68, y = 584.38,   z = 6.91,  heading = 24.72 },    -- Ocean Freeway 24/7
	{ x = -2966.12, y = 391.35,   z = 14.04, heading = 77.04 },    -- Ocean Freeway LT Gasoline5
	{ x = -1819.51, y = 793.72,   z = 137.08,heading = 134.72 }    -- Ocean Freeway LT Gasoline5


}

------------------------------------NIGHTCLUBS-------------------------------------
Config.Locations2 = { -- Nightclub Girls1
	{ x = -1593.89,   y = -3008.52, z = -80.01, heading = 209.22 },	-- NClub1
	{ x = -1587.04,   y = -3005.37, z = -80.01, heading = 137.55 },	-- NClub2
	{ x = -1576.61,   y = -3014.49, z = -80.01, heading = 168.78 },	-- NClub3
	{ x = -1590.54,   y = -3018.24, z = -77.00, heading = 317.10 },	-- NClub4
	{ x = -1585.82,   y = -3008.32, z = -77.00, heading = 218.75 },	-- NClub5
	{ x = -1599.40,   y = -3000.15, z = -76.81, heading = 233.95 }	-- NClub6
}

Config.Locations3 = { -- Nightclub Girls Cheering
	{ x = -1594.81,   y = -3014.21, z = -80.01, heading = 71.46 },	-- NClub1
	{ x = -1597.48,   y = -3010.60, z = -80.01, heading = 104.40 },	-- NClub2
	{ x = -1595.69,   y = -3015.98, z = -78.81, heading = 7.77 },	-- NClub3
	{ x = -1590.34,   y = -3012.13, z = -77.00, heading = 92.40 },	-- NClub4
	{ x = -1605.82,   y = -3011.27, z = -78.80, heading = 244.36 }	-- NClub5
}

Config.Locations4 = { -- Nightclub Girls Partying
	{ x = -1597.33,   y = -3009.50, z = -80.01, heading = 170.30 },	-- NClub1
	{ x = -1588.78,   y = -3017.87, z = -77.01, heading = 65.83 },	-- NClub2
	{ x = -1597.09,   y = -3000.30, z = -76.81, heading = 145.02 },	-- NClub3
	{ x = -1577.94,   y = -3014.36, z = -80.01, heading = 225.58 }	-- NClub4
}

Config.Locations5 = { -- Nightclub Girls Slow
	{ x = -1596.56,   y = -3013.57, z = -80.01, heading = 65.55 },	-- NClub1
	{ x = -1591.78,   y = -3010.03, z = -80.01, heading = 116.30 },	-- NClub2
	{ x = -1587.04,   y = -3011.44, z = -77.00, heading = 101.45 },	-- NClub3
	{ x = -1598.90,   y = -3006.84, z = -77.00, heading = 268.78 },	-- NClub4
	{ x = -1575.12,   y = -3006.97, z = -80.01, heading = 157.70 }	-- NClub5
}

Config.Locations6 = { -- Nightclub Girls Tops
	{ x = -1598.59,   y = -3015.69, z = -79.21, heading = 282.30 },	-- NCTop1
	{ x = -1596.21,   y = -3007.97, z = -79.21, heading = 151.05 }	-- NCTop2
}

Config.Locations7 = { -- Nightclub Mens1
	{ x = -1599.30,   y = -3012.06, z = -80.01, heading = 316.20 },	-- NClub1
	{ x = -1587.75,   y = -3007.00, z = -80.01, heading = 354.15 },	-- NClub2
	{ x = -1575.79,   y = -3008.55, z = -80.01, heading = 324.48 }	-- NClub3
}

Config.Locations8 = { -- Nightclub Mens2
	{ x = -1592.69,   y = -3008.70, z = -80.01, heading = 133.05 },	-- NClub1
	{ x = -1606.27,   y = -3014.39, z = -78.80, heading = 337.85 },	-- NClub2
	{ x = -1575.75,   y = -3012.27, z = -80.01, heading = 135.35 },	-- NClub3
	{ x = -1588.74,   y = -3011.59, z = -77.00, heading = 277.38 },	-- NClub4
	{ x = -1599.36,   y = -3002.17, z = -76.81, heading = 325.15 }	-- NClub5
}

Config.Locations9 = { -- Nightclub Mens3
	{ x = -1597.49,   y = -3006.86, z = -77.00, heading = 93.60 },	-- NClub1
	{ x = -1596.35,   y = -3011.46, z = -80.01, heading = 107.00 },	-- NClub2
	{ x = -1611.66,   y = -3009.90, z = -80.01, heading = 119.85 }	-- NClub3
}

Config.Locations10 = { -- Nightclub Bartender
	{ x = -1584.95,   y = -3012.60, z = -77.01, heading = 92.70 },	-- NClub1
	{ x = -1577.97,   y = -3016.80, z = -80.01, heading = 359.28 },	-- NClub2
	{ x = -1572.20,   y = -3013.56, z = -75.41, heading = 272.63 }	-- NCWelcome
}

Config.Locations11 = { -- Nightclub Guards
	{ x = -1576.46,   y = -3010.37, z = -80.01, heading = 79.00 },	-- NClub1
	{ x = -1588.06,   y = -3014.43, z = -80.01, heading = 349.75 },	-- NClub2
	{ x = -1585.96,   y = -3016.78, z = -77.00, heading = 136.40 },	-- NClub3
	{ x = -1605.85,   y = -3013.04, z = -78.80, heading = 288.05 },	-- NClub4
	{ x = -1614.12,   y = -3009.50, z = -76.21, heading = 119.75 },	-- NClub5
	{ x = -1568.17,   y = -3015.47, z = -75.41, heading = 39.15 },	-- NCWelcome
	{ x = 194.45,     y = -3165.86, z = 4.79,   heading = 115.62 },	-- NCOut
	--
	{ x = 123.57,     y = -1290.38, z = 28.29,  heading = 240.82 },	-- Vanilla1
	{ x = 107.82,     y = -1298.90, z = 27.77,  heading = 172.95 },	-- Vanilla2
	{ x = 462.81,     y = -992.30,  z = 23.91,  heading = 349.60 },	-- LSPD Prison1
	{ x = 462.89,     y = -1003.08, z = 23.91,  heading = 347.88 },	-- LSPD Prison2
	{ x = 470.40,     y = -1015.15, z = 25.39,  heading = 154.75 }	-- LSPD Prison3
	
}

Config.Locations12 = { -- Nightclub Solomun
	{ x = -1604.01,   y = -3011.99, z = -78.80, heading = 266.30 }	-- NCSolomun
}

Config.Locations13 = { -- Nightclub Dixon
	{ x = -1604.01,   y = -3011.99, z = -78.80, heading = 266.30 }	-- NCDixon
}


Config.Locations14 = { -- Mairie
	{ x = -545.09, y = -204.13,   z = 37.22,heading = 211.89 }    -- Mairie
	
}

