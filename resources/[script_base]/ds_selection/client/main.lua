-----------------------------------------------------------------------------------------------
--				█▀▀█ █▀▀ ▀▀█▀▀ █▀▀█ █▀▀█ █▀▀▄ ░▀░ █░█   █▀▀ █▀▀█ █▀▀█ █▀▀
--				█▄▄▀ █▀▀ ░░█░░ █▄▄▀ █░░█ █░░█ ▀█▀ ▄▀▄   █░░ █░░█ █▄▄▀ █▀▀
--				▀░▀▀ ▀▀▀ ░░▀░░ ▀░▀▀ ▀▀▀▀ ▀░░▀ ▀▀▀ ▀░▀   ▀▀▀ ▀▀▀▀ ▀░▀▀ ▀▀▀
-----------------------------------------------------------------------------------------------

local PlayerData                = {}
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
end)

RegisterNetEvent("ds_core:register")
AddEventHandler("ds_core:register", function()
    Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), 409.42, -1001.14, -99.90, 0.0, 0.0, 0.0, true)
	FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("ds_core:animation")
    TriggerEvent("ds_core:camera")
	Visible()
end)

RegisterNetEvent("ds_core:visibleplayer")
AddEventHandler("ds_core:visibleplayer", function()
	Visiblee()
end)

RegisterNetEvent("ds_core:register2")
AddEventHandler("ds_core:register2", function()
    Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), 409.42, -1001.14, -99.90, 0.0, 0.0, 0.0, true)
	FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("ds_core:animation2")
    TriggerEvent("ds_core:camera")
	Visible()
end)

local heading = 360.00
local signmodel = GetHashKey("prop_police_id_board")
local textmodel = GetHashKey("prop_police_id_text")
local scaleform = {}
local text = {}
local enable = true
local enablee = false
local coords = nil
local notifytext = false
local cam = nil
local cam2 = nil
local cam3 = nil
local cam4 = nil
local cam5 = nil
local SignProp1 = {}
local SignProp2 = {}

Citizen.CreateThread(function()
  scaleform = LoadScaleform("mugshot_board_01")
  text = CreateNamedRenderTargetForModel("ID_TEXT", textmodel)

  while text do
      Citizen.Wait(1)
      SetTextRenderId(text) -- set render target
      Set_2dLayer(4)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
      DrawScaleformMovie(scaleform, 0.40, 0.35, 0.80, 0.75, 255, 255, 255, 255, 0)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
      SetTextRenderId(GetDefaultScriptRendertargetRenderId())
  end
end)

RegisterNetEvent('ds_core:camera')
AddEventHandler('ds_core:camera', function()
	local playerPed = GetPlayerPed(-1)
	Citizen.Wait(2000) 
	SetFocusEntity(playerPed)
	cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 415.55, -998.50, -99.29, 0.00, 0.00, 89.75, 50.00, false, 0)
    SetCamActive(cam2, true)
    RenderScriptCams(true, false, 2000, true, true)
end)

RegisterNetEvent('ds_core:camera2')
AddEventHandler('ds_core:camera2', function()
	local playerPed = GetPlayerPed(-1)
	SetFocusEntity(playerPed)
    cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 413.40, -998.43, -99.01, 0.00, 0.00, 89.75, 50.00, false, 0)
    PointCamAtCoord(cam3, 413.40, -998.43, -99.01)
    SetCamActiveWithInterp(cam3, cam2, 5000, true, true)
end)

RegisterNetEvent('ds_core:camera3')
AddEventHandler('ds_core:camera3', function()
	local playerPed = GetPlayerPed(-1)
	SetFocusEntity(playerPed)
    local pos = coords
	SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
    DoScreenFadeIn(500)
	FreezeEntityPosition(GetPlayerPed(-1), true)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    Citizen.Wait(500)
    cam5 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam5, pos.x,pos.y,pos.z+200)
    SetCamActiveWithInterp(cam5, cam4, 900, true, true)
    Citizen.Wait(900)
    cam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x,pos.y,pos.z+200, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam4, pos.x,pos.y,pos.z+2)
    SetCamActiveWithInterp(cam4, cam5, 3700, true, true)
    Citizen.Wait(3700)
    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    Citizen.Wait(500)
    SetCamActive(cam4, false)
    DestroyCam(cam4, true)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	TriggerEvent('esx_ambulancejob:multicharacter', GetPlayerServerId(PlayerId()))
	EnableAllControlActions(0)
	Collision(false)
