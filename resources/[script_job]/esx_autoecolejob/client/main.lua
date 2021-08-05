local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local JobBlips                = {}
local publicBlip = false
ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function Notification(text)
	SetNotificationTextEntry('String')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function TeleportFadeEffect(entity, coords)

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)

	end)
end

function AutoEcole()
	Citizen.CreateThread(function()
    while messagenotfinish do
    		Citizen.Wait(10)

			AddTextEntry('FMMC_MPM_NA', "Message de l'annonce")
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 44)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(10)
		    end
		    if (GetOnscreenKeyboardResult()) then
				local result = GetOnscreenKeyboardResult()
				messagenotfinish = false
				TriggerServerEvent('esx_autoecolejob:autoecole',result)   
		    end
		end
	end)
end

function OpenActionMenu()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			css = 'autoecole',
			title    = _U('cloakroom'),
			align    = 'top-left',
			elements = {
				{label = _U('clothes_civil'), value = 'citizen_wear'},
				{label = _U('clothes_vine'), value = 'work_wear'},
			},
		},
		function(data, menu)
 
			menu.close()

			if data.current.value == 'citizen_wear' then
				TriggerServerEvent("player:serviceOff", "auto")
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if data.current.value == 'work_wear' then
				TriggerServerEvent("player:serviceOn", "auto")
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
			end

			CurrentAction     = 'actions_menu'
			CurrentActionMsg  = _U('open_menu')
			CurrentActionData = {}
		end,
		function(data, menu)
			menu.close()
		end
	)

end

function OpenActionsMenu()

	local elements = {
		{label = _U('deposit_stock'), value = 'put_stock'},
	}

	if Config.EnablePlayerManagement and PlayerData.job ~= nil and (PlayerData.job.grade_name ~= 'recrue' and PlayerData.job.grade_name ~= 'novice') then
		table.insert(elements, {label = _U('take_stock'), value = 'get_stock'})
	end
  
	if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'actions',
		{
			css = 'autoecole',
			title    = 'Auto Ecole',
			align    = 'top-left',
			elements = elements
		},
		
		function(data, menu)
			if data.current.value == 'put_stock' then
				OpenPutStocksMenu()
			end

			if data.current.value == 'get_stock' then
				OpenGetStocksMenu()
			end

			if data.current.value == 'boss_actions' then
				TriggerEvent('esx_society:openBossMenu1', 'autoecole', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'actions_menu'
			CurrentActionMsg  = _U('press_to_open')
			CurrentActionData = {}

		end
	)
end

function OpenVehicleSpawnerAirMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			for i=1, #vehicles, 1 do
				table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
			end

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'vehicle_spawner',
				{
					css = 'autoecole',
					title    = _U('veh_menu'),
					align    = 'top-left',
					elements = elements,
				},
				function(data, menu)

					menu.close()

					local vehicleProps = data.current.value
					local platenum = math.random(100, 900)
					local vehicle = GetVehiclePedIsIn(playerPed)

					ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnerAir.Pos, 198.0, function(vehicle)
						ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
						local playerPed = GetPlayerPed(-1)
						--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						local plate = GetVehicleNumberPlateText(vehicle)
              			plate = string.gsub(plate, " ", "")
						TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
					end)

					TriggerServerEvent('esx_society:removeVehicleFromGarage', 'autoecole', vehicleProps)

				end,
				function(data, menu)

					menu.close()

					CurrentAction     = 'vehicle_spawner_boat_menu'
					CurrentActionMsg  = _U('spawn_veh')
					CurrentActionData = {}

				end
			)

		end, 'autoecole')

	else
	
		local elements = {
			{label = 'Mammatus (Avion)',  value = 'mammatus'},
			{label = 'Frogger (Hélico)',  value = 'frogger'},
		}
		
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				css = 'autoecole',
				title    = _U('veh_menu'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				menu.close()

				local model = data.current.value
				local playerPed = GetPlayerPed(-1)
				local platenum = math.random(100, 900)
				local vehicle = GetVehiclePedIsIn(playerPed)

				if model == 'mammatus' then
					ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPointAirAvion.Pos, 57.0, function(vehicle)
						SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
						local playerPed = GetPlayerPed(-1)
						--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						local plate = GetVehicleNumberPlateText(vehicle)
						  plate = string.gsub(plate, " ", "")
						TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
					end)
				elseif model == 'frogger' then
					ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPointAirHelico.Pos, 329.0, function(vehicle)
						SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
						local playerPed = GetPlayerPed(-1)
						--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						local plate = GetVehicleNumberPlateText(vehicle)
						plate = string.gsub(plate, " ", "")
						TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
					end)
				end
			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'vehicle_spawner_boat_menu'
				CurrentActionMsg  = _U('spawn_veh')
				CurrentActionData = {}

			end
		)
	end
