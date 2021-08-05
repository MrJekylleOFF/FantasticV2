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

local isInZoneJob, inZone, playerInService, UseESX_Service = false, false, false, true 
local weapon, weaponPrice, weaponlist = {}, {}, {}

startMission = false 
coordMission = {}
local zone = ''
local armejoueur = {}

local positionjob = {
    vehicle = 'stockade',
	depot = {11.27, -661.5, 33.46},
	garageVehicle = {-4.84, -661.24, 33.50},
    spawnerVehicle = {-5.48,-670.03,31.35},
	deleterVehicle = {-19.23, -672.34, 32.35},
	coffre = {-4.83, -676.28, 16.13},
	weapon = {
    'WEAPON_COMBATPISTOL',
	'WEAPON_NIGHTSTICK',
	'WEAPON_FLASHLIGHT',
	"WEAPON_STUNGUN",
    },
	jobSkin = {
		male = {
	        ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	        ['torso_1'] = 26,   ['torso_2'] = 2,
	        ['decals_1'] = 0,   ['decals_2'] = 0,
	        ['arms'] = 26,
	        ['pants_1'] = 46,   ['pants_2'] = 0,
	        ['shoes_1'] = 51,   ['shoes_2'] = 0,
	        ['chain_1'] = 38,  ['chain_2'] = 0,
	        ['bproof_1'] = 11, ['bproof_2'] = 1,
	        ['helmet_1'] = 58,  ['helmet_2'] = 1,
	        ['bags_1'] = 41, ['bags_2'] = 0,
	        ['ears_1'] = 0, ['ears_2'] = 0,
	        ['glasses_1'] = 0, ['glasses_2'] = 0,
	    },
	    female = {
	        ['tshirt_1'] = 161,   ['tshirt_2'] = 0,
	        ['torso_1'] = 43,    ['torso_2'] = 4,
	        ['decals_1'] = 0,   ['decals_2'] = 0,
	        ['arms'] = 23,
	        ['pants_1'] = 6,   ['pants_2'] = 0,
	        ['shoes_1'] = 52,    ['shoes_2'] = 0,
	        ['chain_1'] = 0,    ['chain_2'] = 2,
	        ['helmet_1'] = -1, ['helmet_2'] = 0,
	        ['bags_1'] = 45, ['bags_2'] = 0,
	        ['ears_1'] = -1, ['ears_2'] = 0,
	        ['glasses_1'] = 0, ['glasses_2'] = 0,

	    },
	},	
	code = '9510',
	positionFrom = {10.01, -666.6, 32.900, 'Entrer'},
	positionTo   = {1.2, -702.15, 16.700, 'Sortie'}
}


