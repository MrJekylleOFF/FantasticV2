local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = true
local blipActive = true
local mineActive = false
local washingActive = false
local remeltingActive = false
local firstspawn = true
local impacts = 0
local timer = 0
local time = 8000

---### PUNTOS MARCADORES RECOLECCION O FARMEO  DE MATERIAL          ###---
local locations = {
{ ['x'] =-553.19,  ['y'] = 5372.66 , ['z'] = 70.35},
{ ['x'] =-554.17,  ['y'] = 5369.96 , ['z'] = 70.36},
{ ['x'] =-555.03,  ['y'] = 5367.3 , ['z'] = 70.34},

{ ['x'] =-545.36,  ['y'] = 5385.99 , ['z'] = 70.37},
{ ['x'] =-543.63,  ['y'] = 5388.6 , ['z'] =70.29},
{ ['x'] =-541.2,  ['y'] =5393.23 , ['z'] =70.11},

{ ['x'] =-537.83,  ['y'] = 5372.75 , ['z'] = 70.61},
{ ['x'] =-538.77,  ['y'] = 5370.04 , ['z'] =70.48},

}
---### FIN ###  PUNTOS MARCADORES RECOLECCION O FARMEO  DE MATERIAL  ###---

---### PUNTOS MARCADORES Y LETRAS FLOTANTES DE PROCESAMIENTO ###---
local procesamiento2X = -524.86
local procesamiento2Y = 5285.99
local procesamiento2Z = 74.17

local procesamiento3X = -523.98
local procesamiento3Y = 5288.93
local procesamiento3Z = 74.17

local procesamiento4X = -524.15
local procesamiento4Y = 5293.98
local procesamiento4Z = 74.2

local procesamiento5X = -526.86
local procesamiento5Y = 5294.92
local procesamiento5Z = 74.17

---###      PUNTOS MARCADORES Y LETRAS FLOTANTES DE REFINERIA    ###---

local Refinado2X = -515.09
local Refinado2Y = 5263.56
local Refinado2Z = 80.65

local Refinado3X = -517.26
local Refinado3Y = 5257.43
local Refinado3Z = 80.65

local Refinado4X = -506.09
local Refinado4Y = 5262.96
local Refinado4Z = 80.62


---### FIN ### PUNTOS MARCADORES Y LETRAS FLOTANTES DE REFINERIA ###---


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
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent("esx_bucheronsjob:Procesamientomadera")
AddEventHandler("esx_bucheronsjob:Procesamientomadera", function()
    Procesamientomadera()
end)

RegisterNetEvent("esx_bucheronsjob:refinadomadera")
AddEventHandler("esx_bucheronsjob:refinadomadera", function()
    Refinadomadera()
end)

