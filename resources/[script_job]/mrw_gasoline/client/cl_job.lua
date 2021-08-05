-- Create by Morow for Fantastic RP

-- Author : Morow 
-- GitHub : https://github.com/Morow73
-- No Edit, No Sell !!!!!!! 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
   ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
   ESX.PlayerData.job = job
end)

local isInZoneJob, inZone, playerInService, UseESX_Service, zone = false, false, false, true, '' 
startMission = false 
coordMission = {}

local positionJob =  {
	RaffineurAction = {1740.9431, -1606.7901, 111.5570},  
	Garage = {1713.18, -1555.55, 112.94},  
	SpawnPoint = {1754.1186, -1546.1147, 112.6807},  
	DeletePoint = {1724.5075, -1561.75036, 111.6454},
	Vehicle = 'phantom',
	JobClothe = {
		male = {
         	['tshirt_1'] = 59,  ['tshirt_2'] = 0,
	        ['torso_1'] = 12,   ['torso_2'] = 5,
	        ['decals_1'] = 0,   ['decals_2'] = 0,
	        ['arms'] = 1,
	        ['pants_1'] = 9,   ['pants_2'] = 7,
	        ['shoes_1'] = 7,   ['shoes_2'] = 2,
	        ['helmet_1'] = 11,  ['helmet_2'] = 0,
	        ['bags_1'] = 0, ['bags_2'] = 0,
	        ['ears_1'] = 0, ['ears_2'] = 0,
	        ['glasses_1'] = 0, ['glasses_2'] = 0,
		},
		female = {
            ['tshirt_1'] = 0,  ['tshirt_2'] = 0,
	        ['torso_1'] = 56,   ['torso_2'] = 0,
	        ['decals_1'] = 0,   ['decals_2'] = 0,
	        ['arms'] = 63,
	        ['pants_1'] = 36,   ['pants_2'] = 0,
	        ['shoes_1'] = 27,   ['shoes_2'] = 0,
	        ['helmet_1'] = 11,  ['helmet_2'] = 0,
	        ['bags_1'] = 0, ['bags_2'] = 0,
	        ['ears_1'] = 0, ['ears_2'] = 0,
	        ['glasses_1'] = 0, ['glasses_2'] = 0,
		}
	}
}

