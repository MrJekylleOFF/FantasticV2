
ESX = nil
local PlayerData                = {}
local CurrentAction             = nil
local CurrentActionData         = {}
acheter = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	SpawnPed()

	_menuPool = NativeUI.CreatePool()
	mainMenu = NativeUI.CreateMenu("Achat Parcelle","", 8, 200,"","", nil,100,0,0,255)
	_menuPool:Add(mainMenu)

	Inventairemenu = NativeUI.CreateMenu("Coffre","", 8, 200,"","", nil,100,0,0,255)
   _menuPool:Add(Inventairemenu)

   _menuPool:RefreshIndex()
   _menuPool:MouseEdgeEnabled (false);
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	BlipJob()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
   ESX.PlayerData.job = job
   BlipJob()
end)

function SpawnPed()

    local modelHash = GetHashKey('a_m_m_farmer_01')
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    local SpawnedPed = CreatePed(2, modelHash, 2243.5197, 5154.311, 56.89, 150.34, false, true)
    TaskSetBlockingOfNonTemporaryEvents(SpawnedPed, true)
    Citizen.Wait(1)

    SetEntityInvincible(SpawnedPed, true)
    PlaceObjectOnGroundProperly(SpawnedPed)
    SetModelAsNoLongerNeeded(modelHash)
    Citizen.CreateThread(function()
        local x_ped = SpawnedPed
        Citizen.Wait(1000)
        FreezeEntityPosition(x_ped, true)
    end)  
end    

function DrawSub(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
end

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(1)

        local distance = GetDistanceBetweenCoords(2243.5197, 5154.311, 56.89, GetEntityCoords(GetPlayerPed(-1))) 

		if distance <= 3.0 then
			
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour parler à Bill l\'agriculteur')

		    if IsControlPressed(0, 38) then 
				DrawSub('Salut l\'ami tu veux acheter ou vendre un terrain !?', 9000)  
				mainMenu:Clear()
			    ESX.PlayerData = ESX.GetPlayerData()
				AddParcelleMenu(mainMenu)
				mainMenu:Visible(true)  
		    end  
		end	
		
    end
end)

local Achat = {
	'Parcelle 1',
	'Parcelle 2',
	'Parcelle 3',
	'Parcelle 4',
	'Parcelle 5',
	'Parcelle 6',
	'Parcelle 7',
	'Parcelle 8'
}



function AddParcelleMenu(menu)	   	

    local AchatSelect = NativeUI.CreateListItem("Acheter une parcelle", Achat, 1,"Voulez vous achetez une parcelle ? (5000$)")
    menu:AddItem(AchatSelect)

    local Vendre = NativeUI.CreateItem("Vendre votre parcelle","Voulez vous vendre votre parcelle ?")
    Vendre:RightLabel("~g~2500$")
    menu:AddItem(Vendre)


    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur' then
		Achetergraine = NativeUI.CreateItem("Acheter une graine de blé", "Voulez vous acheter une graine de blé pour 10$?")
		Achetergraine:RightLabel("~g~10$")
		menu:AddItem(Achetergraine)

		Achetertruelle = NativeUI.CreateItem("Acheter une truelle", "Voulez vous acheter une truelle pour 150$?")
		Achetertruelle:RightLabel("~g~150$")
	    menu:AddItem(Achetertruelle)
	end  
    
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:WidthOffset(75)

    local PlayerPed = GetPlayerPed(-1)  

    menu.OnListSelect = function(mainMenu, item, index)

        id = index
		if item == AchatSelect then 
			if ESX.Game.IsSpawnPointClear({x = 2238.95, y = 5142.92, z =55.6}, 5.0) then
		   		TriggerServerEvent('mrw_agriculture:BuyParcelle', id, PlayerPed)  
		   		acheter = true
			else
			ESX.ShowNotification('Un véhicule bloque, veuillez le déplacer pour pouvoir acheter une parcelle !')
			end
		   _menuPool:CloseAllMenus()
		end 
	end

	menu.OnItemSelect = function(mainMenu, item)

		if item == Vendre then
			TriggerServerEvent('mrw_agriculture:VendreParcelle', PlayerPed)	
			acheter = false
		elseif item == Achetergraine then 
			TriggerServerEvent('mrw_agriculture:buygraine')
			ESX.ShowHelpNotification('~g~Vous avez acheté 1 graine pour 10$')
		elseif item == Achetertruelle then 
			TriggerServerEvent('mrw_agriculture:buytruelle')
			ESX.ShowHelpNotification('~g~Vous avez acheté 1 truelle pour 150$')
		end	 

	    local owner = PlayerPedId()

        
        --[[if item == DeposerCoffre then 	

        	OpenInventaireMenu(owner) 
        	mainMenu:Visible(false)		    
	    	Inventairemenu:Visible(true) 	
	    end	 
       
	    if item == RecupCoffre then 	
	    	OpenCoffreMenu()
	    	mainMenu:Visible(false)
	    	Coffremenu:Visible(true)	
	    end	  --]]
    end  
