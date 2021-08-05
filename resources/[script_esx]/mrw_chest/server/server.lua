ESX = nil

local AddChest = false
local AddWeapon = false

local AddInv = false
local AddWeap = false

TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

ESX.RegisterUsableItem('chest', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

    TriggerClientEvent('mrw_chest:SpawnChest', _source)
    xPlayer.removeInventoryItem('chest', 1)
end)

RegisterServerEvent('mrw_chest:AddCode')
AddEventHandler('mrw_chest:AddCode', function(x,y,z, h, result)
	local x_source = source

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveChest.json") 
	SaveChest = json.decode(loadFile)

    table.insert(SaveChest, {
   	   ['Coords'] = {x = x, y = y, z = z, h = h},
   	   code = result,
   	   inventaire = {},
   	   weapon = {}
    })

    SaveResourceFile(GetCurrentResourceName(), "./server/SaveChest.json", json.encode(SaveChest, {indent=true}), -1) 

    for i,v in ipairs(SaveChest) do
    	if (v.Coords.x ~= nil and v.Coords.y ~= nil and v.Coords.z ~= nil and v.Coords.h ~= nil) then
	    	   x = v.Coords.x
	    	   y = v.Coords.y
	    	   z = v.Coords.z
	    	   h = v.Coords.h

	    	TriggerClientEvent('mrw_chest:AddChestTable', x_source, x,y,z,h)
	    	TriggerClientEvent('esx:showNotification', x_source, 'Merci de ~r~deco/reco~w~ pour acceder au coffre !.')
	    end	
    end
end)

RegisterServerEvent('mrw_chest:CheckCode')
AddEventHandler('mrw_chest:CheckCode', function(x,y,z, result)
	local x_source = source

    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveChest.json") 
	SaveChest = json.decode(loadFile)

--    print(result)
    inv = {}
     weap = {}

	for i,v in ipairs(SaveChest) do
		if (x == v.Coords.x and y == v.Coords.y and z == v.Coords.z) then
			print('Code du coffre :'..v.code)
			print('Code entré par le demandeur :'..result)
			if result == v.code then 
				print('Code ok !')
				if #v.inventaire ~= 0 then 
					for x,k in ipairs(v.inventaire) do
						table.insert(inv, {
							items = k.items,
							label = k.label,
							count = k.count
						})
					end
					invEmpty = false		
				else 
					inventaire = v.inventaire
					invEmpty = true  	
				end	

				if #v.weapon ~= 0 then
				 
				  for i2,v2 in ipairs(v.weapon) do
				   	table.insert(weap, {
				   		weapons = v2.weapon,
				   		count = v2.count,
				   		munition = v2.munition
					   })
				  end 
				  weapEmpty = false 
				else 
				  weaponT = v.weapon	
				  weapEmpty = true  
				end

				if not invEmpty then 
					inv = inv
				else 
				    inv = inventaire 	
				end
				
				if not weapEmpty then 
					weap = weap 
				else 
				    weap = weaponT 	
				end	

				TriggerClientEvent('mrw_chest:NotifCode', x_source, true, inv, weap, x,y,z)
			else 
				TriggerClientEvent('mrw_chest:NotifCode', x_source, false, nil, nil, nil)
			end
		end	
	end


end)


RegisterServerEvent('mrw_chest:LoadChest')
AddEventHandler('mrw_chest:LoadChest', function()
	local x_source = source

    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveChest.json") 
	SaveChest = json.decode(loadFile)

	for i,v in ipairs(SaveChest) do
		if (v.Coords.x ~= nil and v.Coords.y ~= nil and v.Coords.z ~= nil and v.Coords.h ~= nil) then		    
    	    x = v.Coords.x
    	    y = v.Coords.y
    	    z = v.Coords.z
    	    h = v.Coords.h
	    	TriggerClientEvent('mrw_chest:SpawnOwnerChest', x_source, x,y,z,h)
		end 
	end
end)

RegisterServerEvent('mrw_chest:StockItems')
AddEventHandler('mrw_chest:StockItems', function(label, items, result, x,y,z)

	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveChest.json") 
	SaveChest = json.decode(loadFile)

	local found = false 

	if items == 'black_money' then 
		if xPlayer.getAccount('black_money').money < result then 
            xPlayer.showNotification("Montant invalide")
            return
		end
	elseif item == 'money' then 
	    if xPlayer.getMoney() < result then
	        xPlayer.showNotification("Montant invalide")
            return 
	    end	
	end

    for i,v in ipairs(SaveChest) do 
		if (x == v.Coords.x and y == v.Coords.y and z == v.Coords.z) then
			if #v.inventaire == 0 then -- is table is empty
				if result >= 1 then 				
					table.insert(v.inventaire, {
						items = items,
						label = label,
						count = result  
					})
					AddChest = true
					found = true
				end	
			else 
				inventaire = v.inventaire
			    insert = true 	
			end
		end	
	end	

	if insert then 
		for x,k in ipairs(inventaire) do
			if result >= 1 then 
				if k.items == items then  -- item found add count 
					print('found')
			      	local TotalCount = result + k.count 
					k.items  = items
					k.label = label
					k.count  = TotalCount
				    AddChest = true	
				    found = true  				  
				end							  	
			else
			   print('[mrw_chest] Le joueur :'..xPlayer.identifier..' tente d\' ajouter une valeur négative')	
			end	
		end
	end

	if not found and #inventaire ~= 0 then -- is table is not empty and item not found in inventory
		print('not found')
		table.insert(inventaire, {
			items = items,
			label = label,
			count = result  
		})
		AddChest = true 
	end	



    if AddChest then 
    	if items == 'black_money' then 
    		print('remove', items)
    		xPlayer.removeAccountMoney('black_money', result)
    	elseif items == 'money' then 
    		print('remove', items)
    	    xPlayer.removeMoney(result)
    	else     	
    	    xPlayer.removeInventoryItem(items, result)
    	end    
    end	

	SaveResourceFile(GetCurrentResourceName(), "./server/SaveChest.json", json.encode(SaveChest, {indent=true}), -1) 
end)

