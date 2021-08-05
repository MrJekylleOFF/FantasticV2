-- Create by Morow for Fantastic RP

-- Author : Morow 
-- GitHub : https://github.com/Morow73
-- No Edit, No Sell !!!!!!! 

local isInZone, startAmount, maxAmount, Gasoleprice = false, 1, 100, 0 
local pricePerLitre = 0.2
local outVehicle, startAnim, finishAnim = false, false, false

position = {
	{id= 1, 49.4187, 2778.793, 58.043},
 	{id= 2, 263.894,  2606.463, 44.983},
 	{id= 3, 1039.958,  2671.134,  39.550},
 	{id= 4, 1207.260,   2660.175,   37.899},
 	{id= 5, 2539.685,   2594.192,   37.944},
 	{id= 6,  2679.858,   3263.946,   55.240},
 	{id= 7, 2005.055,   3773.887,   32.403},
 	{id= 8, 1687.156,   4929.392,   42.078},
 	{id= 9, 1701.314,   6416.028,   32.763},
 	{id= 10, 179.857,    6602.839,   31.868},
 	{id= 11, -94.4619,   6419.594,   31.489},
 	{id= 12, -2554.996,  2334.40,   33.078},
 	{id= 13, -1800.375,  803.661,   138.651},
 	{id= 14,  -1437.622,  -276.747,   46.207},
 	{id= 15, -2096.243,  -320.286,   13.168},
 	{id= 16, -724.619,  -935.1631,   19.213},
 	{id= 17,  -526.019,  -1211.003,   18.184},
 	{id= 18,  -70.2148,  -1761.792,   29.534},
 	{id= 19,  265.648,   -1261.309,   29.292},
 	{id= 20, 819.653,   -1028.846,   26.403},
 	{id= 21,  1208.951,   -1402.567,  35.224},
 	{id= 22,  1181.381,   -330.847,   69.316},
 	{id= 23,  620.843,    269.100,   103.089},
 	{id= 24,  2581.321,  362.039,  108.468}
}

local blacklistedVehicle = {
	'BMX', 
	'hydra',
	'khanjali',
} 

RMenu.Add('mrw_gasoline', 'Gasoline Menu', RageUI.CreateMenu("Gasoline", "Libre Service", 10 , 100, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_gasoline', 'Gasoline Menu'):SetRectangleBanner(255, 0, 0, 100)

ESX = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local function GetVehicleBlackList(vehicle)
	for k,v in pairs(blacklistedVehicle) do 
		if GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) == v then 
			return true
		end
	end		
	return false 
end

function Distance3d(coords, coords2)
	return #(coords - coords2)
end

Citizen.CreateThread(function()
    while true do
	    Citizen.Wait(0)

	    local plyCoords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(position) do
			if Distance3d(plyCoords, vector3(v[1], v[2], v[3])) < 5.0 then
				DrawMarker(1, v[1], v[2]+0.5, v[3]-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 0.1, 255, 0, 0, 200, false, true, 2, false, false, false, false)
				GasoId = v.id 
				x,y,z = v[1], v[2], v[3]
				isInZone = true 
				break
			end
		end		
	end
end)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		   
		if isInZone then 
			BeginTextCommandDisplayHelp("STRING")
            AddTextComponentSubstringPlayerName("Appuyez sur ~b~ ~INPUT_CONTEXT~ ~w~ pour mettre de l'essence")
            EndTextCommandDisplayHelp(0, 0, 1, -1)

            if IsControlPressed(0, 38) then 
            	if IsPedSittingInAnyVehicle(PlayerPedId()) then

	                local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	            	local checkBlacklist = GetVehicleBlackList(vehicle)
	            	local Fuel = GetVehicleFuelLevel(vehicle)

	        		if not checkBlacklist then 
	        			if Fuel >= 100 then 
	        				ESX.ShowNotification("Votre véhicule à déja le plein !")
	        			else 	
	                        RageUI.Visible(RMenu:Get('mrw_gasoline', 'Gasoline Menu'), true)
	                    end
	                else 
	                	ESX.ShowNotification("Ce type de véhicule n'est pas ~r~autorisé~w~ !")
	                end  
	            else 
	            	ESX.ShowNotification("Rester dans votre véhicule !")
	            end    	
			end
			isInZone = false
		end
	end
end)

