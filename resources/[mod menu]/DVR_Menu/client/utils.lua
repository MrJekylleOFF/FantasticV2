ESX_READY = true 
if ESX_READY == true then 
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent("esx:getSharedObject", function(obj) ESX = obj
				Citizen.Wait(0)
			end)
		end
	end)
end

local jump1       = false
local godmode1    = false
local sprint1     = false
local invisible  = false
function loadAnimDict( dict ) 
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('esx_pouvoir:menuON')
AddEventHandler('esx_pouvoir:menuON', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_CAT_SLEEPING_GROUND", 0, 1) -- WORLD_RAST_EATING
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'peur', 0.1)
    PouvoirON1 = false
    RequestAnimSet("move_m@hurry_butch@a")
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
        Citizen.Wait(0)
    end
    DoScreenFadeOut(1000)
    Wait(1000)
    DoScreenFadeIn(1000)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    PouvoirON1 = true
    Wait(8000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_pouvoir:DVR__START')
AddEventHandler('esx_pouvoir:DVR__START', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_CAT_SLEEPING_GROUND", 0, 1) -- WORLD_RAST_EATING
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'peur', 0.1)
    PouvoirON1 = false
    RequestAnimSet("move_m@hurry_butch@a")
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
        Citizen.Wait(0)
    end
    DoScreenFadeOut(1000)
    Wait(1000)
    DoScreenFadeIn(1000)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    PouvoirON1 = true
    Wait(8000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_pouvoir:menuOFF')
AddEventHandler('esx_pouvoir:menuOFF', function()
    TriggerServerEvent('InteractSound_SV:PlayOnSource', '', 0)

    local playerPed = GetPlayerPed(-1)
    ClearTimecycleModifier(GetPlayerServerId(playerPed))
    ResetScenarioTypesEnabled(GetPlayerServerId(playerPed))
    StopAllScreenEffects(GetPlayerServerId(playerPed))
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedArmour(GetPlayerPed(-1),0)
    StatSetInt(GetHashKey("MP0_STAMINA"), 20, true)
    RestorePlayerStamina(PlayerId(playerPed), 1.0)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    StopAllScreenEffects()
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    print(playerPed)
end)

RegisterNetEvent('esx_pouvoir:menuClear')
AddEventHandler('esx_pouvoir:menuClear', function(args)
 ClearPedTasksImmediately(GetPlayerPed(-1))

end)
RegisterNetEvent('esx_pouvoir:menuCoffee')
AddEventHandler('esx_pouvoir:menuCoffee', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_AA_COFFEE", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuMandiez')
AddEventHandler('esx_pouvoir:menuMandiez', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_BUM_FREEWAY", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuFume')
AddEventHandler('esx_pouvoir:menuFume', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_AA_SMOKE", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuDormir')
AddEventHandler('esx_pouvoir:menuDormir', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_BUM_SLUMPED", 0, 1)
    --SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuTravail')
AddEventHandler('esx_pouvoir:menuTravail', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_BUM_WASH", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuSirculation')
AddEventHandler('esx_pouvoir:menuSirculation', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuAplaudir')
AddEventHandler('esx_pouvoir:menuAplaudir', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CHEERING", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuBoire')
AddEventHandler('esx_pouvoir:menuBoire', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuVente')
AddEventHandler('esx_pouvoir:menuVente', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRUG_DEALER", 0, 1)
    print('ttt')

end)
RegisterNetEvent('esx_pouvoir:menuPute')
AddEventHandler('esx_pouvoir:menuPute', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", 0, 1)
    local text = '*La personne fait la biatch *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)
RegisterNetEvent('esx_pouvoir:menuAbdo')
AddEventHandler('esx_pouvoir:menuAbdo', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_PUSH_UPS", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:new1')
AddEventHandler('esx_pouvoir:new1', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:clone1')
AddEventHandler('esx_pouvoir:clone1', function()
    local playerPed = PlayerPedId()
    ClonePed(playerPed, 60, true, false)
end)

RegisterNetEvent('esx_pouvoir:menuYoga')
AddEventHandler('esx_pouvoir:menuYoga', function()
    local playerPed = GetPlayerPed(-1)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_YOGA", 0, 1)
    print('ttt')
end)
RegisterNetEvent('esx_pouvoir:menuDoigt')
AddEventHandler('esx_pouvoir:menuDoigt', function()
    local player = GetPlayerPed(-1)
    local ad = "anim@mp_player_intupperfinger"
    loadAnimDict( ad )
    if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
        TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        Wait (100)
        ClearPedSecondaryTask(PlayerPedId())
    else
        TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end
    local text = '*La personne fait des fucks *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)
RegisterNetEvent('esx_pouvoir:menuSuicide')
AddEventHandler('esx_pouvoir:menuSuicide', function()
    local lPed = GetPlayerPed(-1)
    print('ttt')
    local text = '*La personne se suicide *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
    loadAnimDict( "mp_suicide" )
    TaskPlayAnim( lPed, "mp_suicide", "pistol", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
    Wait(1500)
    SetEntityHealth(lPed, 0)
    ClearPedTasksImmediately(GetPlayerPed(-1))
end)
RegisterNetEvent('esx_pouvoir:menuDeco')
AddEventHandler('esx_pouvoir:menuDeco', function()
    Citizen.InvokeNative(0xE574A662ACAEFBB1)
    local text = '*La personne se deconnecte *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)
RegisterNetEvent('esx_pouvoir:closestBraco')
AddEventHandler('esx_pouvoir:closestBraco', function()
    TriggerEvent( 'carry3:anim')
end)
RegisterNetEvent('esx_pouvoir:closestBGD')
AddEventHandler('esx_pouvoir:closestBGD', function()
    local text = '*La personne trouve Damon BG *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('esx_pouvoir:closestbg2')
AddEventHandler('esx_pouvoir:closestbg2', function()
    local text = '*La personne tombe sous le charme de Damon *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('esx_pouvoir:closestarm')
AddEventHandler('esx_pouvoir:closestarm', function()
    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), 1, false, true)
end)
RegisterNetEvent('esx_pouvoir:closestbg3')
AddEventHandler('esx_pouvoir:closestbg3', function()
    local text = '*La personne trouve DVR TROP BG *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)


RegisterNetEvent('esx_pouvoir:closestsuivre')
AddEventHandler('esx_pouvoir:closestsuivre', function()
    local ped = PlayerPedId()
    local player =  GetPedInFront()

    TaskFollowToOffsetOfEntity( ped, player, 0.5, 0.0, 0.0, 5.0, -1, 1.0, true)
end)

RegisterNetEvent('esx_pouvoir:suivreped')
AddEventHandler('esx_pouvoir:suivreped', function()
    local ped = PlayerPedId()
    local player =  GetPedInFront()

    TaskFollowToOffsetOfEntity( ped, player, 0.5, 0.0, 0.0, 5.0, -1, 1.0, true)
end)

RegisterNetEvent('esx_pouvoir:closestObjec0')
AddEventHandler('esx_pouvoir:closestObjec0', function()
    local force = 100.0
    local ped = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(ped, false)
	SetVehicleBoostActive(playerVeh, 1, 0)
    SetVehicleForwardSpeed(playerVeh, force)
    StartScreenEffect("RaceTurbo", 0, 0)
    SetVehicleBoostActive(playerVeh, 0, 0)
    local text = '*La personne active le nitro *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)


RegisterNetEvent('esx_pouvoir:closestPLACE')
AddEventHandler('esx_pouvoir:closestPLACE', function()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsUsing(ped)
    SetVehicleUndriveable(vehicle, true)
    local text = '*La personne coupe le moteur *' -- edit here if you want to change the language : EN: the person / FR: la personne
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('esx_pouvoir:GmodActive')
AddEventHandler('esx_pouvoir:GmodActive', function()
    godmode1 = not godmode1
    plyPed = PlayerPedId()
  
    Citizen.CreateThread(function()
        ESX.ShowNotification('God Mod activer')
        while true do
            Citizen.Wait(0)
            if godmode1 then
                SetEntityInvincible(plyPed, true)
            else 
                SetEntityInvincible(plyPed, false)
                godmode1 = false
                ESX.ShowNotification('God Mod desactiver')
            end
        end
    end)
end)

RegisterNetEvent('esx_pouvoir:punchActive')
AddEventHandler('esx_pouvoir:punchActive', function()
    ESX.ShowNotification("Super Punch Activer")
    ESX.ShowNotification('Merci de deco reco si vous voulez desactivez cette option')
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 10000.0) 
end)

RegisterNetEvent('esx_pouvoir:jumpActive')
AddEventHandler('esx_pouvoir:jumpActive', function()
    jump1 = not jump1
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if jump1 then
                SetSuperJumpThisFrame(PlayerId())
            else 
                jump1 = false
            end
        end
    end)
end)

RegisterNetEvent('esx_pouvoir:sprintActive')
AddEventHandler('esx_pouvoir:sprintActive', function()
    sprint1 = not sprint1
    if sprint1 then
        SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
    else 
        SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
        sprint1 = false
    end
end)

RegisterNetEvent('esx_pouvoir:invicibleActive')
AddEventHandler('esx_pouvoir:invicibleActive', function()
    invisible1 = not invisible1
    if invisible1 then
        SetEntityAlpha(GetPlayerPed(-1), 0.0)
    else 
        ResetEntityAlpha(GetPlayerPed(-1))
        invisible1 = false
    end
end)

RegisterNetEvent('esx_pouvoir:killactive')
AddEventHandler('esx_pouvoir:killactive', function()
    if  GetEntityHealth(PlayerPedId()) then
        SetEntityHealth(PlayerPedId(), 0)
    else
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()))
    end
end)

RegisterNetEvent('esx_pouvoir:GmodPucheffect')
AddEventHandler('esx_pouvoir:GmodPucheffect', function()
    if  GetEntityHealth(PlayerPedId()) then
        SetEntityHealth(PlayerPedId(), 0)
    else
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()))
    end
end)


RegisterCommand('v', function()
    while true do
        Citizen.Wait(1)
        SetUseHigherVehicleJumpForce('t20', true)
        print(SetUseHigherVehicleJumpForce('t20', true))
    end
end)



















