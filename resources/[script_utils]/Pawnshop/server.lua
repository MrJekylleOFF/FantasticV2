ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ItemPrices = {
    
}

local ItemBourse = {
    {item = "orange_pooch",             libelle = "Jus d'orange",                     price = 20,          difference = 5},
    {item = "stone_pooch",              libelle = "Fer",                              price = 20,          difference = 5},
    {item = "pomme_pooch",              libelle = "Jus de pomme",                     price = 20,          difference = 5},
    {item = "sable_pooch",              libelle = "Verre",                            price = 20,          difference = 5},
    {item = "bois_pooch",               libelle = "Planche de bois",                  price = 20,          difference = 5},
}

AddEventHandler('onMySQLReady', function()
	UpdateBourse()
end)

ESX.RegisterServerCallback('pawnshop:getPrices', function (source, cb)
    local TempPrices = {}
    for _,v in pairs(ItemPrices) do 
        table.insert(TempPrices, v)
    end
    local result = MySQL.Sync.fetchAll("SELECT * FROM `bourse`",{})
    for _,v in pairs(result) do 
        table.insert(TempPrices, v)
    end
    cb(TempPrices)
end)

RegisterServerEvent('pawnshop:sellItem')
AddEventHandler('pawnshop:sellItem', function(count, item, value)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local label = xPlayer.getInventoryItem(item).label
	local money = value * count
    
    xPlayer.addMoney(money)
    xPlayer.removeInventoryItem(item, count)
	TriggerClientEvent('esx:showAdvancedNotification', _source, Config.Name, "~b~Prêteur sur gage", "Tu as vendu ".. count.." " .. label.. " pour ~g~".. money.. " $", Config.ImageNotif, 1)
end)

function UpdateBourse()
    local TimeUpdate =  math.random(35, 55)-- En minutes
    local oldPrice = {}
   
    for _,v in pairs(ItemBourse) do 
        MySQL.Async.fetchAll("SELECT price FROM bourse WHERE item=@item",
            {['@item'] = v.item},
        function(result)
            if result[1] ~= nil then
                table.insert(oldPrice, {item = v.item, price = result[1].price})
            end
        end)
    end
    SetTimeout(1000, function()
        MySQL.Async.execute('TRUNCATE `bourse`')
        SetTimeout(200, function()
            for k,v in pairs(ItemBourse) do
                local diff = math.random(0-v.difference, v.difference)
                MySQL.Async.execute(
                'INSERT INTO bourse (item, libelle, price, difference) VALUES (@item, @libelle, @price, @difference)',
                    {
                    ['@item'] = v.item,
                    ['@libelle'] = v.libelle,
                    ['@price']  = v.price + diff,
                    ['@difference']  = (v.price + diff) - getItemOldPrice(oldPrice, v.item)
                    }
                )
            end
        end)
    end)
	
    SetTimeout(TimeUpdate * 60 * 1000, UpdateBourse)
end

function getItemOldPrice(oldPrice, item)
	for _,v in pairs(oldPrice) do
		if v.item == item then
			return v.price
		end
    end
    return 0
end