end

function OpenVehicleSpawnerBoatMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			for i=1, #vehicles, 1 do
				table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
			end

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'vehicle_spawner',
				{
					css = 'autoecole',
					title    = _U('veh_menu'),
					align    = 'top-left',
					elements = elements,
				},
				function(data, menu)

					menu.close()

					local vehicleProps = data.current.value
					local platenum = math.random(100, 900)
					local vehicle = GetVehiclePedIsIn(playerPed)

					ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPointBoat.Pos, 198.0, function(vehicle)
						ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
						local playerPed = GetPlayerPed(-1)
						--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						local plate = GetVehicleNumberPlateText(vehicle)
              			plate = string.gsub(plate, " ", "")
						TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
					end)

					TriggerServerEvent('esx_society:removeVehicleFromGarage', 'autoecole', vehicleProps)

				end,
				function(data, menu)

					menu.close()

					CurrentAction     = 'vehicle_spawner_air_menu'
					CurrentActionMsg  = _U('spawn_veh')
					CurrentActionData = {}

				end
			)

		end, 'autoecole')

	else
	
		local elements = {
			--{label = 'Bateau',  value = 'tropic'},
			{label = 'Voiture',  value = 'school'},
			{label = 'Moto',  value = 'hakuchou'},
			{label = 'Camion',  value = 'pounder'},
		}
		
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				css = 'autoecole',
				title    = _U('veh_menu'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				menu.close()

				local model = data.current.value
				local playerPed = GetPlayerPed(-1)
				local platenum = math.random(100, 900)
				local vehicle = GetVehiclePedIsIn(playerPed)
				
			  if model == 'tropic' then
				ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPointBoat.Pos, 198.0, function(vehicle)
					SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
					local playerPed = GetPlayerPed(-1)
					--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					local plate = GetVehicleNumberPlateText(vehicle)
              		plate = string.gsub(plate, " ", "")
					TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
				end)
			elseif model == 'school' then
				ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPointvoiture.Pos, 259.0, function(vehicle)
					SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
					local playerPed = GetPlayerPed(-1)
					--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					local plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
				end)
			elseif model == 'hakuchou' then
				ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPointmoto.Pos, 259.0, function(vehicle)
					SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
					local playerPed = GetPlayerPed(-1)
					--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					local plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
				end)
			elseif model == 'pounder' then
				ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPointcamoin.Pos, 259.0, function(vehicle)
					SetVehicleNumberPlateText(vehicle, "AUTO" .. platenum)
					local playerPed = GetPlayerPed(-1)
					--TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					local plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
				end)
			end
			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'vehicle_spawner_air_menu'
				CurrentActionMsg  = _U('spawn_veh')
				CurrentActionData = {}

			end
		)
	end
end

function OpenMobileActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_actions',
		{
			css = 'autoecole',
			title    = 'Auto Ecole',
			align    = 'top-left',
			elements = {
				{label = _U('billing'), value = 'billing'},
				{label = 'Donner le Code de la route', value = 'givecode'},
				{label = 'Donner le permis voiture', value = 'givevoiture'},
				{label = 'Donner le permis moto', value = 'givemoto'},
				{label = 'Donner le permis camion', value = 'givecamoin'},
			--	{label = 'Donner le permis bateau', value = 'givebateau'},
			--	{label = 'Donner le permis avion', value = 'giveavion'},
			--	{label = 'Donner le permis hélico', value = 'givehelico'},
			--    {label = 'Passer une annonce', value = 'announce'}
			}
		},
		function(data, menu)
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then

				if data.current.value == 'givecode' then
					TriggerServerEvent('esx_autoecolejob:addLicense', GetPlayerServerId(player), 'dmv')
				end

				if data.current.value == 'givevoiture' then
					TriggerServerEvent('esx_autoecolejob:addLicense', GetPlayerServerId(player), 'drive')
				end

				if data.current.value == 'givemoto' then
					TriggerServerEvent('esx_autoecolejob:addLicense', GetPlayerServerId(player), 'drive_bike')
				end

				if data.current.value == 'givecamoin' then
					TriggerServerEvent('esx_autoecolejob:addLicense', GetPlayerServerId(player), 'drive_truck')
				end

				if data.current.value == 'givebateau' then
					TriggerServerEvent('esx_autoecolejob:addLicense', GetPlayerServerId(player), 'drive_boat')
				end

				if data.current.value == 'giveavion' then
					TriggerServerEvent('esx_autoecolejob:addLicense', GetPlayerServerId(player), 'drive_avion')
				end

				if data.current.value == 'givehelico' then
					TriggerServerEvent('esx_autoecolejob:addLicense', GetPlayerServerId(player), 'drive_heli')
				end

				if data.current.value == 'announce' then
					messagenotfinish = true
					AutoEcole()
				end

				if data.current.value == 'billing' then

					ESX.UI.Menu.Open(
						'dialog', GetCurrentResourceName(), 'billing',
						{
							title = _U('invoice_amount')
						},
						function(data, menu)

							local amount = tonumber(data.value)

							if amount == nil or amount <= 0 then
								ESX.ShowNotification(_U('amount_invalid'))
							else
								menu.close()

								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

								if closestPlayer == -1 or closestDistance > 3.0 then
									ESX.ShowNotification(_U('no_players_near'))
								else
									local playerPed        = GetPlayerPed(-1)

									Citizen.CreateThread(function()
										TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
										Citizen.Wait(5000)
										ClearPedTasks(playerPed)
										TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(closestPlayer), 'society_autoecole', 'Auto Ecole', amount)
									end)
								end
							end
						end,
						function(data, menu)
							menu.close()
						end
					)
				end
			else
				Notification('Pas de joueur a proximité.')
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterNetEvent('esx_autoecolejob:loadLicenses')
AddEventHandler('esx_autoecolejob:loadLicenses', function(licenses)
	Licenses = licenses
end)

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('esx_autoecolejob:getStockItems', function(items)

		print(json.encode(items))

		local elements = {}

		for i=1, #items, 1 do
			if (items[i].count ~= 0) then
				table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
			end
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				css = 'autoecole',
				title    = 'Auto Ecole Stock',
				align    = 'top-left',
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)
		
						local count = tonumber(data2.value)

						if count == nil or count <= 0 then
							ESX.ShowNotification(_U('quantity_invalid'))
						else
							menu2.close()
							menu.close()
							OpenGetStocksMenu()

							TriggerServerEvent('esx_autoecolejob:getStockItem', itemName, count)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)
	end)
end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_autoecolejob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do

			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			end

		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				css = 'autoecole',
				title    = _U('inventory'),
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil or count <= 0 then
							ESX.ShowNotification(_U('quantity_invalid'))
						else
							menu2.close()
							menu.close()
							OpenPutStocksMenu()

							TriggerServerEvent('esx_autoecolejob:putStockItems', itemName, count)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)

	end)

end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	blips()
end)

