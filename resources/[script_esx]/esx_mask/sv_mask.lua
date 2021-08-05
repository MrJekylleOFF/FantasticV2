ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("dqp:SetNewMasque")
AddEventHandler("dqp:SetNewMasque", function(mask,variation,type,label)
  maskx = {mask_1=mask,mask_2=variation}
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  print(label)


  if xPlayer.getMoney() >= 50 then
    xPlayer.removeMoney(50)
  MySQL.Async.execute(
    'INSERT INTO user_accessories (identifier,mask,type,label) VALUES(@identifier,@mask,@type,@label)',
    {
      
      ['@mask'] = json.encode(maskx),
      ['@type'] = type,
      ['@label'] = label,
    ['@identifier'] =  xPlayer.identifier
    }
  )
  TriggerClientEvent("dqp:SyncAccess",source)
  TriggerClientEvent("esx:showNotification",source,"~g~Vous avez reçu un nouveau " .. type .."~n~~r~-50€" )
else
  TriggerClientEvent('esx:showNotification', _source, 'Pas assez d\'argent (50€)')
end
end)