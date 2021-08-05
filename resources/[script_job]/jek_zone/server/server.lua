ESX = nil
local ply = {} 
local TransformZone = {}
local TransformZone2 = {}
local Achat = {}



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- steam:11000011825bfb3
TriggerEvent('esx_phone:registerNumber', 'agriculteur', 'Agriculteur', true, true)

RegisterServerEvent('mrw_agriculture:buygraine')
AddEventHandler('mrw_agriculture:buygraine', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if xPlayer.getMoney() >= 10 then
    if xPlayer.canCarryItem('graineble', 1) then
      xPlayer.removeMoney(10)
      xPlayer.addInventoryItem('graineble', 1)
    else
      TriggerClientEvent('esx:showNotification', x_source, '~r~Vous n\'avez pas assez de place sur vous')
    end
  else
    TriggerClientEvent('esx:showNotification', x_source, '~r~Vous n\'avez pas assez d\'argent sur vous')
  end
end)

RegisterServerEvent('mrw_agriculture:buytruelle')
AddEventHandler('mrw_agriculture:buytruelle', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if xPlayer.getMoney() >= 150 then
    if xPlayer.canCarryItem('truelle2', 1) then
      xPlayer.removeMoney(150)
      xPlayer.addInventoryItem('truelle2', 1)
    else
      TriggerClientEvent('esx:showNotification', x_source, '~r~Vous n\'avez pas assez de place sur vous')
    end
  else
    TriggerClientEvent('esx:showNotification', x_source, '~r~Vous n\'avez pas assez d\'argent sur vous')
  end
end)

RegisterServerEvent('mrw_agriculture:BuyParcelle')
AddEventHandler('mrw_agriculture:BuyParcelle', function(id, PlayerPed)
  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)
  local Player = ESX.GetPlayerFromId(x_source).identifier
  
  local check = MySQL.Sync.fetchAll('SELECT * FROM owned_parcelle')

  for i=1, #check, 1 do
    local owner = check[i].owner
    local state = check[i].state
    local K = check[i].id
    local price = check[i].price

    if owner == Player then 
      TriggerClientEvent('esx:showNotification', x_source, '~r~Vous possedez déja une parcelle')
      break
    else  
      if K == id then 
        if owner == '0' and state == false then
          if xPlayer.getMoney() >= price then
            MySQL.Async.fetchAll("UPDATE owned_parcelle SET owner = @owner, state=@state WHERE id = @id", {['@owner'] = Player, ['@id']  = id, ['@state']='1'},
              function(result)
                xPlayer.removeMoney(price)
                TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Achat', '~g~Vous avez acheté une parcelle pour ~r~' .. price .. '~w~ $', 'CHAR_HUNTER', -1)
                TriggerClientEvent('mrw_agriculture:StopMenu', x_source, id) 
                xPlayer.setJob('agriculteur', 0)
                TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Nouveau Job !', '~g~Bienvenue chez les agriculteurs', 'CHAR_HUNTER', -1)
              end 
            )
          else  
            TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Refus', '~r~Tu n\'a pas assez d\'argent', 'CHAR_HUNTER', -1)
          end
        else
        TriggerClientEvent('esx:showNotification', x_source, '~r~La parcelle est occupée')
        end 
      end 
    end 
  end  
end)


RegisterServerEvent('mrw_agriculture:VendreParcelle')
AddEventHandler('mrw_agriculture:VendreParcelle', function(PlayerPed)
  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)
  local Player = ESX.GetPlayerFromId(x_source).identifier
  local price = 2500

  local check = MySQL.Sync.fetchAll('SELECT owner, id FROM owned_parcelle')

  for k,val in pairs(check) do

    if val.owner == Player then

      MySQL.Async.fetchAll("UPDATE owned_parcelle SET owner = @owner, state = @state WHERE id = @id", {['@owner'] = '0', ['@id']  = val.id, ['@state'] = '0'},
        function(result)
          xPlayer.addMoney(price)
          TriggerClientEvent('esx:showNotification', x_source, '~g~Vous avez vendu votre parcelle pour 2000$')
          TriggerClientEvent('mrw_agriculture:StopMenu', x_source)
          xPlayer.setJob('unemployed', 0)
           TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Perte d\'emploi !', 'Tu n\'est plus agriculteur', 'CHAR_HUNTER', -1)
        end
      )
    end
  end
