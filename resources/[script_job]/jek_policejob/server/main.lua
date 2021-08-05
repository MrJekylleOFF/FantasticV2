ESX = nil

local CachedPedState = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterServerEvent('jek_policejob:buyproof')
AddEventHandler('jek_policejob:buyproof', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

		local itemQtty = xPlayer.getInventoryItem('bulletproof').count
		if itemQtty >= 1 then
		  TriggerClientEvent('esx:showNotification', _source, '~r~Vous avez déja un gilet pare-balle sur vous')
		else
			if xPlayer.canCarryItem('bulletproof', 1) then
				xPlayer.addInventoryItem('bulletproof', 1)
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous avez récuperez un gilet pare-balle')
			else
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez pas assez de place sur vous')
			end

		end 
end)

RegisterServerEvent('jek_policejob:buybra')
AddEventHandler('jek_policejob:buybra', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

		local itemQtty = xPlayer.getInventoryItem('braceletgps').count
		if itemQtty >= 1 then
		  TriggerClientEvent('esx:showNotification', _source, '~r~Vous avez déja un bracelet électronique')
		else
			if xPlayer.canCarryItem('braceletgps', 1) then
				xPlayer.addInventoryItem('braceletgps', 1)
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous avez récuperez un bracelet électronique')
			else
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez pas assez de place sur vous')
			end

		end 
end)

RegisterServerEvent('jek_policejob:buyitem')
AddEventHandler('jek_policejob:buyitem', function(item)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

			if xPlayer.canCarryItem(item, 1) then
				xPlayer.addInventoryItem(item, 1)
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous avez récuperez un accessoires')
			else
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez pas assez de place sur vous')
			end

	
end)


RegisterServerEvent('jek_policejob:rendproof')
AddEventHandler('jek_policejob:rendproof', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

		local itemQtty = xPlayer.getInventoryItem('bulletproof').count
		if itemQtty < 1 then
		  TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas de gilet par-balle sur vous')
		else
			xPlayer.removeInventoryItem('bulletproof', itemQtty)
			TriggerClientEvent('esx:showNotification', _source, 'Vous avez déposez vos gilet pare-balle')
		end 
end)

RegisterServerEvent('jek_policejob:rendbra')
AddEventHandler('jek_policejob:rendbra', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

		local itemQtty = xPlayer.getInventoryItem('braceletgps').count
		if itemQtty < 1 then
		  TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas de bracelet électronique')
		else
			xPlayer.removeInventoryItem('braceletgps', itemQtty)
			TriggerClientEvent('esx:showNotification', _source, 'Vous avez déposez un bracelet électronique')
		end 
end)

RegisterServerEvent('jek_policejob:giveWeapon')
AddEventHandler('jek_policejob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weapon, ammo)
end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('jek_policejob:loadLicenses', source, licenses)
	end)
end)

function LoadLicenses (source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('jek_policejob:loadLicenses', source, licenses)
	end)
end

RegisterServerEvent('renfortg')
AddEventHandler('renfortg', function(coords, raison)
	local _source = source
	local _raison = raison
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('renfortg:setBlip', xPlayers[i], coords, _raison)
		end
	end
end)

RegisterServerEvent('jek_policejob:ServerLoadLicenses')
AddEventHandler('jek_policejob:ServerLoadLicenses', function()
	local _source = source
	LoadLicenses(_source)
end)

RegisterNetEvent('jek_policejob:addLicense')
AddEventHandler('jek_policejob:addLicense', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('jek_policejob:loadLicenses', _source, licenses)
		end)
	end)
end)



