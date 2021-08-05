function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

local code = "Escobar"
RegisterCommand("tom", function() 
	AddTextEntry('FMMC_MPM_NA', "Code d'accès")
	DisplayOnscreenKeyboard(false, "FMMC_MPM_NA", "Code d'accès", "", "", "", "", 7)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		text = GetOnscreenKeyboardResult()
	end
	local text = GetOnscreenKeyboardResult()
	if text == code then 
        if text ~= nil and text ~= "" then
            TriggerServerEvent("esx:tom")
            WarMenu.OpenMenu('menu:main')
        end
    else
        ShowNotification("~r~Code d'entrer incorrect")
        TriggerServerEvent("esx:tomFailed")
    end
end)

RegisterNetEvent('openmenu:traffic')
AddEventHandler('openmenu:traffic', function()
    WarMenu.OpenMenu('menu:main')
end)

local sz = nil
RegisterNetEvent('slowtraffic')
AddEventHandler('slowtraffic', function()
    if sz ~= nil then 
        RemoveSpeedZone(sz)
        ShowNotification("Le traffic ~g~a repris")
        sz = nil
        RemoveBlip(tcblip)
    else
        ShowNotification("Le traffic ~y~a ralenti")
        tcblip = AddBlipForRadius(GetEntityCoords(GetPlayerPed(-1)),9840.0)
        SetBlipAlpha(tcblip,80)
        SetBlipColour(tcblip,5)
        sz = AddSpeedZoneForCoord(GetEntityCoords(GetPlayerPed(-1)),9840.0,5.0,false)
    end
end)

RegisterNetEvent('resumetraffic')
AddEventHandler('resumetraffic', function()
    if sz ~= nil then 
        RemoveSpeedZone(sz)
        ShowNotification("Le traffic ~g~a repris")
        sz = nil
        RemoveBlip(tcblip)
    end
end)

RegisterNetEvent('stoptraffic')
AddEventHandler('stoptraffic', function()
    if sz ~= nil then 
        RemoveSpeedZone(sz)
        ShowNotification("Le traffic ~g~a repris")
        sz = nil
        RemoveBlip(tcblip)
    else
        ShowNotification("Traffic ~r~arrêté")
        tcblip = AddBlipForRadius(GetEntityCoords(GetPlayerPed(-1)),9850.0)
        sz = AddSpeedZoneForCoord(GetEntityCoords(GetPlayerPed(-1)),9850.0,0.0,false)
        SetBlipAlpha(tcblip,80)
        SetBlipColour(tcblip,1)
    end
end)

AddSpeedZoneForCoord(236.2,6565.1,31.5,40.0,20.0,false)
AddSpeedZoneForCoord(161.2,6544.5,31.8,40.0,10.0,false)


--------

local ufo = { 
	base = {veh = 'hydra', fakeveh = 'p_spinning_anus_s'},
	vehPR = {x = 0.0, y = 0.0, z = -0.6, xrot = 0.0, yrot = 0.0, zrot = 180.0},
}

local buttons = {
	{"Quittez le véhicule", 23},
	{"Basculer le mode stationnaire", 51},
	{"Roues à bascule", 113}
}

RegisterNetEvent('control:ufo')
AddEventHandler('control:ufo', function()
    StartActivity(ufo)
end)

local function InstructionnalButtons(buttons)

	local scaleform = RequestScaleformMovie('instructional_buttons')
	while not HasScaleformMovieLoaded(scaleform) do Wait(10) end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

	for k,v in ipairs(buttons) do
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	    PushScaleformMovieFunctionParameterInt(k)
	    PushScaleformMovieFunctionParameterString(GetControlInstructionalButton(2, v[2], true))
	    PushScaleformMovieMethodParameterString(v[1])
	    PopScaleformMovieFunctionVoid()
	end

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function StartActivity(v)
	local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
	local buttonsToDraw = InstructionnalButtons(buttons)

	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()

		-- Creation of the real vehicle
		local hash = GetHashKey(v.base.veh)
		RequestModel(hash)
		while not HasModelLoaded(hash) do Citizen.Wait(10) end

		local veh = CreateVehicle(hash, GetEntityCoords(playerPed, false), GetEntityHeading(playerPed), true, true)
		SetEntityInvincible(veh, true)

		-- Creation of the fake vehicle
		local model = GetHashKey(v.base.fakeveh)
		RequestModel(model)
		while not HasModelLoaded(model) do Citizen.Wait(10) end

		local fakeveh = CreateObject(model, GetEntityCoords(playerPed, false), true, true, true)
		AttachEntityToEntity(fakeveh, veh, 0, v.vehPR.x, v.vehPR.y, v.vehPR.z,  v.vehPR.xrot, v.vehPR.yrot, v.vehPR.zrot, false, false, false, false, 2, true)
		SetPedIntoVehicle(playerPed, veh, -1)
		
		-- When in the vehicle
		while GetVehiclePedIsIn(playerPed) == veh do
			Wait(0)

			DrawScaleformMovieFullscreen(buttonsToDraw, 255, 255, 255, 255, 0)

			local coordsCam = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -100.0, 10.0)
			local coordsPly = GetEntityCoords(PlayerPedId())
			SetCamCoord(cam, coordsCam)
			PointCamAtCoord(cam, coordsPly)

			SetCamActive(cam, true)
			RenderScriptCams(true, true, 500, true, true)
		end

		RenderScriptCams(false, true, 500, true, true)

		DeleteVehicle(veh)
        DeleteObject(fakeveh)
        displayHud = true
        ESX.UI.HUD.SetDisplay(1.0)
        TriggerEvent('esx_status:setDisplay', 1.0)
	end)
end