end)

RegisterNetEvent("ds_core:animation")
AddEventHandler("ds_core:animation", function()
	local ped = PlayerPedId()
	local playerPed = GetPlayerPed()
	enable = true
	Session()
	Citizen.Wait(2000) 
    TriggerServerEvent("ds_core:createsign") 
	SetEntityHeading(PlayerPedId(), 350.0)
	DoScreenFadeIn(1000)
    AnimationIntro()
    Citizen.Wait(1000)
	SetCamActive(cam2, false)
	TriggerEvent("ds_core:camera2")
	while enable == true do
		ESX.ShowHelpNotification("~INPUT_FRONTEND_ACCEPT~ Pour choisir votre personnage.")
		Citizen.Wait(1)
        RequestAnimDict("mp_character_creation@customise@male_a")
        TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 1, 0, 0, 0)
		FreezeEntityPosition(PlayerPedId(), true)
        if IsControlJustReleased(1, 201) then
			FreezeEntityPosition(GetPlayerPed(-1), false)
			Citizen.Wait(200)
			DestroyAllCams(true)
			RequestAnimDict("mp_character_creation@lineup@male_a")
			TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)
			Citizen.Wait(2800)
			DeleteObject(SignProp1)
			DeleteObject(SignProp2)
			Citizen.Wait(5000)							
			SetCamActive(cam3, false)
			DestroyCam(createdCamera, 0)
			RenderScriptCams(0, 0, 1, 1, 1)
			createdCamera = 0
			enable = false
			Collision(false)
			DoScreenFadeOut(10)
			ClearTimecycleModifier("scanline_cam_cheap")
		--	TriggerEvent('ds_core:phase1')
        end
	end
end)

RegisterNetEvent("ds_core:animation2")
AddEventHandler("ds_core:animation2", function()
	local ped = PlayerPedId()
	local playerPed = GetPlayerPed()
	enable = true
	Session()
	Citizen.Wait(2000) 
    TriggerServerEvent("ds_core:createsign") 
    TriggerServerEvent("ds_core:lastpos")
	SetEntityHeading(PlayerPedId(), 350.0)
	DoScreenFadeIn(1000)
    AnimationIntro()
    Citizen.Wait(1000)
	SetCamActive(cam2, false)
	TriggerEvent("ds_core:camera2")
	while enable == true do
		ESX.ShowHelpNotification("Press ~INPUT_FRONTEND_ACCEPT~ to select character.")
		Citizen.Wait(1)
        RequestAnimDict("mp_character_creation@customise@male_a")
        TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 1, 0, 0, 0)
		FreezeEntityPosition(PlayerPedId(), true)
        if IsControlJustReleased(1, 201) then
			FreezeEntityPosition(GetPlayerPed(-1), false)
			Citizen.Wait(200)
			DestroyAllCams(true)
			RequestAnimDict("mp_character_creation@lineup@male_a")
			TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)
			Citizen.Wait(2800)
			DeleteObject(SignProp1)
			DeleteObject(SignProp2)
			Citizen.Wait(5000)			
			SetCamActive(cam3, false)
			enable = false
			DestroyCam(createdCamera, 0)
			RenderScriptCams(0, 0, 1, 1, 1)
			createdCamera = 0
			ClearTimecycleModifier("scanline_cam_cheap")
            TriggerEvent('ds_core:camera3')
            TriggerEvent('ds_core:lastpos')
        end
	end
end)

