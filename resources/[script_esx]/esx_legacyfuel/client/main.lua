models = {
	[1] = -2007231801,
	[2] = 1339433404,
	[3] = 1694452750,
	[4] = 1933174915,
	[5] = -462817101,
	[6] = -469694731,
	[7] = -164877493
}

blacklistedVehicles = {
	[1] = 'BMX',
	[2] = 'CRUISER',
	[3] = 'FIXTER',
	[4] = 'SCORCHER',
	[5] = 'TRIBIKE',
	[6] = 'TRIBIKE2',
	[7] = 'TRIBIKE3',
	[8] = 'CHEVALSURGE'
}

local Vehicles 				  = {}
local pumpLoc 				  = {}
local nearPump 				  = false
local IsFueling 			  = false
local IsFuelingWithJerryCan   = false
local InBlacklistedVehicle	  = false
local NearVehicleWithJerryCan = false
local price 				  = 0
local cash 					  = 0

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

function FuelVehicle()
	local ped 	  = GetPlayerPed(-1)
	local coords  = GetEntityCoords(ped)
	local vehicle = GetPlayersLastVehicle()

	FreezeEntityPosition(ped, true)
	FreezeEntityPosition(vehicle, false)
	SetVehicleEngineOn(vehicle, false, false, false)
	loadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 1.0, 2, -1, 49, 0, 0, 0, 0)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not InBlacklistedVehicle then

			if NearVehicleWithJerryCan and not nearPump then
				local vehicle  = GetPlayersLastVehicle()
				local coords   = GetEntityCoords(vehicle)
				local fuel 	   = round(GetVehicleFuelLevel(vehicle), 1)
				local jerrycan = GetAmmoInPedWeapon(GetPlayerPed(-1), 883325847)
				
				if IsFuelingWithJerryCan then
					DrawText3Ds(coords.x, coords.y, coords.z + 0.5, "Appuie sur ~g~G ~w~pour arreter d'alimenter le véhicule. Actuellement à:: " .. fuel .. "% - Jerry Can: " .. jerrycan)

					DisableControlAction(0, 0, true) -- Changing view (V)
					DisableControlAction(0, 22, true) -- Jumping (SPACE)
					DisableControlAction(0, 23, true) -- Entering vehicle (F)
					DisableControlAction(0, 24, true) -- Punching/Attacking
					DisableControlAction(0, 29, true) -- Pointing (B)
					DisableControlAction(0, 30, true) -- Moving sideways (A/D)
					DisableControlAction(0, 31, true) -- Moving back & forth (W/S)
					DisableControlAction(0, 37, true) -- Weapon wheel
					DisableControlAction(0, 44, true) -- Taking Cover (Q)
					DisableControlAction(0, 56, true) -- F9
					DisableControlAction(0, 82, true) -- Mask menu (,)
					DisableControlAction(0, 140, true) -- Hitting your vehicle (R)
					DisableControlAction(0, 166, true) -- F5
					DisableControlAction(0, 167, true) -- F6
					DisableControlAction(0, 168, true) -- F7
					DisableControlAction(0, 170, true) -- F3
					DisableControlAction(0, 288, true) -- F1
					DisableControlAction(0, 289, true) -- F2
					DisableControlAction(1, 323, true) -- Handsup (X)

					if IsControlJustReleased(0, 47) then
						loadAnimDict("reaction@male_stand@small_intro@forward")
						TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

						Citizen.Wait(2500)
						ClearPedTasksImmediately(GetPlayerPed(-1))
						FreezeEntityPosition(GetPlayerPed(-1), false)
						FreezeEntityPosition(vehicle, false)

						IsFuelingWithJerryCan = false
					end
				else
					DrawText3Ds(coords.x, coords.y, coords.z + 0.5, "Appuie sur ~g~G ~w~pour alimenter le véhicule avec votre bidon d'essence")

					if IsControlJustReleased(0, 47) then
						local vehicle = GetPlayersLastVehicle()
						local plate   = GetVehicleNumberPlateText(vehicle)

						ClearPedTasksImmediately(GetPlayerPed(-1))

						IsFuelingWithJerryCan = true

						FuelVehicle()
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		if IsFuelingWithJerryCan then
			local vehicle   = GetPlayersLastVehicle()
			local plate     = GetVehicleNumberPlateText(vehicle)
			local fuel 	    = GetVehicleFuelLevel(vehicle)
			local integer   = math.random(6, 10)
			local fuelthis  = integer / 10
			local newfuel   = fuel + fuelthis
			local jerryfuel = fuelthis * 100
			local jerrycurr = GetAmmoInPedWeapon(GetPlayerPed(-1), 883325847)
			local jerrynew  = jerrycurr - jerryfuel

			if jerrycurr >= jerryfuel then
				TriggerServerEvent('LegacyFuel:CheckServerFuelTable', plate)
				Citizen.Wait(150)
				SetPedAmmo(GetPlayerPed(-1), 883325847, round(jerrynew, 0))

				if newfuel < 100 then
					SetVehicleFuelLevel(vehicle, newfuel)

					for i=1, #Vehicles, 1 do
						if Vehicles[i].plate == plate then
							TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

							table.remove(Vehicles, i)
							table.insert(Vehicles, {plate = plate, fuel = newfuel})

							break
						end
					end
				else
					SetVehicleFuelLevel(vehicle, 100.0)
					loadAnimDict("reaction@male_stand@small_intro@forward")
					TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(2500)
					ClearPedTasksImmediately(GetPlayerPed(-1))
					FreezeEntityPosition(GetPlayerPed(-1), false)
					FreezeEntityPosition(vehicle, false)

					IsFuelingWithJerryCan = false

					for i=1, #Vehicles, 1 do
						if Vehicles[i].plate == plate then
							TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

							table.remove(Vehicles, i)
							table.insert(Vehicles, {plate = plate, fuel = newfuel})

							break
						end
					end
				end
			else
				loadAnimDict("reaction@male_stand@small_intro@forward")
				TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(2500)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				FreezeEntityPosition(GetPlayerPed(-1), false)
				FreezeEntityPosition(vehicle, false)

				IsFuelingWithJerryCan = false

				for i=1, #Vehicles, 1 do
					if Vehicles[i].plate == plate then
						TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

						table.remove(Vehicles, i)
						table.insert(Vehicles, {plate = plate, fuel = newfuel})

						break
					end
				end
			end
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			Citizen.Wait(2500)

			Timer = true
		else
			Timer = false
		end

		Citizen.Wait(250)
	end