RMenu.Add('mrw_gasoline', 'Fueler Menu', RageUI.CreateMenu("Fueler", "Dépot", 10 , 200, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_gasoline', 'Fueler Menu'):SetRectangleBanner(255, 0, 0, 100)

RMenu.Add('mrw_gasoline', 'Fueler Menu2', RageUI.CreateMenu("Fueler", "Garage", 10 , 200, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_gasoline', 'Fueler Menu2'):SetRectangleBanner(255, 0, 0, 100)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
        
        local plyCoords = GetEntityCoords(PlayerPedId())
		if Distance3d(plyCoords, vector3(positionJob.RaffineurAction[1], positionJob.RaffineurAction[2], positionJob.RaffineurAction[3])) < 20.0 then 
			DrawMarker(1, positionJob.RaffineurAction[1], positionJob.RaffineurAction[2], positionJob.RaffineurAction[3], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			isInZoneJob = true 

			if isInZoneJob and Distance3d(plyCoords, vector3(positionJob.RaffineurAction[1], positionJob.RaffineurAction[2], positionJob.RaffineurAction[3])) < 1.5 then
				inZone, zone = true, 'Action'
			end
		end

		if Distance3d(plyCoords, vector3(positionJob.Garage[1], positionJob.Garage[2], positionJob.Garage[3])) < 20.0 then 
			DrawMarker(1, positionJob.Garage[1], positionJob.Garage[2], positionJob.Garage[3], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			isInZoneJob = true 

			if isInZoneJob and Distance3d(plyCoords, vector3(positionJob.Garage[1], positionJob.Garage[2], positionJob.Garage[3])) < 1.5 then
				inZone, zone = true, 'Garage'
			end
		end

	    if Distance3d(plyCoords, vector3(positionJob.DeletePoint[1], positionJob.DeletePoint[2], positionJob.DeletePoint[3])) < 20.0 then 
			DrawMarker(1, positionJob.DeletePoint[1], positionJob.DeletePoint[2], positionJob.DeletePoint[3], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			isInZoneJob = true 

			if isInZoneJob and Distance3d(plyCoords, vector3(positionJob.DeletePoint[1], positionJob.DeletePoint[2], positionJob.DeletePoint[3])) < 3.0 then
				inZone, zone = true, 'Delete'
			end
		end

		if isInZoneJob and not inZone then 
			closeMenu()
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)

		if inZone then 
			BeginTextCommandDisplayHelp("STRING")
	        AddTextComponentSubstringPlayerName("Appuyez sur ~b~ ~INPUT_CONTEXT~ ~w~")
	        EndTextCommandDisplayHelp(0, 0, 1, -1)

	        if IsControlPressed(0, 38) then 
	        	if zone == 'Action' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'fueler' then 
	        		RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu'), true)
	        	end
	        	if zone == 'Garage' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'fueler' then 
	        		if playerInService then
	        		   RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu2'), true) 
	        		else 
	        			ESX.ShowNotification("Vous n'êtes pas en service !")
	        		end
	        	end
	        	if zone == 'Delete' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'fueler' then 
        			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					if GetPedInVehicleSeat(vehicle, -1) then 
        				DeleteVehicle(vehicle)
        				TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate)
        			end 
	        	end
	        end
	        inZone = false 
		end
		if IsControlJustPressed(0, 178) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'fueler' and not startMission then  -- delete
			local playerPed = GetPlayerPed(-1)
			if playerInService then 
				local vehicle = GetVehiclePedIsIn(playerPed,  false)
				if IsPedInAnyVehicle(playerPed,  false) and GetEntityModel(vehicle) == GetHashKey('phantom') then
					startMission = true 
					goMission()
				else
					ESX.ShowNotification("~r~Vous devez être en véhicule de service !")
				end
	     	else 
	     		ESX.ShowNotification("Vous n'êtes pas en ~r~service~w~ !")
            end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu')) then 

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.Button("Prendre son service", nil, {}, true, function(Hovered, Active, Selected)
               	    if (Selected) then 

		                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							if skin.sex == 0 then
								TriggerEvent('skinchanger:loadClothes', skin, positionJob.JobClothe.male)
							else
								TriggerEvent('skinchanger:loadClothes', skin, positionJob.JobClothe.female)
							end
						end)

               	    	if UseESX_Service then 
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
					
											TriggerServerEvent('esx_service:notifyAllInService', notification, 'fueler')
											TriggerServerEvent('esx_service:ActivateService', 'fueler', 99)
											TriggerServerEvent('esx_service:startPayCheck', 'fueler', 'society_fueler')
											ESX.ShowNotification('~g~Prise de service')
										end
									end, 'fueler')

								else
									serviceOk = true
								end
							end, 'fueler')

							while type(serviceOk) == 'string' do
								Citizen.Wait(5)
							end

							-- if we couldn't enter service don't let the player get changed
							if not serviceOk then
								return
							end
						end
               	    end
                end)

                RageUI.Button("Arreter son service", nil, {}, true, function(Hovered, Active, Selected)
               	    if (Selected) then 

		               	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)

               	    	if UseESX_Service then 

			                ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
								if isInService then

									playerInService = false
									startMission = false 
		                			coordMission = {}

									local notification = {
										title    = 'annonces services',
										subject  = '',
										msg      = 'fin de service', GetPlayerName(PlayerId()),
										iconType = 1
									}

									TriggerServerEvent('esx_service:notifyAllInService', notification, 'fueler')

									TriggerServerEvent('esx_service:disableService', 'fueler')
									ESX.ShowNotification('~r~Fin de service')
								end
							end, 'fueler')
			            end
               	    end
                end)
	      
                if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then 
	                RageUI.Button("Action Patron", nil, {}, true, function(Hovered, Active, Selected)
	                	if (Selected) then 
		                	RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu'), false) 
		                	Citizen.Wait(25)    	
		    	            TriggerEvent('esx_society:openBossMenu1', 'fueler', function(data, menu) end)
		    	        end
	                end)
	            end
	        end, function()
	        end)
        end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)

		if RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu2')) then 

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.Button("Sortir un véhicule du garage", nil, {}, true, function(Hovered, Active, Selected)
               	    if (Selected) then 
                        local model = positionJob.Vehicle
					    local platenum = math.random(100, 999)
					    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
					    local x,y,z = positionJob.SpawnPoint[1], positionJob.SpawnPoint[2], positionJob.SpawnPoint[3]
					    local coord = vector3(x, y, z)

						ESX.Game.SpawnVehicle(model, coord, 183.90, function(vehicle)
							ESX.Game.SpawnVehicle("tanker", coord, 353.76, function(trailer)
								AttachVehicleToTrailer(vehicle, trailer, 1.1)
							end)
						    SetVehicleNumberPlateText(vehicle, "Fuel" .. platenum)
							TaskWarpPedIntoVehicle(GetPlayerPed(-1),  vehicle,  -1)
							local plate = GetVehicleNumberPlateText(vehicle)
						    plate = string.gsub(plate, " ", "")
						    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate)
						end)
						RageUI.CloseAll()

               	    end
                end)
	        end, function()
	        end)
        end
	end
end)

function goMission()
	ESX.ShowNotification("Calcul de l'itinéraire en cours !")

	for i=1,#position,1 do
	    local selectPosition = math.random(0, #position)
	    coordMission = {position[selectPosition][1], position[selectPosition][2], position[selectPosition][3]}
	    break
	end
	if #coordMission ~= 0 then 
        ESX.ShowNotification("L'itinéraire à été trouvé !") 

	    blipJob = AddBlipForCoord(coordMission[1], coordMission[2], coordMission[3])
	    SetBlipSprite (blipJob, 361)
	    SetBlipDisplay(blipJob, 4)
	    SetBlipScale  (blipJob, 1.1)
		SetBlipColour (blipJob, 6)
		SetBlipAsShortRange(blipJob, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Station")
		EndTextCommandSetBlipName(blipJob)
		SetBlipRoute(blipJob, true)
		SetBlipRouteColour(blipJob, 1)

		return blipJob, coordMission
	else
		return goMission()
	end
end

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if blipJob ~= nil and coordMission ~= nil then 
            if Distance3d(GetEntityCoords(PlayerPedId()), vector3(coordMission[1], coordMission[2], coordMission[3])) <= 25.0 then
               ClearAllBlipRoutes()
               RemoveBlip(blipJob)
            end
		end
	end
end)

Citizen.CreateThread(function()

   	local blip = AddBlipForCoord(positionJob.RaffineurAction[1], positionJob.RaffineurAction[2], positionJob.RaffineurAction[3])
	SetBlipSprite (blip, 436)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 6)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Raffinerie")
	EndTextCommandSetBlipName(blip)
end)

function closeMenu()
	if RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu2')) then 
		RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu2'), false)
	end	
	if RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu')) then
		RageUI.Visible(RMenu:Get('mrw_gasoline', 'Fueler Menu'), false) 
    end
end
