ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--Recupere les véhicules
ESX.RegisterServerCallback('garage:getVehicles', function(source, cb)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}
	local dataFound = false

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier ",{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, state = v.state, volee = v.volee, garage = v.garage_id, name = v.name, health = v.health, garageperso = v.garageperso})
		end
		dataFound = true
	end)
	while not dataFound do Wait(0) end
	dataFound = false
	MySQL.Async.fetchAll("SELECT * FROM stolen_vehicles WHERE owner = @identifier ",{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, state = v.state, volee = v.volee, garage = v.garage_id, name = v.name, health = v.health})
		end
		dataFound = true
	end)
	while not dataFound do Wait(0) end
	cb(vehicules)
end)
-- Fin --Recupere les véhicules$

--Recupere les véhicules
ESX.RegisterServerCallback('garage:getVehiclesMecano', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("select * from owned_vehicles inner join characters on owned_vehicles.owner = characters.identifier where volee=true",{}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, state = v.state, volee = v.volee, firstname = v.firstname, lastname = v.lastname})
		end
		cb(vehicules)
	end)
end)
-- Fin --Recupere les véhicules

--Stock les véhicules
ESX.RegisterServerCallback('garage:stockv',function(source,cb, vehicleProps)
	local isFound = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate

	
	for _,v in pairs(vehicules) do
		if(plate == v.plate)then
			local idveh = v.id
			local vehprop = json.encode(vehicleProps)
			MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle =@vehprop WHERE plate=@plate",{['@vehprop'] = vehprop, ['@plate'] = plate})
			isFound = true
			break
		end		
	end
	cb(isFound)
end)
--Fin stock les vehicules

ESX.RegisterServerCallback('garage:stockvmecano',function(source,cb, vehicleProps)
	local plate = vehicleProps.plate
	
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles",{}, function(result) 
		-- for k,v in pairs(result) do
		local isFound = false
		for i=1, #result,1 do
			local vehicle = json.decode(result[i].vehicle)

			local vehicleplate = vehicle.plate
			if (plate == vehicleplate) then
				local vehprop = json.encode(vehicleProps)
				
				MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle =@vehprop WHERE id=@id",{['@vehprop'] = vehprop, ['@id'] = result[i].id})
				isFound = true
				break
			end
		end
		cb(isFound)
	end)
end)

RegisterServerEvent('garage:stockStolenVeh')
AddEventHandler('garage:stockStolenVeh', function (vehicleProps, garage_id, health)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT IGNORE INTO stolen_vehicles (owner, plate, vehicle, garage_id, health) VALUES (@owner, @plate, @vehicle, @garage_id, @health)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@garage_id'] = garage_id,
		['@health'] = health,
	}, function (rowsChanged)
		TriggerClientEvent('esx:showAdvancedNotification', _source, "Garage","", "Le véhicule a bien été rangé", "CHAR_CARSITE", 1)
	end)
end)

--Change le state du véhicule
RegisterServerEvent('garage:modifystate')
AddEventHandler('garage:modifystate', function(vehicleProps, state, garage_id, health, time)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate
	local state = state
	local health = health

	if time == nil then
		time = 0
	end
	if not state then
		MySQL.Async.execute('DELETE FROM stolen_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		})
	end
	
	SetTimeout(time * 1000, function()
	  for _,v in pairs(vehicules) do
		if(plate == v.plate)then
			local idveh = v.id
			MySQL.Async.execute('DELETE FROM stolen_vehicles WHERE plate = @plate', {
				['@plate'] = plate
			})
			MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state , garage_id =@id , health =@health WHERE plate=@plate",{['@state'] = state ,['@id'] = garage_id, ['@health'] = health, ['@plate'] = plate})
			if time > 10 then 
				TriggerClientEvent('esx:showAdvancedNotification', _source, "Garage","", "Votre véhicule immatriculé ~b~"..plate.."~s~ a été retrouvé", "CHAR_CARSITE", 1)
			end
			break
		end		
	  end
	end)
	
end)	
--Fin change le state du véhicule

RegisterServerEvent('garage:rename')
AddEventHandler('garage:rename', function(plate, name)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())

	  for _,v in pairs(vehicules) do
		if(plate == v.plate)then
			local idveh = v.id
			MySQL.Sync.execute("UPDATE owned_vehicles SET name =@name  WHERE plate=@plate",{['@name'] = name , ['@plate'] = plate}) 
				--TriggerClientEvent('esx:showNotification', _source, "Votre véhicule imatriculé ~b~"..plate.."~s~ a été retrouvé")
			break
		end		
	  end
	
	
end)







--Fonction qui récupere les plates

-- Fin Fonction qui récupere les plates

ESX.RegisterServerCallback('garage:getOutVehicles',function(source, cb)	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier AND state=false or garageperso=true",{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
		for _,v in pairs(data) do
			local garageperso = v.garageperso

			if garageperso ~= true then 
				local vehicle = json.decode(v.vehicle)
				table.insert(vehicules, {vehicle =vehicle, volee = v.volee})
			end
		end
		cb(vehicules)
	end)
end)

--Foonction qui check l'argent
ESX.RegisterServerCallback('garage:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)
--Fin Foonction qui check l'argent

--fonction qui retire argent
RegisterServerEvent('garage:pay')
AddEventHandler('garage:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price)

	--TriggerClientEvent('esx:showNotification', source, 'Vous avez payé ~g~' .. Config.Price.." $")
	TriggerClientEvent('esx:showAdvancedNotification', source, "Garage","", "Vous avez payé ~g~" .. Config.Price.." $", "CHAR_CARSITE", 1)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		account.addMoney(Config.Price)
	end)
end)

RegisterServerEvent('garage:payhealth')
AddEventHandler('garage:payhealth', function(price)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(price)

	--TriggerClientEvent('esx:showNotification', source, 'Vous avez payé ~g~' .. price.." $")
	TriggerClientEvent('esx:showAdvancedNotification', source, "Garage","", "Vous avez payé ~g~" .. price.." $", "CHAR_CARSITE", 1)
end)
--Fin fonction qui retire argent


--Recupere les vehicules
function getPlayerVehicles(identifier)
	
	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = vehicle.plate})
	end
	return vehicles
end
--Fin Recupere les vehicules

--Debug
RegisterServerEvent('garage:debug')
AddEventHandler('garage:debug', function(var)
	--print(to_string(var))
end)

function table_print (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs (tt) do
      table.insert(sb, string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        table.insert(sb, "{\n");
        table.insert(sb, table_print (value, indent + 2, done))
        table.insert(sb, string.rep (" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
            "%s = \"%s\"\n", tostring (key), tostring(value)))
       end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

function to_string( tbl )
    if  "nil"       == type( tbl ) then
        return tostring(nil)
    elseif  "table" == type( tbl ) then
        return table_print(tbl)
    elseif  "string" == type( tbl ) then
        return tbl
    else
        return tostring(tbl)
    end
end
--Fin Debug


-- Fonction qui change les etats sorti en rentré lors d'un restart
AddEventHandler('onMySQLReady', function()

	MySQL.Sync.execute("UPDATE owned_vehicles SET state=true WHERE state=false", {})

end)


RegisterCommand("orionpv",function(source, args)
	TriggerClientEvent('garage:PV', source)
end, false)
-- Fin Fonction qui change les etats sorti en rentré lors d'un restart


function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end