end)

Citizen.CreateThread(function()
	while true do
		local myCoords = GetEntityCoords(GetPlayerPed(-1))

		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			local vehicle = GetPlayersLastVehicle()
			local plate   = GetVehicleNumberPlateText(vehicle)
			local fuel 	  = GetVehicleFuelLevel(vehicle)
			local found   = false

			TriggerServerEvent('LegacyFuel:CheckServerFuelTable', plate)

			Citizen.Wait(500)

			for i=1, #Vehicles, 1 do
				if Vehicles[i].plate == plate then
					found = true
					fuel  = round(Vehicles[i].fuel, 1)

					break
				end
			end

			if not found then
				integer = math.random(200, 800)
				fuel 	= integer / 8

				table.insert(Vehicles, {plate = plate, fuel = fuel})

				TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, fuel)
			end

			SetVehicleFuelLevel(vehicle, fuel)
		end

		local currentVeh = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))

		for i=1, #blacklistedVehicles, 1 do
			if blacklistedVehicles[i] == currentVeh then
				InBlacklistedVehicle = true
				found 				 = true
				
				break
			end
		end

		if not found then
			InBlacklistedVehicle = false
		end

		local CurrentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
						
		if CurrentWeapon == 883325847 then
			local MyCoords 		= GetEntityCoords(GetPlayerPed(-1))
			local Vehicle  		= GetClosestVehicle(MyCoords.x, MyCoords.y, MyCoords.z, 3.0, false, 23)

			if Vehicle ~= 0 then
				NearVehicleWithJerryCan = true
			end
		end

		Citizen.Wait(1500)

		nearPump 			 	= false
		IsCloseToLastVehicle 	= false
		found 				 	= false
		NearVehicleWithJerryCan = false
	end
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function GetSeatPedIsIn(ped)
	local vehicle = GetVehiclePedIsIn(ped, false)

	for i=-2, GetVehicleMaxNumberOfPassengers(vehicle) do
		if GetPedInVehicleSeat(vehicle, i) == ped then
			return i
		end
	end

	return -2