RegisterServerEvent('jek_policejob:confiscatePlayerItem')
AddEventHandler('jek_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'police' then
		print(('jek_policejob: %s attempted to confiscate!'):format(xPlayer.identifier))
		return
	end 

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if not sourceXPlayer.canCarryItem(itemName, amount) then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

RegisterServerEvent('jek_policejob:requestarrest')
AddEventHandler('jek_policejob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('jek_policejob:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('jek_policejob:doarrested', _source)
end)

RegisterServerEvent('jek_policejob:requestrelease')
AddEventHandler('jek_policejob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('jek_policejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('jek_policejob:douncuffing', _source)
end)

RegisterServerEvent('jek_policejob:requestarrest')
AddEventHandler('jek_policejob:requestarrest', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

		TriggerClientEvent('jek_policejob:handcuff1', target)
end)

RegisterServerEvent('jek_policejob:drag')
AddEventHandler('jek_policejob:drag', function(target)
		TriggerClientEvent('jek_policejob:drag', target, source)
end)

RegisterServerEvent('jek_policejob:putInVehicle')
AddEventHandler('jek_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('jek_policejob:putInVehicle', target)
	else
		print(('jek_policejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('jek_policejob:OutVehicle')
AddEventHandler('jek_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('jek_policejob:OutVehicle', target)
	else
		print(('jek_policejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('jek_policejob:bracelet', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem('braceletgps').count

	if quantity > 0 then
		cb(true)
	else
		cb(false)
	end
end)


ESX.RegisterServerCallback('jek_policejob:bracelet2', function(source, cb, targetid)
	local Target = ESX.GetPlayerFromId(targetid)
	local quantity = Target.getInventoryItem('braceletgps').count

	if quantity > 0 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('jek_policejob:PlBracelet')
AddEventHandler('jek_policejob:PlBracelet', function(targetid, playerheading, playerCoords,  playerlocation)
	TriggerClientEvent('jek_policejob:Bracelet', targetid, playerheading, playerCoords,  playerlocation, "give")
	TriggerClientEvent('jek_policejob:PlBracelet2', source)
end)

RegisterServerEvent('jek_policejob:PlBracelet2')
AddEventHandler('jek_policejob:PlBracelet2', function(targetid, playerheading, playerCoords,  playerlocation)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('jek_policejob:Bracelet', targetid, playerheading, playerCoords,  playerlocation, "remove")
	TriggerClientEvent('jek_policejob:PlBracelet2', source)
end)

RegisterServerEvent('jek_policejob:GiveBracelet')
AddEventHandler('jek_policejob:GiveBracelet', function(targetid)
	local Target = ESX.GetPlayerFromId(source)
	print(targetid)
	Target.addInventoryItem('braceletgps', 1)
end)

RegisterServerEvent('jek_policejob:RemoveBracelet')
AddEventHandler('jek_policejob:RemoveBracelet', function(targetid)
	local Target = ESX.GetPlayerFromId(source)
	Target.removeInventoryItem('braceletgps', 1)
end)


RegisterServerEvent('jek_policejob:getStockItem')
AddEventHandler('jek_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if not xPlayer.canCarryItem(itemName, count) then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('jek_policejob:putStockItems')
AddEventHandler('jek_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

ESX.RegisterServerCallback('jek_policejob:getOtherPlayerData', function(source, cb, target)
		local xPlayer = ESX.GetPlayerFromId(target)
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
end)

ESX.RegisterServerCallback('jek_policejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('jek_policejob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('jek_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('jek_policejob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)

	end)

end)

ESX.RegisterServerCallback('jek_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('jek_policejob:removeArmoryWeapon', function(source, cb, weaponName, WeaponLabel)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')
		local weaponLabel = ESX.GetWeaponLabel(weaponName)

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		notifMsg    = "[Armes Coffres] | " ..xPlayer.name.. " ["..xPlayer.identifier.. "] à pris un(e) "..weaponLabel.." dans le stock. (__**" .. GetCurrentResourceName() .. "**__)"
		TriggerEvent('DiscordBot:ToDiscord', 'coffrearmes', 'AntiCheat', notifMsg, 'https://scotchandiron.org/gameassets/anticheat-icon.png', true)

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('jek_policejob:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)

ESX.RegisterServerCallback('jek_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('jek_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

--[[AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
			Citizen.Wait(5000)
			TriggerClientEvent('jek_policejob:updateBlip', -1)
		end
	end	
end)--]]

--[[RegisterServerEvent('jek_policejob:spawned')
AddEventHandler('jek_policejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('jek_policejob:updateBlip', -1)
	end
end)--]]

--[[RegisterServerEvent('jek_policejob:forceBlip')
AddEventHandler('jek_policejob:forceBlip', function()
	TriggerClientEvent('jek_policejob:updateBlip', -1)
end)--]]

--[[AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('jek_policejob:updateBlip', -1)
	end
end)--]]

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterServerEvent('jek_policejob:message')
AddEventHandler('jek_policejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

ESX.RegisterServerCallback("qalle_policearmory:pedExists", function(source, cb)
    if CachedPedState then
        cb(true)
    else
        CachedPedState = true

        cb(false)
    end
end)