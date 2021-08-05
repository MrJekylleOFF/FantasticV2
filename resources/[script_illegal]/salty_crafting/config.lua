Config = {}

Config.Recipes = {
	["coke_pooch"] = { 
		{item = "feuillecoca", quantity = 8 }, 
		{item = "essence", quantity = 3 },
		{item = "patecoca", quantity = 5 },
		{item = "plastique", quantity = 1 },
	},

	["meth_pooch"] = { 
		{item = "ephedrine", quantity = 15 }, 
		{item = "meth", quantity = 4 },
		{item = "plastique", quantity = 1 },
	},
	

	["weed_pooch"] = { 
		{item = "weed", quantity = 10 },
		{item = "plastique", quantity = 1 },
	},

}

Config.Shop = {
	useShop = true,
	shopCoordinates = { x= 13.87, y= -2694.77, z= 5.01 }, -- fait
	shopName = "Crafting Station",
	--shopBlipID = 446,
	zoneSize = { x = 1.5, y = 1.5, z = 1.5 },
	zoneColor = { r = 0, g = 0, b = 0, a = 0 }
}
-- Enable crafting menu through a keyboard shortcut
--Config.Keyboard = {
--	useKeyboard = false,
--	keyCode = 303
--}
