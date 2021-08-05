local EnableHUD = true

local UI = { 

	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y

}

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
	
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local RPM = GetVehicleCurrentRpm(vehicle)		
	
	Citizen.CreateThread(function()
		while true do Citizen.Wait(1)
			local MyPed = GetPlayerPed(-1)
			
			if(IsPedInAnyVehicle(MyPed, false))then
				if RPM > 0.99 then
					RPM = RPM*100
					RPM = RPM+math.random(-2,2)
					RPM = RPM/100
				end
				if carspeed == nil and cruisecolor == true then
					carspeed = Speed
				end
			end
		end
	end)
	
	if HUD.Speed == 'kmh' then
		Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
	elseif HUD.Speed == 'mph' then
		Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936
	else
		Speed = 0.0
	end

	local RPM = GetVehicleCurrentRpm(vehicle)	
	local VehBodyHP = GetVehicleBodyHealth(vehicle)	
	Citizen.CreateThread(function()
		
		while true do
			if displayHud then
				HideHudComponentThisFrame(9)
				HideHudComponentThisFrame(8)
				HideHudComponentThisFrame(7)

				-- ESSENCE
				drawRct(UI.x + 0.750,	UI.y + 0.895, 0.080,0.02,255,255,255,25) -- BG essence 
				DrawAdvancedText(0.90 - x, 0.9095 - y, 0.022, 0.0073, 0.31, fuel, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.92 - x, 0.9095 - y, 0.013, 0.0070, 0.31, "%", 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.935 - x, 0.9095 - y, -0.074, 0.0070, 0.31, "Essence:", 255, 255, 255, 255, 6, 1)
				drawRct(UI.x + 0.750,	UI.y + 0.895, fuel/1230, 0.02,0, 24, 40, 200)
			
				-- KMH
				drawRct(UI.x + 0.742, 	UI.y + 0.918, 0.170,0.02,255,255,255,25) -- Speed panel
				drawRct(UI.x + 0.742,	UI.y + 0.918, RPM/6, 0.02,0, 24, 40, 200)
				drawTxt(UI.x + 1.38, 	UI.y + 1.42, 1.01,1.020,0.35 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
				drawTxt(UI.x + 1.38, 	UI.y + 1.42, 0.99,1.020,0.35, "~w~ km/h", 255, 255, 255, 255)

				-- DEGATS
				drawRct(UI.x + 0.823, UI.y + 0.895, 0.08699,0.02,255,255,255,25)
				drawRct(UI.x + 0.823, UI.y + 0.895, -0.0835 + VehBodyHP/5800,0.02,0, 24, 40, 200)
				drawTxt(UI.x + 0.875, UI.y + 0.896, 0.1,0.01,0.2, "🔧", 255, 255, 255, 255)
			else
				Citizen.Wait(750)
			end

			Citizen.Wait(0)
		end
	end)
end

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








