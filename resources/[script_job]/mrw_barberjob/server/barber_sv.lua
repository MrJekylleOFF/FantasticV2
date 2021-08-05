ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'barbier', Config.MaxInService)
end


ESX.RegisterServerCallback('mrw_barberjob:getClosestPlayerSkin', function(source, cb, target)
  local xPlayer = ESX.GetPlayerFromId(target)
  print(xPlayer.identifier)

  MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
    ['@identifier'] = xPlayer.identifier
  }, function(users)
    local user = users[1]
    local skin = nil

    if user.skin ~= nil then
      cl = json.decode(user.skin)
    end

    cb(cl)
  end)
end)

ESX.RegisterServerCallback('mrw_barberjob:getSkin', function(source, cb)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
    ['@identifier'] = xPlayer.identifier
  }, function(users)
    local user = users[1]
    local skin = nil

    if user.skin ~= nil then
      skin = json.decode(user.skin)
    end

    cb(skin)
  end)
end)

RegisterServerEvent('mrw_barberjob:save')
AddEventHandler('mrw_barberjob:save', function(target, skin)

  local _source = source
  local xPlayer = nil
  local xPlayertarget = ESX.GetPlayerFromId(target)

	print('test save')

  MySQL.Async.execute('UPDATE users SET `skin` = @skin WHERE identifier = @identifier',
   	{
		['@skin']       = json.encode(skin),
		['@identifier'] = xPlayertarget.identifier
	},function(result)
     TriggerClientEvent('esx:showNotification', xPlayertarget.source, 'Coupe effectuer')
     TriggerClientEvent('skinchanger:loadSkin',xPlayertarget.source, skin)        
  end)
end)

RegisterServerEvent('mrw_barberjob:testSync')
AddEventHandler('mrw_barberjob:testSync', function(skin, closestPlayer)
  TriggerClientEvent('mrw_barberjob:retourSync', closestPlayer, skin)
end)

RegisterServerEvent('mrw_barberjob:ActualizeHair')
AddEventHandler('mrw_barberjob:ActualizeHair', function(targetHair, HairH)
  local HairH = HairH
  TriggerClientEvent('mrw_barberjob:ActualizeHairH', targetHair, HairH)
end)

RegisterServerEvent('mrw_barberjob:ActualizeHairFemme')
AddEventHandler('mrw_barberjob:ActualizeHairFemme', function(targetHairF, Hair)
  local HairF = Hair
  TriggerClientEvent('mrw_barberjob:ActualizeHairF', targetHairF, HairF)
end)

RegisterServerEvent('mrw_barberjob:ActualizeBarbe')
AddEventHandler('mrw_barberjob:ActualizeBarbe', function(targetBarbe, choise, percentage)
  TriggerClientEvent('mrw_barberjob:ActualizeBeardH', targetBarbe, choise, percentage)
end)

RegisterServerEvent('mrw_barberjob:ActualizeCouleur')
AddEventHandler('mrw_barberjob:ActualizeCouleur', function(targetHairCouleur, hairBaseColor)
  local hairBaseColor = hairBaseColor

  TriggerClientEvent('mrw_barberjob:ActualizeHairCouleur', targetHairCouleur, hairBaseColor)
end)

RegisterServerEvent('mrw_barberjob:ActualizeCouleur2')
AddEventHandler('mrw_barberjob:ActualizeCouleur2', function(targetHairCouleur2, hairBaseColor, hairBaseColor2)
  local hairBaseColor = hairBaseColor
  local hairBaseColor2 = hairBaseColor2

  TriggerClientEvent('mrw_barberjob:ActualizeHairCouleur2', targetHairCouleur2, hairBaseColor, hairBaseColor2)
end)


---########################### ENTREPRISE ########################## ---
TriggerEvent('esx_phone:registerNumber', 'barbier', 'barbier', true, true)
TriggerEvent('esx_society:registerSociety', 'barbier', 'barbier', 'society_barbier', 'society_barbier', 'society_barbier', {type = 'private'})

RegisterServerEvent('mrw_barberjob:getStockItem')
AddEventHandler('mrw_barberjob:getStockItem', function(itemName, count)
  
  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_barbier', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count and xPlayer.canCarryItem(itemName, count) then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)

    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, 'quantité invalide')
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retiré' .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('mrw_barberjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_barbier', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('mrw_barberjob:putStockItems')
AddEventHandler('mrw_barberjob:putStockItems', function(itemName, count)
  
  local x_source = source
  local xPlayer = ESX.GetPlayerFromId(x_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_barbier', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)

    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, 'quantité invalide')
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé' .. count .. ' ' .. item.label)

  end)
end)

ESX.RegisterServerCallback('mrw_barberjob:getPlayerInventory', function(source, cb)

  local x_source = source
  local xPlayer    = ESX.GetPlayerFromId(x_source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)