
TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

ESX.RegisterServerCallback('ticket:checkGroup', function(source, cb, license)

  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
    ['@identifier'] = license
  }, function(result2)
      cb(result2[1].group)
  end)


end)

ESX.RegisterServerCallback('ticket:checkLicense', function(source, cb, id)
  local xPlayer = ESX.GetPlayerFromId(id)
  cb(xPlayer.identifier)
end)

RegisterNetEvent('ticket:Show')
AddEventHandler('ticket:Show', function(targetid, id, args)
  TriggerClientEvent('ticket:ShowC', targetid, id, args)
end)