end

--[[function OpenInventaireMenu(owner)

	Inventairemenu = NativeUI.CreateMenu('Inventaire', '')
    _menuPool:Add(Inventairemenu)

   local Inventaireutilsmenu = NativeUI.CreateMenu('Inventaire', '')
    _menuPool:Add(Inventaireutilsmenu)

    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)

    local Item = {}

	--ESX.TriggerServerCallback('mrw_barberjob:getPlayerInventory', function(inventory)


		for i = 1, #ESX.PlayerData.inventory, 1 do
			if ESX.PlayerData.inventory[i].count > 0 then

				local label = ESX.PlayerData.inventory[i].label
				local value = ESX.PlayerData.inventory[i].name
				local qtty  =  ESX.PlayerData.inventory[i].count

				table.insert(Item, value)

				Item[value] = NativeUI.CreateItem('~g~' ..qtty..' ~s~ '..label.. '','')
				Inventairemenu:AddItem(Item[value])
			end	
		end

		local deposer = NativeUI.CreateItem('Deposer', '')
		Inventaireutilsmenu:AddItem(deposer)

		Inventairemenu.OnItemSelect = function(sender, item, index)
			_menuPool:CloseAllMenus(true)
			Inventaireutilsmenu:Visible(true)
		    for i = 1, #ESX.PlayerData.inventory, 1 do

		    	local label = ESX.PlayerData.inventory[i].label
				local value = ESX.PlayerData.inventory[i].name
				local count  =  ESX.PlayerData.inventory[i].count

		    	if item == Item[value] then 

			    	Inventaireutilsmenu.OnItemSelect = function(sender, item, index)

			    	    if item == deposer then
			    	        local result = OpenKeyboard()
			    	        if result ~= nil then 
				    	        if result <= count  then	
				    	        	print(result)
	                             -- TriggerServerEvent('mrw_agriculture:putStockItems', value, result)
	                                TriggerServerEvent('mrw_agriculture:putItem', owner, 'item_standard', value, result)
	                              _menuPool:CloseAllMenus()
	                            else 
	                              ESX.ShowNotification('Montant invalide')
	                            end
	                        end      
			    	    end 
			        end
			    end    
		    end
	    end
	--end)	
end	

function OpenCoffreMenu(owner)


	Coffremenu = NativeUI.CreateMenu('Coffre', '')
    _menuPool:Add(Coffremenu)


    	_menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
     local coffre = {}
   	ESX.TriggerServerCallback('mrw_agriculture:getParcelleInventory', function(items)

		

		for i=1, #items, 1 do
			if (items[i].count ~= 0) then

				local label = items[i].label
				local count = items[i].count
			    local value = items[i].name
		

			    table.insert(coffre, value)

			    coffre[value] = NativeUI.CreateItem(count..' : '..label, '')
			    Coffremenu:AddItem(coffre[value])
			end
		end

		Coffremenu.OnItemSelect = function(sender, item, index)

		    for i=1,#items,1 do
		    	local label = items[i].label
		    	local count = items[i].count
		    	local value = items[i].name

		    	if item == coffre[value] then 
		    		print('test')

                    local result = OpenKeyboard()
                    if result ~= nil then
		    	         if result <= count then		
	                      --TriggerServerEvent('mrw_agriculture:getStockItem', value, result)
	                      TriggerServerEvent('mrw_agriculture:getItem', owner, 'item_standard', value, result)
	                      _menuPool:CloseAllMenus()
	                    else 
	                      ESX.ShowNotification('Montant invalide')
	                    end  
	                end    
		    	end
		    end
	    end
	end, owner)	
end

function OpenKeyboard()
  -- TextEntry    --> The Text above the typing field in the black square
  -- ExampleText    --> An Example Text, what it should say in the typing field
  -- MaxStringLenght  --> Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', 'Entrer un montant') --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 50) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
	   Citizen.Wait(0)
    end
    
    if UpdateOnscreenKeyboard() ~= 2 then
	    local result = GetOnscreenKeyboardResult() --Gets the result of the typing
	    Citizen.Wait(250) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
	    blockinput = false --This unblocks new Input when typing is done
	    if tonumber(result) == nil or tonumber(result) == 0 or tonumber(result) == -1 then 
	       ESX.ShowNotification('~r~ montant invalide merci d\'entrer un nombre')
	    else	
	       return tonumber(result) --Returns the result
	    end
	else
	   Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
	   blockinput = false --This unblocks new Input when typing is done
	   return nil --Returns nil if the typing got aborted
    end
end
--]]



