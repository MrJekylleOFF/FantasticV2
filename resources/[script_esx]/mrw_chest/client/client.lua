
-- Author: Morow
-- Github: https://github.com/Morow73
-- No Sale !!

local chestCoord, xChest, Try = {}, {}, {}
local Chest = false -- No Change 
local chest = 0     -- no Change 

local limitChar = 4 -- amount max mdp
local try = 3       -- limit try before blocked chest
local TimeUnblock = 2 * 60000 -- Timer for unblock chest


ESX = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    ESX.PlayerData = ESX.GetPlayerData()

	_menuPool = NativeUI.CreatePool()
	mainMenu = NativeUI.CreateMenu('Coffre', '')
	_menuPool:Add(mainMenu)

end)

function GetWeaponName(weapon)
	for k,v in pairs(ESX.GetWeaponList()) do
		if weapon == v.name then 
			return v.label
		end
	end
end
-- Menu 

function AddMenuCoffre(data, data2, x,y,z)

	CoffreMenu = NativeUI.CreateMenu('Coffre', '')
	_menuPool:Add(CoffreMenu)

    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)


	AddSubCoffre(data, data2, x,y,z)
	
	AddSubArmes(data, data2, x,y,z)

    AddSubInventaire(x,y,z)

    AddSubWeapon(x,y,z)


    _menuPool:RefreshIndex()
end

function AddSubCoffre(data, data2, x,y,z)

	InCoffre = _menuPool:AddSubMenu(CoffreMenu, 'Coffre Items')

	local utilsCoffre = NativeUI.CreateMenu('Coffre Items', '')
	_menuPool:Add(utilsCoffre)

	local listCoffre = {}

	_menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)


    if #data == 0 then 
    	local Nul = NativeUI.CreateItem('Aucun Item', '')
		InCoffre.SubMenu:AddItem(Nul)

    else 	

       	for k,v in pairs(data) do
		   items = v.items
		   table.insert(listCoffre, items)
		   listCoffre[items] = NativeUI.CreateItem(v.count..' : '..v.label, '')
		   InCoffre.SubMenu:AddItem(listCoffre[items])
	    end

	    local retirer = NativeUI.CreateItem('Retirer', '')
		utilsCoffre:AddItem(retirer)

	    InCoffre.SubMenu.OnItemSelect = function(sender, item, index)
			_menuPool:CloseAllMenus()
	--		utilsCoffre:Visible(true)
			for k,v in pairs(data) do
				local items  = v.items 
				local label  = v.label
				local count  = v.count
				if item == listCoffre[items] then

					--utilsCoffre.OnItemSelect = function(sender, item, index)
					--   if item == retirer then 
						   	local result = OpenKeyboardAmount()
			    	        if result ~= nil then 
				    	        if result <= count then	
								   TriggerServerEvent('mrw_chest:PickItems', items, result, x,y,z)
								   TriggerServerEvent('3dme:shareDisplay', "La personne prend " .. result .. 'x ' .. items)
	                               _menuPool:CloseAllMenus()
	                            else 
	                              ESX.ShowNotification('Montant invalide')
	                            end
                            end  
					  --  end	
			    --	end
				end	
			end
	    end
	end	
end

