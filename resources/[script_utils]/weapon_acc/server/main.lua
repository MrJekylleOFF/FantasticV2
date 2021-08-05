local ESX = nil
 
TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)
 
ESX.RegisterUsableItem('silent', function( source )
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('eden_accesories:use', _source, 'silencieux')
	xPlayer.removeInventoryItem('silent', 1)
end)
 
ESX.RegisterUsableItem('flashlight', function( source )
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('eden_accesories:use', _source, 'lampe')
	xPlayer.removeInventoryItem('flashlight', 1)
end)
 
ESX.RegisterUsableItem('grip', function( source )
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('eden_accesories:use', _source, 'poignee')
	xPlayer.removeInventoryItem('grip', 1)
end)
 
ESX.RegisterUsableItem('yusuf', function( source )
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('eden_accesories:use', _source, 'skin')
	xPlayer.removeInventoryItem('yusuf', 1)
end)

ESX.RegisterUsableItem('magazine', function( source )
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('eden_accesories:use', _source, 'extentionchargeur')
	xPlayer.removeInventoryItem('magazine', 1)
end)

ESX.RegisterUsableItem('scope', function( source )
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('eden_accesories:use', _source, 'scope')
	xPlayer.removeInventoryItem('scope', 1)
end)


-------

RegisterServerEvent('eden_accesories:giveBack')
AddEventHandler('eden_accesories:giveBack', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addInventoryItem(item, 1)
end)

RegisterServerEvent('eden_accesories:ReturnIsNotValid')
AddEventHandler('eden_accesories:ReturnIsNotValid', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if type == 'silencieux' then 
		xPlayer.addInventoryItem('silent', 1)
	elseif type == 'lampe' then
	  	xPlayer.addInventoryItem('flashlight', 1)
	elseif type == 'poignee' then   
	    xPlayer.addInventoryItem('grip', 1)
	elseif type == 'skin' then    	
		xPlayer.addInventoryItem('yusuf', 1)
	elseif type == 'extentionchargeur' then 
	 	xPlayer.addInventoryItem('magazine', 1)
	elseif type == 'scope' then 
	 	xPlayer.addInventoryItem('scope', 1)
	elseif type == '9 mm' then
	    xPlayer.addInventoryItem('box_9mm', 1)	
	elseif type == '12 mm' then
	    xPlayer.addInventoryItem('box_12mm', 1)	
    elseif type == '.45 ACP' then
	    xPlayer.addInventoryItem('box_.45ACP', 1)	
	elseif type == '7.62 mm' then
	    xPlayer.addInventoryItem('box_7.62mm', 1)
    elseif type == '357 Magnum' then
	    xPlayer.addInventoryItem('box_357Magnum', 1)
	end	
end)

RegisterServerEvent('eden_accesories:SaveComponnent')
AddEventHandler('eden_accesories:SaveComponnent', function(weapons, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if type == 'silencieux' then 
		xPlayer.addWeaponComponent(weapons, 'suppressor')
	elseif type == 'lampe' then
	  	xPlayer.addWeaponComponent(weapons, 'flashlight')
	elseif type == 'poignee' then   
	    xPlayer.addWeaponComponent(weapons, 'grip')
	elseif type == 'skin' then    	
		xPlayer.addWeaponComponent(weapons, 'luxary_finish')
	elseif type == 'extentionchargeur' then 
	 	xPlayer.addWeaponComponent(weapons, 'clip_extended')
	elseif type == 'scope' then 
	 	xPlayer.addWeaponComponent(weapons, 'scope')
	end	
end)

RegisterServerEvent('eden_accesories:RemoveComponnent')
AddEventHandler('eden_accesories:RemoveComponnent', function(weapons, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if type == 'silencieux' then 
		if xPlayer.hasWeaponComponent(weapons, 'suppressor') then
		   xPlayer.removeWeaponComponent(weapons, 'suppressor')
    	end
	elseif type == 'lampe' then
	  	local weaponName, weaponComponent = weapons, 'flashlight'
		if xPlayer.hasWeaponComponent(weaponName, weaponComponent) then
		   xPlayer.removeWeaponComponent(weaponName, 'flashlight')
    	end
	elseif type == 'poignee' then   
	    local weaponName, weaponComponent = weapons, 'grip'
		if xPlayer.hasWeaponComponent(weaponName, weaponComponent) then
		   xPlayer.removeWeaponComponent(weaponName, 'grip')
    	end
	elseif type == 'skin' then    	
	    local weaponName, weaponComponent = weapons, 'luxary_finish'
		if xPlayer.hasWeaponComponent(weaponName, weaponComponent) then
		   xPlayer.removeWeaponComponent(weaponName, 'luxary_finish')
    	end
	elseif type == 'extentionchargeur' then 
	    local weaponName, weaponComponent = weapons, 'clip_extended'
		if xPlayer.hasWeaponComponent(weaponName, weaponComponent) then
		   xPlayer.removeWeaponComponent(weaponName, 'clip_extended')
    	end
	elseif type == 'scope' then 
	 	local weaponName, weaponComponent = weapons, 'scope'
		if xPlayer.hasWeaponComponent(weaponName, weaponComponent) then
		   xPlayer.removeWeaponComponent(weaponName, 'scope')
    	end
	end	
end)
