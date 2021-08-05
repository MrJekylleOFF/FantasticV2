--------------------------------------------------[ KEYS ]--------------------------------------------------
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
--------------------------------------------------[ KEYS ]--------------------------------------------------
local redbookShow = false 
local PlayerData                = {}
local timer = 8000

ESX                             = nil


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  --radar()
  --photo()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job

end)

Citizen.CreateThread(function ()
	while true do 
		Citizen.Wait(1)
		--if PlayerData.job ~= nil and PlayerData.job.name == 'pizza' then
			if IsControlJustPressed(1, Keys["F6"] ) then
				ESX.ShowNotification("~r~POUR QUITTER ! ~n~~s~~g~Cliquer a l'exterieur de l'ecran et faite ~r~~n~[ECHAP]")

				if not redbookShow then
					openGui()
					local dict = "amb@world_human_seat_wall_tablet@female@base"

					RequestAnimDict(dict)
					while not HasAnimDictLoaded(dict) do
						Citizen.Wait(100)
					end
					TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
					
				else 
					closeGui()
				end
			end

			if IsControlPressed(1, Keys['=']) then
				closeGui()
			end

			if redbookShow then
				DisableControlAction(0, 1, redbookShow) 
		  	DisableControlAction(0, 2, redbookShow) 
		  	DisableControlAction(0, 142, redbookShow) 
				DisableControlAction(0, 106, redbookShow) 
			end
		--end
	end
end)

function openGui()
	SetNuiFocus(true, true)
	SendNUIMessage({openRedPad = true})
	redbookShow = true
end

function closeGui()
	SetNuiFocus(false)
  SendNUIMessage({openRedPad = false})
  redbookShow = false 
end

RegisterNUICallback('close', function(data, cb)
  closeGui()
  ClearPedTasks(GetPlayerPed(-1))
  cb('ok')
end)