function AddSubArmes(data, data2, x,y,z)

	InArmes = _menuPool:AddSubMenu(CoffreMenu, 'Coffre Armes')


	local utilsCoffre2 = NativeUI.CreateMenu('Coffre Armes', '')
	_menuPool:Add(utilsCoffre2)

	local listCoffre2 = {}

	if #data2 == 0 then 
    	local Nul2 = NativeUI.CreateItem('Aucune Armes', '')
		InArmes.SubMenu:AddItem(Nul2)

    else 	

       	for k,v in pairs(data2) do
		   weapon = v.weapons
		   table.insert(listCoffre2, weapon)
		   listCoffre2[weapon] = NativeUI.CreateItem(v.count..' : '..GetWeaponName(weapon)..' : '..v.munition..' munitions', '')
		   InArmes.SubMenu:AddItem(listCoffre2[weapon])
	    end

			local retirerW = NativeUI.CreateItem('Retirer', '')
			utilsCoffre2:AddItem(retirerW)

		InArmes.SubMenu.OnItemSelect = function(sender, item, index)
		    _menuPool:CloseAllMenus()
		--	utilsCoffre2:Visible(true)
			for k,v in pairs(data2) do
				local weapon  = v.weapons 
				local count  = v.count
				local munition = v.munition
				if item == listCoffre2[weapon] then 
				--	utilsCoffre2.OnItemSelect = function(sender, item, index)
					--   if item == retirerW then 
						   	local mun = OpenKeyboardAmount2()
			    	        if mun ~= nil then 
				    	        if mun <= munition then	
								   TriggerServerEvent('mrw_chest:PickWeapons', weapon, 1, mun, x,y,z)
								   TriggerServerEvent('3dme:shareDisplay', "La personne prend un " .. GetWeaponName(weapon))
	                               _menuPool:CloseAllMenus()
	                            else 
	                              ESX.ShowNotification('Montant invalide')
	                            end
                            end  
					    --end	
			    	--end
				end	
			end
	    end
	end	
end	

function AddSubInventaire(x,y,z)
    
	InvMenu = _menuPool:AddSubMenu(CoffreMenu, 'Déposer Items')

	local UtilsMenu = NativeUI.CreateMenu('Déposer Items', '')
    _menuPool:Add(UtilsMenu)

	local Item = {}
	local Item2 = {}
	local Item3 = {}

	_menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)

	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].count > 0 then

			label = ESX.PlayerData.inventory[i].label
			value = ESX.PlayerData.inventory[i].name
			qtty  =  ESX.PlayerData.inventory[i].count

			table.insert(Item, value)

			Item[value] = NativeUI.CreateItem('~g~' ..qtty..' ~s~ '..label.. '', '')
			InvMenu.SubMenu:AddItem(Item[value])
		end	
	end

	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == 'money' then
			money = ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money)
			table.insert(Item2, money)
			Item2[money] = NativeUI.CreateItem('Argent : ~g~'..money, '')	
			InvMenu.SubMenu:AddItem(Item2[money])
		end
	end	

	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == 'black_money' then
			blackmoney = ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money)
		    table.insert(Item3, blackmoney)
			Item3[blackmoney] = NativeUI.CreateItem('Argent sale : ~r~'..blackmoney, '')
			InvMenu.SubMenu:AddItem(Item3[blackmoney])
		end
	end

	local deposer = NativeUI.CreateItem('Déposer', nil)
	UtilsMenu:AddItem(deposer)

	InvMenu.SubMenu.OnItemSelect = function(sender, item, index)
       	_menuPool:CloseAllMenus()
		--UtilsMenu:Visible(true)
		for i = 1, #ESX.PlayerData.inventory, 1 do

	    	local label = ESX.PlayerData.inventory[i].label
			local value = ESX.PlayerData.inventory[i].name
			local count = ESX.PlayerData.inventory[i].count

	    	if item == Item[value] then 

		    --	UtilsMenu.OnItemSelect = function(sender, item, index)

		    	  --  if item == deposer then
		    	        local result = OpenKeyboardAmount()
		    	        if result ~= nil then 
			    	        if result <= count then	
							  TriggerServerEvent('mrw_chest:StockItems', label, value, result, x,y,z)
							  TriggerServerEvent('3dme:shareDisplay', "La personne dépose " .. result .. 'x ' .. value)
                              _menuPool:CloseAllMenus()
                               CancelOnscreenKeyboard()
                            else 
                              ESX.ShowNotification('Montant invalide')
                            end
                        end      
		    	 --   end 
		      --  end 	  
		    end    
	    end
        if item == Item2[money] then  	
    	    local result = OpenKeyboardAmount()
    		if result ~= nil then 
    		   TriggerServerEvent('mrw_chest:StockItems', 'monnaie', 'money', result, x,y,z)
    		    _menuPool:CloseAllMenus()
    		    CancelOnscreenKeyboard()
    		end
    	end	
	    if item == Item3[blackmoney] then  
    	    local result = OpenKeyboardAmount()
    		if result ~= nil then
    		   TriggerServerEvent('mrw_chest:StockItems', 'argent sale', 'black_money', result, x,y,z)
    		    _menuPool:CloseAllMenus()
    		    CancelOnscreenKeyboard()
    		end 
    	end 
    end