RegisterNetEvent('esx_bucheronsjob:Temporizadormadera')
AddEventHandler('esx_bucheronsjob:Temporizadormadera', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(150)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 


    Citizen.CreateThread(function()
        while true do

    local ped = PlayerPedId()

    Citizen.Wait(10)

            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.ProcesamientoX, Config.ProcesamientoY, Config.ProcesamientoZ, true) < 1.5 then
                Draw3DText(Config.ProcesamientoX, Config.ProcesamientoY, Config.ProcesamientoZ-2.0, ( Config.ProcesamientoLetra .. timer .. '%'), 4, 0.1, 0.1)
            --Draw3DText 
            end


---### PROCESAMIENTO SIN BLIPS ###---
            if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento2X, procesamiento2Y, procesamiento2Z, true) < 1.5 then
                Draw3DText(procesamiento2X, procesamiento2Y, procesamiento2Z-2.0, ( Config.ProcesamientoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento3X, procesamiento3Y, procesamiento3Z, true) < 1.5 then
                Draw3DText(procesamiento3X, procesamiento3Y, procesamiento3Z-2.0, ( Config.ProcesamientoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento4X, procesamiento4Y, procesamiento4Z, true) < 1.5 then
                Draw3DText(procesamiento4X, procesamiento4Y, procesamiento4Z-2.0, ( Config.ProcesamientoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento5X, procesamiento5Y, procesamiento5Z, true) < 1.5 then
                Draw3DText(procesamiento5X, procesamiento5Y, procesamiento5Z-2.0, ( Config.ProcesamientoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RefinadoX, Config.RefinadoY, Config.RefinadoZ, true) < 1.5 then
                Draw3DText(Config.RefinadoX, Config.RefinadoY, Config.RefinadoZ-2.0, ( Config.RefinadoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado2X, Refinado2Y, Refinado2Z, true) < 1.5 then
                Draw3DText(Refinado2X, Refinado2Y, Refinado2Z-2.0, ( Config.RefinadoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado3X, Refinado3Y, Refinado3Z, true) < 1.5 then
                Draw3DText(Refinado3X, Refinado3Y, Refinado3Z-2.0, ( Config.RefinadoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end

             if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado4X, Refinado4Y, Refinado4Z, true) < 1.5 then
                Draw3DText(Refinado4X, Refinado4Y, Refinado4Z-2.0, ( Config.RefinadoLetra .. timer .. '%'), 4, 0.1, 0.1)
            end
---### FIN ### PROCESAMIENTO SIN BLIPS ###---

            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
end)


RegisterNetEvent('esx_bucheronsjob:creadorblipmadera')
AddEventHandler('esx_bucheronsjob:creadorblipmadera', function()
    Citizen.CreateThread(function()
        blip1 = AddBlipForCoord(Config.BlipmaderaX, Config.BlipmaderaY, Config.BlipmaderaZ)
        blip2 = AddBlipForCoord(Config.ProcesamientoX, Config.ProcesamientoY, Config.ProcesamientoZ)
        blip3 = AddBlipForCoord(Config.RefinadoX, Config.RefinadoY, Config.RefinadoZ)

        
        SetBlipSprite(blip1, 238)
        SetBlipColour(blip1, 5)
        SetBlipScale(blip1,0.9)
        SetBlipAsShortRange(blip1, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.blipdemandera)
        EndTextCommandSetBlipName(blip1)  
        

        SetBlipSprite(blip2, 238)
        SetBlipColour(blip2, 5)
        SetBlipScale(blip2,0.9)
        SetBlipAsShortRange(blip2, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipProcesomiento)
        EndTextCommandSetBlipName(blip2)  

        SetBlipSprite(blip3, 238)
        SetBlipColour(blip3, 5)
        SetBlipScale(blip3,0.9)
        SetBlipAsShortRange(blip3, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipRefinado) 
        EndTextCommandSetBlipName(blip3)
    end)
end)

Citizen.CreateThread(function()

    blip1ve = AddBlipForCoord(Config.InicioTrabajoX, Config.InicioTrabajoY, Config.InicioTrabajoZ)
    SetBlipSprite(blip1ve, 238)
    SetBlipColour(blip1ve, 5)
    SetBlipScale(blip1ve,0.7)
    SetBlipAsShortRange(blip1ve, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipInicioTrabajo)
    EndTextCommandSetBlipName(blip1ve)  

end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
    local coords = GetEntityCoords(PlayerPedId()) 
    Citizen.Wait(1)
    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.InicioTrabajoX, Config.InicioTrabajoY, Config.InicioTrabajoZ, true) < 25 then
        DrawMarker(25, Config.InicioTrabajoX, Config.InicioTrabajoY, Config.InicioTrabajoZ-0.95, 0, 0, 0, 0, 0, 90.0, 2.0, 2.0, 1.0, 0, 155, 253, 100, 0, 0, 2, 0, 0, 0, 0)                
        if GetDistanceBetweenCoords(coords,  Config.InicioTrabajoX,Config.InicioTrabajoY,Config.InicioTrabajoZ, true) < 4.0 then
                DrawText3Ds(vector3(Config.InicioTrabajoX,Config.InicioTrabajoY,Config.InicioTrabajoZ), "[E] Ouvrir le menu", 0.35)    
        end    
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.InicioTrabajoX, Config.InicioTrabajoY, Config.InicioTrabajoZ, true) < 1 then
            ESX.ShowHelpNotification(Config.BotonInicioTrabajo)
                if IsControlJustReleased(1, 51) then
                    VestuarioMadera() 
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonRecoleccion)
                    if IsControlJustReleased(1, 51) then
                        Animacionmadera()
                        Citizen.Wait(time)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.ProcesamientoX, Config.ProcesamientoY, Config.ProcesamientoZ, true) < 25 and washingActive == false then
            DrawMarker(20, Config.ProcesamientoX, Config.ProcesamientoY, Config.ProcesamientoZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.ProcesamientoX, Config.ProcesamientoY, Config.ProcesamientoZ, true) < 1 then
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ Pour traiter le bois ")
              
                if IsControlJustReleased(1, 51) then
                    TriggerServerEvent("esx_bucheronsjob:Procesamientomadera")
                    Citizen.Wait(time)
                end
            end
        end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento2X, procesamiento2Y, procesamiento2Z, true) < 25 and washingActive == false then
            DrawMarker(20, procesamiento2X, procesamiento2Y, procesamiento2Z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento2X, procesamiento2Y, procesamiento2Z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonProcesamiento)
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_bucheronsjob:Procesamientomadera")
                            Citizen.Wait(time)
                end
            end
        end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento3X, procesamiento3Y, procesamiento3Z, true) < 25 and washingActive == false then
            DrawMarker(20, procesamiento3X, procesamiento3Y, procesamiento3Z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento3X, procesamiento3Y, procesamiento3Z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonProcesamiento)
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_bucheronsjob:Procesamientomadera")
                            Citizen.Wait(time)
                end
            end
        end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento4X, procesamiento4Y, procesamiento4Z, true) < 25 and washingActive == false then
            DrawMarker(20, procesamiento4X, procesamiento4Y, procesamiento4Z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento4X, procesamiento4Y, procesamiento4Z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonProcesamiento)
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_bucheronsjob:Procesamientomadera")
                            Citizen.Wait(time)
                end
            end
        end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento5X, procesamiento5Y, procesamiento5Z, true) < 25 and washingActive == false then
            DrawMarker(20, procesamiento5X, procesamiento5Y, procesamiento5Z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), procesamiento5X, procesamiento5Y, procesamiento5Z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonProcesamiento)
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_bucheronsjob:Procesamientomadera")
                            Citizen.Wait(time)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
     Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RefinadoX, Config.RefinadoY, Config.RefinadoZ, true) < 25 and remeltingActive == false then
            DrawMarker(20, Config.RefinadoX, Config.RefinadoY, Config.RefinadoZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RefinadoX, Config.RefinadoY, Config.RefinadoZ, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonRefinado)
                        if IsControlJustReleased(1, 51) then
                          TriggerServerEvent("esx_bucheronsjob:refinadomadera")  
                          Citizen.Wait(time)
                    end
                end
            end
               if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado2X, Refinado2Y ,Refinado2Z, true) < 25 and remeltingActive == false then
            DrawMarker(20, Refinado2X, Refinado2Y, Refinado2Z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado2X, Refinado2Y, Refinado2Z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonRefinado)
                        if IsControlJustReleased(1, 51) then
                          TriggerServerEvent("esx_bucheronsjob:refinadomadera")  
                          Citizen.Wait(time)
                    end
                end
            end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado3X, Refinado3Y, Refinado3Z, true) < 25 and remeltingActive == false then
            DrawMarker(20, Refinado3X, Refinado3Y, Refinado3Z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado3X, Refinado3Y, Refinado3Z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonRefinado)
                        if IsControlJustReleased(1, 51) then
                          TriggerServerEvent("esx_bucheronsjob:refinadomadera")  
                          Citizen.Wait(time)
                    end
                end
            end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado4X, Refinado4Y, Refinado4Z, true) < 25 and remeltingActive == false then
            DrawMarker(20, Refinado4X, Refinado4Y, Refinado4Z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 1, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Refinado4X, Refinado4Y, Refinado4Z, true) < 1 then
                    ESX.ShowHelpNotification(Config.BotonRefinado)
                        if IsControlJustReleased(1, 51) then
                          TriggerServerEvent("esx_bucheronsjob:refinadomadera")  
                          Citizen.Wait(time)
                    end
                end
            end
        end
    end)

