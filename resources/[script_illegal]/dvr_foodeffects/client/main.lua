ESX                  = nil

Citizen.CreateThread(function()
  while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(1)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  Stop()
end)

Config = {
  StatusBars = true
}

AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drug', 0, 'fas fa-pills blue', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(200)
  end)
end)

--Weed
RegisterNetEvent('dvr_foodeffects:onWeed')
AddEventHandler('dvr_foodeffects:onWeed', function()
  local playerPed = GetPlayerPed(-1)

  RequestAnimSet("move_m@hipster@a") 
  while not HasAnimSetLoaded("move_m@hipster@a") do
    Citizen.Wait(0)
  end 

  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bob', 0.1)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
  Citizen.Wait(Config.DvrtimeWeed)
  Stop()
end)

screen = false
--GHB
RegisterNetEvent('dvr_foodeffects:onGHB')
AddEventHandler('dvr_foodeffects:onGHB', function()
  local playerPed = GetPlayerPed(-1)

  RequestAnimDict("mp_suicide")
  TaskPlayAnim((playerPed), 'mp_suicide', 'pill', 8.0, 8.0, -1, 1, 0, 0, 0, 0)
  Citizen.Wait(5000)
  --TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bob', 0.1)
  screen = true
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedToRagdoll(playerPed, 60000, 60000, 0, 0, 0, 0)
  Citizen.Wait(60000)
  screen = false
  RequestAnimSet("move_m@drunk@verydrunk")
  while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
      Citizen.Wait(0)
  end
  SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
  Citizen.Wait(20000)
  Stop()
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(2)      
           if screen then 
            SetFollowPedCamViewMode(4)
         local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

         if HasScaleformMovieLoaded(scaleform) then

         PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
         BeginTextComponent("STRING")
         AddTextComponentString("~r~Vous êtes dans l'oubli !")
         EndTextComponent()
         PopScaleformMovieFunctionVoid()
           DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        
          end
      end
   end
end)


RegisterNetEvent('esx_cigaret:startSmoke')
AddEventHandler('esx_cigaret:startSmoke', function(source)
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
        if Config.StatusBars then
          print("status ok")
          TriggerEvent('esx_status:getStatus', 'drug', function(status)
                print("get status")
                if status.val > 900000 then
                  while true do
                    print("debut de la boucle")
                    Citizen.Wait(0)
                    print("Acro")
                    ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous faut encore de la nicotine~r~...")
                    print("milieu")
                    Wait(80000)
                    print("acro")
                    ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous faut encore de la nicotine~r~...")
                    Citizen.Wait(time)
                    Wait(50000)
                    ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous faut encore de la nicotine~r~...")
                    print("Fin de la boucle") 
                  Stop()
                  Wait(3600000)
                  end 
                else
                  Stop()
                  print("Stop()")
                end
          end)
        end               
	end)
end)

RegisterNetEvent('doli:startdoli')
AddEventHandler('doli:startdoli', function(source)
	  local playerPed = GetPlayerPed(-1)
    Citizen.CreateThread(function()
      print("doliprane")
      Citizen.Wait(8000)
      ESX.ShowNotification("~r~Doucement avec les doliprane~r~...")
      TriggerEvent('esx_status:getStatus', 'drug', function(status) 
      end)
    end)
end)