end)

RegisterServerEvent('mrw_agriculture:createPlante')
AddEventHandler('mrw_agriculture:createPlante', function(x, y, z)

  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)

  MySQL.Async.execute(
    'INSERT INTO position_plante (identifier, name, x, y, z) VALUES (@identifier, @name, @x, @y, @z)',
    {
    ['@identifier'] = xPlayer.identifier,
    ['@name'] = 'ble',
    ['@x']  = x,
    ['@y']  = y,
    ['@z']  = z
    },

    function(result)
    end
  )
end)

RegisterServerEvent('mrw_agriculture:deletePlant')
AddEventHandler('mrw_agriculture:deletePlant', function(x)

  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)

  TriggerClientEvent('mrw_agriculture:deletePlant', x_source, x)

  MySQL.Async.execute(
    'DELETE FROM position_plante WHERE x = @x',
    {
    ['@x'] = x
    },
    function()
    end
  )
end)

ESX.RegisterServerCallback('mrw_agriculture:checkPlante', function(source, cb)

  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)

  MySQL.Async.fetchAll(
    'SELECT * FROM position_plante',
    {},
    function(result)
      local data = {}
      for i=1, #result, 1 do
        if result[i].identifier == xPlayer.identifier then 
          table.insert(data, {
            id         = result[i].id,
            identifier = result[i].identifier,
            name       = result[i].name,
            x          = result[i].x,
            y          = result[i].y,
            z          = result[i].z,
            percent    = result[i].percent
          })
        end
      end
      cb(data)
    end
  )
end)

RegisterServerEvent('mrw_agriculture:Notif')
AddEventHandler('mrw_agriculture:Notif', function(P)
  local x_source      = source
  if P == 25 then 
    TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Status', 'Ta plante est à '..P..' % de sa croissance', 'CHAR_HUNTER', -1)
  elseif P == 50 then 
    TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Status', 'Ta plante est à '..P..' % de sa croissance', 'CHAR_HUNTER', -1)
  elseif P == 75 then
    TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Status', 'Ta plante est à '..P..' % de sa croissance', 'CHAR_HUNTER', -1)  
  elseif P == 130 then
   TriggerClientEvent('esx:showAdvancedNotification', x_source, 'Bill', 'Status', 'Ta plante à bientot finit sa croissance rend toi sur ta parcelle', 'CHAR_HUNTER', -1)  
  end
end) 


RegisterServerEvent('mrw_agriculture:GiveItem')
AddEventHandler('mrw_agriculture:GiveItem', function(x)
  local x_source      = source
  local xPlayer       = ESX.GetPlayerFromId(x_source)
  local random        = math.random(50,100)
  local randomplante  = math.random(0,25)
  local randomgraine  = math.random(1,3)

  if xPlayer.canCarryItem('ble', random) then
  xPlayer.addInventoryItem('ble', random)

  if randomplante <= 2 and xPlayer.canCarryItem('graineble', randomgraine) then
    xPlayer.addInventoryItem('graineble', randomgraine)
  end

  TriggerClientEvent('mrw_agriculture:deleteweed', x_source, x)

  MySQL.Async.execute(
    'DELETE FROM position_plante WHERE x = @x',
    {
    ['@x'] = x
    },
    function()
    end
  )
else
  TriggerClientEvent('esx:showNotification', x_source,'~r~Vous n\'avez pas assez de place dans votre inventaire !')
end
end)

ESX.RegisterUsableItem('graineble', function(source)
  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)
  local truelle  = xPlayer.getInventoryItem('truelle2').count

  if truelle <= 0 then 
    TriggerClientEvent('esx:showNotification', x_source,'~r~Vous devez avoir une ~b~truelle~s~ !')
  else   
   TriggerClientEvent('mrw_agriculture:CheckId', x_source)
  end 
