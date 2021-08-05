ESX                    = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('parow:setHat')
AddEventHandler('parow:setHat', function(hat)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll(
		'SELECT * FROM user_accessories WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
    function(result)
      if result[1] ~= nil then
      MySQL.Async.execute(
        'UPDATE user_accessories SET hat = @glasses WHERE identifier = @identifier',
        {
          ['@identifier']   = xPlayer.identifier,
          ['@glasses'] = json.encode(hat)
    
        }
      )
    else
      MySQL.Async.execute(
        'INSERT INTO user_accessories (identifier,hat) VALUES(@identifier,@glasses)',
        {
          
          ['@glasses'] = json.encode(hat),
    
        ['@identifier'] =  xPlayer.identifier
        }
      )
    end
		end
  )
  TriggerClientEvent("parow:SyncAccess",source)


end)
RegisterServerEvent('parow:setGlasses')
AddEventHandler('parow:setGlasses', function(glasses)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll(
		'SELECT * FROM user_accessories WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
    function(result)
      if result[1] ~= nil then
      MySQL.Async.execute(
        'UPDATE user_accessories SET glasses = @glasses WHERE identifier = @identifier',
        {
          ['@identifier']   = xPlayer.identifier,
          ['@glasses'] = json.encode(glasses)
    
        }
      )
    else
      MySQL.Async.execute(
        'INSERT INTO user_accessories (identifier,glasses) VALUES(@identifier,@glasses)',
        {
          
          ['@glasses'] = json.encode(glasses),
    
        ['@identifier'] =  xPlayer.identifier
        }
      )
    end
		end
	)
  TriggerClientEvent("parow:SyncAccess",source)

end)


RegisterServerEvent("parow:SetNewAcces")
AddEventHandler("parow:SetNewAcces", function(data,_source)

  local xPlayer = ESX.GetPlayerFromId(_source)
  MySQL.Async.execute(
    'INSERT INTO user_accessories (identifier,mask,type,label) VALUES(@identifier,@mask,@type,@label)',
    {
      
      ['@mask'] = data.mask,
      ['@type'] = data.type,
      ['@label'] = data.label,
    ['@identifier'] =  xPlayer.identifier
    }
  )
  TriggerClientEvent("parow:SyncAccess",_source)
  TriggerClientEvent("esx:showNotification",_source,"~g~Vous avez reçu un nouveau " .. data.type )
end)
RegisterServerEvent("parow:SetNewMasque")
AddEventHandler("parow:SetNewMasque", function(mask,variation,type,label)
  maskx = {mask_1=mask,mask_2=variation}
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

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
  TriggerClientEvent("parow:SyncAccess",source)
  TriggerClientEvent("esx:showNotification",source,"~g~Vous avez reçu un nouveau " .. type .."~n~~r~-50€" )
else
  TriggerClientEvent('esx:showNotification', _source, 'Pas assez d\'argent (50€)')
end
end)




RegisterServerEvent('prw:GiveAccessories')
AddEventHandler('prw:GiveAccessories', function(target,id,label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayer2 = ESX.GetPlayerFromId(target)
	MySQL.Async.execute(
		'UPDATE user_accessories SET identifier = @identifier WHERE id = @id',
		{
			['@identifier']   = xPlayer2.identifier,
			['@id'] = id

		}
	)
			TriggerClientEvent('esx:showNotification', _source, '~r~-1 '.. label)
			TriggerClientEvent('esx:showNotification', target, '~g~+1 '.. label)
		
			TriggerClientEvent("parow:SyncAccess",source)
			TriggerClientEvent("parow:SyncAccess",target)

end)

ESX.RegisterServerCallback('parow:getMask', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    
  
    MySQL.Async.fetchAll(
      'SELECT * FROM user_accessories WHERE identifier = @identifier',
      {
          ['@identifier'] = xPlayer.identifier
      },
      function(result)
  
        cb(result)
  
    end )
  
  end)
  
RegisterServerEvent('prw:Delclo')
AddEventHandler('prw:Delclo', function(id,label,data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

			

			
			MySQL.Async.execute(
				'DELETE FROM user_accessories where id = @id',
				{
					['@id']   = id,

		
				}
			)
		--	ESX.CreatePickup('accessories', data, 1, data.type , _source)
			TriggerClientEvent('esx:showNotification', _source, '~r~-1 '.. label)
			


end)

RegisterServerEvent("parow:RenameMasque")
AddEventHandler("parow:RenameMasque", function(id,txt,type)
  MySQL.Async.execute(
    'UPDATE user_accessories SET label = @label WHERE id=@id',
    {
      ['@id'] = id,
      ['@label'] = txt

    }
  )
  TriggerClientEvent("esx:showNotification",source,"Vous avez bien renommé votre "..type.." en "..txt)

end)