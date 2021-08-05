ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenVoteMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vote',
		{
			title    = "Candidats",
			elements = {
				{label = "Alex Stéréochoc", value = 'Alex Stéréochoc'},
				{label = "John Bowden", value = 'John Bowden'},
				{label = "Mario Loster",  value = 'Mario Loster'},-- value = nil}
				{label = "Retirer vote",  value = nil}
			}
		},
		function(data, menu)
			TriggerServerEvent("elec:vote",data.current.value)
			TriggerEvent('esx:showNotification', "Vous avez voté pour "..data.current.label)
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

-- Create blips
Citizen.CreateThread(function()
	  local blip = AddBlipForCoord(-266.36416625977, -2035.6640625, 29.145593643188)
	  SetBlipSprite (blip, 304)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 1.5)
	  SetBlipColour (blip, 1)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName('STRING')
	  AddTextComponentString('Élections Présidentielles')
	  EndTextCommandSetBlipName(blip)
  end)

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

-- Display markers
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.MarkerPos.x, v.MarkerPos.y, v.MarkerPos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.MarkerPos.x, v.MarkerPos.y, v.MarkerPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.MarkerPos.x, v.MarkerPos.y, v.MarkerPos.z, true) < v.Size.x) then
				drawTxt('Utiliser ~g~E~s~ pour ~b~voter', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				if IsControlJustPressed(1, 38) then
					OpenVoteMenu()
				end
			end
		end
	end
end)