function CreateBlipRoute(id)
    if id == 1 then 
		blip = AddBlipForCoord(2504.09, 4866.18, 37.54)
		SetBlipRoute(blip, true)
		SetBlipRouteColour(blip, 1)
		SetBlipSprite(blip, 89)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 64)
		AddTextComponentString("Parcelle 1")
		EndTextCommandSetBlipName(blip)

		if GetDistanceBetweenCoords(2504.09, 4866.18, 37.54, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip)
		end	
	elseif id == 2 then 	
		blip2 = AddBlipForCoord(2495.61, 4857.0475, 37.33)
		SetBlipRoute(blip2, true)
		SetBlipRouteColour(blip2, 1)
		SetBlipSprite(blip2, 89)
		SetBlipScale(blip2, 0.7)
		SetBlipColour(blip2, 64)
		AddTextComponentString("Parcelle 2")
		EndTextCommandSetBlipName(blip2)
		if GetDistanceBetweenCoords(2495.61, 4857.0475, 37.33, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip2)
		end	
    elseif id == 3 then 	
		blip3 = AddBlipForCoord(2485.8925, 4847.057, 36.64)
		SetBlipRoute(blip3, true)
		SetBlipRouteColour(blip3, 1)
		SetBlipSprite(blip3, 89)
		SetBlipScale(blip3, 0.7)
		SetBlipColour(blip3, 64)
		AddTextComponentString("Parcelle 3")
		EndTextCommandSetBlipName(blip3)
		if GetDistanceBetweenCoords(2485.8925, 4847.057, 36.64, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip3)
		end	
	elseif id == 4 then 	
		blip4 = AddBlipForCoord(2476.73125, 4834.05 , 35.86)
		SetBlipRoute(blip4, true)
		SetBlipRouteColour(blip4, 1)
		SetBlipSprite(blip4, 89)
		SetBlipScale(blip4, 0.7)
		SetBlipColour(blip4, 64)
		AddTextComponentString("Parcelle 4")
		EndTextCommandSetBlipName(blip4)
		if GetDistanceBetweenCoords(2476.73125, 4834.05 , 35.86, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip4)
		end	
	elseif id == 5 then 	
		blip5 = AddBlipForCoord(2520.23, 4830.1875, 35.68)
		SetBlipRoute(blip5, true)
		SetBlipRouteColour(blip5, 1)
		SetBlipSprite(blip5, 89)
		SetBlipScale(blip5, 0.7)
		SetBlipColour(blip5, 64)
		AddTextComponentString("Parcelle 5")
		EndTextCommandSetBlipName(blip5)
		if GetDistanceBetweenCoords(2520.23, 4830.1875, 35.68, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip5)
		end	
	elseif id == 6 then 	
		blip6 = AddBlipForCoord(2531.6325, 4818.747, 35.08)
		SetBlipRoute(blip6, true)
		SetBlipRouteColour(blip6, 1)
		SetBlipSprite(blip6, 89)
		SetBlipScale(blip6, 0.7)
		SetBlipColour(blip6, 64)
		AddTextComponentString("Parcelle 6")
		EndTextCommandSetBlipName(blip6)
		if GetDistanceBetweenCoords(2485.8925, 4847.057, 36.64, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip6)
		end	
	elseif id == 7 then 	
		blip7 = AddBlipForCoord(2545.3125, 4806.17, 34.79)
		SetBlipRoute(blip7, true)
		SetBlipRouteColour(blip7, 1)
		SetBlipSprite(blip7, 89)
		SetBlipScale(blip7, 0.7)
		SetBlipColour(blip7, 64)
		AddTextComponentString("Parcelle 7")
		EndTextCommandSetBlipName(blip7)
		if GetDistanceBetweenCoords(2545.3125, 4806.17, 34.79, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip7)
		end	
	elseif id == 8 then 	
		blip8 = AddBlipForCoord(2560.226, 4789.65, 34.006)
		SetBlipRoute(blip8, true)
		SetBlipRouteColour(blip8, 1)
		SetBlipSprite(blip8, 89)
		SetBlipScale(blip8, 0.7)
		SetBlipColour(blip8, 64)
		AddTextComponentString("Parcelle 8")
		EndTextCommandSetBlipName(blip8)
		if GetDistanceBetweenCoords(560.226, 4789.65, 34.006, GetEntityCoords(GetPlayerPed(-1))) <=2.0 then
			RemoveBlip(blip8)
		end	
	end	
