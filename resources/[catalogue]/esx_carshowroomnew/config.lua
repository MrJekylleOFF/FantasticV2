Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 200, g = 25, b = 255 }
--language currently available EN and SV
Config.Locale                     = 'fr'
--this is how much the price shows from the purchase price
-- exapmle the cardealer boughts it for 2000 if 2 then it says 4000
Config.Price = 1.300 -- this is times how much it should show

Config.Zones = {

  ShopInside = {
    Pos     = { x = -14.48, y = -1095.51, z = 26.68},
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 164.04,
    Type    = -1,
  },

  Katalog = {
    Pos     = { x = -50.22, y = -1089.5, z = 25.42 },
    Size    = { x = 1.5, y = 1.5, z = 0.1 },
    Heading = 121.281,
    Type    = 1,
  },


}