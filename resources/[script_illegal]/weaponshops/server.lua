ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('weaponshops:buytruc')
AddEventHandler('weaponshops:buytruc', function(obj, prix)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local label = xPlayer.getInventoryItem(obj).label

    if xPlayer.getMoney() >= prix then
		xPlayer.removeMoney(prix)
        xPlayer.addInventoryItem(obj, 1)
        TriggerClientEvent('esx:showAdvancedNotification', _source, "Ammu-nation", "", "Tu as acheté 1 " ..label.." pour "..prix.."$" , "CHAR_AMMUNATION", 1)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, "Ammu-nation", "", "Tu n'as pas assez d'argent" , "CHAR_AMMUNATION", 1)
    end
end)

ESX.RegisterServerCallback('weaponshops:buyWeapon', function(source, cb, weaponName, price, legal)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if price == 0 then
		print(('esx_weaponshop: %s attempted to buy a unknown weapon!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('esx:showAdvancedNotification', _source, "Ammu-nation", "", "Tu as déjà cette arme" , "CHAR_AMMUNATION", 1)
		cb(false)
	else

			if xPlayer.getMoney() >= price then
				xPlayer.removeMoney(price)
				xPlayer.addWeapon(weaponName, 40)

				cb(true)
			else
				TriggerClientEvent('esx:showAdvancedNotification', _source, "Ammu-nation", "", "Tu n'as pas assez d'argent" , "CHAR_AMMUNATION", 1)
				cb(false)
			end
	end
end)