RegisterServerEvent('mrw_chest:PickItems')
AddEventHandler('mrw_chest:PickItems', function(items, result, x,y,z)

	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveChest.json") 
	SaveChest = json.decode(loadFile)

	if items ~= 'black_money' and items ~= 'money' then
	    if not xPlayer.canCarryItem(items, result) then 
	     	xPlayer.showNotification('Vous portez trop sur vous !')
	     	return
	    end
	end 

	for i,v in pairs(SaveChest) do
		if (x == v.Coords.x and y == v.Coords.y and z == v.Coords.z) then 
			for m,n in pairs(v.inventaire) do
				if items == n.items then 
				    local TotalCount = n.count - result
					if result <= n.count then
						if n.count <= 1 or TotalCount <= 0 then 
							print('remove total')
							table.remove(v.inventaire, m)
							AddInv = true 
						else 
							n.items = items 
							n.count = TotalCount
							AddInv = true   
						end	
						
					else 
					   print('[mrw_chest] Le joueur :'..xPlayer.identifier..' tente de retirer une valeur négative')	
					end	
				end	
			end
		end	
	end

	if AddInv then 
		if items == 'black_money' then 
			xPlayer.addAccountMoney('black_money', result)
		elseif items == 'money' then 
			xPlayer.addMoney(result)
		else 	
		    xPlayer.addInventoryItem(items, result)
		end
	end	 

	SaveResourceFile(GetCurrentResourceName(), "./server/SaveChest.json", json.encode(SaveChest, {indent=true}), -1) 
end)	

RegisterServerEvent('mrw_chest:stockWeapons')
AddEventHandler('mrw_chest:stockWeapons', function(weaponName, mun, result, x,y,z)
    local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveChest.json") 
	SaveChest = json.decode(loadFile)

	local found = false

	for i,v in ipairs(SaveChest) do
		if (x == v.Coords.x and y == v.Coords.y and z == v.Coords.z) then
			weapons = v.weapon
			if #weapons == 0 then -- is table is empty
				if result >= 1 then 				
					table.insert(weapons, {
						weapon = weaponName,
						count = result,
						munition = mun  
					})
					AddWeapon = true
					found = true
				end	
			else 
				insert = true 	
			end
		end	
	end	
	if insert then 
		for v,k in ipairs(weapons) do
			
			if result >= 1 then 
				if k.weapon == weaponName then  -- item found add count 
					print('found')
			      	local TotalCount = result + k.count 
			      	local TotalMunition = mun + k.munition
					k.weapon  = weaponName
					k.count  = TotalCount
					k.munition = TotalMunition
				    AddWeapon = true	
				    found = true  				  
				end							  	
			else
			   print('[mrw_chest] Le joueur :'..xPlayer.identifier..' tente d\' ajouter une valeur négative')	
			end	
		end
	end

	if not found and #weapons ~= 0 then -- is table is not empty and item not found in inventory
		print('not found')
		table.insert(weapons, {
			weapon = weaponName,
			count = result,
			munition = mun  
		})
		AddWeapon = true 
	end	

	if AddWeapon then 
		xPlayer.removeWeaponAmmo(weaponName, mun)
		xPlayer.removeWeapon(weaponName)
	end

   SaveResourceFile(GetCurrentResourceName(), "./server/SaveChest.json", json.encode(SaveChest, {indent=true}), -1) 
end)

RegisterServerEvent('mrw_chest:PickWeapons')
AddEventHandler('mrw_chest:PickWeapons', function(weapons, result, mun, x,y,z)

	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveChest.json") 
	SaveChest = json.decode(loadFile)

	for i,v in pairs(SaveChest) do
		if (x == v.Coords.x and y == v.Coords.y and z == v.Coords.z) then 
			for m,n in pairs(v.weapon) do
				if weapons == n.weapon then 
				    local TotalCount = n.count - result
				    local TotalMunition = n.munition - mun
					if result <= n.count then
						if n.count <= 1 or TotalCount <= 0 then 
							print('remove total')
							table.remove(v.weapon, m)
							AddWeap = true 
						else 
							n.weapon = weapons 
							n.count = TotalCount
							n.munition = TotalMunition
							AddWeap = true   
						end	
						
					else 
					   print('[mrw_chest] Le joueur :'..xPlayer.identifier..' tente de retirer une valeur négative')	
					end	
				end	
			end
		end	
	end

	if AddWeap then 
		xPlayer.addWeapon(weapons, mun)
	end	 
   
	SaveResourceFile(GetCurrentResourceName(), "./server/SaveChest.json", json.encode(SaveChest, {indent=true}), -1) 
end)