end

--[[function DisplayHud()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetSeatPedIsIn(GetPlayerPed(-1)) == -1 then
		local vehicle = GetPlayersLastVehicle()
		local fuel    = math.ceil(round(GetVehicleFuelLevel(vehicle), 1))
		local kmh 	  =	round(GetEntitySpeed(vehicle) * 3.6, 0)
		local mph 	  = round(GetEntitySpeed(vehicle) * 2.236936, 0)

		if fuel == 0 then
			fuel = "0"
		end
		if kmh == 0 then
			kmh = "0"
		end
		if mph == 0 then
			mph = "0"
		end

		x = 0.01135
		y = 0.002

		DrawAdvancedText(0.2195 - x, 0.77 - y, 0.005, 0.0028, 0.6, fuel, 255, 255, 255, 255, 6, 1)

		DrawAdvancedText(0.130 - x, 0.77 - y, 0.005, 0.0028, 0.6, mph, 255, 255, 255, 255, 6, 1)
		DrawAdvancedText(0.174 - x, 0.77 - y, 0.005, 0.0028, 0.6, kmh, 255, 255, 255, 255, 6, 1)

		DrawAdvancedText(0.148 - x, 0.7765 - y, 0.005, 0.0028, 0.4, "mp/h              km/h              Fuel", 255, 255, 255, 255, 6, 1)
	end
end]]

RegisterNetEvent('LegacyFuel:ReturnFuelFromServerTable')
AddEventHandler('LegacyFuel:ReturnFuelFromServerTable', function(vehInfo)
	local fuel   = round(vehInfo.fuel, 1)

	for i=1, #Vehicles, 1 do
		if Vehicles[i].plate == vehInfo.plate then
			table.remove(Vehicles, i)

			break
		end
	end

	table.insert(Vehicles, {plate = vehInfo.plate, fuel = fuel})
end)

RegisterNetEvent('LegacyFuel:supportGasoline')
AddEventHandler('LegacyFuel:supportGasoline', function(plate, fuel)
   	for i=1, #Vehicles, 1 do
		if Vehicles[i].plate == plate then
			table.remove(Vehicles, i)

			break
		end
	end

	table.insert(Vehicles, {plate = plate, fuel = fuel})
end)

Citizen.CreateThread(function()
	while true do
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
		local engine  = Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle)

		if vehicle and engine then
			local plate    	   = GetVehicleNumberPlateText(vehicle)
			local rpm 	   	   = GetVehicleCurrentRpm(vehicle)
			local fuel     	   = GetVehicleFuelLevel(vehicle)
			local rpmfuelusage = 0

			if rpm > 1.0 then
				rpmfuelusage = fuel - rpm / 1.5
				Citizen.Wait(1000)
			elseif rpm > 2.0 then
				rpmfuelusage = fuel - rpm / 2.5
				Citizen.Wait(1500)
			elseif rpm > 3.0 then
				rpmfuelusage = fuel - rpm / 3.5
				Citizen.Wait(2000)
			elseif rpm > 4.0 then
				rpmfuelusage = fuel - rpm / 4.5
				Citizen.Wait(3000)
			elseif rpm > 4.5 then
				rpmfuelusage = fuel - rpm / 5.0
				Citizen.Wait(4000)
			elseif rpm > 5.0 then
				rpmfuelusage = fuel - rpm / 6.0
				Citizen.Wait(5000)
			elseif rpm > 5.5 then
				rpmfuelusage = fuel - rpm / 7.0
				Citizen.Wait(6000)
			elseif rpm > 6.0 then
				rpmfuelusage = fuel - rpm / 8.0
				Citizen.Wait(8000)
			else
				rpmfuelusage = fuel - rpm / 4.0
				Citizen.Wait(15000)
			end

			for i = 1, #Vehicles do
				if Vehicles[i].plate == plate then
					SetVehicleFuelLevel(vehicle, rpmfuelusage)

					local updatedfuel = round(GetVehicleFuelLevel(vehicle), 1)

					if updatedfuel ~= 0 then
						TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, updatedfuel)

						table.remove(Vehicles, i)
						table.insert(Vehicles, {plate = plate, fuel = rpmfuelusage})
					end

					break
				end
			end

			if rpmfuelusage < Config.VehicleFailure then
				SetVehicleUndriveable(vehicle, true)
			elseif rpmfuelusage == 0 then
				SetVehicleEngineOn(vehicle, false, false, false)
			else
				SetVehicleUndriveable(vehicle, false)
			end
		end

		Citizen.Wait(5000)
	end
