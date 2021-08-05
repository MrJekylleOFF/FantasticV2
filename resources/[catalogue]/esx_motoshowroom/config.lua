Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 0, g = 0, b = 255 }
--language currently available EN and SV
Config.Locale                     = 'fr'
--this is how much the price shows from the purchase price
-- exapmle the cardealer boughts it for 2000 if 2 then it says 4000
Config.Price = 1.30-- this is times how much it should show

Config.Zones = {

  ShopInside = {
    Pos     = { x = 962.75, z = -39.65, y = -3025.13},
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 60.16,
    Type    = -1,
  },

  Katalog = {
    Pos     = { x = 968.59, y = -2999.57, z = -39.65 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 335.54,
    Type    = 29,
  },

}