local PlayerData                = {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local JobBlips                = {}
local playerInService = false
ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	JobMenu = NativeUI.CreateMenu('Barbier','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    _menuPool:Add(JobMenu)

    GarageMenu = NativeUI.CreateMenu('Garage','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    _menuPool:Add(GarageMenu)

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
   ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
ESX.PlayerData.job = job
end)


--[[Citizen.CreateThread(function()

	WarMenu.CreateMenu('BarbierVestiaire', '~w~Last Dream')
    WarMenu.SetMenuBackgroundColor("BarbierVestiaire", 0, 0, 0, 200)
	WarMenu.SetTitleBackgroundColor("BarbierVestiaire", 3, 86, 241, 1000)
	WarMenu.SetSubTitle("BarbierVestiaire", "Vestiaire")

	while true do
		if WarMenu.IsMenuOpened('BarbierVestiaire') then
		
			if WarMenu.MenuButton('deposer sa tenue', 'BarbierVestiaire') then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
	
		    elseif WarMenu.MenuButton('Prendre sa tenue', 'BarbierVestiaire') then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
			end

			
			WarMenu.Display()	
		end
		Citizen.Wait(2)
	end		
end)]]


function AddJobMenu(menu)

	Utilsmenu = _menuPool:AddSubMenu(menu, 'Interaction','', 8, 200, nil, nil, nil, 255, 255, 255, 220)


    local Vestiaire = _menuPool:AddSubMenu(menu, 'Vestiaire','', 8, 200, nil, nil, nil, 255, 255, 255, 220)

    --local PrendreTenue = NativeUI.CreateItem('Prendre sa tenue', '')
   -- Vestiaire.SubMenu:AddItem(PrendreTenue)

    local PrendreService = NativeUI.CreateItem('Prendre son service','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    Vestiaire.SubMenu:AddItem(PrendreService)

    local stopService = NativeUI.CreateItem('Arreter son service','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    Vestiaire.SubMenu:AddItem(stopService)

   -- local DeposerTenue = NativeUI.CreateItem('Deposer sa tenues', '')
    --Vestiaire.SubMenu:AddItem(DeposerTenue)

    local DeposerObjet = NativeUI.CreateItem('Deposer un Objet','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    Utilsmenu.SubMenu:AddItem(DeposerObjet)

    local RetirerObjet = NativeUI.CreateItem('Retirer un Objet','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    Utilsmenu.SubMenu:AddItem(RetirerObjet)
    
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then 
	    ActionPatron = NativeUI.CreateItem('Action Patron','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
	    Utilsmenu.SubMenu:AddItem(ActionPatron)
	end 

	_menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
	_menuPool:WidthOffset(80)
	Vestiaire.SubMenu.OnItemSelect = function(sender, item, index)    
         

		if item == PrendreService then 
			if  Config.MaxInService ~= -1 then 
				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
			    	if not isInService then
						TriggerServerEvent("player:serviceOn", "barbier")
			            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
			              if not canTakeService then
			                ESX.ShowNotification('Trop de collègues en services', inServiceCount, maxInService)
			              else

			                serviceOk = true
			                playerInService = true

			                local notification = {
			                  title    = 'annonces services',
			                  subject  = '',
			                  msg      = 'prise de service', GetPlayerName(PlayerId()),
			                  iconType = 1
			                }
							TriggerServerEvent("player:serviceOn", "barbier")
			                TriggerServerEvent('esx_service:notifyAllInService', notification, 'barbier')
			                TriggerServerEvent('esx_service:ActivateService', 'barbier', 99)
			                TriggerServerEvent('esx_service:StartPayCheck', 'barbier', 'society_barbier')

			                ESX.ShowNotification('~g~Prise de service')
			              end
			            end, 'barbier')

			        else
			           serviceOk = true
			        end
		        end, 'barbier')
		    end    

	        while type(serviceOk) == 'string' do
	          Citizen.Wait(5)
	        end

	        -- if we couldn't enter service don't let the player get changed
	        if not serviceOk then
	          return
	        end
	    elseif item == stopService then 
	        if Config.MaxInService ~= -1 then

	            ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
		            if isInService then

		                playerInService = false

			            local notification = {
			               title    = 'annonces services',
			               subject  = '',
			               msg      = 'fin de service', GetPlayerName(PlayerId()),
			               iconType = 1
			            }

			            TriggerServerEvent('esx_service:notifyAllInService', notification, 'barbier')

			            TriggerServerEvent('esx_service:disableService', 'barbier')
						TriggerServerEvent("player:serviceOff", "barbier")
			            ESX.ShowNotification('~r~Fin de service')
		            end
	            end, 'barbier')
	        end  
	    end      
	end	

	Utilsmenu.SubMenu.OnItemSelect = function(sender, item, index)

	   if item == DeposerObjet then 
	   	  OpenInventaireMenu()
	   	  Utilsmenu.SubMenu:Visible(false)
	   	  Inventairemenu:Visible(true)
	   elseif item == RetirerObjet then
	      OpenCoffreMenu()
	      Utilsmenu.SubMenu:Visible(false)
	      Coffremenu:Visible(true) 
	    elseif item == ActionPatron then
	     _menuPool:CloseAllMenus()	
	     Wait(25)    	
	    	TriggerEvent('esx_society:openBossMenu1', 'barbier', function(data, menu)
	    	 end)
	   end	
    end
    _menuPool:RefreshIndex()
end	

function OpenInventaireMenu()

	Inventairemenu = NativeUI.CreateMenu('Inventaire','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    _menuPool:Add(Inventairemenu)

   local Inventaireutilsmenu = NativeUI.CreateMenu('Inventaire','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
   _menuPool:WidthOffset(80)
    _menuPool:Add(Inventaireutilsmenu)

    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
	_menuPool:WidthOffset(80)
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

		local deposer = NativeUI.CreateItem('Deposer','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
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
	                              TriggerServerEvent('mrw_barberjob:putStockItems', value, result)
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

function OpenCoffreMenu()


	Coffremenu = NativeUI.CreateMenu('Coffre','', 8, 200, nil, nil, nil, 255, 255, 255, 220)
    _menuPool:Add(Coffremenu)

	_menuPool:WidthOffset(80)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
     local coffre = {}
   	ESX.TriggerServerCallback('mrw_barberjob:getStockItems', function(items)

		

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
	                      TriggerServerEvent('mrw_barberjob:getStockItem', value, result)
	                      _menuPool:CloseAllMenus()
	                    else 
	                      ESX.ShowNotification('Montant invalide')
	                    end  
	                end    
		    	end
		    end
	    end
	end)	
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

--[[function OpenBarbierActionsMenu()

	local elements = {
        {label = 'Vestiaire', value = 'cloakroom'},
		{label = 'déposer un objet', value = 'put_stock'}
	}

	table.insert(elements, {label = 'Prendre un objet', value = 'get_stock'})
  
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then 
		table.insert(elements, {label = 'Action Patron', value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'barbier_actions_menu',
		{
			title    = 'Barbier',
			align    = 'top-left',
			elements = elements
		},
		
		function(data, menu)
			if data.current.value == 'cloakroom' then
				WarMenu.OpenMenu('BarbierVestiaire')
				Wait(15)
				ESX.UI.Menu.CloseAll()
			end

			if data.current.value == 'put_stock' then
				OpenPutStocksMenu()
			end

			if data.current.value == 'get_stock' then
				OpenGetStocksMenu()
			end

			if data.current.value == 'boss_actions' then
				TriggerEvent('esx_society:openBossMenu', 'barbier', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'barbier_actions_menu'
			CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~'
			CurrentActionData = {}

		end
	)
end
]]



function AddGarageMenu(menu)

    UtilsGarageMenu = _menuPool:AddSubMenu(menu, 'Garage','', 8, 200, nil, nil, nil, 255, 255, 255, 220)

    local Burrito = NativeUI.CreateItem('Véhicule de travail', 'Burrito')
    UtilsGarageMenu.SubMenu:AddItem(Burrito)
	_menuPool:WidthOffset(80)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)

    UtilsGarageMenu.SubMenu.OnItemSelect = function(menu, item)

       if item == Burrito then

   			local model = 'burrito3'
			local playerPed = GetPlayerPed(-1)
			local platenum = math.random(100, 900)
			local vehicle = GetVehiclePedIsIn(playerPed)

			if IsEntityAtCoord(GetPlayerPed(-1), Config.Job.VehicleSpawner.Pos.x, Config.Job.VehicleSpawner.Pos.y, Config.Job.VehicleSpawner.Pos.z, 1.5, 1.5, 1.5, 0, 1, 0) then

				if not IsAnyVehicleNearPoint(Config.Job.VehicleSpawnPoint.Pos.x, Config.Job.VehicleSpawnPoint.Pos.y, Config.Job.VehicleSpawnPoint.Pos.z, 5.0) then
			
					ESX.Game.SpawnVehicle(model, Config.Job.VehicleSpawnPoint.Pos, 300.47, function(vehicle)
						SetVehicleNumberPlateText(vehicle, "Barb" .. platenum)
						local playerPed = GetPlayerPed(-1)
						TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						local plate = GetVehicleNumberPlateText(vehicle)
						plate = string.gsub(plate, " ", "")
						TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
					end)

					_menuPool:CloseAllMenus()

				else
					exports.pNotify:SendNotification({ text = 'il y as deja un véhicule de sortie, patientez....', queue = "right", timeout = 1500, layout = "centerLeft" })
				end
			end	
        end
    end    
end	


AddEventHandler('mrw_barberjob:hasEnteredMarker', function(zone)

	print(zone)

	if zone == 'BarberActions' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'barbier' then
		CurrentAction     = 'barbier_actions_menu'
		CurrentActionMsg  = '~INPUT_CONTEXT~ pour ouvrir le menu'
		CurrentActionData = {}
	end
  
	if zone == 'VehicleSpawner' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'barbier' then
		CurrentAction     = 'vehicle_spawner_menu'
		CurrentActionMsg  = '~INPUT_CONTEXT~ pour ouvrir le garage'
		CurrentActionData = {}
	end

	if zone == 'VehicleDeleter' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'barbier' then

		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
		
		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 3.0 then

				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = '~INPUT_CONTEXT~ pour ranger votre véhicule'
				CurrentActionData = {vehicle = vehicle}

			end
		end
	end
end)

AddEventHandler('mrw_barberjob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()

	CurrentAction = nil
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Job.BarberActions.Pos.x, Config.Job.BarberActions.Pos.y, Config.Job.BarberActions.Pos.z)
	SetBlipSprite (blip, 71)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 51)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Barbier")
	EndTextCommandSetBlipName(blip)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Job) do
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'barbier' then
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'barbier' then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Job) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('mrw_barberjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('mrw_barberjob:hasExitedMarker', LastZone)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentAction ~= nil then

	        ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlPressed(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'barbier' then

				if CurrentAction == 'barbier_actions_menu' then
					  JobMenu:Clear()
					 ESX.PlayerData = ESX.GetPlayerData()
				    AddJobMenu(JobMenu)
				    JobMenu:Visible(true)
				end
				if CurrentAction == 'vehicle_spawner_menu' then
					AddGarageMenu(GarageMenu)
				    GarageMenu:Visible(true)
				end
				if CurrentAction == 'delete_vehicle' then

				    TriggerEvent('cyprom:etatVeh', function(cb) etat = cb end)
					if (etat == 'HS') then
						exports.pNotify:SendNotification({ text = 'Vous devez faire réparer votre véhicule', queue = "right", timeout = 1500, layout = "centerLeft" })
					else

						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
						TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
						
					end
				end

				CurrentAction = nil
			end
		end

	end
end)

