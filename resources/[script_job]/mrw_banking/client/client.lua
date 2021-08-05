-- Author : Morow 
-- GitHub : https://github.com/Morow73
-- No Edit, No Sell !!!!!!! 

position = {
	{ id=1, -386.733, 6045.953, 31.501},
	{ id=2, -284.037, 6224.385, 31.187},
	{ id=3, -284.037, 6224.385, 31.187},
	{ id=4, -135.165, 6365.738, 31.101},
	{ id=5, -110.753, 6467.703, 31.784},
	{ id=6, -94.9690, 6455.301, 31.784},
	{ id=7, 155.4300, 6641.991, 31.784},
	{ id=8, 174.6720, 6637.218, 31.784},
	{ id=9, 1703.138, 6426.783, 32.730},
	{ id=10, 1735.114, 6411.035, 35.164},
	{ id=11, 1702.842, 4933.593, 42.051},
	{ id=12, 1967.333, 3744.293, 32.272},
	{ id=13, 1821.917, 3683.483, 34.244},
	{ id=14, 1174.532, 2705.278, 38.027},
	{ id=15, 540.0420, 2671.007, 42.177},
	{ id=16, 2564.399, 2585.100, 38.016},
	{ id=17, 2558.683, 349.6010, 108.050},
	{ id=18, 2558.051, 389.4817, 108.660},
	{ id=19, 1077.692, -775.796, 58.218},
	{ id=20, 1139.018, -469.886, 66.789},
	{ id=21, 1168.975, -457.241, 66.641},
	{ id=22, 1153.884, -326.540, 69.245},
	{ id=23, 381.2827, 323.2518, 103.270},
	{ id=24, 236.4638, 217.4718, 106.840},
	{ id=25, 265.0043, 212.1717, 106.780},
	{ id=26, 285.2029, 143.5690, 104.970},
	{ id=27, 157.7698, 233.5450, 106.450},
	{ id=28, -164.568, 233.5066, 94.919},
	{ id=29, -1827.04, 785.5159, 138.020},
	{ id=30, -1409.39, -99.2603, 52.473},
	{ id=31, -1205.35, -325.579, 37.870},
	{ id=32, -1215.64, -332.231, 37.881},
	{ id=33, -2072.41, -316.959, 13.345},
	{ id=34, -2975.72, 379.7737, 14.992},
	{ id=35, -2962.60, 482.1914, 15.762},
	{ id=36, -2955.70, 488.7218, 15.486},
	{ id=37, -3044.22, 595.2429, 7.595},
	{ id=38, -3144.13, 1127.415, 20.868},
	{ id=39, -3241.10, 996.6881, 12.500},
	{ id=40, -3241.11, 1009.152, 12.877},
	{ id=41, -1305.40, -706.240, 25.352},
	{ id=42, -538.225, -854.423, 29.234},
	{ id=43, -711.156, -818.958, 23.768},
	{ id=44, -717.614, -915.880, 19.268},
	{ id=45, -526.566, -1222.90, 18.434},
	{ id=46, -256.831, -719.646, 33.444},
	{ id=47, -203.548, -861.588, 30.205},
	{ id=48, 112.4102, -776.162, 31.427},
	{ id=49, 112.9290, -818.710, 31.386},
	{ id=50, 119.9000, -883.826, 31.191},
	{ id=52, -846.304, -340.402, 38.687},
	{ id=53, -1204.35, -324.391, 37.877},
	{ id=54, -1216.27, -331.461, 37.773},
	{ id=55, -56.1935, -1752.53, 29.452},
	{ id=56, -261.692, -2012.64, 30.121},
	{ id=57, -273.001, -2025.60, 30.197},
	{ id=58, 314.187, -278.621, 54.170},
	{ id=59, -351.534, -49.529, 49.042},
	{ id=60, 24.589, -946.056, 29.357},
	{ id=61, -254.112, -692.483, 33.616},
	{ id=62, -1570.197, -546.651, 34.955},
	{ id=63, -1415.909, -211.825, 46.500},
	{ id=64, -1430.112, -211.014, 46.500},
	{ id=65, 33.232, -1347.849, 29.497},
	{ id=66, 129.216, -1292.347, 29.269},
	{ id=67, 287.645, -1282.646, 29.659},
	{ id=68, 289.012, -1256.545, 29.440},
	{ id=69, 295.839, -895.640, 29.217},
	{ id=70, 1686.753, 4815.809, 42.008},
	{ id=71, -302.408, -829.945, 32.417},
	{ id=72, 5.134, -919.949, 29.557},
	{ id=73, 147.79, -1035.38, 29.34},
	-- banking 
	{id=74, 150.266, -1040.203, 29.374},
	{id=75, -1212.980, -330.841, 37.787},
	{id=76, -2962.582,482.627, 15.703},
	{id=77, -112.202,6469.295, 31.626},
	{id=78, 314.187,-278.621, 54.170},
	{id=79, -351.534,-49.529, 49.042},
	{id=80, 241.727, 220.706, 106.286},
	{id=81, 1175.0643310547, 2706.6435546875, 38.094036102295}
}

