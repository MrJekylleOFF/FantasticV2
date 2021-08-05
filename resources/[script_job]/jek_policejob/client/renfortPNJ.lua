ESX = nil
local spawn = {}
local ZoneDeSpawnHeli = {coords = vector3(-468.596, 6038.115, 70.20)}
local MaxRenfort = 0
local renfortList = {}
local renfortBlip = {}
local renfortPed = {}
local renfortHelico = {}
local renfortHelicoPed = {}
local patrouilleMolduVeh = {}
local patrouilleMolduBlip = {}
local patrouilleMolduPed = {}
local vehicle = "police7"

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

_menuPool4 = NativeUI.CreatePool()
RenfortPNJMenu = NativeUI.CreateMenu("Menu véhicule", "~b~Sortir un véhicule de service.", 8, 200,nil,nil,nil)
_menuPool4:Add(RenfortPNJMenu)
_menuPool4:WidthOffset(80)


function SetVehicleMaxMods(vehicle)
    local props = {
        modEngine       = 3,
        modBrakes       = 3,
        modTransmission = 3,
        modSuspension   = 3,
        modTurbo        = true,
        windowTint = 0,
        modLivery = 2,
        plateIndex = 1,
    }
    SetVehicleDirtLevel(vehicle, 0.1)
    

    ESX.Game.SetVehicleProperties(vehicle, props)

end

local vehicule = {
    "police7",
    "policeold1",
    "police8",
    "police",
    "policet",
}

local ZoneDeSpawn = {coords = vector3(-450.821, 5992.636, 30.91)}

