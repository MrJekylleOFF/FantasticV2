Config                            = {}
Config.DrawDistance               = 20.0
Config.Locale = 'fr'
Config.DeliveryTime = 1 -- IN SECOUNDS DEFAULT (18000) IS 5 HOURS / 300 MINUTES
Config.TimeBetweenRobberies = 43200
Config.CutOnRobbery = 10 -- IN PERCENTAGE FROM THE TARGET SHOP
Config.RequiredPolices = 0 -- For the robbery
Config.SellValue = 2 -- This is the shops value divided by 2
Config.ChangeNamePrice = 50 -- In $ - how much you can change the shops name for

-- CONFIG ITEMS, DON'T FORGET TO ADD CORRECT NUMBER IN THE BRACKETS
Config.Items = {
  [1] = {label = "Eau",               item = "water",               price = 5,               categorie="boisson"},
  [2] = {label = "Jus de fruit",      item = "jusfruit",            price = 5,               categorie="boisson"},
  [3] = {label = "Pain",              item = "bread",               price = 5,               categorie="nourriture"},
  [4] = {label = "Hamburger",         item = "burger",              price = 5,               categorie="nourriture"},
  [5] = {label = "Cigarette Forfume",              item = "cigarett",               price = 5,               categorie="consommable"},
  [6] = {label = "Cigarette Balaclope",         item = "cigarettr",              price = 5,               categorie="consommable"},
  [7] = {label = "GPS",         item = "gps",              price = 5,               categorie="divers"},
  [8] = {label = "Téléphone",         item = "tel",              price = 5,             categorie="divers"},
}

Config.Images = {
  [1] = {item = "water",                  src = "img/bottle.png"},
  [2] = {item = "bread",                  src = "img/pain.png"},
  [3] = {item = "gps",                    src = "img/gps.png"},
  [4] = {item = "parapluie",              src = "img/umbrella.png"},
  [5] = {item = "picnic",                 src = "img/picnic.png"},
  [6] = {item = "bag",                    src = "img/bag.png"},
  [7] = {item = "croquettes",             src ="img/croquettes.png"},
  [8] = {item = "paquet de chips",        src ="img/paquet de chips.png"},
  [9] = {item = "CocaCola",               src ="img/coca.png"},
  [10] = {item = "sprit",                 src ="img/sprit.png"},
  [11] = {item = "whisky",                src ="img/whisky.png"},
  [12] = {item = "Orange",                src ="img/orange.png"},
  [13] = {item = "tel",                 src ="img/tel.png"},
  [14] = {item = "7up",                   src ="img/7up.png"},
  [15] = {item = "alcool",                src ="img/alcool.png"},
  [16] = {item = "alliance",              src ="img/alliance.png"},
  [17] = {item = "ball",                  src ="img/ball.png"},
  [18] = {item = "burgerthon",            src ="img/burgerthon.png"},
  [19] = {item = "cagoule",               src ="img/cagoule.png"},
  [20] = {item = "chargeur",              src ="img/chargeur.png"},
  [21] = {item = "cheeseburger",          src ="img/cheeseburger.png"},
  [22] = {item = "cocacola",              src ="img/cocacola.png"},
  [23] = {item = "cryptedphone",          src ="img/cryptedphone.png"},
  [24] = {item = "doliprane",             src ="img/doliprane.png"},
  [25] = {item = "drive",                 src ="img/drive.png"},
  [26] = {item = "fanta",                 src ="img/fanta.png"},
  [27] = {item = "flashlight",            src ="img/flashlight.png"},
  [28] = {item = "grandcru",              src ="img/grandcru.png"},
  [29] = {item = "hamburger",             src ="img/hamburger.png"},
  [30] = {item = "icetea",                src ="img/icetea.png"},
  [31] = {item = "phone",                 src ="img/phone.png"},
  [32] = {item = "jager",                 src ="img/jager.png"},
  [33] = {item = "pincecoupante",         src ="img/pincecoupante.png"},
  [34] = {item = "powerade",              src ="img/powerade.png"},
  [35] = {item = "redbull",               src ="img/redbull.png"},
  [36] = {item = "rose",                  src ="img/rose.png"},
  [37] = {item = "serflex",               src ="img/serflex.png"},
  [38] = {item = "sprite",                src ="img/sprite.png"},
  [39] = {item = "weed",                  src ="img/weed.png"},
  [40] = {item = "cannabis",              src ="img/cannabis.png"},
  [41] = {item = "burger",                src ="img/hamburger.png"},
  [42] = {item = "hacha",                 src ="img/hacha.png"},
  [43] = {item = "chest",                 src ="img/chest.png"},
  [44] = {item = "pico",                  src ="img/pico.png"},

}