end

function AddSubWeapon(x,y,z)

	WeapMenu = _menuPool:AddSubMenu(CoffreMenu, 'Déposer Armes')

	local UtilsWeapMenu = NativeUI.CreateMenu('Déposer Armes', '')
    _menuPool:Add(UtilsWeapMenu)

	local Item = {}

	_menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)

    for k,v in pairs(ESX.GetWeaponList()) do
    	if HasPedGotWeapon(PlayerPedId(), v.name, false) then 
    		name = v.name 
			table.insert(Item, name)
			
            Item[name] = NativeUI.CreateItem(''..v.label..' | '.. GetAmmoInPedWeapon(PlayerPedId(), name) .. ' Munitions', '')
			WeapMenu.SubMenu:AddItem(Item[name]) 
			
    	end
    end

    local deposer = NativeUI.CreateItem("Déposer", "Déposer une armes !")
    UtilsWeapMenu:AddItem(deposer)

    WeapMenu.SubMenu.OnItemSelect = function(sender, item, index)
       _menuPool:CloseAllMenus()
	--	UtilsWeapMenu:Visible(true)

		for k,v in pairs(ESX.GetWeaponList()) do
			local name = v.name 

			if item == Item[name] then 
			--	UtilsWeapMenu.OnItemSelect = function (sender, item, index)
				 --  if item == deposer then 
	    	        	local mun = OpenKeyboardAmount2()
	    	        	if mun ~= nil then 
		    	        	if mun <= GetAmmoInPedWeapon(PlayerPedId(), name) then
								TriggerServerEvent('mrw_chest:stockWeapons', name, mun, 1, x,y,z)
								TriggerServerEvent('3dme:shareDisplay', "La personne dépose un " .. GetWeaponName(name))
	                            _menuPool:CloseAllMenus()
	                        else 
	                        	ESX.ShowNotification('Vous ne disposez pas assez de munitions')
	                        end 
	                    end        
			--	   end
			--	end
			end
		end
    end
	-- body
end

function PlaceChest()

    local PlyCoord = GetEntityCoords(PlayerPedId())
    local h = GetEntityHeading(PlayerPedId())
    local x = PlyCoord.x + 1
    local y = PlyCoord.y
    local z = PlyCoord.z - 1
    local coord = vector3(x, y, z)

    ESX.Game.SpawnLocalObject('prop_ld_int_safe_01', coord, function(obj)
        Citizen.Wait(1)
         SetEntityHeading(obj, h)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)    
        table.insert(xChest, obj)
        chest = chest + 1 
	end)
	
	--if obj then 
        SpChest = true 
    --end    

    --if SpChest then 
        OpenKeyboardCode(x,y,z,h)
    --end    
end

function PlaceOwnerChest(x,y,z,h) -- Spawn All Chest 

    Citizen.Wait(50)
    local coord = vector3(x, y, z)
    ESX.Game.SpawnLocalObject('prop_ld_int_safe_01', coord, function(obj)
	--	print("OwnerObject")
	    Citizen.Wait(1)
	 	SetEntityHeading(obj, h)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)	
		table.insert(xChest, obj)
		chest = chest + 1 
	end)	
end

function OpenKeyboardCode(x,y,z,h)
	AddTextEntry('FMMC_MPM_NA', 'Entrer le code') 
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", limitChar)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
       Citizen.Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        result = GetOnscreenKeyboardResult()
        if result == nil then
           ESX.ShowNotification('~r~Entrer un mot de passe')
        else 
           TriggerServerEvent('mrw_chest:AddCode', x,y,z, h, result) 
        end     
    end 
end