end)

RegisterServerEvent('mrw_agriculture:CheckOwnedParcelle')
AddEventHandler('mrw_agriculture:CheckOwnedParcelle', function(id)
  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)
  local Player = ESX.GetPlayerFromId(x_source).identifier

  local check = MySQL.Sync.fetchAll('SELECT owner, id FROM owned_parcelle')

  for k,val in pairs(check) do

    if id == val.id then
      if Player == val.owner then
        xPlayer.removeInventoryItem('graineble', 1)
        TriggerClientEvent('mrw_agriculture:PlantationGrBle', x_source)
        TriggerClientEvent('esx:showNotification', x_source,'~g~Plantation~s~ en ~b~cours~s~.')
      else
        TriggerClientEvent('esx:showNotification', x_source,'~r~Cette parcelle n\'est pas la votre')  
      end  
    end    
  end
end)


ESX.RegisterUsableItem('truelle2', function(source)
  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)
  TriggerClientEvent('mrw_agriculture:usetruelle', x_source)
end)


function UptadePourcent()

  local xPlayers  = ESX.GetPlayers()
  local TimeUpdate = 2 -- En minutes
  num = 1
  for i=1, #xPlayers, 1 do
    if num == 1 then
    MySQL.Async.execute(
      'UPDATE position_plante SET percent = percent + 2.09',
      {
      }
    )
  end
  num = 0
  end
  SetTimeout(TimeUpdate * 60 * 1000, UptadePourcent)
end

UptadePourcent()

------------------------------||||||||||||||||||| Transformation |||||||||||| ---------------------------------

function Transform(x_source, zone)
  if TransformZone[x_source] == true then
    local xPlayer  = ESX.GetPlayerFromId(x_source)
    if zone == 'Zone' then
      local itemQtty = xPlayer.getInventoryItem('ble').count
      if itemQtty <= 2 then
        TriggerClientEvent('esx:showNotification', x_source, '~r~Vous n\'avez pas assez de grain')
        TriggerClientEvent('mrw_agriculture:StopAnim', x_source)
        return
      else
        SetTimeout(2500, function()
          if xPlayer.canCarryItem('farine', 1) then
            xPlayer.removeInventoryItem('ble', 3)
            xPlayer.addInventoryItem('farine', 1)

            Transform(x_source, zone)
          else
            TriggerClientEvent('esx:showNotification', x_source, '~r~Vous n\'avez pas assez de place sur vous (1kg)')
          end
        end)  
      end
    end 
  end    
end

function Transform2(x_source, zone)
  if TransformZone2[x_source] == true then
    local xPlayer  = ESX.GetPlayerFromId(x_source)
    if zone == 'Zone2' then
     -- local item2Qtty = xPlayer.getInventoryItem('water').count
      local item3Qtty = xPlayer.getInventoryItem('farine').count
      if item3Qtty <=1 then
        TriggerClientEvent('esx:showNotification', x_source, 'Vous n\'avez pas assez de farine')
     --   TriggerClientEvent('esx:showNotification', x_source, 'Vous n\'avez pas assez d\'eau')
        TriggerClientEvent('mrw_agriculture:StopAnim', x_source)
        return
      else  
        SetTimeout(2500, function()    
          xPlayer.removeInventoryItem('farine', 2)
         -- xPlayer.removeInventoryItem('water', 1)
          xPlayer.addInventoryItem('bread', 1)

          Transform2(x_source, zone)
        end)  
      end
    end 
  end  
end

function Sell(x_source, zone)
  if SellZone[x_source] == true then
    local xPlayer  = ESX.GetPlayerFromId(x_source)
    if zone == 'Sell' then 
      local itemSellQtty = xPlayer.getInventoryItem('bread').count
      if itemSellQtty <= 1 then
        TriggerClientEvent('esx:showNotification', x_source, 'Vous n\'avez pas assez de pain')
        return
      else
        SetTimeout(2500, function()    
          xPlayer.removeInventoryItem('bread', 2)
          xPlayer.addMoney(5)
          Sell(x_source, zone)
        end) 
      end  
    end    
  end 
