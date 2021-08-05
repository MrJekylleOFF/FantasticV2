Config              = {}
Config.ShowBlips   = false  --markers visible on the map? (false to hide the markers on the map)



Config.Zones = {
    Oranges = {
        Name =          "Oranges",
        sellName =      "Jus d'oranges",
        ItemsName =     {"orange", "orange_pooch"},
        SellPrice =     20,
        Recolte =       {pos = {x = 347.76, y = 6518.09, z = 27.30}, marker = {size = 5.0, r = 255, g = 56, b = 14}, blip = {name = "Orange: Récolte", sprite = 478, color = 5}},
        Traitement =    {pos = {x = 1721.27, y = 4711.93, z = 41.10}, marker = {size = 3.5, r = 255, g = 0, b = 0}, blip = {name = "Orange: Traitement", sprite = 467, color = 5}},
        --Vente =         {pos = {x = -1710.36, y = -2963.36, z = 12.94}, marker = {size = 2.5, r = 150, g = 150, b = 0}},
    },
   Pierres = {
        Name =          "Pierres",
        sellName =      "Fer",
        ItemsName =     {"stone", "stone_pooch"},
        SellPrice =     20,
        Recolte =       {pos = {x = 2590.56,  y = 2819.00, z = 32.0},  marker = {size = 6.5, r = 0, g = 0, b = 250}, blip = {name = "Mineur: Récolte", sprite = 653, color = 55}},
        Traitement =    {pos = {x = 1108.945,  y = -2007.37, z = 29.50},  marker = {size = 2.5, r = 250, g = 150, b = 255}, blip = {name = "Mineur Traitement", sprite = 652, color = 55}},
        --Vente =         {pos = {x = 290.94,   y =  2863.57, z = 42.64},  marker = {size = 2.5, r = 70, g = 135, b = 20}},
    },
    Pommes = {
        Name =          "Pommes",
        sellName =      "pomme_pooch",
        ItemsName =     {"pomme", "pomme_pooch"},
        SellPrice =     20,
        Recolte =       {pos = {x = 2360.646, y = 5001.76, z = 42.40},  marker = {size = 4.5, r = 84, g = 199, b = 50}, blip = {name = "Pomme: Récolte", sprite = 478, color = 24}},
        Traitement =    {pos = {x = 1551.98, y = 2190.94, z = 77.84},  marker = {size = 2.5, r = 25, g = 150, b = 255}, blip = {name = "Pomme: traitement", sprite = 467, color = 24}},
        --Vente =         {pos = {x = 290.94,   y =  2863.57, z = 42.64},  marker = {size = 2.5, r = 70, g = 135, b = 20}},
    },
    Sables = {
        Name =          "Sables",
        sellName =      "sable_pooch",
        ItemsName =     {"sable", "sable_pooch"},
        SellPrice =     20,
        Recolte =       {pos = {x = 826.902, y = 6624.369, z = 0.5},  marker = {size = 10.0, r = 4, g = 19, b = 200}, blip = {name = "Maçon: Recolte", sprite = 478, color = 46}},
        Traitement =    {pos = {x = 1088.62, y = -2000.72, z = 29.500},  marker = {size = 3.5, r = 255, g = 0, b = 25}, blip = {name = "Maçon: Traitement", sprite = 467, color = 46}},
        --Vente =         {pos = {x = 290.94,   y =  2863.57, z = 42.64},  marker = {size = 2.5, r = 70, g = 135, b = 20}},
    },
    Bois = {
        Name =          "Bois",
        sellName =      "bois_pooch",
        ItemsName =     {"bois", "bois_pooch"},
        SellPrice =     20,
        Recolte =       {pos = {x = 190.37, y = 4415.80, z = 72.90},  marker = {size = 12.5, r = 80, g = 0, b = 0}, blip = {name = "Bucherons: Récolte", sprite = 478, color = 21}},
        Traitement =    {pos = {x = -508.53, y = 5269.99, z = 79.00},  marker = {size = 4.5, r = 25, g = 0, b = 255}, blip = {name = "Bucherons Traitement", sprite = 467, color = 21}},
        --Vente =         {pos = {x = 290.94,   y =  2863.57, z = 42.64},  marker = {size = 2.5, r = 70, g = 135, b = 20}},
    },
  --[[  Fuels = {
        Name =          "Pétrole",
        sellName =      "petrol_raffin",
        ItemsName =     {"fuel", "petrol_raffin"},
        SellPrice =     20,
        Recolte =       {pos = {x = 648.418, y = 3018.52, z = 42.00},  marker = {size = 8.5, r = 84, g = 199, b = 50}, blip = {name = "Rafineur Récolte", sprite = 478, color = 17}},
        Traitement =    {pos = {x = 2745.01, y = 1487.22, z = 28.99},  marker = {size = 2.3, r = 25, g = 150, b = 255}, blip = {name = "Rafineur Traitement", sprite = 467, color = 17}},
        --Vente =         {pos = {x = 290.94,   y =  2863.57, z = 42.64},  marker = {size = 2.5, r = 70, g = 135, b = 20}},
    }--]]
}
