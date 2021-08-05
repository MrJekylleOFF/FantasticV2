Config = {}


Config.WeaponsIllegalPaleto = {
    {weapon = "WEAPON_WRENCH", price = 100},
    {weapon = "WEAPON_SWITCHBLADE", price = 350},
    {weapon = "WEAPON_MOLOTOV", price = 8000},    
    {weapon = "WEAPON_BATTLEAXE", price = 200},
    {weapon = "WEAPON_REVOLVER", price = 16500},
    {weapon = "WEAPON_SAWNOFFSHOTGUN", price = 21800},
}

Config.WeaponsIllegalClub = {
    {weapon = "WEAPON_DAGGER", price = 180},
    {weapon = "WEAPON_CROWBAR", price = 100},
    {weapon = "WEAPON_HATCHET", price = 200},
    {weapon = "WEAPON_FLAREGUN", price = 3500},
    {weapon = "WEAPON_PISTOL50", price = 20000},
    {weapon = "WEAPON_MINISMG", price = 30000},
    {weapon = "WEAPON_DBSHOTGUN", price=27000},
    {weapon = "WEAPON_MUSKET", price=4000},
    {weapon = "WEAPON_MOLOTOV", price=20000},
}

Config.WeaponsIllegalDino = {
    {weapon = "WEAPON_BAT", price = 140},
    {weapon = "WEAPON_MACHETE", price = 100},
    {weapon = "WEAPON_KNUCKLE", price = 230},
    {weapon = "WEAPON_PISTOL", price = 5000},
    {weapon = "WEAPON_DOUBLEACTION", price = 18000},
    {weapon = "WEAPON_SAWNOFFSHOTGUN", price = 35000},  
    {weapon = "WEAPON_MUSKET", price = 4800},
    {weapon = "WEAPON_FLARE", price = 3600},
    {weapon = "WEAPON_ASSAULTRIFLE", price=50000},
}

Config.WeaponsIllegalPort = {
    {weapon = "WEAPON_KNIFE", price = 80},
    {weapon = "WEAPON_SWITCHBLADE", price = 380},
    {weapon = "WEAPON_HAMMER", price = 100},
    {weapon = "WEAPON_STUNGUN", price = 900},
    {weapon = "WEAPON_SNSPISTOL", price = 6000},
    {weapon = "WEAPON_VINTAGEPISTOL", price = 16000},
    {weapon = "WEAPON_MICROSMG", price = 29000},
    {weapon = "WEAPON_DBSHOTGUN", price=30000},
    {weapon = "WEAPON_FLARE", price=3600},
}

Config.ShopsIllegal = {
   
    {model= "ig_g",   x= 988.31, y= -141.36, z= 72.09, a= 57.4, shopui = "shopui_title_gr_gunmod", stocks = Config.WeaponsIllegalPaleto},
    {model= "ig_g",   x= -1522.28, y= 143.78, z= 54.65, a= 322.25, shopui = "shopui_title_gr_gunmod", stocks = Config.WeaponsIllegalClub},
    {model= "ig_g",   x= -13.83, y= 6480.76, z= 30.42, a= 227.85, shopui = "shopui_title_gr_gunmod", stocks = Config.WeaponsIllegalDino},
    {model= "ig_g",   x= 2403.61, y= 3127.78, z= 47.15, a= 237.09, shopui = "shopui_title_gr_gunmod", stocks = Config.WeaponsIllegalPort},
}