RegisterNetEvent("ds_core:createsign")
AddEventHandler("ds_core:createsign", function(name, job, money) 
    SignProp1 = CreateObject(signmodel, 1, 1, 1, false, true, false)
    SignProp2 = CreateObject(textmodel, 1, 1, 1, false, true, false)

    AttachEntityToEntity(SignProp1, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);
    AttachEntityToEntity(SignProp2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);

    local ScaleformMovie = RequestScaleformMovie("MUGSHOT_BOARD_01")

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    while HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
        PushScaleformMovieFunction(ScaleformMovie, "SET_BOARD")
        PushScaleformMovieFunctionParameterString(job)
        PushScaleformMovieFunctionParameterString(name)
        PushScaleformMovieFunctionParameterString("KONGERIKET")
        PushScaleformMovieFunctionParameterString(money)
        PushScaleformMovieFunctionParameterString(0)
        PushScaleformMovieFunctionParameterString(5)
        PushScaleformMovieFunctionParameterString(0)
        PopScaleformMovieFunctionVoid()
    end
end)

RegisterNetEvent("ds_core:lastpos")
AddEventHandler("ds_core:lastpos", function(position) 
    coords = position
end)

function AnimationIntro()
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityHeading(PlayerPedId(), 350.0)
    RequestAnimDict("mp_character_creation@lineup@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "intro", 1.0, 1.0, 5900, 0, 1, 0, 0, 0)
    Citizen.Wait(5700)
    RequestAnimDict("mp_character_creation@customise@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 1.0, 1.0, -1, 0, 1, 0, 0, 0)
end
	
function SpawnEntity()
    RequestAnimDict("mp_character_creation@lineup@male_a")
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)
    Citizen.Wait(8000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    DeleteObject(SignProp1)
    DeleteObject(SignProp2)
    RenderScriptCams(false, true, 500, true, true)                                              
    enable = false
end

function Session()
    SetEntityCoords(PlayerPedId(), 409.42, -1001.14, -99.90, 0.0, 0.0, 0.0, true)
    SetEntityHeading(PlayerPedId(), 350.0)
end

function Collision()
    for i=1,256 do
        if NetworkIsPlayerActive(i) then
            SetEntityVisible(GetPlayerPed(i), false, false)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
        end
    end
end

function Visible()
    while enable == true do
        Citizen.Wait(0)
        Collision()
    end
end

function Collisione()
    for i=1,256 do
        if NetworkIsPlayerActive(i) then
            SetEntityVisible(GetPlayerPed(i), false, false)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
        end
    end
end

function Visiblee()
    while enablee == true do
        Citizen.Wait(0)
        Collisione()
    end
end

function LoadScaleform (scaleform)
    local text = RequestScaleformMovie(scaleform)

    if text ~= 0 then
        while not HasScaleformMovieLoaded(text) do
            Citizen.Wait(0)
        end
    end

    return text
end




function CreateNamedRenderTargetForModel(name, model)
    local text = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, 0)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        text = GetNamedRendertargetRenderId(name)
    end

    return text
end

RegisterNUICallback("spawnPlayer", function(data)
	local Location = data["Location"]

	SpawnPlayer(Location)
end)

SpawnPlayer = function(Location)
	DoScreenFadeOut(500)

	while not IsScreenFadedOut() do
		Citizen.Wait(0)
	end

	SetNuiFocus(false, false)

	if Config.SpawnPoints[Location] then
		ESX.Game.Teleport(PlayerPedId(), Config.SpawnPoints[Location], function()
			FreezeEntityPosition(GetPlayerPed(-1), true)
			DoScreenFadeIn(500)
			enablee = false
			EnableAllControlActions(0)
			Collision(false)
			FreezeEntityPosition(GetPlayerPed(-1), false)
		end)
	end
end

RegisterNetEvent("ds_core:showmenu")
AddEventHandler("ds_core:showmenu", function()
	SetNuiFocus(true, true)

	SendNUIMessage({
		["Action"] = "OPEN_SPAWNMENU"
	})
end)