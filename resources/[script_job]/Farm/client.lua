ESX 			    			= nil
local DrugZone                  = nil
local TypeZone                  = nil
local IsInZone                  = nil
local CurrentZone               = nil
local CurrentFarm               = nil
local HasAlreadyEnteredMarker   = nil
local StartAction               = false
local mult                      = 1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    for _,zone in pairs(Config.Zones) do
        --print(json.encode(zone.Recolte.blip))
        if zone.Recolte.blip ~= nil then
            newBlip(zone.Recolte.pos, zone.Recolte.blip)
            newBlip(zone.Traitement.pos, zone.Traitement.blip)
        end
    end
end)

function newBlip(pos, data)
    local blip = AddBlipForCoord(pos.x, pos.y, pos.z)

        SetBlipSprite (blip, data.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, data.color)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.name)
        EndTextCommandSetBlipName(blip)
end


-- Render markers
Citizen.CreateThread(function()
	while true do Wait(0)
        local playerPed = GetPlayerPed(-1)
        local coords = GetEntityCoords(playerPed)
        
        DrugZone = nil
        TypeZone = nil
        IsInZone = false
		for _,zone in pairs(Config.Zones) do
            local Recolte, Traitement, Vente, Name = zone.Recolte, zone.Traitement, zone.Vente, zone.Name
			
			DrawMarker(1, Recolte.pos.x, Recolte.pos.y, Recolte.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Recolte.marker.size, Recolte.marker.size, 1.0, Recolte.marker.r, Recolte.marker.g, Recolte.marker.b, 100, false, true, 2, false, false, false, false)
			DrawMarker(1, Traitement.pos.x, Traitement.pos.y, Traitement.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Traitement.marker.size, Traitement.marker.size, 1.0, Traitement.marker.r, Traitement.marker.g, Traitement.marker.b, 100, false, true, 2, false, false, false, false)
			--DrawMarker(1, Vente.pos.x, Vente.pos.y, Vente.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Vente.marker.size, Vente.marker.size, 1.0, Vente.marker.r, Vente.marker.g, Vente.marker.b, 100, false, true, 2, false, false, false, false)
			
			if Recolte ~= nil and GetDistanceBetweenCoords(coords, Recolte.pos.x, Recolte.pos.y, Recolte.pos.z) < Recolte.marker.size/2 then
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ Pour commencer recolter ~b~Zone de " ..Name)
                DrugZone = Name
                TypeZone = "Recolte"
                IsInZone = true
                if IsControlJustReleased(0, 38)then
                    StartAction = true
                end
                
            elseif Traitement ~= nil and GetDistanceBetweenCoords(coords, Traitement.pos.x, Traitement.pos.y, Traitement.pos.z) < Traitement.marker.size/2 then
				ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour commencer a traiter ~b~Zone de "..Name)
					DrugZone = Name
					TypeZone = "Traitement"
					IsInZone = true
                if IsControlJustReleased(0, 38)then
                    StartAction = true
                end
                            
            elseif Vente ~= nil and GetDistanceBetweenCoords(coords, Vente.pos.x, Vente.pos.y, Vente.pos.z) < Vente.marker.size/2 then
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour vendre les ~b~ "..zone.sellName)
                DrugZone = Name
                TypeZone = "Vente"
                IsInZone = true
                if IsControlJustReleased(0, 38)then
                    StartAction = true
                end
            else
                --TypeZone = nil
            end
          
            --if IsControlJustReleased(0, 23)then
                --ESX.ShowNotification(GetInteriorFromEntity(playerPed))
                --ESX.ShowNotification(GetRoomKeyFromEntity(playerPed))
            --end
            
			
			--DrawMarker(1, Recolte.pos.x, Recolte.pos.y, Recolte.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
            --DrawMarker(1, Traitement.pos.x, Traitement.pos.y, Traitement.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
            --DrawMarker(1, Vente.pos.x, Vente.pos.y, Vente.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			
		end
        if IsInZone and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			CurrentType = TypeZone
            CurrentFarm = DrugZone
            --ESX.ShowNotification(tostring(TypeZone))
			--ESX.ShowNotification(tostring("Enter"))
		end

		if not IsInZone and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
            CurrentType = nil
            CurrentFarm = nil
            StartAction = false
			--ESX.ShowNotification(tostring("Exit"))
		end
	end
end)

Citizen.CreateThread(function()
	while true do Wait(1000)
        if StartAction then
            if CurrentType == "Recolte" then
                TriggerServerEvent("Farm:Recolte", CurrentFarm)
                TriggerEvent("Farm:animRammase")
            elseif CurrentType == "Traitement" then
                TriggerServerEvent("Farm:Traitement", CurrentFarm)
            elseif CurrentType == "Vente" then
                TriggerServerEvent("Farm:Vente", CurrentFarm)
            end                
            Wait(4000/mult)
        end
	end
end)

AddEventHandler('Farm:animRammase', function()
	ESX.Streaming.RequestAnimDict('anim@mp_snowball', function()
        TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_snowball', 'pickup_snowball', 9.0, -8, -1, 52, 0, 0, 0, 0)
        
	end)
end)

RegisterNetEvent('Farm:boostFarm')
AddEventHandler('Farm:boostFarm', function(_mult, _duration)
    mult = _mult
    Wait(_duration * 1000)
    mult = 1
end)
