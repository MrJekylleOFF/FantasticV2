local ESX = nil
local Bproof = false 
local found = false
local found2 = false
local found3 = false
local insert = false
local insert2 = false
local insert3 = false
 
TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

ESX.RegisterUsableItem('box_9mm', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '9 mm')
    xPlayer.removeInventoryItem('box_9mm', 1)
end)

ESX.RegisterUsableItem('box_12mm', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '12 mm')
    xPlayer.removeInventoryItem('box_12mm', 1)
end)

ESX.RegisterUsableItem('box_7.62mm', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '7.62 mm')
    xPlayer.removeInventoryItem('box_7.62mm', 1)
end)

ESX.RegisterUsableItem('box_.45ACP', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '.45 ACP')
    xPlayer.removeInventoryItem('box_.45ACP', 1)
end)

ESX.RegisterUsableItem('box_357Magnum', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '357 Magnum')
    xPlayer.removeInventoryItem('box_357Magnum', 1)
end)

ESX.RegisterUsableItem('bulletproof', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
  
    LoadJson(_source)
end)


ESX.RegisterUsableItem('bulletproof2', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
  
    LoadJson2(_source)
end)

ESX.RegisterUsableItem('bulletproof3', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    LoadJson3(_source)
end)

-------

RegisterServerEvent('mrw_utils:DelBProof')
AddEventHandler('mrw_utils:DelBProof', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('bulletproof', 1)
end)

RegisterServerEvent('mrw_utils:DelBProof2')
AddEventHandler('mrw_utils:DelBProof2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('bulletproof2', 1)
end)

RegisterServerEvent('mrw_utils:DelBProof3')
AddEventHandler('mrw_utils:DelBProof3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('bulletproof3', 1)
end)

RegisterServerEvent('mrw_utils:ReturnIsNotValid')
AddEventHandler('mrw_utils:ReturnIsNotValid', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if type == '9 mm' then
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

RegisterServerEvent('mrw_utils:SaveBproof')
AddEventHandler('mrw_utils:SaveBproof', function(val)

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local id = xPlayer.identifier

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof.json") 
	LoadBproof = json.decode(loadFile)

	for i,v in ipairs(LoadBproof) do
		if v.users == id then
			print('found users', v.users == id)
			if tonumber(val) == 0 then 
				table.remove(LoadBproof, i)
            else 
			    v.value = val
			end    
		end 
	end
	SaveResourceFile(GetCurrentResourceName(), "./server/SaveBproof.json", json.encode(LoadBproof, {indent=true}), -1)  
end)	

function LoadJson(_source)

	local xPlayer  = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof.json") 
	LoadBproof = json.decode(loadFile)

	if #LoadBproof == 0 then 
		table.insert(LoadBproof, {
	       users = identifier,
	       value = 100
		})
		insert = true
		TriggerClientEvent('mrw_utils:bproof', _source, 100)
	end

	for i,v in ipairs(LoadBproof) do
		local value = v.value
		if v.users == identifier then
			print(v.users == identifier)
			found = true 
			TriggerClientEvent('mrw_utils:bproof', _source, v.value)	
		end
	end

	if not found and not insert then 
		print("not found", "not insert")
		table.insert(LoadBproof, {
	       users = identifier,
	       value = 100
		})
		TriggerClientEvent('mrw_utils:bproof', _source, 100)
	end

	SaveResourceFile(GetCurrentResourceName(), "./server/SaveBproof.json", json.encode(LoadBproof, {indent=true}), -1)    
end

RegisterServerEvent('mrw_utils:SaveBproof2')
AddEventHandler('mrw_utils:SaveBproof2', function(val)

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local id = xPlayer.identifier

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof2.json") 
	LoadBproof2 = json.decode(loadFile)

	for i,v in ipairs(LoadBproof2) do
		if v.users == id then
			print('found users', v.users == id)
			if tonumber(val) == 0 then 
				table.remove(LoadBproof2, i)
            else 
			    v.value = val
			end    
		end 
	end
	SaveResourceFile(GetCurrentResourceName(), "./server/SaveBproof2.json", json.encode(LoadBproof2, {indent=true}), -1)  
end)

function LoadJson2(_source)

	local xPlayer  = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof2.json") 
	LoadBproof2 = json.decode(loadFile)

	if #LoadBproof2 == 0 then 
		table.insert(LoadBproof2, {
	       users = identifier,
	       value = 100
		})
		insert2 = true
		TriggerClientEvent('mrw_utils:bproof2', _source, 100)
	end

	for i,v in ipairs(LoadBproof2) do
		local value = v.value
		if v.users == identifier then
			print(v.users == identifier)
			found2 = true 
			TriggerClientEvent('mrw_utils:bproof2', _source, v.value)	
		end
	end

	if not found2 and not insert2 then 
		print("not found", "not insert")
		table.insert(LoadBproof2, {
	       users = identifier,
	       value = 100
		})
		TriggerClientEvent('mrw_utils:bproof2', _source, 100)
	end

	SaveResourceFile(GetCurrentResourceName(), "./server/SaveBproof2.json", json.encode(LoadBproof2, {indent=true}), -1)    
end


RegisterServerEvent('mrw_utils:SaveBproof3')
AddEventHandler('mrw_utils:SaveBproof3', function(val)

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local id = xPlayer.identifier

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof3.json") 
	LoadBproof3 = json.decode(loadFile)

	for i,v in ipairs(LoadBproof3) do
		if v.users == id then
			print('found users', v.users == id)
			if tonumber(val) == 0 then 
				table.remove(LoadBproof3, i)
            else 
			    v.value = val
			end    
		end 
	end
	SaveResourceFile(GetCurrentResourceName(), "./server/SaveBproof3.json", json.encode(LoadBproof3, {indent=true}), -1)  
end)

function LoadJson3(_source)

	local xPlayer  = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof3.json") 
	LoadBproof3 = json.decode(loadFile)

	if #LoadBproof3 == 0 then 
		table.insert(LoadBproof3, {
	       users = identifier,
	       value = 100
		})
		insert3 = true
		TriggerClientEvent('mrw_utils:bproof3', _source, 100)
	end

	for i,v in ipairs(LoadBproof3) do
		local value = v.value
		if v.users == identifier then
			print(v.users == identifier)
			found3 = true 
			TriggerClientEvent('mrw_utils:bproof3', _source, v.value)	
		end
	end

	if not found3 and not insert3 then 
		print("not found", "not insert")
		table.insert(LoadBproof3, {
	       users = identifier,
	       value = 100
		})
		TriggerClientEvent('mrw_utils:bproof3', _source, 100)
	end

	SaveResourceFile(GetCurrentResourceName(), "./server/SaveBproof3.json", json.encode(LoadBproof3, {indent=true}), -1)    
end

