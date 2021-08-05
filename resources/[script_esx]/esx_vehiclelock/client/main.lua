ESX               = nil
local playerCars = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


function OpenCloseVehicle()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed, true)

	local vehicle = nil

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 71)
	end

	ESX.TriggerServerCallback('esx_vehiclelock:mykey', function(gotkey)

		if gotkey then
			local locked = GetVehicleDoorLockStatus(vehicle)
			if locked == 1 or locked == 0 then -- if unlocked
				SetVehicleDoorsLocked(vehicle, 2)
				PlayVehicleDoorCloseSound(vehicle, 1)
			--	ESX.ShowAdvancedColoredNotification(('Clé'), ("de voiture"), ("Vous avez ~r~fermé~s~ le véhicule."), 'CHAR_PEGASUS_DELIVERY', 1, 2)
				ESX.ShowNotification("Vous avez ~r~fermé~s~ le véhicule")
				TriggerServerEvent("InteractSound_SV:PlayOnSource", "lock", 0.8)
			elseif locked == 2 then -- if locked
				SetVehicleDoorsLocked(vehicle, 1)
				PlayVehicleDoorOpenSound(vehicle, 0)
			--	ESX.ShowAdvancedColoredNotification(('Clé'), ("de voiture"), ("Vous avez ~g~ouvert~s~ le véhicule."), 'CHAR_PEGASUS_DELIVERY', 1, 2)
				ESX.ShowNotification("Vous avez ~g~ouvert~s~ le véhicule")
				TriggerServerEvent("InteractSound_SV:PlayOnSource", "unlock", 0.8)
			end
		else
		--	ESX.ShowAdvancedColoredNotification(('Clé'), ("de voiture"), ("Vous n'avez pas les clés de ce véhicule."), 'CHAR_PEGASUS_DELIVERY', 1, 2)
			ESX.ShowNotification("~r~Vous n'avez pas les clés de ce véhicule")
		end
	end, GetVehicleNumberPlateText(vehicle))
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 303) then -- Touche U
			OpenCloseVehicle()
		end
	end
end)

AddEventHandler('esx_vehiclelock:hasEnteredMarker', function(zone)

	CurrentAction     = 'Serrurier'
	CurrentActionMsg  = 'Serrurier'
	CurrentActionData = {zone = zone}

end)

AddEventHandler('esx_vehiclelock:hasExitedMarker', function(zone)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

end)


-- Menu Serrurier --
function OpenSerrurierMenu()
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'GetKey',
	{
		title = 'Que voulez vous ? ',
		align = 'top-left',
		elements = {
			{label = ('Enregistrer une nouvelle clé'),              value = 'registerkey'},
	}
	  },
        function(data, menu) --Submit Cb
        if data.current.value == 'registerkey' then
					ESX.TriggerServerCallback('esx_vehiclelock:getVehiclesnokey', function(Vehicles2)
						local elements = {}
						if Vehicles2 == nil then
							table.insert(elements, {label = 'Aucun véhicule sans clés ', value = nil})
						else
							for i=1, #Vehicles2, 1 do
								model = Vehicles2[i].model
								modelname = GetDisplayNameFromVehicleModel(model)
								Vehicles2[i].model = GetLabelText(modelname)
							end
							for i=1, #Vehicles2, 1 do
								table.insert(elements, {label = Vehicles2[i].model .. ' [' .. Vehicles2[i].plate .. ']', value = Vehicles2[i].plate})					
							end
							ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'backey',
							{
							title    = 'Nouvelle clés.',
							align    = 'top-left',
							elements = elements
							},
							function(data2, menu2)
									menu2.close()	
									TriggerServerEvent('esx_vehiclelock:registerkey', data2.current.value, 'no')
							end,
							function(data2, menu2)
								menu2.close()
							end
							)
						end
					end)
			end
        end,   
        function(data, menu) --Cancel Cb
                menu.close()
        end,
        function(data, menu) --Change Cb
        end
      )
end

-- Create Blips
--[[Citizen.CreateThread(function()
		local blip = AddBlipForCoord(Config.Zones.place.Pos.x, Config.Zones.place.Pos.y, Config.Zones.place.Pos.z)
		SetBlipSprite (blip, 682)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.6)
		SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Serrurier')
		EndTextCommandSetBlipName(blip)
end)]]--

-- Display markers
Citizen.CreateThread(function()
	while true do

		Wait(0)

			local coords = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(Config.Zones) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)
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
				TriggerEvent('esx_vehiclelock:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_vehiclelock:hasExitedMarker', LastZone)
			end

		end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  if CurrentAction ~= nil then
  
		SetTextComponentFormat('STRING')
		AddTextComponentString('~INPUT_CONTEXT~ Pour ouvrir le menu')
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
		if IsControlJustReleased(0, 38) then
  
		  if CurrentAction == 'Serrurier' then
			OpenSerrurierMenu(CurrentActionData.zone)
		  end
  
		  CurrentAction = nil
  
		end
  
	  end
	end
  end)


Citizen.CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 303) then -- When you press "U"
             if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
                TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
				StopAnimTask = true		
             end
        end
    end
end)

RegisterNetEvent('NB:car')
AddEventHandler('NB:car', function()
	OpenCloseVehicle()
end)