RegisterNetEvent('dvr_foodeffects:starteffectmeth')
 AddEventHandler('dvr_foodeffects:starteffectmeth', function()
    print("debut")
    local playerPed = GetPlayerPed(-1)
    local time = 80000
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'baraking', 0.3)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    RequestAnimSet("move_m@drunk@verydrunk")
    while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
    end
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
    DoScreenFadeOut(1000)
    Wait(1000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    StopAllScreenEffects()
    StartScreenEffect("Rampage",0,true)
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
    DoScreenFadeIn(1000)
    Wait(30000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    Wait(20000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    
    if Config.StatusBars then
      print("status ok")
      TriggerEvent('esx_status:getStatus', 'drug', function(status)
            print("get status")
            if status.val > 900000 then
              while true do  --- si plus que 90 alors acro
                print("debut de la boucle")
                SetTimecycleModifier("trevorspliff")
                Citizen.Wait(0)
                print("Acro")
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                print("milieu")
                Wait(80000)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Vite allez voir un medecin ~r~...")
                print("acro")
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                Citizen.Wait(time)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Vite allez voir un medecin ~r~...")
                Wait(50000)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                print("Fin de la boucle") 
              Stop()
              Wait(3600000)
              end
            else
              Stop()
              print("Stop()")
            end
      end)
    end
end)


RegisterNetEvent('dvr_foodeffects:starteffectlegacy')
 AddEventHandler('dvr_foodeffects:starteffectlegacy', function()
    print("debut")
    local playerPed = GetPlayerPed(-1)
    local time = 80000
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'jason', 0.3)
    RequestAnimSet("move_m@hurry_butch@a")
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
        Citizen.Wait(0)
    end
    DoScreenFadeOut(1000)
    Wait(1000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    StopAllScreenEffects()
    StartScreenEffect("Rampage",0,true)
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@hurry_butch@a", true)
    DoScreenFadeIn(1000)
    Wait(30000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    Wait(20000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    
    if Config.StatusBars then
      print("status ok")
      TriggerEvent('esx_status:getStatus', 'drug', function(status)
            print("get status")
            if status.val > 900000 then
              while true do  --- si plus que 90 alors acro
                print("debut de la boucle")
                SetTimecycleModifier("trevorspliff")
                Citizen.Wait(0)
                print("Acro")
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                print("milieu")
                Wait(80000)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Vite allez voir un medecin ~r~...")
                print("acro")
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                Citizen.Wait(time)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Vite allez voir un medecin ~r~...")
                Wait(50000)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                print("Fin de la boucle") 
              Stop()
              Wait(3600000)
              end
            else
              Stop()
              print("Stop()")
            end
      end)
    end
end)

RegisterNetEvent('dvr_foodeffects:starteffectmoukate')
 AddEventHandler('dvr_foodeffects:starteffectmoukate', function()
    print("debut")
    local playerPed = GetPlayerPed(-1)
    local time = 80000
    RequestAnimSet("move_m@hurry_butch@a")
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
        Citizen.Wait(0)
    end
    DoScreenFadeOut(1000)
    Wait(1000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    StopAllScreenEffects()
    StartScreenEffect("Rampage",0,true)
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@hurry_butch@a", true)
    DoScreenFadeIn(1000)
    Wait(30000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    Wait(20000)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    
    if Config.StatusBars then
      print("status ok")
      TriggerEvent('esx_status:getStatus', 'drug', function(status)
            print("get status")
            if status.val > 900000 then
              while true do  --- si plus que 90 alors acro
                print("debut de la boucle")
                SetTimecycleModifier("trevorspliff")
                Citizen.Wait(0)
                print("Acro")
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                print("milieu")
                Wait(80000)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Vite allez voir un medecin ~r~...")
                print("acro")
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                Citizen.Wait(time)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Vite allez voir un medecin ~r~...")
                Wait(50000)
                ESX.ShowNotification("~r~Vous êtes accro ~n~ ~s~Il vous en faut encore ~r~...")
                print("Fin de la boucle") 
              Stop()
              Wait(3600000)
              end
            else
              Stop()
              print("Stop()")
            end
      end)
    end
end)


 
function Stop()
  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    Wait(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    StopAllScreenEffects()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
  end)
end


RegisterNetEvent('dvr_foodeffects:reset')
AddEventHandler('dvr_foodeffects:reset', function()
  print("plus acro")
  SetPedArmour(GetPlayerPed(-1),0)
  StatSetInt(GetHashKey("MP0_STAMINA"), 20, true)
  RestorePlayerStamina(PlayerId(), 1.0)
  Stop()
  TriggerEvent('esx_status:remove', 'drug', 300000)
end)

