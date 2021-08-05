ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('graine', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local truelle  = xPlayer.getInventoryItem('truelle').count

  if truelle <= 0 then
    TriggerClientEvent('esx:showNotification', source,'~r~Vous devez avoir une ~b~truelle~s~ !')
  else
    xPlayer.removeInventoryItem('graine', 1)
    TriggerClientEvent('eden_drugs:plantation', source)
    print("Graine Plante par: " ..xPlayer.name)
    TriggerClientEvent('esx:showNotification', source,'~g~Plantation~s~ en ~b~cours~s~.')
  end
end)

ESX.RegisterUsableItem('truelle', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerClientEvent('eden_drugs:usetruelle', source)
end)

ESX.RegisterUsableItem('pelle', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerClientEvent('eden_drugs:usepelle', source)
  TriggerClientEvent('esx:showNotification', source,'~r~Destruction~s~ de plant en ~b~cours~s~.')
end)

RegisterServerEvent('eden_drugs:appelPolice')
AddEventHandler('eden_drugs:appelPolice', function(gx, gy, gz)	
	--print("esx_recell : appelPolice")
	TriggerClientEvent('eden_drugs:policeNotif', -1, gx, gy, gz)
	
end)

RegisterServerEvent('eden_drugs:deleteweed')
AddEventHandler('eden_drugs:deleteweed', function(x)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerClientEvent('eden_drugs:deleteweed', -1, x)

  MySQL.Async.execute(
    'DELETE FROM position_drugs WHERE x = @x',
    {
    ['@x'] = x
    },
    function()
    end
  )
end)

RegisterServerEvent('eden_drugs:createweed')
AddEventHandler('eden_drugs:createweed', function(x, y, z,id)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  MySQL.Async.execute(
    'INSERT INTO position_drugs (identifier, name, x, y, z) VALUES (@identifier, @name, @x, @y, @z)',
    {

    ['@identifier'] = xPlayer.identifier,
    ['@name'] = 'Weed',
    ['@x']  = x,
    ['@y']  = y,
    ['@z']  = z
    },

    function(result)
    end
  )
end)

ESX.RegisterServerCallback('eden_drugs:checkplan', function(source, cb)

  --print("Eden_weed : checkplan")
  MySQL.Async.fetchAll(
    'SELECT * FROM position_drugs',
    {},
    function(result)
      local data = {}
      for i=1, #result, 1 do
        table.insert(data, {
          identifier = result[i].identifier,
          name       = result[i].name,
          x          = result[i].x,
          y          = result[i].y,
          z          = result[i].z,
          percent    = result[i].percent
          })
      end
      cb(data)
    end
  )
end)

ESX.RegisterServerCallback('eden_drugs:countCops', function(source, cb)
    local xPlayer        = ESX.GetPlayerFromId(source)
	local xPlayers 		 = ESX.GetPlayers()

	
    local CopsConnected = 0
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected + 1
        end
    end
		
	if CopsConnected >= 1 then	
        cb(true)
        
    else
        cb(false)
	end
	
end)

RegisterServerEvent('eden_drugs:sellweed')
AddEventHandler('eden_drugs:sellweed', function()
    local xPlayer        = ESX.GetPlayerFromId(source)
    local WeedPlayer        = xPlayer.getInventoryItem('weed').count
    local nbWeed = math.random(4,12)
    
    if WeedPlayer >= nbWeed then
		xPlayer.removeInventoryItem('weed', nbWeed)
		xPlayer.addAccountMoney('black_money', nbWeed * math.random(8,10))
        TriggerClientEvent('esx:showNotification', source, "Je vais te prendre "..nbWeed.." ~g~weed")
    else
        TriggerClientEvent('esx:showNotification', source, "T'as rien a vendre")
    end
end)

RegisterServerEvent('eden_drugs:giveweed')
AddEventHandler('eden_drugs:giveweed', function(x)
	local _source		= source
  local xPlayer  		= ESX.GetPlayerFromId(source)
  local random        = math.random(5,10)
  local randomweed    = math.random(0,100)
  local randomgraine  = math.random(1,3)

  if xPlayer.canCarryItem('weed', random) then
  xPlayer.addInventoryItem('weed', random)
  

  if randomweed <= 20 and xPlayer.canCarryItem('graine', randomgraine) then
    xPlayer.addInventoryItem('graine', randomgraine)
  end

  TriggerClientEvent('eden_drugs:deleteweed', _source, x)
  TriggerClientEvent('esx_status:add', source, 'stress', 5000)

  MySQL.Async.execute(
    'DELETE FROM position_drugs WHERE x = @x',
    {
    ['@x'] = x
    },
    function()
    end
  )
else
  TriggerClientEvent('esx:showNotification', source,'~r~Vous n\'avez pas assez de place dans votre inventaire')
end
end)

RegisterServerEvent('eden_drugs:buyseed')
AddEventHandler('eden_drugs:buyseed', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.removeMoney(Config.PriceSeed)
  xPlayer.addInventoryItem('graine', 1)
end)

RegisterServerEvent('eden_drugs:buytruelle')
AddEventHandler('eden_drugs:buytruelle', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.removeMoney(Config.PriceTruele)
  xPlayer.addInventoryItem('truele', 1)
end)


function UpdatePourcent()
	local TimeUpdate =  21 -- En minutes
	--print("Eden_weed : updatePourcent")
	MySQL.Async.execute(
		'UPDATE position_drugs SET percent = percent + 7',
	 	{
	 	}
	)
    SetTimeout(TimeUpdate * 60 * 1000, UpdatePourcent)
end

MySQL.ready(function ()
  print('good')
    UpdatePourcent()
end)