AddEventHandler('esx_autoecolejob:hasEnteredMarker', function(zone)
	if zone == 'ActionsMenu' and PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then
		CurrentAction     = 'actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end
  
	if zone == 'VehicleSpawnerBoat' and PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then
		CurrentAction     = 'vehicle_spawner_boat_menu'
		CurrentActionMsg  = _U('spawn_veh')
		CurrentActionData = {}
	end
		
	if zone == 'VehicleDeleterBoat' and PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then

		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
		
		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then
				CurrentAction     = 'delete_vehicle_boat'
				CurrentActionMsg  = _U('store_veh')
				CurrentActionData = {vehicle = vehicle}
			end
		end
	end

	if zone == 'VehicleSpawnerAir' and PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then
		CurrentAction     = 'vehicle_spawner_boat_menu'
		CurrentActionMsg  = _U('spawn_veh')
		CurrentActionData = {}
	end
		
	if zone == 'VehicleDeleterAir' and PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then

		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
		
		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then
				CurrentAction     = 'delete_vehicle_air'
				CurrentActionMsg  = _U('store_veh')
				CurrentActionData = {vehicle = vehicle}
			end
		end
	end
end)

AddEventHandler('esx_autoecolejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

-- Create Blips
function blips()
	-- if publicBlip == false then
		local blip = AddBlipForCoord(Config.Zones.VehicleSpawnerBoat.Pos.x, Config.Zones.VehicleSpawnerBoat.Pos.y, Config.Zones.VehicleSpawnerBoat.Pos.z)
		SetBlipSprite (blip, 76)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.6)
		SetBlipColour (blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Auto-école")
		EndTextCommandSetBlipName(blip)
		-- publicBlip = true
	-- end

	-- if publicBlip == false then
		--[[local blip2 = AddBlipForCoord(Config.Zones.ActionsMenu.Pos.x, Config.Zones.ActionsMenu.Pos.y, Config.Zones.ActionsMenu.Pos.z)
		SetBlipSprite (blip2, 251)
		SetBlipDisplay(blip2, 4)
		SetBlipScale  (blip2, 0.9)
		SetBlipColour (blip2, 4)
		SetBlipAsShortRange(blip2, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Auto-école Aérien")
		EndTextCommandSetBlipName(blip2)
		publicBlip = true]]--
	-- end
	
    -- if PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then

	-- 	for k,v in pairs(Config.Zones)do
	-- 		if v.Type == 1 then
	-- 			local blip2 = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

	-- 			SetBlipSprite (blip2, 85)
	-- 			SetBlipDisplay(blip2, 4)
	-- 			SetBlipScale  (blip2, 0.9)
	-- 			SetBlipColour (blip2, 19)
	-- 			SetBlipAsShortRange(blip2, true)

	-- 			BeginTextCommandSetBlipName("STRING")
	-- 			AddTextComponentString(v.Name)
	-- 			EndTextCommandSetBlipName(blip2)
	-- 			table.insert(JobBlips, blip2)
	-- 		end
	-- 	end
	-- end
end


-- Display markers
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(10)

		if PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_autoecolejob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_autoecolejob:hasExitedMarker', LastZone)
			end
		end
	end
end)

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' and (GetGameTimer() - GUI.Time) > 300 then				
				if CurrentAction == 'actions_menu' then
					OpenActionsMenu()
				end
				if CurrentAction == 'vehicle_spawner_boat_menu' then
					OpenVehicleSpawnerBoatMenu()
				end
				if CurrentAction == 'delete_vehicle_boat' then

					if Config.EnableSocietyOwnedVehicles then
						local vehicle   = GetVehiclePedIsIn(playerPed,  false)
						local plate = GetVehicleNumberPlateText(vehicle)
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'autoecole', vehicleProps)
						TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
				end
				if CurrentAction == 'vehicle_spawner_air_menu' then
					OpenVehicleSpawnerAirMenu()
				end
				if CurrentAction == 'delete_vehicle_air' then

					if Config.EnableSocietyOwnedVehicles then
						local vehicle   = GetVehiclePedIsIn(playerPed,  false)
						local plate = GetVehicleNumberPlateText(vehicle)
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'autoecole', vehicleProps)
						TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end

		if IsControlPressed(0,  Keys['F6']) and Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'autoecole' and (GetGameTimer() - GUI.Time) > 150 then
			OpenMobileActionsMenu()
			GUI.Time = GetGameTimer()
		end
	end
end)