RMenu.Add('mrw_banking', 'Brinks Menu', RageUI.CreateMenu("Brinks", "Dépot", 10 , 200, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_banking', 'Brinks Menu'):SetRectangleBanner(255, 0, 0, 100)

RMenu.Add('mrw_banking', 'Brinks Menu2', RageUI.CreateMenu("Brinks", "Garage", 10 , 200, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_banking', 'Brinks Menu2'):SetRectangleBanner(255, 0, 0, 100)

RMenu.Add('mrw_banking', 'Brinks Menu3', RageUI.CreateMenu("Brinks", "Coffre", 10 , 200, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_banking', 'Brinks Menu3'):SetRectangleBanner(255, 0, 0, 100)

RMenu.Add('mrw_banking', 'Brinks Menu4', RageUI.CreateMenu("Brinks", "Actions", 10 , 200, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_banking', 'Brinks Menu4'):SetRectangleBanner(255, 0, 0, 100)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local PlyCoords = GetEntityCoords(PlayerPedId())
    	if Vdist(PlyCoords, positionjob.depot[1], positionjob.depot[2], positionjob.depot[3]) <= 20.0 then 
    		isInZoneJob = true
    		DrawMarker(20, positionjob.depot[1], positionjob.depot[2], positionjob.depot[3], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)

    		if isInZoneJob and Vdist(PlyCoords, positionjob.depot[1], positionjob.depot[2], positionjob.depot[3]) <= 3.0 then 
    			zone, inZone = 'depot', true 
    		end
    	end	
    	if Vdist(PlyCoords, positionjob.garageVehicle[1], positionjob.garageVehicle[2], positionjob.garageVehicle[3]) <= 20.0 then 
    		isInZoneJob = true
    		DrawMarker(20, positionjob.garageVehicle[1], positionjob.garageVehicle[2], positionjob.garageVehicle[3], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)

    		if isInZoneJob and Vdist(PlyCoords, positionjob.garageVehicle[1], positionjob.garageVehicle[2], positionjob.garageVehicle[3]) <= 3.0 then 
    			zone, inZone = 'garage', true 
    		end
    	end	
    	if Vdist(PlyCoords, positionjob.deleterVehicle[1], positionjob.deleterVehicle[2], positionjob.deleterVehicle[3]) <= 20.0 then 
    		isInZoneJob = true
    		DrawMarker(20, positionjob.deleterVehicle[1], positionjob.deleterVehicle[2], positionjob.deleterVehicle[3], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
            
            if isInZoneJob and Vdist(PlyCoords, positionjob.deleterVehicle[1], positionjob.deleterVehicle[2], positionjob.deleterVehicle[3]) <= 3.0 then 
    			zone, inZone = 'garage_deleter', true 
    		end
    	end 
    	if Vdist(PlyCoords, positionjob.coffre[1], positionjob.coffre[2], positionjob.coffre[3]) <= 20.0 then 
    		isInZoneJob = true
    		DrawMarker(20, positionjob.coffre[1], positionjob.coffre[2], positionjob.coffre[3], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
            
            if isInZoneJob and Vdist(PlyCoords, positionjob.coffre[1], positionjob.coffre[2], positionjob.coffre[3]) <= 3.0 then 
    			zone, inZone = 'coffre', true 
    		end
    	end

    	if (Vdist(PlyCoords, positionjob.positionFrom[1], positionjob.positionFrom[2], positionjob.positionFrom[3]) < 3.0)then
	        DrawMarker(1, positionjob.positionFrom[1], positionjob.positionFrom[2], positionjob.positionFrom[3]-1, 0, 0, 0, 0, 0, 0, 1.8, 1.8, 0.801, 255, 0, 0,255, 0, 0, 0,0)
	        isInZoneJob = true
	        zone, inZone = 'Entrer', true 
		end

	    if(Vdist(PlyCoords, positionjob.positionTo[1], positionjob.positionTo[2], positionjob.positionTo[3]) < 2.0) and modele ~= 2 and modele ~= 3 then
	        DrawMarker(1, positionjob.positionTo[1], positionjob.positionTo[2], positionjob.positionTo[3] - 1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.801, 255, 0, 0,255, 0, 0, 0,0)
	      	isInZoneJob = true
	        zone, inZone = 'Sortie', true 
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
	        AddTextComponentSubstringPlayerName("Appuyez sur ~b~ ~INPUT_CONTEXT~ ~w~ !")
	        EndTextCommandDisplayHelp(0, 0, 1, -1)
			if IsControlPressed(0, 38) then 
				if zone == 'depot' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'brinks' then 
				   RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu'), true) 
				elseif zone == 'garage'and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'brinks' then 
					if playerInService then 
					   RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu2'), true) 
					else 
						ESX.ShowNotification("Vous n'êtes pas en ~r~service~w~ !")
					end
				elseif zone == 'garage_deleter' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'brinks' then 
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					if GetPedInVehicleSeat(vehicle, -1) then 
        				DeleteVehicle(vehicle)
        				TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate)
        			end
				elseif zone == 'coffre' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'brinks' then 
					if playerInService then
						RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu3'), true) 
					else
					    ESX.ShowNotification("Vous n'êtes pas en ~r~service~w~ !")
					end
				elseif zone == 'Entrer' then 
					OpenKeyboardCode()
				elseif zone == 'Sortie' then 
				    SetEntityCoords(GetPlayerPed(-1), positionjob.positionFrom[1], positionjob.positionFrom[2], positionjob.positionFrom[3] - 1)	
				end
			end
			inZone = false
		end

		if IsControlJustPressed(0, 167) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'brinks' then  -- f6
			if playerInService then
				RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu4'), true)
			else 
				ESX.ShowNotification("Vous n'êtes pas en ~r~service~w~ !")
		   end
		elseif IsControlJustPressed(0, 178) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'brinks' and not startMission then  -- delete
			local playerPed = GetPlayerPed(-1)
			if playerInService then 
				local vehicle = GetVehiclePedIsIn(playerPed,  false)
				if IsPedInAnyVehicle(playerPed,  false) and GetEntityModel(vehicle) == GetHashKey('stockade') then
					ESX.TriggerServerCallback('mrw_banking:checkItem', function(cb)
						if cb then
							startMission = true 
							goMission()
						else
							ESX.ShowNotification("Vous devez posséder au moin un lingot d'or sur vous pour commencer une mission !")
						end
					end, 'lingot')
				else
					ESX.ShowNotification("~r~Vous devez êtres en véhicule brinks !")
				end
	     	else 
	     		ESX.ShowNotification("Vous n'êtes pas en ~r~service~w~ !")
            end
		end
	end
end)



function OpenKeyboardCode()
	AddTextEntry('FMMC_MPM_NA', 'Entrer le code') --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
       Citizen.Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        result = GetOnscreenKeyboardResult()
        if result == positionjob.code then
           SetEntityCoords(GetPlayerPed(-1), positionjob.positionTo[1], positionjob.positionTo[2], positionjob.positionTo[3] - 1)
        else
           ESX.ShowNotification("~r~Code incorrect !")
        end
    end 
end


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu')) then 

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.Button("Prendre son service", nil, {}, true, function(Hovered, Active, Selected)
               	    if (Selected) then 

		                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							if skin.sex == 0 then
								TriggerEvent('skinchanger:loadClothes', skin, positionjob.jobSkin.male)
							else
								TriggerEvent('skinchanger:loadClothes', skin, positionjob.jobSkin.female)
							end
						end)

						SetPedArmour(GetPlayerPed(-1), 100)

               	    	if UseESX_Service then 
	                        local serviceOk = 'waiting'

							ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
								if not isInService then

									for i = 1, #weaponlist do 
										table.remove(weaponlist, 1)
									end

									wepList = ESX.GetWeaponList()
									for i = 1, #wepList, 1 do
									  local weaponHash = GetHashKey(wepList[i].name)
								  
									  if HasPedGotWeapon(PlayerPedId(), weaponHash, false) and wepList[i].name ~= 'WEAPON_UNARMED' then
										local ammo = GetAmmoInPedWeapon(PlayerPedId(), weaponHash)
										local value = wepList[i].name
										table.insert(weaponlist, {value = wepList[i].name, mun = ammo})
										TriggerServerEvent('mrw_banking:RemoveWeapon', value)
									  end
									end

									TriggerServerEvent('mrw_banking:ActiveService', weaponlist)
									
									for k,v in pairs(positionjob.weapon) do
										TriggerServerEvent('mrw_banking:GiveWeapon', v, 100)
									end

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
					
											TriggerServerEvent('esx_service:notifyAllInService', notification, 'brinks')
											TriggerServerEvent('esx_service:ActivateService', 'brinks', 99)
											TriggerServerEvent('esx_service:startPayCheck', 'brinks', 'society_brinks')
											ESX.ShowNotification('~g~Prise de service')
										end
									end, 'brinks')

								else
									serviceOk = true
								end
							end, 'brinks')

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

									for k,v in pairs(positionjob.weapon) do
										TriggerServerEvent('mrw_banking:RemoveWeapon', v)
									end

									for k,v in pairs(weaponlist) do
										TriggerServerEvent('mrw_banking:GiveWeapon', v.value, v.mun)
									end

									TriggerServerEvent('mrw_banking:RemoveItem')
									SetPedArmour(GetPlayerPed(-1), 0)

									playerInService = false

									local notification = {
										title    = 'annonces services',
										subject  = '',
										msg      = 'fin de service', GetPlayerName(PlayerId()),
										iconType = 1
									}

									TriggerServerEvent('esx_service:notifyAllInService', notification, 'brinks')

									TriggerServerEvent('esx_service:disableService', 'brinks')
									ESX.ShowNotification('~r~Fin de service')
								end
							end, 'brinks')
			            end
               	    end
                end)
	      
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then 
	                RageUI.Button("Action Patron", nil, {}, true, function(Hovered, Active, Selected)
	                	if (Selected) then 
		                	RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu'), false) 
		                	Citizen.Wait(25)    	
		    	            TriggerEvent('esx_society:openBossMenu1', 'brinks', function(data, menu) end)
		    	        end
	                end)
	            end
	        end, function()
	        end)
        end
	end
end)

local max = 7 -- number of items that can be selected
Numbers = {}

Citizen.CreateThread(function()
    for i = 1, max do
        table.insert(Numbers, i)
    end
end)
local nombre = 1

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)

        if RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu3')) then 
        	RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
	        
					RageUI.List("Prendre des lingots d'or", Numbers, nombre, nil, { }, true, function(hovered, active, selected, Index)
						nombre = Index

						if selected then
							local count = Numbers[Index]
							TriggerServerEvent('mrw_banking:GiveItem', 'lingot', count)
						end
					end)   	         	   
		    end, function()
		    end)      
        end
    end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)

		if RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu2')) then 

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.Button("Sortir un véhicule du garage", nil, {}, true, function(Hovered, Active, Selected)
               	    if (Selected) then 
                        local model = positionjob.vehicle
					    local platenum = math.random(100, 999)
					    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
					    local x,y,z = positionjob.spawnerVehicle[1], positionjob.spawnerVehicle[2], positionjob.spawnerVehicle[3]
					    local coord = vector3(x, y, z)

						ESX.Game.SpawnVehicle(model, coord, 183.90, function(vehicle)
						    SetVehicleNumberPlateText(vehicle, "Brin" .. platenum)
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

RegisterNetEvent('mrw_banking:menotter')
AddEventHandler('mrw_banking:menotter', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	SetEnableHandcuffs(playerPed, true)
	DisablePlayerFiring(playerPed, true)
end)

RegisterNetEvent('mrw_banking:demenotter')
AddEventHandler('mrw_banking:demenotter', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	SetEnableHandcuffs(playerPed, false)
	DisablePlayerFiring(playerPed, false)
	ClearPedTasks(GetPlayerPed(-1))
end)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)

        if RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu4')) then 
        	RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
				RageUI.Button("Menotter", nil, {}, true, function(Hovered, Active, Selected)
					if (Selected) then
						local target, distance = ESX.Game.GetClosestPlayer()
						playerheading = GetEntityHeading(GetPlayerPed(-1))
						playerlocation = GetEntityForwardVector(PlayerPedId())
						playerCoords = GetEntityCoords(GetPlayerPed(-1))
						local target_id = GetPlayerServerId(target)
						if target ~= -1 and distance <= 3.0 then
							TriggerServerEvent('mrw_banking:menotter', target_id, playerheading, playerCoords, playerlocation)
						else
							ESX.ShowNotification('Aucun joueur à proximité')
						end
					end
				end)
				
				RageUI.Button("Démenotter", nil, {}, true, function(Hovered, Active, Selected)
					if (Selected) then
						local target, distance = ESX.Game.GetClosestPlayer()
						playerheading = GetEntityHeading(GetPlayerPed(-1))
						playerlocation = GetEntityForwardVector(PlayerPedId())
						playerCoords = GetEntityCoords(GetPlayerPed(-1))
						local target_id = GetPlayerServerId(target)
						if target ~= -1 and distance <= 3.0 then
							TriggerServerEvent('mrw_banking:demenotter', target_id, playerheading, playerCoords, playerlocation)
						else
							ESX.ShowNotification('Aucun joueur à proximité')
						end
					end
				end)

				RageUI.Button("Appel renfort LSPD", nil, {}, true, function(Hovered, Active, Selected)
					if (Selected) then
						local coords  = GetEntityCoords(GetPlayerPed(-1))
						TriggerServerEvent("mrw_banking:AppelRenfort", coords)
					end
				end)
		    end, function()
		    end)      
        end
    end