end)

local EnableHUD = true
local HUD = {
	
	Speed 			= 'kmh', 	-- kmh or mph
	DamageSystem 	= true, 
	SpeedIndicator 	= true,
	Plate 			= false, 	-- only if Top is false and you want to keep Plate Number
	Engine			= false,  	-- Engine Status off/on
	CarRPM			= true,  	-- Enables/Disables The RPM status of the car


}

local UI = { 

	x =  0.008 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y

}

local cruisecolor = false
local carspeed = nil

if EnableHUD then
	local function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
		SetTextFont(font)
		SetTextProportional(0)
		SetTextScale(sc, sc)
		N_0x4e096588b13ffeca(jus)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x - 0.1+w, y - 0.02+h)
	end


	local fuel = 0
	local displayHud = false

	local x = 0.01135
	local y = 0.002

	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) and not InBlacklistedVehicle then
				local vehicle = GetVehiclePedIsUsing(ped)
				local speed = GetEntitySpeed(vehicle)


				mph = tostring(math.ceil(speed * 2.236936))
				kmh = tostring(math.ceil(speed * 3.6))
				fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

				displayHud = true
			else
				displayHud = false

				Citizen.Wait(500)
			end

			Citizen.Wait(50)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			if displayHud then
				drawRct(UI.x + 0.745,	UI.y + 0.895, 0.080,0.02,255,255,255,25) -- BG essence 
				DrawAdvancedText(0.90 - x, 0.9095 - y, 0.022, 0.0073, 0.31, fuel, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.92 - x, 0.9095 - y, 0.013, 0.0070, 0.31, "%", 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.935 - x, 0.9095 - y, -0.074, 0.0070, 0.31, "Essence:", 255, 255, 255, 255, 6, 1)
				drawRct(UI.x + 0.742,	UI.y + 0.895, fuel/1230, 0.02,13, 13, 13, 220)
			else
				Citizen.Wait(750)
			end

			Citizen.Wait(0)
		end
	end)
end


Citizen.CreateThread(function()
	while true do Citizen.Wait(1)


		local MyPed = GetPlayerPed(-1)
		
		if(IsPedInAnyVehicle(MyPed, false))then
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(7)

			local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
			local VehBodyHP = GetVehicleBodyHealth(MyPedVeh)
            local RPM = GetVehicleCurrentRpm(MyPedVeh)									-- Check the rpm of the vehicle
			local model = GetVehicleClass(MyPedVeh)										-- Check the vehicle class/model

			if RPM > 0.99 then
				RPM = RPM*100
				RPM = RPM+math.random(-2,2)
				RPM = RPM/100
			end
			if carspeed == nil and cruisecolor == true then
				carspeed = Speed
			end

			if HUD.CarRPM and (model ~= 13) then
					drawRct(UI.x + 0.742, 	UI.y + 0.918, 0.170,0.02,255,255,255,25) -- Speed panel
					drawRct(UI.x + 0.742,	UI.y + 0.918, RPM/6, 0.02,13, 13, 13, 220)
			end
			
			if HUD.Speed == 'kmh' then
				Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
			elseif HUD.Speed == 'mph' then
				Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936
			else
				Speed = 0.0
			end
			 
			if HUD.SpeedIndicator then
				if HUD.Speed == 'kmh' then
					drawTxt(UI.x + 1.38, 	UI.y + 1.42, 1.01,1.020,0.35 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
					drawTxt(UI.x + 1.38, 	UI.y + 1.42, 0.99,1.020,0.35, "~w~ km/h", 255, 255, 255, 255)
				end
			end

			if HUD.DamageSystem then
				drawRct(UI.x + 0.823, UI.y + 0.895, 0.08699,0.02,255,255,255,25)
				drawRct(UI.x + 0.823, UI.y + 0.895, -0.0835 + VehBodyHP/5800,0.02,13, 13, 13, 220)
				drawTxt(UI.x + 0.875, UI.y + 0.896, 0.1,0.01,0.2, "🔧", 255, 255, 255, 255)
			end
		end		
	end
end)



function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end