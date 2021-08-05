local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
local playerInService = false
isInShopMenu = false

-- AJOUT BY TACKTIIK (TEST) --

function DrawSub(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
  end
  
  function ShowLoadingPromt(msg, time, type)
	Citizen.CreateThread(function()
	  Citizen.Wait(0)
	  N_0xaba17d7ce615adbf("STRING")
	  AddTextComponentString(msg)
	  N_0xbd12f8228410d9b4(type)
	  Citizen.Wait(time)
	  N_0x10d373323e5b9c0d()
	end)
  end
  
  function GetRandomWalkingNPC()
  
	local search = {}
	local peds   = ESX.Game.GetPeds()
  
	for i=1, #peds, 1 do
	  if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
		table.insert(search, peds[i])
	  end
	end
  
	if #search > 0 then
	  return search[GetRandomIntInRange(1, #search)]
	end
  
	for i=1, 250, 1 do
  
	  local ped = GetRandomPedAtCoord(0.0,  0.0,  0.0,  math.huge + 0.0,  math.huge + 0.0,  math.huge + 0.0,  26)
  
	  if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
		table.insert(search, ped)
	  end
  
	end
  
	if #search > 0 then
	  return search[GetRandomIntInRange(1, #search)]
	end
  
  end
  
  function ClearCurrentMission()
  
	if DoesBlipExist(CurrentCustomerBlip) then
	  RemoveBlip(CurrentCustomerBlip)
	end
  
	if DoesBlipExist(DestinationBlip) then
	  RemoveBlip(DestinationBlip)
	end
  
	CurrentCustomer           = nil
	CurrentCustomerBlip       = nil
	DestinationBlip           = nil
	IsNearCustomer            = false
	CustomerIsEnteringVehicle = false
	CustomerEnteredVehicle    = false
	TargetCoords              = nil
  
  end
  
  function StartAmbulanceJob()
  
	ShowLoadingPromt(_U('taking_service') .. 'Ambulance', 5000, 3)
	ClearCurrentMission()
  
	OnJob = true
  
  end
  
  function StopAmbulanceJob()
  
	local playerPed = GetPlayerPed(-1)
  
	if IsPedInAnyVehicle(playerPed, false) and CurrentCustomer ~= nil then
	  local vehicle = GetVehiclePedIsIn(playerPed,  false)
	  TaskLeaveVehicle(CurrentCustomer,  vehicle,  0)
  
	  if CustomerEnteredVehicle then
		TaskGoStraightToCoord(CurrentCustomer,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z,  1.0,  -1,  0.0,  0.0)
	  end
  
	end
  
	ClearCurrentMission()
  
	OnJob = false
  
	DrawSub(_U('mission_complete'), 5000)
  
  end
  
  
  Citizen.CreateThread(function()
  
	while true do
  
	  Citizen.Wait(0)
  
	  local playerPed = GetPlayerPed(-1)
  
	  if OnJob then
  
		if CurrentCustomer == nil then
  
		  DrawSub(_U('drive_search_pass'), 1000)
  
		  if IsPedInAnyVehicle(playerPed,  false) and GetEntitySpeed(playerPed) > 0 then
  
			local waitUntil = GetGameTimer() + GetRandomIntInRange(3000,  9500)
  
			while OnJob and waitUntil > GetGameTimer() do
			  Citizen.Wait(5000)
			end
  
			if OnJob and IsPedInAnyVehicle(playerPed,  false) and GetEntitySpeed(playerPed) > 0 then
  
			  CurrentCustomer = GetRandomWalkingNPC()
  
			  if CurrentCustomer ~= nil then
  
				CurrentCustomerBlip = AddBlipForEntity(CurrentCustomer)
  
				SetBlipAsFriendly(CurrentCustomerBlip, 1)
				SetBlipColour(CurrentCustomerBlip, 1)
				SetBlipCategory(CurrentCustomerBlip, 3)
				SetBlipRoute(CurrentCustomerBlip,  true)
  
				SetEntityAsMissionEntity(CurrentCustomer,  true, false)
				ClearPedTasksImmediately(CurrentCustomer)
				SetBlockingOfNonTemporaryEvents(CurrentCustomer, 1)
  
				local standTime = GetRandomIntInRange(60000,  180000)
  
				TaskStandStill(CurrentCustomer, standTime)
  
				ESX.ShowNotification(_U('customer_found'))
  
			  end
  
			end
  
		  end
  
		else
  
		  if IsPedFatallyInjured(CurrentCustomer) then
  
			ESX.ShowNotification(_U('client_unconcious'))
  
			if DoesBlipExist(CurrentCustomerBlip) then
			  RemoveBlip(CurrentCustomerBlip)
			end
  
			if DoesBlipExist(DestinationBlip) then
			  RemoveBlip(DestinationBlip)
			end
  
			SetEntityAsMissionEntity(CurrentCustomer,  false, true)
  
			CurrentCustomer           = nil
			CurrentCustomerBlip       = nil
			DestinationBlip           = nil
			IsNearCustomer            = false
			CustomerIsEnteringVehicle = false
			CustomerEnteredVehicle    = false
		TargetCoords              = nil
  
		  end
  
		  if IsPedInAnyVehicle(playerPed,  false) then
  
			local vehicle          = GetVehiclePedIsIn(playerPed,  false)
			local playerCoords     = GetEntityCoords(playerPed)
			local customerCoords   = GetEntityCoords(CurrentCustomer)
			local customerDistance = GetDistanceBetweenCoords(playerCoords.x,  playerCoords.y,  playerCoords.z,  customerCoords.x,  customerCoords.y,  customerCoords.z)
  
			if IsPedSittingInVehicle(CurrentCustomer,  vehicle) then
  
			  if CustomerEnteredVehicle then
  
				local targetDistance = GetDistanceBetweenCoords(playerCoords.x,  playerCoords.y,  playerCoords.z,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z)
  
				if targetDistance <= 5.0 then
  
				  TaskLeaveVehicle(CurrentCustomer,  vehicle,  0)
  
				  --ESX.ShowNotification(_U('arrive_dest'))
  
				  TaskGoStraightToCoord(CurrentCustomer,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z,  1.0,  -1,  0.0,  0.0)
				  SetEntityAsMissionEntity(CurrentCustomer,  false, true)
  
				  TriggerServerEvent('orion_ambulancejob:success')
  
				  RemoveBlip(DestinationBlip)
  
				  local scope = function(customer)
					ESX.SetTimeout(6000, function()
					  DeletePed(customer)
					end)
				  end
  
				  scope(CurrentCustomer)
  
				  CurrentCustomer           = nil
				  CurrentCustomerBlip       = nil
				  DestinationBlip           = nil
				  IsNearCustomer            = false
				  CustomerIsEnteringVehicle = false
				  CustomerEnteredVehicle    = false
				  TargetCoords              = nil
  
				end
  
				if TargetCoords ~= nil then
				  DrawMarker(1, TargetCoords.x, TargetCoords.y, TargetCoords.z + 0.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.5001, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				end
  
			  else
  
				RemoveBlip(CurrentCustomerBlip)
				CurrentCustomerBlip = nil
  
				--TargetCoords = Config.JobLocations[GetRandomIntInRange(1,  #Config.JobLocations)]
		  TargetCoords = {x = 291.44,y = -587.35,z = 43.2 }
  
				local street = table.pack(GetStreetNameAtCoord(TargetCoords.x, TargetCoords.y, TargetCoords.z))
				local msg    = nil
  
				if street[2] ~= 0 and street[2] ~= nil then
				  msg = string.format(_U('take_me_to_near', GetStreetNameFromHashKey(street[1]),GetStreetNameFromHashKey(street[2])))
				else
				  msg = string.format(_U('take_me_to', GetStreetNameFromHashKey(street[1])))
				end
  
				ESX.ShowNotification(msg)
  
				DestinationBlip = AddBlipForCoord(TargetCoords.x, TargetCoords.y, TargetCoords.z)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Destination")
				EndTextCommandSetBlipName(blip)
  
				SetBlipRoute(DestinationBlip,  true)
  
				CustomerEnteredVehicle = true
			  end
  
			else
  
			  DrawMarker(0, customerCoords.x, customerCoords.y, customerCoords.z + 2.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.3, 255, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)
  
			  if not CustomerEnteredVehicle then
				if customerDistance <= 30.0 then
				  if not IsNearCustomer then
					--ESX.ShowNotification(_U('close_to_client'))
					IsNearCustomer = true
				  end
				end
  
				if customerDistance <= 100.0 then
				  if not CustomerIsEnteringVehicle then
					ClearPedTasksImmediately(CurrentCustomer)
  
					local seat = 2
  
					for i=4, 0, 1 do
					  if IsVehicleSeatFree(vehicle,  seat) then
						seat = i
						break
					  end
					end
					TaskEnterVehicle(CurrentCustomer,  vehicle,  -1,  seat,  2.0,  1)
					CustomerIsEnteringVehicle = true
				  end
				end
			  end
			end
		  else
			DrawSub(_U('return_to_veh'), 5000)
		  end
		end
	  end
	end
  end)
  
function OpenVehicleSpawnerMenu()
	ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
			css         = 'vehicle',
			title		= _U('veh_menu'),
			align		= 'top-left',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()
			ESX.Game.SpawnVehicle(data.current.model, {x = 292.130, y = -572.41, z = 43.18}, 55.0, function(vehicle)
				local playerPed = GetPlayerPed(-1)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end, function(data, menu)
			menu.close()
		end
		)
end

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'},
		{label = '~g~Mettre sac', value = 'sac_wear'},
		{label = '~g~Enlever sac', value = 'sac1_wear'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'sac_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					local clothesSkin = {
						['bags_1'] = 44, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				else
					local clothesSkin = {
						['bags_1'] = 44, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
		elseif data.current.value == 'sac1_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					local clothesSkin = {
						['bags_1'] = 0, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				else
					local clothesSkin = {
						['bags_1'] = 0, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu1', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMobileAmbulanceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'},
			{ label = 'Facture',   value = 'billing' }	
	}}, function(data, menu)
		if data.current.value == 'billing' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = 'Montant de la facture'
			}, function(data, menu)

					local amount = tonumber(data.value)
					if amount == nil then
						ESX.ShowNotification('Montant invalide')
					else
					menu.close()
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players'))
					else
						TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(closestPlayer), 'society_ambulance', 'Ambulance', amount)
						ESX.ShowNotification('Facture envoyée')
					end
				end
			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-left',
				elements = {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = "Donner la visite médical", value='visite'}
			}}, function(data, menu)
				if isBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
				else
					if data.current.value == 'revive' then
						revivePlayer(closestPlayer)
					elseif data.current.value == 'small' then
						ESX.TriggerServerCallback('orion_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('orion_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('orion_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('orion_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('orion_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('orion_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('orion_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif data.current.value == 'visite' then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance <= 3.0 then
						ESX.ShowNotification("Vous avez donné la visite medicale")
						TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'visite')
						end
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function revivePlayer(closestPlayer)
	isBusy = true

	ESX.TriggerServerCallback('orion_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)

			if IsPedDeadOrDying(closestPlayerPed, 1) then
				local playerPed = PlayerPedId()
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				ESX.ShowNotification(_U('revive_inprogress'))

				for i=1, 15 do
					Citizen.Wait(900)

					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
					end)
				end

				TriggerServerEvent('orion_ambulancejob:removeItem', 'medikit')
				TriggerServerEvent('orion_ambulancejob:rea', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification(_U('player_not_unconscious'))
			end
		else
			ESX.ShowNotification(_U('not_enough_medikit'))
		end
		isBusy = false
	end, 'medikit')
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local letSleep, isInMarker, hasExited = true, false, false
			local currentHospital, currentPart, currentPartNum

			for hospitalNum,hospital in pairs(Config.Hospitals) do
				-- Ambulance Actions
				for k,v in ipairs(hospital.AmbulanceActions) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
						end
					end
				end

				-- Pharmacies
				for k,v in ipairs(hospital.Pharmacies) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
						end
					end
				end

				-- Vehicle Spawners
				for k,v in ipairs(hospital.Vehicles) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
						end
					end
				end
				----------------------------------

				for k,v in ipairs(hospital.Vehicles) do
				--	print(v.Deleter)
					local distance = #(playerCoords - v.Deleter)

					--print(distance)
					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, 255, 0, 0, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'VehicleDeleter', k
						end
					end
				end

				--------------------

				-- Helicopter Spawners
				for k,v in ipairs(hospital.Helicopters) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
						end
					end
				end

				-- Fast Travels (Prompt)
				for k,v in ipairs(hospital.FastTravelsPrompt) do
					local distance = #(playerCoords - v.From)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
						end
					end
				end
			end

			-- Logic for exiting & entering markers
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('orion_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

				TriggerEvent('orion_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('orion_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Fast travels
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true

		for hospitalNum,hospital in pairs(Config.Hospitals) do
			-- Fast Travels
			for k,v in ipairs(hospital.FastTravels) do
				local distance = #(playerCoords - v.From)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false

					if distance < v.Marker.x then
						FastTravel(v.To.coords, v.To.heading)
					end
				end
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('orion_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if part == 'AmbulanceActions' then
		CurrentAction = part
		CurrentActionMsg = _U('actions_prompt')
		CurrentActionData = {}
	elseif part == 'Pharmacy' then
		CurrentAction = part
		CurrentActionMsg = _U('open_pharmacy')
		CurrentActionData = {}
	elseif part == 'Vehicles' then
		CurrentAction = part
		CurrentActionMsg = _U('garage_prompt')
		CurrentActionData = {hospital = hospital, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction = part
		CurrentActionMsg = _U('helicopter_prompt')
		CurrentActionData = {hospital = hospital, partNum = partNum}
	elseif part == 'VehicleDeleter' then
		local playerPed = GetPlayerPed(-1)
		local coords	= GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then

			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then

				CurrentAction		= part
				CurrentActionMsg	= 'E pour ranger'
				CurrentActionData	= {vehicle = vehicle}

			end

		end
	elseif part == 'FastTravelsPrompt' then
		local travelItem = Config.Hospitals[hospital][part][partNum]

		CurrentAction = part
		CurrentActionMsg = travelItem.Prompt
		CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
	end
end)

AddEventHandler('orion_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'Pharmacy' then
					if playerInService then 
						OpenPharmacyMenu()
					else 
						ESX.ShowNotification("~r~Vous n'êtes pas en service !")
				 	end
				elseif CurrentAction == 'Vehicles' then
					if playerInService then 
						OpenVehicleSpawnerMenu()
					else 
						ESX.ShowNotification("~r~Vous n'êtes pas en service !")
					 end
				elseif CurrentAction == 'Helicopters' then
					if not IsAnyVehicleNearPoint(352.09, -587.61, 74.17, 3.0) then
						ESX.Game.SpawnVehicle('aw139', {
							x = 351.69,
							y = -588.47,
							z = 73.17
						}, 347.27, function(vehicle)
							SetVehicleModKit(vehicle, 0)
							SetVehicleLivery(vehicle, 1)
						end)
			
					else
						ESX.ShowNotification('~r~Un hélicopter est déjà sorti !')
					end
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				elseif CurrentAction == 'VehicleDeleter' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				CurrentAction = nil
			end 
		elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and not isDead then
			if IsControlJustReleased(0, 167) then
			--	if playerInService then 
					OpenMobileAmbulanceActionsMenu()
			--	else 
			--		ESX.ShowNotification("~r~Vous n'êtes pas en service !")
			 --	end
			elseif IsControlJustReleased(0, 178) then
				if playerInService then
				if OnJob then
				  StopAmbulanceJob()
				  Citizen.Wait(3000)
				else
		  

		  
					local playerPed = GetPlayerPed(-1)
		  
					if IsPedInAnyVehicle(playerPed,  false) then
		  
					  local vehicle = GetVehiclePedIsIn(playerPed,  false)
		  
						if GetEntityModel(vehicle) == GetHashKey('ambulance') or GetEntityModel(vehicle) == GetHashKey('ambulance1') or GetEntityModel(vehicle) == GetHashKey('sams1') then
						  StartAmbulanceJob()
						else
						  exports.pNotify:SendNotification({text = "<b style='color:grey'>Fantastic</b><br><br>🚑 vous n\'êtes pas dans une ambulance<br><br><b style='color:grey'>Ambulance</b>", type = "error"})
						end
		  
					else
		
						  exports.pNotify:SendNotification({text = "<b style='color:grey'>Fantastic</b><br><br>🚑 vous n\'êtes pas dans une ambulance<br><br><b style='color:grey'>Ambulance</b>", type = "error"})
		  
				  end
		  
				end
		
			else 
					ESX.ShowNotification("~r~Vous n'êtes pas en service !")
				 end
			  end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('orion_ambulancejob:putInVehicle')
AddEventHandler('orion_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
	}}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
				isOnDuty = false

				for playerId,v in pairs(deadPlayerBlips) do
					RemoveBlip(v)
					deadPlayerBlips[playerId] = nil
				end
			end)

			TriggerServerEvent("player:serviceOff", "ambulance")

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

							TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')

							TriggerServerEvent('esx_service:disableService', 'ambulance')
							ESX.ShowNotification('~r~Fin de service')
						end
					end, 'ambulance')
				end
		elseif data.current.value == 'ambulance_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end

				isOnDuty = true
				TriggerEvent('orion_ambulancejob:setDeadPlayers', deadPlayers)
			end)

			TriggerServerEvent("player:serviceOn", "ambulance")

				if Config.MaxInService ~= -1 then 
					local serviceOk = 'waiting'

					ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
						if not isInService then
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
			
									TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')
									TriggerServerEvent('esx_service:ActivateService', 'ambulance', 99)
									TriggerServerEvent('esx_service:startPayCheck', 'ambulance', 'society_ambulance')
									ESX.ShowNotification('~g~Prise de service')
								end
							end, 'ambulance')

						else
							serviceOk = true
						end
					end, 'ambulance')

					while type(serviceOk) == 'string' do
						Citizen.Wait(5)
					end

					-- if we couldn't enter service don't let the player get changed
					if not serviceOk then
						return
					end
				end
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-left',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), item = 'medikit', type = 'slider', value = 1, min = 1, max = 100},
			{label = _U('pharmacy_take', _U('bandage')), item = 'bandage', type = 'slider', value = 1, min = 1, max = 100},
			{label = _U('pharmacy_take', ("doliprane")),  item = 'doliprane', type = 'slider', value = 1, min = 1, max = 100},
			{label = _U('pharmacy_take', ('defibrillateur')),  item = 'defibrillateur', type = 'slider', value = 1, min = 1, max = 100},
			{label = _U('pharmacy_take', ("dolophine")),  item = 'dolophine',type = 'slider', value = 1, min = 1, max = 100}
	}}, function(data, menu)
		TriggerServerEvent('orion_ambulancejob:giveItem', data.current.item, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('orion_ambulancejob:heal')
AddEventHandler('orion_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

RegisterNetEvent('orion_ambulancejob:setDeadPlayers')
AddEventHandler('orion_ambulancejob:setDeadPlayers', function(_deadPlayers)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local player = GetPlayerFromServerId(playerId)
				local playerPed = GetPlayerPed(player)
				local blip = AddBlipForEntity(playerPed)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(_U('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip

				Citizen.Wait(120000)
				RemoveBlip(blip)
			end
		end
	end
end)
