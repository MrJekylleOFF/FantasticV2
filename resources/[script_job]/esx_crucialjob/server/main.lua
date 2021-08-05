ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'crucial', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'crucial', _U('crucial_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'crucial', 'crucial', 'society_crucial', 'society_crucial', 'society_crucial', {type = 'private'})



RegisterServerEvent('esx_crucialjob:getStockItem')
AddEventHandler('esx_crucialjob:getStockItem', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_crucial', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count and xPlayer.canCarryItem(itemName, count) then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)
end)

ESX.RegisterServerCallback('esx_crucialjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_crucial', function(inventory)
    cb(inventory.items)
  end)
end)

RegisterServerEvent('esx_crucialjob:putStockItems')
AddEventHandler('esx_crucialjob:putStockItems', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_crucial', function(inventory)
    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)
  end)
end)


RegisterServerEvent('esx_crucialjob:getFridgeStockItem')
AddEventHandler('esx_crucialjob:getFridgeStockItem', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_crucial_fridge', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count and xPlayer.canCarryItem(itemName, count) then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)
  end)
end)

ESX.RegisterServerCallback('esx_crucialjob:getFridgeStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_crucial_fridge', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_crucialjob:putFridgeStockItems')
AddEventHandler('esx_crucialjob:putFridgeStockItems', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_crucial_fridge', function(inventory)
    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)


RegisterServerEvent('esx_crucialjob:buyItem')
AddEventHandler('esx_crucialjob:buyItem', function(itemName, price, itemLabel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local qtty = xPlayer.getInventoryItem(itemName).count
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_crucial', function(account)
        societyAccount = account
      end)
    
    if societyAccount ~= nil and societyAccount.money >= price and xPlayer.canCarryItem(itemName, 1)then
            societyAccount.removeMoney(price)
            xPlayer.addInventoryItem(itemName, 1)
            TriggerClientEvent('esx:showNotification', _source, _U('bought') .. itemLabel)
            TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
    else
        TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
    end

end)


ESX.RegisterServerCallback('esx_crucialjob:getVaultWeapons', function(source, cb)
  TriggerEvent('esx_datastore:getSharedDataStore', 'society_crucial', function(store)
    local weapons = store.get('weapons')
    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_crucialjob:addVaultWeapon', function(source, cb, weaponName)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.removeWeapon(weaponName)
  TriggerEvent('esx_datastore:getSharedDataStore', 'society_crucial', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
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

ESX.RegisterServerCallback('esx_crucialjob:removeVaultWeapon', function(source, cb, weaponName)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.addWeapon(weaponName, 1000)
  TriggerEvent('esx_datastore:getSharedDataStore', 'society_crucial', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end
     store.set('weapons', weapons)
     cb()
  end)
end)

ESX.RegisterServerCallback('esx_crucialjob:getPlayerInventory', function(source, cb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local items      = xPlayer.inventory
  cb({
    items      = items
  })
end)