end)

blips = {}

RegisterNetEvent('mrw_banking:setBlip')
AddEventHandler('mrw_banking:setBlip', function(coords)
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort BRINKS', 'Demande de renfort BRINKS demandé.\nRéponse: ~g~CODE-2.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, 47)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort BRINKS')
	EndTextCommandSetBlipName(blipId)
	table.insert(blips, blipId)
	Wait(60*1000)
	for i, blipId in pairs(blips) do 
		RemoveBlip(blipId)
	end
end)

function goMission()
	ESX.ShowNotification("Calcul de l'itinéraire en cours !")

	for i=1,#position,1 do
	    local selectPosition = math.random(0, #position)
	    coordMission = {position[selectPosition][1], position[selectPosition][2], position[selectPosition][3]}
	    break
	end
	if coordMission ~= nil then 
        ESX.ShowNotification("L'itinéraire à été trouvé !") 

	    blipJob = AddBlipForCoord(coordMission[1], coordMission[2], coordMission[3])
	    SetBlipSprite (blipJob, 108)
	    SetBlipDisplay(blipJob, 4)
	    SetBlipScale  (blipJob, 1.1)
		SetBlipColour (blipJob, 50)
		SetBlipAsShortRange(blipJob, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Atm")
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
            if Vdist2(GetEntityCoords(PlayerPedId()), coordMission[1], coordMission[2], coordMission[3]) <= 5.0 then
               ClearAllBlipRoutes()
               RemoveBlip(blipJob)
               inProximityAtm = true
            end
		end
	end
end)


function closeMenu()

	if RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu3')) then
		RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu3'), false) 
	end	
	if RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu2')) then 
		RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu2'), false)
	end	
	if RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu')) then
		RageUI.Visible(RMenu:Get('mrw_banking', 'Brinks Menu'), false) 
    end

end