Citizen.CreateThread(function()
    for k,v in pairs(position) do
       	local blip = AddBlipForCoord(v[1], v[2], v[3])
		SetBlipSprite (blip, 361)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 6)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Station essences")
		EndTextCommandSetBlipName(blip)
    end
end)

-- RageUI.Progress(Label, ProgressStart, ProgressMax, Description, Counter, Enabled, Callback)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if RageUI.Visible(RMenu:Get('mrw_gasoline', 'Gasoline Menu')) then
    
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            	RageUI.Progress("Essence : "..startAmount..'litre(s), Prix : '..Gasoleprice..' ~g~$', startAmount, maxAmount, nil, false, true,function(Hovered, Active, Selected, Index)
            		Gasoleprice = startAmount * pricePerLitre
					startAmount = Index
					if (Selected) then
						local vehicle = GetVehiclePedIsUsing(PlayerPedId())
						local currentFuel = GetVehicleFuelLevel(vehicle) 
						print(currentFuel)
						print(startAmount)
                    	TriggerServerEvent('mrw_gasoline:checkLiter', GasoId, x,y,z, startAmount, Gasoleprice, currentFuel)
                    	RageUI.CloseAll()
                    end
                end)

                if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'fueler' and startMission  then 
                	if Distance3d(GetEntityCoords(PlayerPedId()), vector3(coordMission[1], coordMission[2], coordMission[3])) <= 25.0 then 
                		if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('phantom') then 
		                	RageUI.Button("Remplir la station", nil, {}, true, function(Hovered, Active, Selected)
		                		if (Selected) then 
		                			startMission = false 
		                			coordMission = {}
		                			TriggerServerEvent('mrw_gasoline:addGasole', GasoId)
		                			RageUI.CloseAll()
		                		end
		                    end)
		                else
		                   ESX.ShowNotification("Retourne chercher ton véhicule de service !")
		                end 
	                end
                end
            end, function()
            end)
        end
	end
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

RegisterNetEvent('mrw_gasoline:startAnimation')
AddEventHandler('mrw_gasoline:startAnimation', function(id, amountLiter, priceLiter)
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())

	if IsPedSittingInAnyVehicle(PlayerPedId()) then 
		TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
		Citizen.Wait(50)
        startAnim = true
        outVehicle = true  
	end

	if startAnim then 
	    Citizen.CreateThread(function()
		    RequestAnimDict('reaction@male_stand@small_intro@forward')
		    while not HasAnimDictLoaded('reaction@male_stand@small_intro@forward') do
		      Citizen.Wait(1)
		    end
		end) 
		   
	    TaskPlayAnim(PlayerPedId(), 'reaction@male_stand@small_intro@forward', 'react_forward_small_intro_a', 1.0, 2, -1, 49, 0, 0, 0, 0)
	    Citizen.Wait(10000)
	    ClearPedTasksImmediately(GetPlayerPed(-1))
	    finishAnim = true
	    if outVehicle and finishAnim then 
		   local vehicleUsed   = GetPlayersLastVehicle()
		   TaskEnterVehicle(PlayerPedId(), vehicleUsed, 1.5, -1, 1.0, 1, 0)
	    end
	    if finishAnim then 
	    	TriggerServerEvent('mrw_gasoline:payGasole', id, amountLiter, priceLiter)
	    	local fuel = GetVehicleFuelLevel(vehicle)
	    	local totalFuel = fuel + amountLiter
	    	local plate = GetVehicleNumberPlateText(vehicle)
	    	SetVehicleFuelLevel(vehicle, totalFuel)
            
            -- Support for esx_legacyfuel
			TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))
			TriggerEvent('LegacyFuel:supportGasoline', plate, round(GetVehicleFuelLevel(vehicle)))
        end
	    
	end
end)