function OpenKeyboardCode2(x,y,z)
	AddTextEntry('FMMC_MPM_NA', 'Entrer le code') 
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", limitChar)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
       Citizen.Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        result = GetOnscreenKeyboardResult()
        if result == nil then
           ESX.ShowNotification('~r~Entrer un mot de passe')
        else 
           TriggerServerEvent('mrw_chest:CheckCode', x,y,z, result) 
        end     
    end 
end

function OpenKeyboardAmount()
	AddTextEntry('FMMC_MPM_NA', 'Entrer un nombre d\'item') 
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
       Citizen.Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = tonumber(GetOnscreenKeyboardResult())
        if tonumber(result) == nil  or tonumber(result) == 0 or tonumber(result) == -1 then
           ESX.ShowNotification('~r~Montant invalide !')
        else 
           CancelOnscreenKeyboard()
           return tonumber(result)
        end     
    end 
end

function OpenKeyboardAmount2()
	AddTextEntry('FMMC_MPM_NA', 'Entrer un nombre de munition') --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
       Citizen.Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        result = GetOnscreenKeyboardResult()
        if tonumber(result) == nil  or tonumber(result) == -1 then
           ESX.ShowNotification('~r~Montant invalide !')
        else 
           return tonumber(result)
        end     
    end 
end

AddEventHandler('onClientResourceStart', function (resourceName) -- if resource start Load All Chest
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
  TriggerServerEvent('mrw_chest:LoadChest')  
end)

AddEventHandler('onResourceStop', function(resource) -- if resource stop delete All Chest
	if resource == GetCurrentResourceName() then
		for k,v in pairs(xChest) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

RegisterNetEvent('mrw_chest:SpawnChest')
AddEventHandler('mrw_chest:SpawnChest', function()
   PlaceChest()
end)

RegisterNetEvent('mrw_chest:AddChestTable')
AddEventHandler('mrw_chest:AddChestTable', function(x,y,z,h)
    table.insert(chestCoord, {
   	    x = x,
        y = y,
        z = z,
        h = h
    })
    Chest = true 
end)

RegisterNetEvent('mrw_chest:SpawnOwnerChest')
AddEventHandler('mrw_chest:SpawnOwnerChest', function(x,y,z,h)   
    table.insert(chestCoord, {
   	    x = x,
        y = y,
        z = z,
        h = h
    })
    PlaceOwnerChest(x,y,z,h)
    Chest = true  
end)



RegisterNetEvent('mrw_chest:NotifCode')
AddEventHandler('mrw_chest:NotifCode', function(valide, data, data2, x,y,z)
    if valide == true then 
    	-- open menu coffre (data)
    	print(#data2)

		ESX.ShowNotification('~g~ Code correct !')
		TriggerServerEvent('3dme:shareDisplay', "La personne a trouver le code")
    	mainMenu:Clear()
    	ESX.PlayerData = ESX.GetPlayerData()
    	AddMenuCoffre(data, data2, x,y,z)
    	CoffreMenu:Visible(true)
    else  
		ESX.ShowNotification('~r~ Code incorrect !')
		TriggerServerEvent('3dme:shareDisplay', "La personne n'a pas trouver le code")
   	    table.insert(Try, try)
   	    try = try + 1
    end	
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(55)

		local coords = GetEntityCoords(PlayerPedId())
		local object = GetHashKey('prop_ld_int_safe_01')
		if Chest then
			for k,v in pairs(chestCoord) do 
				local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, true)
				if distance < 2.8 and object ~= nil then 
					ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour acceder au coffre')
					if IsControlPressed(0, 38) then 
						TriggerServerEvent('3dme:shareDisplay', "La personne tape un code")
						if #Try >= 3 then 
							ESX.ShowNotification('~r~ Vous avez saisit trop d\'essais invalide le coffre est bloqué')
							Citizen.Wait(TimeUnblock)
							table.remove(Try, 1, 2, 3)
						else
							local x,y,z,h = v.x,v.y,v.z
							OpenKeyboardCode2(x,y,z)
						end	
					end	
				end	
			end	
		end	
	end	
end)

Citizen.CreateThread(function()
	while true do
		if _menuPool ~= nil then
			_menuPool:ProcessMenus()
		end		
		Citizen.Wait(0)
	end
end)