end

RegisterServerEvent('mrw_agriculture:Transform')
AddEventHandler('mrw_agriculture:Transform', function(zone)
  local x_source      = source

  if zone then
    print(zone)
    TransformZone[x_source] = true
    Transform(x_source, zone)
  end 
end) 

RegisterServerEvent('mrw_agriculture:StopTransform')
AddEventHandler('mrw_agriculture:StopTransform', function()
  local x_source      = source

  TransformZone[x_source] = false
  TriggerClientEvent('esx:showNotification', source, 'Vous n\'etes plus dans la zone')
end) 

RegisterServerEvent('mrw_agriculture:Transform2')
AddEventHandler('mrw_agriculture:Transform2', function(zone)
  local x_source      = source
  if zone then
    TransformZone2[x_source] = true
    Transform2(x_source, zone)
  end 
end) 

RegisterServerEvent('mrw_agriculture:StopTransform2')
AddEventHandler('mrw_agriculture:StopTransform2', function()
  local x_source      = source

  TransformZone2[x_source] = false
  TriggerClientEvent('esx:showNotification', source, 'Vous n\'etes plus dans la zone')
end) 

RegisterServerEvent('mrw_agriculture:Sell')
AddEventHandler('mrw_agriculture:Sell', function(zone)
  local x_source      = source

  if zone then
    SellZone[x_source] = true
    Sell(x_source, zone)
  end 
end) 

RegisterServerEvent('mrw_agriculture:StopSell')
AddEventHandler('mrw_agriculture:StopSell', function()
  local x_source      = source

  SellZone[x_source] = false
  TriggerClientEvent('esx:showNotification', source, 'Vous n\'etes plus dans la zone')
end) 

------------------------------||||||||||||||||||| Coffre ||||||||||||||||||------------------------------------

RegisterServerEvent('mrw_agriculture:getItem')
AddEventHandler('mrw_agriculture:getItem', function(owner, type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
  local xPlayerOwner = ESX.GetPlayerFromId(_source).identifier

  if type == 'item_standard' then
    local sourceItem = xPlayer.getInventoryItem(item)
    
    TriggerEvent('esx_addoninventory:getInventory', 'parcelle', xPlayerOwner, function(inventory)
      local inventoryItem = inventory.getItem(item)
      
      if count > 0 and inventoryItem.count >= count then
      
        if not xPlayer.canCarryItem(item, count) then
          TriggerClientEvent('esx:showNotification', _source, 'Vous ne disposez pas assez d\'espace')
        else
          inventory.removeItem(item, count)
          xPlayer.addInventoryItem(item, count)
          TriggerClientEvent('esx:showNotification', _source, 'Vous avez recuperez : '..count..' '..inventoryItem.label)
        end
      else
        TriggerClientEvent('esx:showNotification', _source, 'montant invalide')
      end
    end)
  end
end)

RegisterServerEvent('mrw_agriculture:putItem')
AddEventHandler('mrw_agriculture:putItem', function(owner, type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
  local xPlayerOwner = ESX.GetPlayerFromId(_source).identifier

  if type == 'item_standard' then

    local playerItemCount = xPlayer.getInventoryItem(item).count

    if playerItemCount >= count and count > 0 then
     
      TriggerEvent('esx_addoninventory:getInventory', 'parcelle', xPlayerOwner, function(inventory)
        xPlayer.removeInventoryItem(item, count)
        inventory.addItem(item, count)
        TriggerClientEvent('esx:showNotification', _source, 'vous avez déposez : '..count..' '..inventoryItem.label)
      end)
      
    else
      TriggerClientEvent('esx:showNotification', _source, 'montant invalide')
    end

  end
end)

ESX.RegisterServerCallback('mrw_agriculture:getParcelleInventory', function(source, cb, owner)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source).identifier
  local items      = {}


  TriggerEvent('esx_addoninventory:getInventory', 'parcelle', xPlayer, function(inventory)
    items = inventory.items
  end)


  cb(items)

end)

