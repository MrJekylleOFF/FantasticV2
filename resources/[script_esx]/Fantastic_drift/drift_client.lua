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

ESX = nil 
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

local kmh = 1.9
local mph = 1.33693629
local carspeed = 0
local driftmode = false -- on/off 
local speed = kmh -- or mph
local drift_speed_limit = 85.0

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(100)

		if IsControlPressed(1, 323) then -- Change the key here
			driftmode = not driftmode

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			if driftmode then
				ShowNotification("~g~Mode drift Activé~.")
			else
				ShowNotification("~r~Mode drift Desactivé~.")
			end
		end
		end

		if driftmode then

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then

				CarSpeed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1),false)) * speed

				if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),false), -1) == GetPlayerPed(-1) then

					if CarSpeed <= drift_speed_limit then  

						if IsControlPressed(1, 21) then
							if ESX.PlayerData.identifier == '66c3c4c6336adc6fb48b625296cfaf6a1fdc9769' then
								SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1),false), true)
							else
								SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1),false), true)
								Wait(500)
								SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1),false), false)
							end
						else
							SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1),false), false)
						end
					end
				end
			end
		end
	end
end)