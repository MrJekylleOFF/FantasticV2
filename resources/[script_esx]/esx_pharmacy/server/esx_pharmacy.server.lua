ESX              = nil
local ItemLabels = {}


-- ====================================================================================================================
-- Basic event handler
-- ====================================================================================================================
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()

  MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
    for i = 1, #result, 1 do
      ItemLabels[result[i].name] = result[i].label
    end
  end)

end)

RegisterServerEvent('esx_pharmacy:buyItem')
AddEventHandler('esx_pharmacy:buyItem', function(itemName, price)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if xPlayer.getMoney() >= price then
    if xPlayer.canCarryItem(itemName, 1) then
      xPlayer.removeMoney(price)
      xPlayer.addInventoryItem(itemName, 1)

      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
      account.addMoney(price)
      end)

      TriggerClientEvent('esx:showNotification', _source, _U('bought') .. ItemLabels[itemName])
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de place dans votre inventaire (1kg).')
    end
  else
    TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
  end

end)

RegisterServerEvent('esx_pharmacy:removeItem')
AddEventHandler('esx_pharmacy:removeItem', function(itemName)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.removeInventoryItem(itemName, 1)
end)


-- ====================================================================================================================
-- Usable item
-- ====================================================================================================================
ESX.RegisterUsableItem('defibrillateur', function(source)
  local xPlayers     = ESX.GetPlayers()

  local ambulance =exports['esx_service']:GetInServiceCount('ambulance')

  if ambulance == 0 then
    TriggerClientEvent('esx_pharmacy:useDefibrillateur', source, 'defibrillateur')

  else
    TriggerClientEvent('esx:showNotification', source, _U('has_ambulance'))  
  end
end)