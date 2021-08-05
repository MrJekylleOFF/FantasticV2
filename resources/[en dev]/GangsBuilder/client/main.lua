ActualGang = false

ESX = nil
local PlayerData = {}

local GUI = {}
GUI.Time = 0

local HasAlreadyEnteredMarker = false
local LastPart = nil

local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local IsHandcuffed = false
local DragStatus = {}
DragStatus.IsDragged = false
local CurrentTask = {}

function gangChecker(job2)
	for k, v in ipairs(gangsData) do
		if job2 == v.Name then
			return v
		end
	end

	return false
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('gb:requestSync')
	
	while gangsData == nil do
		Citizen.Wait(0)
	end

	ActualGang = gangChecker(PlayerData.job2.name)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	print('test')
	PlayerData.job2 = job
	ActualGang = gangChecker(job.name)
end) 

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	print('test')
end) 


function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function OpenCloakroomMenu()
	local elements = {
		{label = 'Mettre Sac', value = 'sac_wear'},
		{label = 'Enlever Sac', value = 'sac_wear1'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title = _U('cloakroom'),
		elements = elements
	}, function(data, menu)
		local playerPed = PlayerPedId()
		SetPedArmour(playerPed, 0)
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		ResetPedMovementClipset(playerPed, 0)

		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end

		if data.current.value == 'sac_wear' or data.current.value == 'sac_wear1' then
			setUniform(data.current.value, playerPed)
		end
	end, function(data, menu)
	end)
end

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 2,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function OpenVehicleSpawnerMenu()
	local vehSpawnPoint = ActualGang.VehSpawnPoint
	local vehSpawnHeading = ActualGang.VehSpawnHeading

	ESX.UI.Menu.CloseAll()

	local elements = {}
	local vehicles = {}
	local platenum = math.random(100000, 999999)
	color = nil

	ESX.TriggerServerCallback('GangsBuilderJob:loadjson', function(cb)

		for k,v in pairs(cb) do
			table.insert(vehicles, {label=v.label, name=v.name})
			color = v.color
			color2 = v.color2
		end

		for k,v in pairs(vehicles) do
			table.insert(elements, {
				label = v.label,
				value = v.name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
			title = _U('vehicle_menu'),
			elements = elements
		}, function(data, menu)
			menu.close()
			local vehicleProps = data.current.value
			local vehicle = GetClosestVehicle(vehSpawnPoint.x, vehSpawnPoint.y, vehSpawnPoint.z, 3.0, 0, 71)

			if not DoesEntityExist(vehicle) then
				local playerPed = PlayerPedId()

				ESX.Game.SpawnVehicle(vehicleProps, vehSpawnPoint, vehSpawnHeading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetEntityAsMissionEntity(vehicle, true, true)
					SetVehicleMaxMods(vehicle)
					SetVehicleNumberPlateText(vehicle, platenum)
					SetVehicleCustomPrimaryColour(vehicle, color.r, color.g, color.b)
					SetVehicleCustomSecondaryColour(vehicle, color2.r, color2.g, color2.b)
					local plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
				end)
			else
				ESX.ShowNotification("~r~Il y'a deja un véhicule de sortie")
			end
		end, function(data, menu)
		end)
	end, ActualGang.Name)
end

function OpenGangActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_actions', {
		title = ActualGang.Label,
		elements = {
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			{label = _U('object_spawner'),		value = 'object_spawner'}
		} ,
	}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title = _U('citizen_interaction'),
				elements = {
					{label = 'Menotter / Demenotter',		value = 'handcuff'},
					{label = 'Attraper',			value = 'drag'},
					{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
					{label = _U('out_the_vehicle'), value = 'out_the_vehicle'}
				}
			}, function(data2, menu2)
				local player, distance = ESX.Game.GetClosestPlayer()

				if distance ~= -1 and distance <= 3.0 then
					if data2.current.value == 'handcuff' then
						TriggerServerEvent('GangsBuilderJob:handcuff', GetPlayerServerId(player))
					end
					if data2.current.value == 'drag' then
						TriggerServerEvent('GangsBuilderJob:drag', GetPlayerServerId(player))
					end

					if data2.current.value == 'put_in_vehicle' then
						TriggerServerEvent('GangsBuilderJob:putInVehicle', GetPlayerServerId(player))
					end

					if data2.current.value == 'out_the_vehicle' then
						TriggerServerEvent('GangsBuilderJob:OutVehicle', GetPlayerServerId(player))
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
			end)
		end

		if data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'),		value = 'prop_roadcone02a'},
				--	{label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
					{label = _U('box'),			value = 'prop_boxpile_07d'}
				}
			}, function(data2, menu2)
				local model     = data2.current.value
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local forward   = GetEntityForwardVector(playerPed)
				local x, y, z   = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 1.0
				end

				ESX.Game.SpawnObject(model, {
					x = x,
					y = y,
					z = z
				}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)

			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
	end)
end

RegisterNetEvent('GangsBuilderJob:handcuff')
AddEventHandler('GangsBuilderJob:handcuff', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)

		else

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)

end)


