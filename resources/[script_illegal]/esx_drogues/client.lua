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
end)

function hasItemCoke (cb)
    cb(true)
  end

function hasItemCoke (cb)
    if (ESX == nil) then return cb(0) end
        ESX.TriggerServerCallback('jek:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'coke_pooch')
 end

 function hasItemMeth (cb)
    cb(true)
  end

function hasItemMeth (cb)
    if (ESX == nil) then return cb(0) end
        ESX.TriggerServerCallback('jek:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'meth_pooch')
 end

 function hasItemWeed (cb)
    cb(true)
  end

function hasItemWeed (cb)
    if (ESX == nil) then return cb(0) end
        ESX.TriggerServerCallback('jek:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'weed_pooch')
 end


Citizen.CreateThread(function()
	while true do Wait(0)
        local playerPed = GetPlayerPed(-1)
        local coords = GetEntityCoords(playerPed)
        
        DrugZone = nil
        TypeZone = nil
        IsInZone = false

		for _,zone in pairs(Config.Zones) do
            local Recolte, Traitement, Vente, Name = zone.Recolte, zone.Traitement, zone.Vente, zone.Name
			
--			DrawMarker(1, Recolte.pos.x, Recolte.pos.y, Recolte.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Recolte.marker.size, Recolte.marker.size, 1.0, 100, false, true, 2, false, false, false, false)

			if Recolte ~= nil and GetDistanceBetweenCoords(coords, Recolte.pos.x, Recolte.pos.y, Recolte.pos.z) < Recolte.marker.size/2 then
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ Pour commencer a recolter " ..Name)
                DrugZone = Name
                TypeZone = "Recolte"
                IsInZone = true
                if IsControlJustReleased(0, 38)then
                    StartAction = true
                end
            elseif Vente ~= nil and GetDistanceBetweenCoords(coords, Vente.pos.x, Vente.pos.y, Vente.pos.z) < Vente.marker.size/2 then
               if zone.ItemsName[2] == 'coke_pooch' then
                hasItemCoke(function (hasItemCoke)
                    if hasItemCoke == true then
                        ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour vendre ~b~ "..zone.sellName)
                        if IsControlJustReleased(0, 38)then
                    StartAction = true
                        end
                    end
                end)
            elseif zone.ItemsName[2] == 'meth_pooch' then
                hasItemMeth(function (hasItemMeth)
                    if hasItemMeth == true then
                        ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour vendre ~b~ "..zone.sellName)
                        if IsControlJustReleased(0, 38)then
                    StartAction = true
                        end
                    end
                end)
            elseif zone.ItemsName[2] == 'weed_pooch' then
                hasItemWeed(function (hasItemWeed)
                    if hasItemWeed == true then
                        ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour vendre ~b~ "..zone.sellName)
                        if IsControlJustReleased(0, 38)then
                    StartAction = true
                        end
                    end
                end)
            end
            
            DrugZone = Name
            TypeZone = "Vente"
            IsInZone = true
            end
        end

        if IsInZone and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			CurrentType = TypeZone
            CurrentFarm = DrugZone
 
		end

		if not IsInZone and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
            CurrentType = nil
            CurrentFarm = nil
            StartAction = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do Wait(1000)
        if StartAction then
            if CurrentType == "Recolte" then
                TriggerServerEvent("Farm2:Recolte", CurrentFarm)
                TriggerEvent("Farm:animRammase")
            elseif CurrentType == "Vente" then
                TriggerServerEvent("Farm2:Vente", CurrentFarm)
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