end

Citizen.CreateThread(function()
	while true do
		if _menuPool ~= nil then
			_menuPool:ProcessMenus()
		end		
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('mrw_agriculture:StopMenu')
AddEventHandler('mrw_agriculture:StopMenu', function(id)
	_menuPool:CloseAllMenus()
	CreateBlipRoute(id)
	if acheter then
	ESX.Game.SpawnVehicle('tractor2', {x = 2238.95, y = 5142.92, z = 55.6}, 228.96, function(vehicle)
		SetVehicleNumberPlateText(vehicle, "AGRI"..math.random(1000,1999))
	end)  
	end
end)

local CheckId = false

RegisterNetEvent('mrw_agriculture:CheckId')
AddEventHandler('mrw_agriculture:CheckId', function()

	CheckId = true

	Citizen.CreateThread(function()

		TriggerEvent("izone:isPlayerInZone", "parcelle1", function(isIn)
			if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 1)
            end
        end)
        TriggerEvent("izone:isPlayerInZone", "parcelle2", function(isIn)
            if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 2)
            end
        end)
        TriggerEvent("izone:isPlayerInZone", "parcelle3", function(isIn)
            if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 3)
            end
		end)
		TriggerEvent("izone:isPlayerInZone", "parcelle4", function(isIn)
            if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 4)
            end
		end)
		TriggerEvent("izone:isPlayerInZone", "parcelle5", function(isIn)
            if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 5)
            end
		end)
		TriggerEvent("izone:isPlayerInZone", "parcelle6", function(isIn)
            if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 6)
            end
		end)
		TriggerEvent("izone:isPlayerInZone", "parcelle7", function(isIn)
            if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 7)
            end
		end)
		TriggerEvent("izone:isPlayerInZone", "parcelle8", function(isIn)
            if isIn == true and CheckId then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 8)
            end
		end)
        CheckId = false
	end)
end)