RegisterNetEvent('GangsBuilderJob:drag')
AddEventHandler('GangsBuilderJob:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 166, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 174, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


AddEventHandler('GangsBuilderJob:hasEnteredMarker', function(part)
	if part == 'Cloakroom' then
		CurrentAction = 'menu_cloakroom'
		CurrentActionMsg = _U('open_cloackroom')
		CurrentActionData = {}
	end

	if part == 'VehicleSpawner' then
		CurrentAction = 'menu_vehicle_spawner'
		CurrentActionMsg = _U('vehicle_spawner')
		CurrentActionData = {}
	end

	if part == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction = 'delete_vehicle'
				CurrentActionMsg = _U('store_vehicle')
				CurrentActionData = {vehicle = vehicle}
			end
		end
	end

	if part == 'BossActions' then
		CurrentAction = 'menu_boss_actions'
		CurrentActionMsg = _U('open_bossmenu')
		CurrentActionData = {}
	end
end)

AddEventHandler('GangsBuilderJob:hasExitedMarker', function(part)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)


AddEventHandler('GangsBuilderJob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job2 ~= nil and ActualGang then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = 'Appuyez sur E pour enlever l\'objet'
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('GangsBuilderJob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)


RegisterNetEvent('GangsBuilderJob:putInVehicle')
AddEventHandler('GangsBuilderJob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, false)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle,  i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

RegisterNetEvent('GangsBuilderJob:OutVehicle')
AddEventHandler('GangsBuilderJob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job2 ~= nil and ActualGang then
			local coords = GetEntityCoords(PlayerPedId(), false)

			if GetDistanceBetweenCoords(coords, ActualGang.Cloakroom.x, ActualGang.Cloakroom.y, ActualGang.Cloakroom.z,  true) < 10.0 then
				local zone = vector3(ActualGang.Cloakroom.x, ActualGang.Cloakroom.y, ActualGang.Cloakroom.z)
				DrawMarker(Config.MarkerType, ActualGang.Cloakroom.x, ActualGang.Cloakroom.y, ActualGang.Cloakroom.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehSpawner.x, ActualGang.VehSpawner.y, ActualGang.VehSpawner.z,  true) < 10.0 then
				local zone = vector3(ActualGang.VehSpawner.x, ActualGang.VehSpawner.y, ActualGang.VehSpawner.z)
				DrawMarker(Config.MarkerType, ActualGang.VehSpawner.x, ActualGang.VehSpawner.y, ActualGang.VehSpawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehDeleter.x, ActualGang.VehDeleter.y, ActualGang.VehDeleter.z,  true) < 20.0 then
				local zone = vector3(ActualGang.VehDeleter.x, ActualGang.VehDeleter.y, ActualGang.VehDeleter.z)
				DrawMarker(Config.MarkerType, ActualGang.VehDeleter.x, ActualGang.VehDeleter.y, ActualGang.VehDeleter.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
			end

			if PlayerData.job2 ~= nil and PlayerData.job2.grade_name == 'boss' then
				if GetDistanceBetweenCoords(coords, ActualGang.BossActions.x, ActualGang.BossActions.y, ActualGang.BossActions.z, true) < 10.0 then
						local zone = vector3(ActualGang.BossActions.x, ActualGang.BossActions.y, ActualGang.BossActions.z)
						DrawMarker(Config.MarkerType, ActualGang.BossActions.x, ActualGang.BossActions.y, ActualGang.BossActions.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

function ShowHelp(text, n)
    BeginTextCommandDisplayHelp(text)
    EndTextCommandDisplayHelp(n or 0, false, true, -1)
end


-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job2 ~= nil and ActualGang then
			local coords = GetEntityCoords(PlayerPedId(), false)
			local isInMarker = false
			local currentPart = nil
			local hasExited = false

			if GetDistanceBetweenCoords(coords, ActualGang.Cloakroom.x, ActualGang.Cloakroom.y, ActualGang.Cloakroom.z, true) < Config.MarkerSize.x then
				isInMarker = true
				currentPart = 'Cloakroom'
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehSpawner.x, ActualGang.VehSpawner.y, ActualGang.VehSpawner.z, true) < Config.MarkerSize.x then
				isInMarker = true
				currentPart = 'VehicleSpawner'
			end

			if GetDistanceBetweenCoords(coords, ActualGang.VehDeleter.x, ActualGang.VehDeleter.y, ActualGang.VehDeleter.z, true) < Config.MarkerSize.x then
				isInMarker = true
				currentPart = 'VehicleDeleter'
			end

			if PlayerData.job2 ~= nil and PlayerData.job2.grade_name == 'boss' then
				if GetDistanceBetweenCoords(coords, ActualGang.BossActions.x, ActualGang.BossActions.y, ActualGang.BossActions.z, true) < Config.MarkerSize.x then
					isInMarker = true
					currentPart = 'BossActions'
				end
			end


			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPart ~= currentPart)) then
				if (LastPart ~= nil) and (LastPart ~= currentPart) then
					TriggerEvent('GangsBuilderJob:hasExitedMarker', LastPart)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastPart = currentPart

				TriggerEvent('GangsBuilderJob:hasEnteredMarker', currentPart)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('GangsBuilderJob:hasExitedMarker', LastPart)
			end
		end
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end


		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('GangsBuilderJob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity ~= nil then
				TriggerEvent('GangsBuilderJob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlPressed(0, 38) and PlayerData.job2 ~= nil and ActualGang and (GetGameTimer() - GUI.Time) > 150 then
				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				end

				if CurrentAction == 'menu_armory' then
					local players = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 4.0)
					if #players > 1 then
						PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 1)
						ESX.ShowNotification("~r~Vous devez etre seul sur le point pour l'utilisé.")
					else
						OpenArmoryMenu()
					end
				end

				if CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu()
				end

				if CurrentAction == 'delete_vehicle' then
					local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
					TriggerServerEvent('esx_society:putVehicleInGarage1', ActualGang.Name, vehicleProps)

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				if CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()

					TriggerEvent('esx_society:openBossMenu2', ActualGang.Name, function(data, menu)
						CurrentAction = 'menu_boss_actions'
						CurrentActionMsg = _U('open_bossmenu')
						CurrentActionData = {}
					end, {wash = false})
				end

				if CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
				GUI.Time = GetGameTimer()
			end
		end

		if IsControlPressed(0, 168) and PlayerData.job2 ~= nil and ActualGang and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gang_actions') and (GetGameTimer() - GUI.Time) > 150 then
			OpenGangActionsMenu()
			GUI.Time = GetGameTimer()
		end
	end
end)