DrawText3Ds = function(coords, text, scale)
    local x,y,z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 420

    DrawRect(_x, _y + 0.0115, 0.032 + factor, 0.033, 41, 11, 41, 100)
end

Citizen.CreateThread(function()
  local hash = GetHashKey(Config.ModeloNpc1)
    if not HasModelLoaded(hash) then
       RequestModel(hash)
      Citizen.Wait(100)
    end
    while not HasModelLoaded(hash) do
       Citizen.Wait(0)
    end
if firstspawn == true then
       local npc = CreatePed(6, hash, Config.NpcVenta1X, Config.NpcVenta1Y, Config.NpcVenta1Z,Config.NpcVenta1H, false, false)
             FreezeEntityPosition(npc, true) 
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            while not  TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", 0, false) do -- TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", 1, true) do
            Citizen.Wait(200)
            end             
            Citizen.Wait(200)   
        end
  end)

Citizen.CreateThread(function()
  local hash = GetHashKey(Config.ModeloNpc2)
    if not HasModelLoaded(hash) then
       RequestModel(hash)
      Citizen.Wait(100)
    end
    while not HasModelLoaded(hash) do
       Citizen.Wait(0)
    end
if firstspawn == true then
       local npc = CreatePed(6, hash, Config.NpcVenta2X, Config.NpcVenta2Y, Config.NpcVenta2Z, Config.NpcVenta2H, false, false)
             FreezeEntityPosition(npc, true) 
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            while not  TaskStartScenarioInPlace(npc, "WORLD_HUMAN_HAMMERING", 1, true) do 
            Citizen.Wait(1000)
            end             
            Citizen.Wait(200)   

        end
  end)

