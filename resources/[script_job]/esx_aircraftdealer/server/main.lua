ESX = nil
local Categories, Vehicles = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'aircraft', _U('dealer_customers'), false, false)
TriggerEvent('esx_society:registerSociety', 'aircraft', _U('car_dealer'), 'society_aircraft', 'society_aircraft', 'society_aircraft', {type = 'private'})

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('esx_aircraftjob: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

MySQL.ready(function()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM avion_categories')
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM avion')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end

	-- send information after db has loaded, making sure everyone gets vehicle information
	TriggerClientEvent('esx_aircraftjob:sendCategories', -1, Categories)
	TriggerClientEvent('esx_aircraftjob:sendVehicles', -1, Vehicles)
end)

RegisterServerEvent('esx_aircraftjob:setVehicleOwned1')
AddEventHandler('esx_aircraftjob:setVehicleOwned1', function(vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_avions (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function(rowsChanged)
		xPlayer.showNotification(_U('avion_belongs', vehicleProps.plate))
	end)
end)

RegisterServerEvent('esx_aircraftjob:setVehicleOwnedPlayerId1')
AddEventHandler('esx_aircraftjob:setVehicleOwnedPlayerId1', function(playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('INSERT INTO owned_avions (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function(rowsChanged)
		xPlayer.showNotification(_U('avion_belongs', vehicleProps.plate))
	end)
end)

RegisterServerEvent('esx_aircraftjob:setVehicleOwnedSociety1')
AddEventHandler('esx_aircraftjob:setVehicleOwnedSociety1', function(society, vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_avions (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
		['@owner']   = 'society:' .. society,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
	}, function(rowsChanged) end)
end)

RegisterServerEvent('esx_aircraftjob:sellVehicle1')
AddEventHandler('esx_aircraftjob:sellVehicle1', function(vehicle)
	MySQL.Async.fetchAll('SELECT * FROM aircraft_vehicles WHERE vehicle = @vehicle LIMIT 1', {
		['@vehicle'] = vehicle
	}, function(result)
		local id = result[1].id

		MySQL.Async.execute('DELETE FROM aircraft_vehicles WHERE id = @id', {
			['@id'] = id
		})
	end)
end)

RegisterServerEvent('esx_aircraftjob:addToList1')
AddEventHandler('esx_aircraftjob:addToList1', function(target, model, plate)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)
	local dateNow = os.date('%Y-%m-%d %H:%M')

	if xPlayer.job.name == 'aircraft' then
		MySQL.Async.execute('INSERT INTO avion_sold (client, model, plate, soldby, date) VALUES (@client, @model, @plate, @soldby, @date)', {
			['@client'] = xTarget.getName(),
			['@model'] = model,
			['@plate'] = plate,
			['@soldby'] = xPlayer.getName(),
			['@date'] = dateNow
		})
	else
		print(('esx_aircraftjob: %s attempted to add a sold vehicle to list!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('esx_aircraftjob:getSoldVehicles', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM avion_sold', {}, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('esx_aircraftjob:rentVehicle1')
AddEventHandler('esx_aircraftjob:rentVehicle1', function(vehicle, plate, playerName, basePrice, rentPrice, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT * FROM aircraft_vehicles WHERE vehicle = @vehicle LIMIT 1', {
		['@vehicle'] = vehicle
	}, function(result)
		local id    = result[1].id
		local price = result[1].price
		local owner = xPlayer.identifier

		MySQL.Async.execute('DELETE FROM aircraft_vehicles WHERE id = @id', {
			['@id'] = id
		})

		MySQL.Async.execute('INSERT INTO rented_avions (vehicle, plate, player_name, base_price, rent_price, owner) VALUES (@vehicle, @plate, @player_name, @base_price, @rent_price, @owner)', {
			['@vehicle']     = vehicle,
			['@plate']       = plate,
			['@player_name'] = playerName,
			['@base_price']  = basePrice,
			['@rent_price']  = rentPrice,
			['@owner']       = owner
		})
	end)
end)

RegisterServerEvent('esx_aircraftjob:getStockItem1')
AddEventHandler('esx_aircraftjob:getStockItem1', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_aircraft', function(inventory)
		local item = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, item.label))
			else
				xPlayer.showNotification(_U('player_cannot_hold'))
			end
		else
			xPlayer.showNotification(_U('not_enough_in_society'))
		end
	end)
end)

RegisterServerEvent('esx_aircraftjob:putStockItems1')
AddEventHandler('esx_aircraftjob:putStockItems1', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_aircraft', function(inventory)
		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, item.label))
		else
			xPlayer.showNotification(_U('invalid_amount'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_aircraftjob:getCategories', function(source, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('esx_aircraftjob:getVehicles', function(source, cb)
	cb(Vehicles)
end)

ESX.RegisterServerCallback('esx_aircraftjob:buyVehicle', function(source, cb, vehicleModel)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehicleData

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	if vehicleData and xPlayer.getMoney() >= vehicleData.price then
		xPlayer.removeMoney(vehicleData.price)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_aircraftjob:buyVehicleSociety', function(source, cb, society, vehicleModel)
	local vehicleData

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function(account)
		if account.money >= vehicleData.price then
			account.removeMoney(vehicleData.price)

			MySQL.Async.execute('INSERT INTO aircraft_vehicles (vehicle, price) VALUES (@vehicle, @price)', {
				['@vehicle'] = vehicleData.model,
				['@price']   = vehicleData.price
			}, function(rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_aircraftjob:getCommercialVehicles', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM aircraft_vehicles ORDER BY vehicle ASC', {}, function(result)
		local vehicles = {}

		for i=1, #result, 1 do
			table.insert(vehicles, {
				name  = result[i].vehicle,
				price = result[i].price
			})
		end

		cb(vehicles)
	end)
end)


RegisterServerEvent('esx_aircraftjob:returnProvider1')
AddEventHandler('esx_aircraftjob:returnProvider1', function(vehicleModel)
	local _source = source

	MySQL.Async.fetchAll('SELECT * FROM aircraft_vehicles WHERE vehicle = @vehicle LIMIT 1', {
		['@vehicle'] = vehicleModel
	}, function(result)
		if result[1] then
			local id = result[1].id
			local price = ESX.Math.Round(result[1].price * 0.75)

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_aircraft', function(account)
				account.addMoney(price)
			end)

			MySQL.Async.execute('DELETE FROM aircraft_vehicles WHERE id = @id', {
				['@id'] = id
			})

			xPlayer.showNotification(_U('avion_sold_for', vehicleModel, ESX.Math.GroupDigits(price)))
		else
			print(('esx_aircraftjob: %s attempted selling an invalid vehicle!'):format(GetPlayerIdentifiers(_source)[1]))
		end
	end)
end)

ESX.RegisterServerCallback('esx_aircraftjob:getRentedVehicles', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM rented_avions ORDER BY player_name ASC', {}, function(result)
		local vehicles = {}

		for i=1, #result, 1 do
			table.insert(vehicles, {
				name = result[i].vehicle,
				plate = result[i].plate,
				playerName = result[i].player_name
			})
		end

		cb(vehicles)
	end)
end)


ESX.RegisterServerCallback('esx_aircraftjob:getStockItems1', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_aircraft', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_aircraftjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_aircraftjob:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_avions WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_aircraftjob:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_avions WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('esx_aircraftjob:setJobVehicleState')
AddEventHandler('esx_aircraftjob:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_avions SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('esx_aircraftjob: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM rented_avions', {}, function(result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			if xPlayer then -- message player if connected
				xPlayer.removeAccountMoney('bank', result[i].rent_price)
				xPlayer.showNotification(_U('paid_rental', ESX.Math.GroupDigits(result[i].rent_price)))
			else -- pay rent by updating SQL
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier', {
					['@bank'] = result[i].rent_price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_aircraft', function(account)
				account.addMoney(result[i].rent_price)
			end)
		end
	end)
end

TriggerEvent('cron:runAt', 22, 00, PayRent)
