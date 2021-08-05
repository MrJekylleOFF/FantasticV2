
ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent("annim:saveBind")
AddEventHandler("annim:saveBind", function(anim,touche)
	local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  bind = anim
  print(touche)
  if touche == "pav7" then
    MySQL.Async.fetchAll(
      'SELECT * FROM `user_settings` WHERE `identifier` = @identifier',
      {
        ['@identifier'] = xPlayer.identifier,
        
      },
      function(result)
        

        if result[1] == nil then

          MySQL.Async.execute('INSERT INTO user_settings (identifier, pav7) VALUES (@owner, @bind)',
          {
            ['@owner']   = xPlayer.identifier,
            
            ['@bind'] = json.encode(bind)
          },
          function (_)
            TriggerClientEvent("annim:shownotif",_source,"Touche enregistrée",26)  
          end)
        else
          id = result[1].id
          MySQL.Async.execute('UPDATE user_settings SET pav7=@bind WHERE identifier = @owner',
          {
            ['@owner']   = xPlayer.identifier,
            
            ['@bind'] = json.encode(bind)
          },
          function (_)
            TriggerClientEvent("annim:shownotif",_source,"Touche enregistrée",26)  
            TriggerClientEvent("annim:ready",_source)
      --      TriggerClientEvent("annim:syncdemarche",_source,demarche)
          end)
        end
        

      end
    )
  end
  if touche == "pav8" then
    MySQL.Async.fetchAll(
      'SELECT * FROM `user_settings` WHERE `identifier` = @identifier',
      {
        ['@identifier'] = xPlayer.identifier,
        
      },
      function(result)

        

        if result[1] == nil then

          MySQL.Async.execute('INSERT INTO user_settings (identifier, pav8) VALUES (@owner, @bind)',
          {
            ['@owner']   = xPlayer.identifier,
            
            ['@bind'] = json.encode(bind)
          },
          function (_)
            TriggerClientEvent("annim:shownotif",_source,"Touche enregistrée",26)  
          end)
        else
          id = result[1].id
          MySQL.Async.execute('UPDATE user_settings SET pav8=@bind WHERE identifier = @owner',
          {
            ['@owner']   = xPlayer.identifier,
            
            ['@bind'] = json.encode(bind)
          },
          function (_)
            TriggerClientEvent("annim:shownotif",_source,"Touche enregistrée",26)  
            TriggerClientEvent("annim:ready",_source)
      --      TriggerClientEvent("annim:syncdemarche",_source,demarche)
          end)
        end
        

      end
    )
  end
  if touche == "pav9" then
    MySQL.Async.fetchAll(
      'SELECT * FROM `user_settings` WHERE `identifier` = @identifier',
      {
        ['@identifier'] = xPlayer.identifier,
        
      },
      function(result)

        

        if result[1] == nil then

          MySQL.Async.execute('INSERT INTO user_settings (identifier, pav9) VALUES (@owner, @bind)',
          {
            ['@owner']   = xPlayer.identifier,
            
            ['@bind'] = json.encode(bind)
          },
          function (_)
            TriggerClientEvent("annim:shownotif",_source,"Touche enregistrée",26)  
          end)
        else
          id = result[1].id
          MySQL.Async.execute('UPDATE user_settings SET pav9=@bind WHERE identifier = @owner',
          {
            ['@owner']   = xPlayer.identifier,
            
            ['@bind'] = json.encode(bind)
          },
          function (_)
            TriggerClientEvent("annim:shownotif",_source,"Touche enregistrée",26)  
            TriggerClientEvent("annim:ready",_source)
      --      TriggerClientEvent("annim:syncdemarche",_source,demarche)
          end)
        end
        

      end
    )
  end
  Wait(400)
  TriggerClientEvent("annim:ready",_source)
end)


ESX.RegisterServerCallback('annim:getsettings', function(source, cb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end

  local opt = {}
	MySQL.Async.fetchAll(
		'SELECT * FROM `user_settings` WHERE `identifier` = @identifier',
		{
			['@identifier'] = xPlayer.identifier,
			
		},
		function(result)

			

      cb(result)

			

		end
	)
end)