Citizen.CreateThread(function()
  local hash = GetHashKey(Config.ModeloNpc3)
    if not HasModelLoaded(hash) then
       RequestModel(hash)
      Citizen.Wait(100)
    end
    while not HasModelLoaded(hash) do
       Citizen.Wait(0)
    end
if firstspawn == true then
       local npc = CreatePed(6, hash, Config.NpcVenta3X, Config.NpcVenta3Y, Config.NpcVenta3Z, Config.NpcVenta3H, false, false)
             FreezeEntityPosition(npc, true) 
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            while not  TaskStartScenarioInPlace(npc,"WORLD_HUMAN_HAMMERING" , 1, true) do 
            Citizen.Wait(1000)
            end             
            Citizen.Wait(200)   

        end
  end)

function VestuarioMadera()
    local elements = {
        {label = '<span style="color:#06E931;">Prendre son service  </span>',      value = 'activar'},
        {label = 'Vehicule de travail ',       value = 'vehicle'},
        {label = 'Retour &nbsp;&nbsp;<span style="color:#EA1313;"> </span>',         value = 'Salir'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'miner_actions', {
        title    = ' Menu bûcheron ',
        align    = 'top-right',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'activar' then
            menu.close()
                TriggerEvent("esx_bucheronsjob:creadorblipmadera")
                ESX.ShowNotification("~g~Prise de service")
                Wait(800)
                ESX.ShowNotification("~r~INFO: OUBLIEZ PAS VOTRE HACHE")
                Wait(800)
                ESX.ShowNotification("~r~Allez en acheter une dans un shops si vous en avez pas")
      
elseif data.current.value == 'Salir' then
 menu.close()


        elseif data.current.value == 'vehicle' then
            menu.close()
            RequestModel(Config.Vehiculo)

            Citizen.Wait(100)
            CreateVehicle(Config.Vehiculo, Config.VehiclespawnX, Config.VehiclespawnY, Config.VehiclespawnZ, Config.VehiclespawnH, true, true)
           ESX.ShowNotification("Bon courage !")
          -- TriggerServerEvent("esx_bucheronsjob:giveitem")
        end
    end)
end



function Animacionmadera()
    Citizen.CreateThread(function()
        while impacts < 3 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("amb@world_human_hammering@male@base") 
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'amb@world_human_hammering@male@base', 'base', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'cortemadera', 4.0)
                SetEntityHeading(ped, 270.0)

                if impacts == 0 then
                    pickaxe = CreateObject(GetHashKey('prop_w_me_hatchet'), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, -0.02, -0.02, 350.0, 100.00, 280.0, true, true, false, true, 1, true)
                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 3 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                    TriggerServerEvent("esx_bucheronsjob:darmadera")
                    break
                end        
        end
    end)
end

function Procesamientomadera()
    local ped = PlayerPedId()
RequestAnimDict("mp_am_hold_up")
    washingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'mp_am_hold_up', 'purchase_beerbox_shopkeeper', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'procemadera', 4.0)
    TriggerEvent("esx_bucheronsjob:Temporizadormadera")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    washingActive = false

end

function Refinadomadera()
    local ped = PlayerPedId()
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)

TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, false)
TriggerEvent("esx_bucheronsjob:Temporizadormadera")

    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    remeltingActive = false
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 


    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   

end

DrawText3Ds = function(coords, text, scale)
    local x,y,z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 420

    DrawRect(_x, _y + 0.0115, 0.032 + factor, 0.033, 41, 11, 41, 100)
end
