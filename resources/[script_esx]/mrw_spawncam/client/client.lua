-- Create by Morow for fantastic RP
-- Author : Morow 
-- GitHub : https://github.com/Morow73
-- No Edit, No Sell !!!!!!! 

ESX = nil

local firstSpawn, createDraw, display, isBlackedOut, PlayerData = true, false, false, false, {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

local function blackout()
    if not isBlackedOut then
        isBlackedOut = true
        Citizen.CreateThread(function()
            DoScreenFadeOut(100)
            while not IsScreenFadedOut() do
                Citizen.Wait(0)
            end
            Citizen.Wait(7000)
            DoScreenFadeIn(250)
        end)
    end
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "FantasticLogo",
        status = bool,
    }) 
end

function LoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString("STRING")
        AddTextComponentSubstringPlayerName(showText)
        EndTextCommandBusyString(showType)
    end)
end

function Cam()

	local x,y,z = 229.5582, -748.1517, 65.60
    FreezeEntityPosition(GetPlayerPed(-1), true)
	SetFocusArea(x,y,z, 0.0, 0.0, 0.0)
	displayHud = false
	ESX.UI.HUD.SetDisplay(0.0)
	TriggerEvent('esx_status:setDisplay', 0.0)

	LoadingPrompt("Chargement du mode Fantastic", 4)

    Citizen.SetTimeout(7000, function()
        RemoveLoadingPrompt()
        SetDisplay(not display)
         
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		isBlackedOut = false
		createDraw = true 
		
		SetCamCoord(cam, x,y,z)
		
		Citizen.CreateThread(function()
		    while createDraw do 
		    	Citizen.Wait(5000)
		    	x = x -0.1 
		    	y = y -0.1
		    	z = z
		        SetCamCoord(cam, x,y,z)
		    end
		end)

	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 180.0)
		RenderScriptCams(true,  false,  0,  true,  true)
		
		Citizen.CreateThread(function()
			while createDraw do 
				Citizen.Wait(0)
				HideHudAndRadarThisFrame() 
				SetTextScale(0.8, 0.8)
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextFont(7)
				SetTextEntry("STRING")
				AddTextComponentString("Bienvenue sur Fantastic [~b~ENTRER~w~ pour passer]")
				DrawText(0.4-0.13, 0.9*1.02) 

				if IsControlJustPressed(0, 18) then 
					TriggerEvent("ds_core:register2")
					SetFocusEntity(GetPlayerPed(PlayerId()))
					DestroyCam(cam, 0)
					RenderScriptCams(false,  false,  0,  false,  false)
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    ClearFocus()
				    createDraw = false 
					SetDisplay(false)
					displayHud = true
					ESX.UI.HUD.SetDisplay(1.0)
					TriggerEvent('esx_status:setDisplay', 1.0)
				end
			end
	    end)
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	if firstSpawn then
		ESX.TriggerServerCallback('mrw_spawncam:getPlayerName', function(cb)
			if cb ~= nil and not IsEntityDead(GetPlayerPed(-1)) then 
				blackout()
		        Cam()
				firstSpawn = false 
			end	
		end)	
	end
end)