ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'pizza', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'pizza', _U('pizza_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'pizza', 'pizza', 'society_pizza', 'society_pizza', 'society_pizza', {type = 'private'})



RegisterServerEvent('esx_pizzajob:getStockItem')
AddEventHandler('esx_pizzajob:getStockItem', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pizza', function(inventory)

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

ESX.RegisterServerCallback('esx_pizzajob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pizza', function(inventory)
    cb(inventory.items)
  end)
end)

RegisterServerEvent('esx_pizzajob:putStockItems')
AddEventHandler('esx_pizzajob:putStockItems', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pizza', function(inventory)
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


RegisterServerEvent('esx_pizzajob:getFridgeStockItem')
AddEventHandler('esx_pizzajob:getFridgeStockItem', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pizza_fridge', function(inventory)

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

ESX.RegisterServerCallback('esx_pizzajob:getFridgeStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pizza_fridge', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_pizzajob:putFridgeStockItems')
AddEventHandler('esx_pizzajob:putFridgeStockItems', function(itemName, count)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pizza_fridge', function(inventory)
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


RegisterServerEvent('esx_pizzajob:buyItem')
AddEventHandler('esx_pizzajob:buyItem', function(itemName, price, itemLabel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local qtty = xPlayer.getInventoryItem(itemName).count
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_pizza', function(account)
        societyAccount = account
      end)
    
    if societyAccount ~= nil and societyAccount.money >= price and xPlayer.canCarryItem(itemName, 1) then
            societyAccount.removeMoney(price)
            xPlayer.addInventoryItem(itemName, 1)
            TriggerClientEvent('esx:showNotification', _source, _U('bought') .. itemLabel)
            TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
    else
        TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
    end

end)


RegisterServerEvent('esx_pizzajob:pizza1')
AddEventHandler('esx_pizzajob:pizza1', function(itemValue)
    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'reine' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('pate').count
            local bethQuantity      = xPlayer.getInventoryItem('ing').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ing') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('reine') .. ' ~w~!')
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                    xPlayer.addInventoryItem('reine', 1)
                end
            end

        end)
    end

end)

RegisterServerEvent('esx_pizzajob:pizza2')
AddEventHandler('esx_pizzajob:pizza2', function(itemValue)
    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == '5fromages' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('pate').count
            local bethQuantity      = xPlayer.getInventoryItem('ing').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pate') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ing') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)

                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('5fromages') .. ' ~w~!')
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                    xPlayer.addInventoryItem('5fromages', 1)
                end
            end

        end)
    end

end)

RegisterServerEvent('esx_pizzajob:pizza3')
AddEventHandler('esx_pizzajob:pizza3', function(itemValue)
    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'barbecue' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('pate').count
            local pouleQuantity      = xPlayer.getInventoryItem('ing').count
 

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pate') .. '~w~')
            elseif pouleQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ing') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('barbecue') .. ' ~w~!')
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                    xPlayer.addInventoryItem('barbecue', 1)
                end
            end

        end)
    end

end)

RegisterServerEvent('esx_pizzajob:pizza4')
AddEventHandler('esx_pizzajob:pizza4', function(itemValue)
    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'saumons' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('pate').count
            local vkebabQuantity      = xPlayer.getInventoryItem('ing').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pate') .. '~w~')
            elseif vkebabQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('saumons') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('saumons') .. ' ~w~!')
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                    xPlayer.addInventoryItem('saumons', 1)
                end
            end
        end)
    end
end)

RegisterServerEvent('esx_pizzajob:pizza5')
AddEventHandler('esx_pizzajob:pizza5', function(itemValue)

    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'orientale' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('pate').count
            local vkebabQuantity      = xPlayer.getInventoryItem('ing').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pate') .. '~w~')
            elseif vkebabQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('orientale') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)

                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('orientale') .. ' ~w~!')
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                    xPlayer.addInventoryItem('orientale', 1)
                end
            end

        end)
    end

end)

RegisterServerEvent('esx_pizzajob:pizza6')
AddEventHandler('esx_pizzajob:pizza6', function(itemValue)

    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'calzone' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('pate').count
            local vkebabQuantity      = xPlayer.getInventoryItem('ing').count


            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pate') .. '~w~')
            elseif vkebabQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ing') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('calzone') .. ' ~w~!')
                    xPlayer.removeInventoryItem('pate', 1)
                    xPlayer.removeInventoryItem('ing', 1)
                    xPlayer.addInventoryItem('calzone', 1)
                end
            end

        end)
    end

end)

ESX.RegisterServerCallback('esx_pizzajob:getVaultWeapons', function(source, cb)
  TriggerEvent('esx_datastore:getSharedDataStore', 'society_pizza', function(store)
    local weapons = store.get('weapons')
    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_pizzajob:addVaultWeapon', function(source, cb, weaponName)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.removeWeapon(weaponName)
  TriggerEvent('esx_datastore:getSharedDataStore', 'society_pizza', function(store)

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

ESX.RegisterServerCallback('esx_pizzajob:removeVaultWeapon', function(source, cb, weaponName)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.addWeapon(weaponName, 1000)
  TriggerEvent('esx_datastore:getSharedDataStore', 'society_pizza', function(store)

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

ESX.RegisterServerCallback('esx_pizzajob:getPlayerInventory', function(source, cb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local items      = xPlayer.inventory
  cb({
    items      = items
  })
end)

--------- item basic needs

ESX.RegisterUsableItem('reine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('reine', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
  xPlayer.showNotification("Vous avez manger une reine")
end)

ESX.RegisterUsableItem('5fromages', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('5fromages', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
  xPlayer.showNotification("Vous avez manger une pizza 5 fromages")
end)

ESX.RegisterUsableItem('barbecue', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('barbecue', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
  xPlayer.showNotification("Vous avez manger une pizza au barbecue")
end)

ESX.RegisterUsableItem('saumons', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('saumons', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
  xPlayer.showNotification("Vous avez manger une pizza au saumon")
end)

ESX.RegisterUsableItem('orientale', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('orientale', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
  xPlayer.showNotification("Vous avez manger une pizza orientale")
end)

ESX.RegisterUsableItem('calzone', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('calzone', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
  xPlayer.showNotification("Vous avez manger une calzone")
end)






