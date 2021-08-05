ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

_pilotePool = NativeUI.CreatePool()
piloteMenu = NativeUI.CreateMenu("Menu véhicule", "~b~Sortir un véhicule de service.")
_pilotePool:Add(piloteMenu)
_pilotePool:WidthOffset(80)

local ZoneDeSpawnMissionRaw = {coords = vector3(448.86053, -991.73, 43.69)}
local ZoneDeSpawnPaleto = {coords = vector3(-474.62, 5989.16, 31.33)}

function PiloteMenuTransport(menu)
    local pedX = GetPlayerPed(-1)
    local pedCoordsX = GetEntityCoords(pedX)
    local distancePNJPaleto = GetDistanceBetweenCoords(pedCoordsX, ZoneDeSpawnPaleto.coords, true)
    if distancePNJPaleto > 100 then
        transportPaleto = NativeUI.CreateItem("Direction Paleto Bay", "~b~LSPD")
        menu:AddItem(transportPaleto)
    end
    local distancePNJMissionRow = GetDistanceBetweenCoords(pedCoordsX, ZoneDeSpawnMissionRaw.coords, true)
    if distancePNJMissionRow > 100 then
        transportMissionRaw = NativeUI.CreateItem("Direction Ville", "~b~LSPD")
        menu:AddItem(transportMissionRaw)
    end

    menu.OnItemSelect = function(sender, item, index)
        if item == transportPaleto then
            _pilotePool:CloseAllMenus()
            local pedPlayer = GetPlayerPed(-1)
            local closeHeli = ESX.Game.GetClosestVehicle(ZoneDeSpawnMissionRaw.coords)
            local heliCloseCoords = GetEntityCoords(closeHeli)
            local distanceCloseVeh = GetDistanceBetweenCoords(heliCloseCoords, ZoneDeSpawnMissionRaw.coords, true)
            if distanceCloseVeh <= 3.0 then
                TaskWarpPedIntoVehicle(pedPlayer, closeHeli, -2)
            else
                VehBlock = ESX.Game.GetVehiclesInArea(ZoneDeSpawnMissionRaw.coords, 5)
                for _, voiture in pairs(VehBlock) do
                    ESX.Game.DeleteVehicle(voiture)
                end

                ESX.Game.SpawnVehicle("buzzard", ZoneDeSpawnMissionRaw.coords, 95.0, function(vehicule)
                    SetVehicleMaxMods(vehicule)
                    ped = CreatePedInsideVehicle(vehicule, 6, GetHashKey("s_m_m_pilot_02"), -1, true, false)
                    --TaskVehicleEscort(ped, vehicule, veh, -1, 320.0, 1074528293, 1.0, 1, 30.0)
                    SetCanAttackFriendly(ped, false, true)
                    TaskWarpPedIntoVehicle(pedPlayer, vehicule, -2)
                    Wait(7000)
                    TaskHeliMission(ped, vehicule, 0, 0, ZoneDeSpawnPaleto.coords.x, ZoneDeSpawnPaleto.coords.y, ZoneDeSpawnPaleto.coords.z, 4, 300.0, 1.0, 32.0, -1, 70, -1, 32)
                    SetVehicleSearchlight(vehicule, true, false)


                    -- AI
                    SetCanAttackFriendly(ped, false, true)
                    SetPedAsCop(ped, true)
                    SetPedCombatAbility(ped, 0)
                    SetPedCombatAttributes(ped, 0, 1)
                    SetPedCombatAttributes(ped, 1, 1)
                    SetPedCombatAttributes(ped, 3, 0)
                    SetPedCombatAttributes(ped, 5, 0)
                    SetPedCombatAttributes(ped, 20, 1)
                    SetPedCombatAttributes(ped, 46, 0)
                    SetPedCombatAttributes(ped, 52, 0)
                    SetPedCombatRange(ped, 0)

                    local pedCoords = GetEntityCoords(ped)
                    local distanceArriver = GetDistanceBetweenCoords(pedCoords, ZoneDeSpawnPaleto.coords, true)
                    _pilotePool:CloseAllMenus()
                    while distanceArriver >= 20.5 do
                        local pedCoords = GetEntityCoords(ped)
                        distanceArriver = GetDistanceBetweenCoords(pedCoords, ZoneDeSpawnPaleto.coords, true)
                        Wait(1000)
                    end
                    ESX.ShowNotification("~g~Arrivé à déstination.")
                    Wait(5000)
                    DeleteEntity(vehicule)
                    DeleteEntity(ped)
                end)
                ESX.ShowNotification("Transport en cours.")
                _pilotePool:CloseAllMenus()
            end
        elseif item == transportMissionRaw then
            _pilotePool:CloseAllMenus()
            local pedPlayer = GetPlayerPed(-1)
            local closeHeli = ESX.Game.GetClosestVehicle(ZoneDeSpawnPaleto.coords)
            local heliCloseCoords = GetEntityCoords(closeHeli)
            local distanceCloseVeh = GetDistanceBetweenCoords(heliCloseCoords, ZoneDeSpawnPaleto.coords, true)
            if distanceCloseVeh <= 3.0 then
                TaskWarpPedIntoVehicle(pedPlayer, closeHeli, -2)
            else
                local VehBlock = ESX.Game.GetVehiclesInArea(ZoneDeSpawnPaleto.coords, 5)
                for _, voiture in pairs(VehBlock) do
                    ESX.Game.DeleteVehicle(voiture)
                end
                ESX.Game.SpawnVehicle("buzzard", ZoneDeSpawnPaleto.coords, 95.0, function(vehicule)
                    SetVehicleMaxMods(vehicule)
                    ped = CreatePedInsideVehicle(vehicule, 6, GetHashKey("s_m_m_pilot_02"), -1, true, false)
                    --TaskVehicleEscort(ped, vehicule, veh, -1, 320.0, 1074528293, 1.0, 1, 30.0)
                    SetCanAttackFriendly(ped, false, true)
                    TaskWarpPedIntoVehicle(pedPlayer, vehicule, -2)
                    Wait(7000)
                    TaskHeliMission(ped, vehicule, 0, 0, ZoneDeSpawnMissionRaw.coords.x, ZoneDeSpawnMissionRaw.coords.y, ZoneDeSpawnMissionRaw.coords.z, 4, 300.0, 1.0, 212.0, -1, 70, -1, 32)
                    SetVehicleSearchlight(vehicule, true, false)



                    -- AI
                    SetCanAttackFriendly(ped, false, true)
                    SetPedAsCop(ped, true)
                    SetPedCombatAbility(ped, 0)
                    SetPedCombatAttributes(ped, 0, 1)
                    SetPedCombatAttributes(ped, 1, 1)
                    SetPedCombatAttributes(ped, 3, 0)
                    SetPedCombatAttributes(ped, 5, 0)
                    SetPedCombatAttributes(ped, 20, 1)
                    SetPedCombatAttributes(ped, 46, 0)
                    SetPedCombatAttributes(ped, 52, 0)
                    SetPedCombatRange(ped, 0)


                    local pedCoords = GetEntityCoords(ped)
                    local distanceArriver = GetDistanceBetweenCoords(pedCoords, ZoneDeSpawnMissionRaw.coords, true)
                    _pilotePool:CloseAllMenus()
                    while distanceArriver >= 20.5 do
                        local pedCoords = GetEntityCoords(ped)
                        distanceArriver = GetDistanceBetweenCoords(pedCoords, ZoneDeSpawnMissionRaw.coords, true)
                        Wait(3000)
                    end
                    ESX.ShowNotification("~g~Arrivé à déstination.")
                    Wait(7000)
                    DeleteEntity(vehicule)
                    DeleteEntity(ped)
                end)
                ESX.ShowNotification("Transport en cours.")
                _pilotePool:CloseAllMenus()
            end
        end
    end
end


local count = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        while ESX == nil do
            Citizen.Wait(10)
        end
        _pilotePool:ProcessMenus()
        if count == 0 then
            PiloteMenuTransport(piloteMenu)
            count = 1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if not _pilotePool:IsAnyMenuOpen() then
            piloteMenu:Clear()
            PiloteMenuTransport(piloteMenu)
        end
        Wait(5000)
    end
end)



_pilotePool:RefreshIndex()
_pilotePool:MouseControlsEnabled (false);
_pilotePool:MouseEdgeEnabled (false);
_pilotePool:ControlDisablingEnabled(false);
_pilotePool:WidthOffset(80)

function OpenpiloteMenu(station)
    piloteMenu:Visible(not piloteMenu:Visible())
end