function RenfortPNJ(menu)
    local vehicule = NativeUI.CreateListItem("Véhicule pour renfort", vehicule, 1, "Permet de choisir en quels véhicule les renfort vont venir")
    menu:AddItem(vehicule)
    local renfortSUV = NativeUI.CreateItem("Demande de renfort", "~b~Arrière")
    menu:AddItem(renfortSUV)
    local renfortHELI = NativeUI.CreateItem("Demande de renfort HELICO", "")
    menu:AddItem(renfortHELI)
    local renfortSireneOn = NativeUI.CreateItem("Renfort sirène ~g~ON", "")
    menu:AddItem(renfortSireneOn)
    local renfortSireneOff = NativeUI.CreateItem("Renfort sirène ~r~OFF", "")
    menu:AddItem(renfortSireneOff)
    local renfortTerminer = NativeUI.CreateItem("Annulé la demande de renfort", "")
    menu:AddItem(renfortTerminer)
    menu.OnListChange = function(sender, item, index)
        if item == vehicule then
            local currentSelectedIndex = item:IndexToItem(index)
            vehicle = currentSelectedIndex
            --print(vehicle)
        end
    end

    

    menu.OnItemSelect = function(sender, item, index)
        if item == renfortSUV then
            --if MaxRenfort <= 1 then
                MaxRenfort = MaxRenfort + 1
                renfort = true
                local pedPlayer = GetPlayerPed(-1)
                local inVeh = IsPedInAnyVehicle(pedPlayer, false)
                if inVeh then
                    veh = GetVehiclePedIsIn(pedPlayer, false)
                    local clear = ESX.Game.IsSpawnPointClear(ZoneDeSpawn.coords, 8)

                    while not clear do
                        clear = ESX.Game.IsSpawnPointClear(ZoneDeSpawn.coords, 8)
                        ESX.ShowNotification("Point de spawn bloqué.")
                        Wait(100)
                    end

                    ESX.Game.SpawnVehicle(vehicle, ZoneDeSpawn.coords, 42.0, function(vehicule)
                        SetVehicleMaxMods(vehicule)
                        ped = CreatePedInsideVehicle(vehicule, 1, GetHashKey("s_m_y_cop_01"), -1, true, true)
                        TaskSetBlockingOfNonTemporaryEvents(ped, true)
                        TaskVehicleEscort(ped, vehicule, veh, -1, 320.0, 2883621, 1.0, 1, 30.0)

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

                        SetVehicleDoorsLocked(vehicule, 4)
 
                        blip = AddBlipForEntity(vehicule)
                        SetBlipSprite(blip, 56)
                        ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
                        SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
                        SetBlipScale(blip, 0.65) -- set scale
                        SetBlipShowCone(blip, true)
                        SetBlipShrink(blip, true)
                        ShowFriendIndicatorOnBlip(blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("~b~Patrouille moldu.")
                        EndTextCommandSetBlipName(blip)

                        table.insert(renfortList, vehicule)
                        table.insert(renfortBlip, blip) 
                        table.insert(renfortPed, ped) 
                    end)
                    ESX.ShowNotification("Renfort moldu en approche.")
                   --_menuPool4:CloseAllMenus()
                else
                    ESX.ShowNotification("Tu doit etre en véhicule pour te faire éscorter.")
                end
            --else
            --    ESX.ShowNotification("Vous avez demandez trop d'unité.")
            --end
        elseif item == renfortHELI then
                renfort = true
                local pedPlayer = GetPlayerPed(-1)
                local inVeh = IsPedInAnyVehicle(pedPlayer, false)
                if inVeh then
                    veh = GetVehiclePedIsIn(pedPlayer, false)
                    VehBlock = ESX.Game.GetVehiclesInArea(ZoneDeSpawnHeli.coords, 10)
                    for _, voiture in pairs(VehBlock) do
                        ESX.Game.DeleteVehicle(voiture)
                    end
    
                    ESX.Game.SpawnVehicle("polmav", ZoneDeSpawnHeli.coords, 95.0, function(vehicule)
                        SetVehicleMaxMods(vehicule)
                        ped = CreatePedInsideVehicle(vehicule, 6, GetHashKey("s_m_y_cop_01"), -1, true, false)
                        --TaskVehicleEscort(ped, vehicule, veh, -1, 320.0, 1074528293, 1.0, 1, 30.0)
                        SetCanAttackFriendly(ped, false, true)
                        TaskHeliChase(ped, veh, 0.0, 0.0, 80.0)
                        SetVehicleSearchlight(vehicule, true, false)
    
                        blip = AddBlipForEntity(vehicule)
                        SetBlipSprite(blip, 15)
                        ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
                        SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
                        SetBlipScale(blip, 0.65) -- set scale
                        SetBlipShowCone(blip, true)
                        SetBlipShrink(blip, true)
                        SetBlipCategory(blip, 7)
                        ShowFriendIndicatorOnBlip(blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("~b~Patrouille moldu.")
                        EndTextCommandSetBlipName(blip)
    
                        table.insert(renfortHelico, vehicule)
                        table.insert(renfortBlip, blip) 
                        table.insert(renfortHelicoPed, ped) 
                    end)
                    ESX.ShowNotification("Renfort moldu en approche.")
                    _menuPool4:CloseAllMenus()
                else
                    ESX.ShowNotification("Tu doit etre en véhicule pour te faire éscorter.")
                end
        elseif item == renfortSireneOn then  
            for _, voiture in pairs(renfortList) do
                SetVehicleSiren(voiture, true)
            end
        elseif item == renfortSireneOff then  
            for _, voiture in pairs(renfortList) do
                SetVehicleSiren(voiture, false)
            end
        elseif item == renfortTerminer then  
            for _, voiture in pairs(renfortList) do
                --ESX.Game.DeleteVehicle(voiture)
                ped = GetPedInVehicleSeat(voiture, -1)
                TaskVehicleDriveWander(ped, voiture, 85.0, 786603)
                SetVehicleAsNoLongerNeeded(voiture)
                SetPedAsNoLongerNeeded(ped)
            end
            for _, blip in pairs(renfortBlip) do
                RemoveBlip(blip)
            end
            for _, heli in pairs(renfortHelico) do
                DeleteEntity(heli)
            end
            for _, ped in pairs(renfortHelicoPed) do
                DeleteEntity(ped)
            end
            renfortList = {}
            renfortBlip = {}
            renfortPed = {}
            renfortHelico = {}
            renfortHelicoPed = {}
            MaxRenfort = 0
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
        _menuPool4:ProcessMenus()
        if count == 0 then
            RenfortPNJ(RenfortPNJMenu)
            count = 1
        end
    end
end)


_menuPool4:RefreshIndex()
_menuPool4:MouseControlsEnabled (false);
_menuPool4:MouseEdgeEnabled (false);
_menuPool4:ControlDisablingEnabled(false);
_menuPool4:WidthOffset(80)

function OpenRenfortPNJMenu(station)
    RenfortPNJMenu:Visible(not RenfortPNJMenu:Visible())
end


RegisterNetEvent("police:GetTable")
AddEventHandler("police:GetTable", function()
    local veh = ESX.Game.GetClosestVehicle(ZoneDeSpawn.coords)
    table.insert(patrouilleMolduVeh, veh)
    print("Vehicule: "..veh.." ajouté à la table")
    print(patrouilleMolduVeh)
end)