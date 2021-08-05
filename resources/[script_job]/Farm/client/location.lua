ESX = nil
currentLoc = nil

Citizen.CreateThread(function()
    --AddTextEntryByHash('bike', 'Mobylette')
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Wait(500)
    AddMenuJobMenu(mainMenu)
    for k,v in pairs(Config.Location) do
        SpawnPed("s_m_m_dockwork_01", v.ped.x, v.ped.y, v.ped.z-1, v.ped.h, "WORLD_HUMAN_AA_COFFEE")
        local blip = AddBlipForCoord(v.ped.x, v.ped.y, v.ped.z)
        SetBlipSprite(blip, 133)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 61)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Vehicule de travail")
        EndTextCommandSetBlipName(blip)
    end
end)

function SpawnPed(model, x, y, z, h, anim)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
      Wait(1)
    end
    local ped = CreatePed(2, model, x, y, z, h, false, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedDropsWeaponsWhenDead(ped, false)
    SetPedDiesWhenInjured(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanBeTargetted(ped, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    TaskStartScenarioInPlace(ped, anim, 0, false)
end

Citizen.CreateThread(function()

    while true do
        Wait(0)
        _menuPool:ProcessMenus()
        isNearLocation = false
        
        for k,v in pairs(Config.Location) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.ped.x, v.ped.y, v.ped.z)

            if dist <= 2.2 then
                isNearLocation = true
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour louer un véhicule")
				if IsControlJustPressed(1,51) then 
                    currentLoc = v
					mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
        
        if isNearLocation and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isNearLocation and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			mainMenu:Visible(false)
		end
    end
end)
