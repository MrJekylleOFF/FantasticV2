ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Config = {}
Config.Shops = {
    {model= "s_m_y_ammucity_01",    x= 1082.45, y= -787.42, z= 57.35, a= 194.01, 	 shopui = "shopui_title_arenawar"},
    {model= "s_m_y_ammucity_01",    x= -1250.8, y= -271.84, z= 37.99, a= 30.03, 	 shopui = "shopui_title_arenawar"},
    {model= "s_m_y_ammucity_01",    x= 1538.97, y= 6321.92, z= 24.07, a= 4.24,   shopui = "shopui_title_arenawar"},
	{model= "s_m_y_ammucity_01",    x= 730.2, y= 2532.08, z= 72.23, a= 278.58,   shopui = "shopui_title_arenawar"},

}

Config.Items = {
	{label = "Truelle", 									objet = "truelle", 					price = 18, 	sale = false},
	{label = "Plastique",									objet = "plastique",				price = 1,		sale = false},
	{label = "Graine de weed", 								objet = "graine", 					price = 10, 	sale = false},
	{label = "Ephedrine", 									objet = "ephedrine", 				price = 15, 	sale = false},
	{label = "Gilet pare-balle",           			        objet = "bulletproof2",             price = 100,    sale = false},
	{label = "Perceuse",									objet = "weld", 					price = 200,	sale = false},
	{label = "Sac sur la tête",								objet = "headbag",					price = 20,		sale = false},
	{label = "Pelle", 										objet = "pelle", 					price = 18, 	sale = false},
	{label = "Poignée", 									objet = "grip",						price = 600,	sale = false},
	{label = "Silencieux",									objet = "silent", 					price = 1500,   sale = false},
	{label = "Lunette", 									objet = "scope",					price = 2500,   sale = false},
	{label = "Lampe torche",								objet = "flashlight",				price = 200,    sale = false},
	{label = "Camouflage arme",								objet = "yusuf",					price = 2000,   sale = false},
	{label = "Chargeur grande capacité", 					objet = "magazine", 				price = 2000,	sale = false},
	{label = "Boite de chargeur type .45ACP (SMG)", 		objet = "box_.45ACP", 				price = 400,	sale = false},
	{label = "Boite de chargeur type 357 Magnum (CAL.50)",  objet = "box_357Magnum", 			price = 300,	sale = false},
	{label = "Boite de chargeur type 7.62mm (FUSIL)", 		objet = "box_7.62mm", 				price = 600,	sale = false},
	{label = "Boite de chargeur type 12mm (POMPE)", 		objet = "box_12mm", 				price = 500,	sale = false},
}


local data = {}

data.pos = {
	Config.Shops[math.random(1, 2)],
	Config.Shops[math.random(3, 4)]
}

print(json.encode(data.pos))
data.items = {}
for k,v in pairs(Config.Items) do
	if math.random(1,100) > 50 then
		local price = math.ceil(v.price + (v.price*(math.random(-50, 50)/1000)))
		table.insert(data.items, {label = v.label, objet = v.objet, price = price, sale = v.sale} )
	end
end

ESX.RegisterServerCallback('blackmarket:GetData', function(source, cb)
	cb(data) 
end)

RegisterNetEvent('blackmarket:buytruc')
AddEventHandler('blackmarket:buytruc', function(obj, prix, argSale)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local label = xPlayer.getInventoryItem(obj).label

	if argSale then
		if xPlayer.getAccount('black_money').money >= prix and xPlayer.canCarryItem(obj, 1) then
			xPlayer.removeAccountMoney('black_money', prix)
			xPlayer.addInventoryItem(obj, 1)
			TriggerClientEvent('esx:showAdvancedNotification', _source, "Marché noir", "", "Tu as acheté 1 " ..label.." pour "..prix.."$" , "CHAR_LESTER", 9)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _source, "Marché noir", "", "Tu n'as pas assez d'argent ou pas assez de place" , "CHAR_LESTER", 1)
		end
	else
		if xPlayer.getMoney() >= prix and xPlayer.canCarryItem(obj, 1) then
			xPlayer.removeMoney(prix)
			xPlayer.addInventoryItem(obj, 1)
			TriggerClientEvent('esx:showAdvancedNotification', _source, "Marché noir", "", "Tu as acheté 1 " ..label.." pour "..prix.."$" , "CHAR_LESTER", 9)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _source, "Marché noir", "", "Tu n'as pas assez d'argent ou pas assez de place" , "CHAR_LESTER", 1)
		end
	end
end)