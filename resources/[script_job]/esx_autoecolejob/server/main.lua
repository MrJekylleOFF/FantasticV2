ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'autoecole', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'autoecole', 'Client Auto Ecole', true, true)
TriggerEvent('esx_society:registerSociety', 'autoecole', 'Auto Ecole', 'society_autoecole', 'society_autoecole', 'society_autoecole', {type = 'private'})

RegisterServerEvent('esx_autoecolejob:autoecole')
AddEventHandler('esx_autoecolejob:autoecole', function(result)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local mess     = result
	-- print(mess)
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_breakingnews:autoecole', xPlayers[i],mess)
	end
end)

RegisterServerEvent('esx_autoecolejob:addLicense')
AddEventHandler('esx_autoecolejob:addLicense', function(target, type)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	TriggerEvent('esx_license:addLicense', targetXPlayer.source, type, function()
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez donner un permis de conduire')
		TriggerClientEvent('esx:showNotification', targetXPlayer.source, 'Vous avez reçu un permis de conduire')
		TriggerEvent('esx_license:getLicenses', targetXPlayer.source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', targetXPlayer.source, licenses)
		end)
	end)
end)


RegisterServerEvent('esx_autoecolejob:getStockItem')
AddEventHandler('esx_autoecolejob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_autoecole', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_autoecolejob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_autoecole', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_autoecolejob:putStockItems')
AddEventHandler('esx_autoecolejob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_autoecole', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_autoecolejob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})
end)