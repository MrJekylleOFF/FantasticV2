ESX = nil
local PlayerData                = {}

local piloteHelico = {coords = vector3(463.50, -991.07, 43.69)}
local piloteHelicoPaleto = {coords = vector3(-467.1829, 5996.34, 31.25)}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

-- Zone de mise nettoyage

Citizen.CreateThread(function()
     while true do
          while ESX == nil do
               Citizen.Wait(10)
          end
		local sleepThread = 1000
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
        local distanceSortiePlanque1 = GetDistanceBetweenCoords(pedCoords, piloteHelico.coords, true)
        local distancePNJPaleto = GetDistanceBetweenCoords(pedCoords, piloteHelicoPaleto.coords, true)
        if distanceSortiePlanque1 <= 2.5 then
               sleepThread = 5
               ESX.Game.Utils.DrawText3D(piloteHelico.coords, "~b~[E] ~w~Transport en hélico\n~r~Transport automatique PNJ", 1.0)
			if IsControlJustPressed(0, 38) then
				OpenpiloteMenu()
            end
        end
        
        if distancePNJPaleto <= 2.5 then
            sleepThread = 5
            ESX.Game.Utils.DrawText3D(piloteHelicoPaleto.coords, "~b~[E] ~w~Transport en hélico\n~r~Transport automatique PNJ", 1.0)
         if IsControlJustPressed(0, 38) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
             OpenpiloteMenu()
         end
     end

		Citizen.Wait(sleepThread)
	end
end)