RMenu.Add('mrw_banking', 'Atm Menu', RageUI.CreateMenu("Atm's", "Atm Banking", 10 , 200, nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_banking', 'Atm Menu'):SetRectangleBanner(255, 0, 0, 100)

local isInZone = false
local robCoord = {}
local amountTimer = 5 -- nbr for timer 

ESX = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(50)
          
		for k,v in pairs(position) do
			if Vdist2(GetEntityCoords(PlayerPedId()), v[1], v[2], v[3]) <= 1.0 then
				AtmId = v.id 
				x,y,z = v[1], v[2], v[3]
				isInZone = true 
				break
			end
		end		
        
        if isInZone then 

        	BeginTextCommandDisplayHelp("STRING")
            AddTextComponentSubstringPlayerName("Appuyez sur ~b~ ~INPUT_CONTEXT~ ~w~ pour accéder aux distributeur ou ~b~ G ~w~ pour le braquer !")
            EndTextCommandDisplayHelp(0, 0, 1, -1)

			if IsControlPressed(0, 38) then 
				RageUI.Visible(RMenu:Get('mrw_banking', 'Atm Menu'), true) 
			end

			if IsControlPressed(0, 47) then
				TriggerServerEvent('mrw_banking:startRob', AtmId, x,y,z)
			end

			isInZone = false 
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if RageUI.Visible(RMenu:Get('mrw_banking', 'Atm Menu')) then 

			RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

                RageUI.Button("Retirer de l'argent" , nil, {}, true, function(Hovered, Active, Selected)
               	    if (Selected) then 
                     	local amount = OpenKeyboardAmount()
				   	    if amount ~= nil then 
				   	    	TriggerServerEvent('mrw_banking:withdrawMoney', AtmId, x,y,z, amount)
				   	    end 
               	    end
                end)
                RageUI.Button("Deposer de l'argent", nil, {}, true, function(Hovered, Active, Selected)
               	    if (Selected) then 
                     	local amount = OpenKeyboardAmount()
				   	    if amount ~= nil then 
				   	    	TriggerServerEvent('mrw_banking:depositMoney', AtmId, x,y,z, amount)
				   	    end 
               	    end
                end)
                if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'brinks' and startMission then 
                	local coords = GetEntityCoords(PlayerPedId())
                	if Vdist2(coords, coordMission[1], coordMission[2], coordMission[3]) <= 3.0 then 
		                RageUI.Button("Ajouter de l'argent", nil, {}, true, function(Hovered, Active, Selected)
		                	if (Selected) then 
		                		startMission = false 
		                		coordMission = {}
								TriggerServerEvent('mrw_banking:addMoneyInAtm', AtmId, x,y,z)
								TriggerServerEvent('mrw_banking:RemoveItem')
		                		RageUI.Visible(RMenu:Get('mrw_banking', 'Atm Menu'), false) 
		                	end
		                end)
		            end
	            end  
	        end, function()
	        end)
        end
	end
end)

function OpenKeyboardAmount()
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
       Citizen.Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        result = GetOnscreenKeyboardResult()
        if tonumber(result) == nil  or tonumber(result) == -1 or tonumber(result) == 0 then
           ESX.ShowNotification('~r~Montant invalide !')
        else 
           return tonumber(result)
        end     
    end 
end

RegisterNetEvent('mrw_banking:startTimer')
AddEventHandler('mrw_banking:startTimer', function(id, posx,posy,posz)
   	local amount = amountTimer
	local pretime = amount * 60000 
	local time = pretime / 1000
    local robCoord = {x = posx, y = posy, z = posz}

    TriggerServerEvent('esx_addons_gcphone:startAnonymeCall', 'police', 'Un braquage est en cours !', robCoord , {

    	robCoord = { x = posx, y = posy, z = posz}
	})
	
	TriggerServerEvent('esx_addons_gcphone:startAnonymeCall', 'fbi', 'Un braquage est en cours !', robCoord , {

    	robCoord = { x = posx, y = posy, z = posz}
    })

    ESX.ShowNotification("La police à été ~r~alerté~w~ !")

	Citizen.CreateThread(function()
	    while time > 0 do
	        Citizen.Wait(1000) 
	        if Vdist2(GetEntityCoords(PlayerPedId()), posx,posy,posz) <= 3.0 then 
		        if time > 0 then 
		            time = time - 1
		            if time == 0 then 
	                   TriggerServerEvent('mrw_banking:finishTimer', id, posx,posy,posz)
		            end
		        end
		    else 
		    	time = 0
		    	ESX.ShowNotification("Vous sortez de la zone, le braquage est annulé !")
		    end    
	    end  
	end)

	Citizen.CreateThread(function()
		while time > 0 do
			Citizen.Wait(0)
			SetTextScale(0.5, 0.5)
			SetTextEntry("STRING")
			AddTextComponentString("Braquage en cour : ~r~"..string.format("%02.f", math.floor(time)).."~w~ secondes restante !")
			DrawText(0.4-0.05, 0.9*1.04) 
		end
    end)
end)

Citizen.CreateThread(function()
	for i=73,#position do
		local blip = AddBlipForCoord(position[i][1], position[i][2], position[i][3])
		SetBlipSprite (blip, 434)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 24)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Banque")
		EndTextCommandSetBlipName(blip)
	end
end)