Config.Zones = {

  ShopCenter = {
    Pos   = {x = 6.09,   y = -708.89,  z = 44.97, number = 'center'},
  },
  Shop1 = {
    Pos   = {x = 373.875,   y = 325.896,  z = 102.566, number = 1},
  },
  Shop2 = {
    Pos = {x = 2557.458,  y = 382.282,  z = 107.622, number = 2},
  },
  Shop3 = {
    Pos = {x = -3038.939, y = 585.954,  z = 6.908, number = 3},
  },
  Shop4 = {
    Pos = {x = -1487.553, y = -379.107,  z = 39.163, number = 4},
  },
  Shop5 = {
    Pos = {x = 1392.562,  y = 3604.684,  z = 33.980, number = 5},
  },
  Shop6 = {
    Pos = {x = -2968.243, y = 390.910,   z = 14.043, number = 6},
  },
  Shop7 = {
    Pos = {x = 2678.916,  y = 3280.671, z = 54.241, number = 7},
  },
  Shop8 = {
    Pos = {x = -48.519,   y = -1757.514, z = 28.421, number = 8},
  },
  Shop9 = {
    Pos = {x = 1163.373,  y = -323.801,  z = 68.205, number = 9},
  },
  Shop10 = {
    Pos = {x = -707.501,  y = -914.260,  z = 18.215, number = 10},
  },
  Shop11 = {
    Pos = {x = -1820.523, y = 792.518,   z = 137.118, number = 11},
  },
  Shop12 = {
    Pos = {x = 1698.388,  y = 4924.404,  z = 41.063, number = 12},
  },
  Shop13 = {
    Pos = {x = 1961.464,  y = 3740.672, z = 31.343, number = 13},
  },
  Shop14 = {
    Pos = {x = 1135.808,  y = -982.281,  z = 45.415, number = 14},
  },
  Shop15 = {
    Pos = {x = 25.88,   y = -1347.1, z = 28.5, number = 15},
  },
  Shop16 = {
    Pos = {x = -1393.409, y = -606.624,  z = 29.319, number = 16},
  },
  Shop17 = {
    Pos = {x = 547.431,   y = 2671.710, z = 41.156, number = 17},
  },
  Shop18 = {
    Pos = {x = -3241.927, y = 1001.462, z = 11.830, number = 18},
  },
  Shop19 = {
    Pos = {x = 1166.024,  y = 2708.930,  z = 37.157, number = 19},
  },
  Shop20 = {
    Pos = {x = 1729.216,  y = 6414.131, z = 34.037, number = 20}
  },
  --[[Robbery1 = {
    Pos   = {x = 379.19, y = 332.08, z = 102.57, number = 101, red = true},
  },
  Robbery2 = {
    Pos   = {x = 2550.15, y = 385.37, z = 107.62, number = 102, red = true},
  },
  Robbery3 = {
    Pos   = {x = -3047.08, y = 586.37, z = 6.91, number = 103, red = true},
  },
  Robbery4 = {
    Pos   = {x = -1480.09, y = -373.35, z = 38.16, number = 104, red = true},
  },
  Robbery5 = {
    Pos   = {x = 1396.21, y = 3611.28, z = 33.98, number = 105, red = true},
  },
  Robbery6 = {
    Pos   = {x = -2959.15, y = 388.54, z = 13.04, number = 106, red = true},
  },
  Robbery7 = {
    Pos   = {x = 2673.59, y = 3286.2, z = 54.24, number = 107, red = true},
  },
  Robbery8 = {
    Pos   = {x = -43.7, y = -1750.58, z = 28.42, number = 108, red = true},
  },
  Robbery9 = {
    Pos   = {x = 1161.15, y = -315.73, z = 68.21, number = 109, red = true},
  },
  Robbery10 = {
    Pos   = {x = -708.29, y = -905.99, z = 18.22, number = 110, red = true},
  },
  Robbery11 = {
    Pos   = {x = -1827.32, y = 798.78, z = 137.16, number = 111, red = true},
  },
  Robbery12 = {
    Pos   = {x = 1705.41, y = 4920.56, z = 41.06, number = 112, red = true},
  },
  Robbery13 = {
    Pos   = { x = 1959.04, y = 3747.93, z = 31.34, number = 113, red = true},
  },
  Robbery14 = {
    Pos   = {x = 1126.83, y = -982.6, z = 44.42, number = 114, red = true},
  },
  Robbery15 = {
    Pos   = {x = 28.48, y = -1339.94, z = 28.5, number = 115, red = true},
  },
  Robbery16 = {
    Pos   = {x = -1384.41, y = -628.71, z = 29.82, number = 116, red = true},
  },
  Robbery17 = {
    Pos   = {x = 546.86, y = 2663.71, z = 41.16, number = 117, red = true},
  },
  Robbery18= {
    Pos   = {x = -3249.3, y = 1004.54, z = 11.83, number = 118, red = true},
  },
  Robbery19 = {
    Pos   = {x = 1166.89, y = 2718.14, z = 36.16, number = 119, red = true},
  },
  Robbery20= {
    Pos   = {x = 1734.88, y = 6419.83, z = 34.04, number = 120, red = true},
  },]]--
}