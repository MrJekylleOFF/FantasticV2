ESX = nil
--local ZoneDeSpawn = {coords = vector3(452.04, -997.05, 25.76)}
--local cameraCoords = {coords = vector3(445.26, -994.35, 25.997)}
local couleurVeh = "blanc"

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



local endroit = "M"
local previewCoords = {}
local pointDeSpawn = {}
local cameraCoords = {}
local heading = 0
Citizen.CreateThread(function()
    while true do
        local PlayerCoords = GetEntityCoords(GetPlayerPed(-1), true)
        local MissionRowCoords = {coords = vector3(-1077.07, -850.18, 4.88)}
        local PaletoBeaCoords = {coords = vector3(-455.246, 6019.278, 31.490)}
        local distanceMissionRow = GetDistanceBetweenCoords(PlayerCoords, MissionRowCoords.coords, true)
        local distancePaletoBea = GetDistanceBetweenCoords(PlayerCoords, PaletoBeaCoords.coords, true)

        if distanceMissionRow < distancePaletoBea then
            endroit = "M"
            previewCoords = {coords = vector3(463.51, -997.02, 25.76)}
            pointDeSpawn = {coords = vector3(436.58, -998.18, 25.75)}
            cameraCoords = {coords = vector3(449.69, -999.67, 27.72)}
            heading = 179.2
        else
            endroit = "P"
            previewCoords = {coords = vector3(-365.178, 6065.46, 31.50)}
            pointDeSpawn = {coords = vector3(-464.791, 6005.540, 31.34)}
            cameraCoords = {coords = vector3(-363.72, 6069.79, 33.49)}
            heading = 0.0
        end
        Wait(10000)
    end
end)

_menuPool3 = NativeUI.CreatePool()
NatveVehMenu = NativeUI.CreateMenu("Garage LSPD", "~b~Sortir un véhicule de service.", 8, 200,nil,nil,nil)
_menuPool3:Add(NatveVehMenu)
_menuPool3:WidthOffset(80)


function SetVehicleMaxMods(vehicle)
    local props = {
        modEngine       = 4,
        modBrakes       = 3,
        modTransmission = 3,
        modSuspension   = 3,
        modTurbo        = true,
        windowTint = 0,
        plateIndex = 1,
    }
    SetVehicleDirtLevel(vehicle, 0.0)
    

    ESX.Game.SetVehicleProperties(vehicle, props)

end

function couleurVehicule(veh)
    --print(couleurVeh)
    if couleurVeh == "bleu" then
        -- Preview
        SetVehicleCustomPrimaryColour(previewVeh, 0, 0, 255)
        SetVehicleCustomSecondaryColour(previewVeh, 0, 0, 255)
        -- Vrais véhicule
        SetVehicleCustomPrimaryColour(veh, 0, 0, 255)
        SetVehicleCustomSecondaryColour(veh, 0, 0, 255)
    elseif couleurVeh == "blanc" then
        -- Preview
        SetVehicleCustomPrimaryColour(previewVeh, 255, 255, 255)
        SetVehicleCustomSecondaryColour(previewVeh, 255, 255, 255)
        -- Vrais véhicule
        SetVehicleCustomPrimaryColour(veh, 255, 255, 255)
        SetVehicleCustomSecondaryColour(veh, 255, 255, 255)
    elseif couleurVeh == "noir" then
        SetVehicleCustomPrimaryColour(previewVeh, 0, 0, 0)
        SetVehicleCustomSecondaryColour(previewVeh, 0, 0, 0)
        SetVehicleCustomPrimaryColour(veh, 0, 0, 0)
        SetVehicleCustomSecondaryColour(veh, 0, 0, 0)
    elseif couleurVeh == "rouge" then
        SetVehicleCustomPrimaryColour(previewVeh, 255, 0, 0)
        SetVehicleCustomSecondaryColour(previewVeh, 255, 0, 0)
        SetVehicleCustomPrimaryColour(veh, 255, 0, 0)
        SetVehicleCustomSecondaryColour(veh, 255, 0, 0)
    elseif couleurVeh == "gris" then
        SetVehicleCustomPrimaryColour(previewVeh, 79, 79, 79)
        SetVehicleCustomSecondaryColour(previewVeh, 79, 79, 79)
        SetVehicleCustomPrimaryColour(veh, 79, 79, 79)
        SetVehicleCustomSecondaryColour(veh, 79, 79, 79)
    end
end


function menuVeh(menu)

    local Moto = NativeUI.CreateItem("Moto BMW ", "")
    local StatMoto = NativeUI.CreateStatisticsPanel()
    StatMoto:AddStatistics("Vitesse")
    StatMoto:SetPercentage(1, 80)
    
    StatMoto:AddStatistics("Maniabilité")
    StatMoto:SetPercentage(2, 60)
    
    StatMoto:AddStatistics("Nombre de place")
    StatMoto:SetPercentage(3, 20)
    
    Moto:AddPanel(StatMoto)
    menu:AddItem(Moto)


    local Chevrolet = NativeUI.CreateItem("Chevrolet", "")
    local StatChevrolet = NativeUI.CreateStatisticsPanel()
    StatChevrolet:AddStatistics("Vitesse")
    StatChevrolet:SetPercentage(1, 90)
    
    StatChevrolet:AddStatistics("Maniabilité")
    StatChevrolet:SetPercentage(2, 90)
    
    StatChevrolet:AddStatistics("Nombre de place")
    StatChevrolet:SetPercentage(3, 80)
    
    Chevrolet:AddPanel(StatChevrolet)
    menu:AddItem(Chevrolet)

    
    local Ford = NativeUI.CreateItem("Ford", "")
    local StatFord = NativeUI.CreateStatisticsPanel()
    StatFord:AddStatistics("Vitesse")
    StatFord:SetPercentage(1, 90)
    
    StatFord:AddStatistics("Maniabilité")
    StatFord:SetPercentage(2, 90)
    
    StatFord:AddStatistics("Nombre de place")
    StatFord:SetPercentage(3, 80)
    
    Ford:AddPanel(StatFord)
    menu:AddItem(Ford)

    local FordSUV = NativeUI.CreateItem("Ford SUV", "")
    local StatFordSUV = NativeUI.CreateStatisticsPanel()
    StatFordSUV:AddStatistics("Vitesse")
    StatFord:SetPercentage(1, 90)
    
    StatFordSUV:AddStatistics("Maniabilité")
    StatFordSUV:SetPercentage(2, 90)
    
    StatFordSUV:AddStatistics("Nombre de place")
    StatFordSUV:SetPercentage(3, 80)
    
    FordSUV:AddPanel(StatFordSUV)
    menu:AddItem(FordSUV)

    local Fords = NativeUI.CreateItem("Ford Sport", "")
    local StatFords = NativeUI.CreateStatisticsPanel()
    StatFords:AddStatistics("Vitesse")
    StatFords:SetPercentage(1, 90)
    
    StatFords:AddStatistics("Maniabilité")
    StatFords:SetPercentage(2, 90)
    
    StatFords:AddStatistics("Nombre de place")
    StatFords:SetPercentage(3, 80)
    
    Fords:AddPanel(StatFords)
    menu:AddItem(Fords)

    local Lambo = NativeUI.CreateItem("Lamborghini", "")
    local StatLambo= NativeUI.CreateStatisticsPanel()
    StatLambo:AddStatistics("Vitesse")
    StatLambo:SetPercentage(1, 90)
    
    StatLambo:AddStatistics("Maniabilité")
    StatLambo:SetPercentage(2, 90)
    
    StatLambo:AddStatistics("Nombre de place")
    StatLambo:SetPercentage(3, 80)
    
    Lambo:AddPanel(StatLambo)
    menu:AddItem(Lambo)

    local ChevroletBana = NativeUI.CreateItem("Chevrolet banalisé", "")
    local StatChevroletBana = NativeUI.CreateStatisticsPanel()
    StatChevroletBana:AddStatistics("Vitesse")
    StatChevroletBana:SetPercentage(1, 90)
    
    StatChevroletBana:AddStatistics("Maniabilité")
    StatChevroletBana:SetPercentage(2, 90)
    
    StatChevroletBana:AddStatistics("Nombre de place")
    StatChevroletBana:SetPercentage(3, 80)
    
    ChevroletBana:AddPanel(StatChevroletBana)
    menu:AddItem(ChevroletBana)

    local VoitureCiv1 = NativeUI.CreateItem("Voiture civil 1", "")
    local StatVoitureCiv1 = NativeUI.CreateStatisticsPanel()
    StatVoitureCiv1:AddStatistics("Vitesse")
    StatVoitureCiv1:SetPercentage(1, 90)
    
    StatVoitureCiv1:AddStatistics("Maniabilité")
    StatVoitureCiv1:SetPercentage(2, 90)
    
    StatVoitureCiv1:AddStatistics("Nombre de place")
    StatVoitureCiv1:SetPercentage(3, 80)
    
    VoitureCiv1:AddPanel(StatVoitureCiv1)
    menu:AddItem(VoitureCiv1)

    local VoitureCiv2 = NativeUI.CreateItem("Voiture civil 2", "")
    local StatVoitureCiv2 = NativeUI.CreateStatisticsPanel()
    StatVoitureCiv2:AddStatistics("Vitesse")
    StatVoitureCiv2:SetPercentage(1, 90)
    
    StatVoitureCiv2:AddStatistics("Maniabilité")
    StatVoitureCiv2:SetPercentage(2, 90)
    
    StatVoitureCiv2:AddStatistics("Nombre de place")
    StatVoitureCiv2:SetPercentage(3, 80)
    
    VoitureCiv2:AddPanel(StatVoitureCiv2)
    menu:AddItem(VoitureCiv2)

    local BlindeS = NativeUI.CreateItem("Blindé SWAT", "")
    local StatBlindeS = NativeUI.CreateStatisticsPanel()
    StatBlindeS:AddStatistics("Vitesse")
    StatBlindeS:SetPercentage(1, 90)
    
    StatBlindeS:AddStatistics("Maniabilité")
    StatBlindeS:SetPercentage(2, 90)
    
    StatBlindeS:AddStatistics("Nombre de place")
    StatBlindeS:SetPercentage(3, 80)
    
    BlindeS:AddPanel(StatBlindeS)
    menu:AddItem(BlindeS)

    local BlindeAE = NativeUI.CreateItem("Blindé anti-émeute", "")
    local StatBlindeAE = NativeUI.CreateStatisticsPanel()
    StatBlindeAE:AddStatistics("Vitesse")
    StatBlindeAE:SetPercentage(1, 90)
    
    StatBlindeAE:AddStatistics("Maniabilité")
    StatBlindeAE:SetPercentage(2, 90)
    
    StatBlindeAE:AddStatistics("Nombre de place")
    StatBlindeAE:SetPercentage(3, 80)
    
    BlindeAE:AddPanel(StatBlindeAE)
    menu:AddItem(BlindeAE)

    local couleur = {
        "blanc",
        "bleu",
        "noir",
        "rouge",
        "gris",
    }

    local couleur = NativeUI.CreateListItem("Couleur véhicule", couleur, 1, "Permet de choisir la couleur de son véhicule")
    menu:AddItem(couleur)
    menu.OnListChange = function(sender, item, index)
        if item == couleur then
            local currentSelectedIndex = item:IndexToItem(index)
            if currentSelectedIndex == "blanc" then
                couleurVeh = "blanc"
                couleurVehicule(previewVeh)
            elseif currentSelectedIndex == 'bleu' then
                couleurVeh = "bleu"
                couleurVehicule(previewVeh)
            elseif currentSelectedIndex == "noir" then
                couleurVeh = "noir"
                couleurVehicule(previewVeh)
            elseif currentSelectedIndex == "rouge" then
                couleurVeh = "rouge"
                couleurVehicule(previewVeh)
            elseif currentSelectedIndex == "gris" then
                couleurVeh = "gris"
                couleurVehicule(previewVeh)
            end
        end
    end

    menu.OnIndexChange = function(menu, newindex)
        --print(newindex)
        if newindex == 1 then
            DeleteEntity(previewVeh)
            if not HasModelLoaded(GetHashKey("policec")) then
                RequestModel(GetHashKey("policec"))
                while not HasModelLoaded(GetHashKey("policec")) do
                    Wait(10)
                end
            end 
            previewVeh = CreateVehicle(GetHashKey("policec"), previewCoords.coords, heading, false, 0)
            PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
            SetVehicleMaxMods(previewVeh)
            couleurVehicule(previewVeh)
            SetVehicleOnGroundProperly(previewVeh)
            FreezeEntityPosition(previewVeh, true)
            SetEntityCollision(previewVeh, false, false)
        elseif newindex == 2 then
            DeleteEntity(previewVeh)
            if not HasModelLoaded(GetHashKey("police22")) then
                RequestModel(GetHashKey("police22"))
                while not HasModelLoaded(GetHashKey("police22")) do
                    Wait(10)
                end
            end
            previewVeh = CreateVehicle(GetHashKey("police22"), previewCoords.coords, heading, false, 0)
            PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
            SetVehicleMaxMods(previewVeh)
            couleurVehicule(previewVeh)
            SetVehicleOnGroundProperly(previewVeh)
            FreezeEntityPosition(previewVeh, true)
            SetEntityCollision(previewVeh, false, false)
        elseif newindex == 3 then
            DeleteEntity(previewVeh)
            if not HasModelLoaded(GetHashKey("police2")) then
                RequestModel(GetHashKey("police2"))
                while not HasModelLoaded(GetHashKey("police2")) do
                    Wait(10)
                end
            end
            previewVeh = CreateVehicle(GetHashKey("police2"), previewCoords.coords, heading, false, 0)
            PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
            SetVehicleMaxMods(previewVeh)
            couleurVehicule(previewVeh)
            SetVehicleOnGroundProperly(previewVeh)
            FreezeEntityPosition(previewVeh, true)
            SetEntityCollision(previewVeh, false, false)
        elseif newindex == 4 then
            DeleteEntity(previewVeh)
            if not HasModelLoaded(GetHashKey("police3")) then
                RequestModel(GetHashKey("police3"))
                while not HasModelLoaded(GetHashKey("police3")) do
                    Wait(10)
                end
            end
            previewVeh = CreateVehicle(GetHashKey("police3"), previewCoords.coords, heading, false, 0)
            PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
            SetVehicleMaxMods(previewVeh)
            couleurVehicule(previewVeh)
            SetVehicleOnGroundProperly(previewVeh)
            FreezeEntityPosition(previewVeh, true)
            SetEntityCollision(previewVeh, false, false)
        elseif newindex == 5 then
            DeleteEntity(previewVeh)
            if not HasModelLoaded(GetHashKey("police6")) then
                RequestModel(GetHashKey("police6"))
                while not HasModelLoaded(GetHashKey("police6")) do
                    Wait(10)
                end
            end
            previewVeh = CreateVehicle(GetHashKey("police6"), previewCoords.coords, heading, false, 0)
            PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
            SetVehicleMaxMods(previewVeh)
            couleurVehicule(previewVeh)
            SetVehicleOnGroundProperly(previewVeh)
            FreezeEntityPosition(previewVeh, true)
            SetEntityCollision(previewVeh, false, false)
        elseif newindex == 6 then
            DeleteEntity(previewVeh)
            if not HasModelLoaded(GetHashKey("police18")) then
                RequestModel(GetHashKey("police18"))
                while not HasModelLoaded(GetHashKey("police18")) do
                    Wait(10)
                end
            end
            previewVeh = CreateVehicle(GetHashKey("police18"), previewCoords.coords, heading, false, 0)
            PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
            SetVehicleMaxMods(previewVeh)
            couleurVehicule(previewVeh)
            SetVehicleOnGroundProperly(previewVeh)
            FreezeEntityPosition(previewVeh, true)
            SetEntityCollision(previewVeh, false, false)
    elseif newindex == 7 then
        DeleteEntity(previewVeh)
        if not HasModelLoaded(GetHashKey("police13")) then
            RequestModel(GetHashKey("police13"))
            while not HasModelLoaded(GetHashKey("police13")) do
                Wait(10)
            end
        end
        previewVeh = CreateVehicle(GetHashKey("police13"), previewCoords.coords, heading, false, 0)
        PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
        SetVehicleMaxMods(previewVeh)
        couleurVehicule(previewVeh)
        SetVehicleOnGroundProperly(previewVeh)
        FreezeEntityPosition(previewVeh, true)
        SetEntityCollision(previewVeh, false, false)
    elseif newindex == 8 then
        DeleteEntity(previewVeh)
        if not HasModelLoaded(GetHashKey("jackal")) then
            RequestModel(GetHashKey("jackal"))
            while not HasModelLoaded(GetHashKey("jackal")) do
                Wait(10)
            end
        end
        previewVeh = CreateVehicle(GetHashKey("jackal"), previewCoords.coords, heading, false, 0)
        PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
        SetVehicleMaxMods(previewVeh)
        couleurVehicule(previewVeh)
        SetVehicleOnGroundProperly(previewVeh)
        FreezeEntityPosition(previewVeh, true)
        SetEntityCollision(previewVeh, false, false)
    elseif newindex == 9 then
        DeleteEntity(previewVeh)
        if not HasModelLoaded(GetHashKey("sultan")) then
            RequestModel(GetHashKey("sultan"))
            while not HasModelLoaded(GetHashKey("sultan")) do
                Wait(10)
            end
        end
        previewVeh = CreateVehicle(GetHashKey("sultan"), previewCoords.coords, heading, false, 0)
        PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
        SetVehicleMaxMods(previewVeh)
        couleurVehicule(previewVeh)
        SetVehicleOnGroundProperly(previewVeh)
        FreezeEntityPosition(previewVeh, true)
        SetEntityCollision(previewVeh, false, false)
    elseif newindex == 10 then
        DeleteEntity(previewVeh)
        if not HasModelLoaded(GetHashKey("riot")) then
            RequestModel(GetHashKey("riot"))
            while not HasModelLoaded(GetHashKey("riot")) do
                Wait(10)
            end
        end
        previewVeh = CreateVehicle(GetHashKey("riot"), previewCoords.coords, heading, false, 0)
        PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
        SetVehicleMaxMods(previewVeh)
        couleurVehicule(previewVeh)
        SetVehicleOnGroundProperly(previewVeh)
        FreezeEntityPosition(previewVeh, true)
        SetEntityCollision(previewVeh, false, false)
    elseif newindex == 11 then
        DeleteEntity(previewVeh)
        if not HasModelLoaded(GetHashKey("riot2")) then
            RequestModel(GetHashKey("riot2"))
            while not HasModelLoaded(GetHashKey("riot2")) do
                Wait(10)
            end
        end
        previewVeh = CreateVehicle(GetHashKey("riot2"), previewCoords.coords, heading, false, 0)
        PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
        SetVehicleMaxMods(previewVeh)
        couleurVehicule(previewVeh)
        SetVehicleOnGroundProperly(previewVeh)
        FreezeEntityPosition(previewVeh, true)
        SetEntityCollision(previewVeh, false, false)
    end

end

    menu.OnItemSelect = function(sender, item, index)
        if item == Moto then
            spawnVeh("Mission row", "policec")
        elseif item == Chevrolet then
            spawnVeh("Mission row", "police22")
        elseif item == Ford then
            spawnVeh("Mission row", "police2")
        elseif item == FordSUV then
           spawnVeh("Mission row", "police3")
        elseif item == Fords then
            spawnVeh("Mission row", "police6")
        elseif item == Lambo then
            spawnVeh("Mission row", "police18")
        elseif item == ChevroletBana then
            spawnVeh("Misson row", "police13")
        elseif item == VoitureCiv1 then
           spawnVeh("Mission row", "jackal")
        elseif item == VoitureCiv2 then
            spawnVeh("Misson row", "sultan")
        elseif item == BlindeS then
            spawnVeh("Misson row", "riot")
        elseif item == BlindeAE then
            spawnVeh("Misson row", "riot2")
        end
    end
end


function spawnVeh(zone, vehicle)
    if endroit == "P" then
        VehBlock = ESX.Game.GetVehiclesInArea(pointDeSpawn.coords, 10)
        for _, voiture in pairs(VehBlock) do
	    	ESX.Game.DeleteVehicle(voiture)
        end
        local ped = GetPlayerPed(-1)
        ESX.Game.SpawnVehicle(vehicle, pointDeSpawn.coords, heading, function(veh)
            local plate = math.random(1000000, 9999999)
            SetVehicleNumberPlateText(veh, plate)
            TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
            SetVehicleMaxMods(veh)
            blip = AddBlipForEntity(veh)
            SetBlipSprite(blip, 56)
            ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
            SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
            --SetBlipNameToPlayerName(blip, id) -- update blip name
            SetBlipScale(blip, 0.65) -- set scale
            --SetBlipAsShortRange(blip, true)
            SetBlipShowCone(blip, true)
            SetBlipShrink(blip, true)
            ShowFriendIndicatorOnBlip(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~b~Véhicule de service.")
            EndTextCommandSetBlipName(blip)
            couleurVehicule(veh)
            --exports["esx_legacyfuel"]:SetFuel(veh, 100)
            

            ESX.ShowAdvancedNotification("Centrale", "~b~Garage LSPD", "Votre véhicule de service est en train d'etre sortie.", "CHAR_CALL911", 8)

            local ped = CreatePedInsideVehicle(veh, 6, GetHashKey("s_m_y_cop_01"), -1, true, false)
            TaskVehicleDriveToCoord(ped, veh, -460.211, 6022.263, 31.34, 5.0, 1.0, GetHashKey(GetVehiclePedIsIn(ped, false)), 786603, 1.0, 1.0)
            local pedCoord = GetEntityCoords(ped, true)
            local voiture = GetVehiclePedIsIn(ped, false)
            local model = GetEntityModel(voiture)
            print(voiture)
            local name = GetDisplayNameFromVehicleModel(model)
            print(name)
            
            if name == "police112" then
                ModifyVehicleTopSpeed(voiture, 2*30.0)
                ModifyVehicleTopSpeed(veh, 2*30.0)
            end 
            SetVehicleDirtLevel(voiture, 0.1)
            WashDecalsFromVehicle(voiture, 1.0)
            local distance = GetDistanceBetweenCoords(pedCoord, -460.211, 6022.263, 31.34, true)
            while distance > 3.0 do
                pedCoord = GetEntityCoords(ped, true)
                distance = GetDistanceBetweenCoords(pedCoord, -460.211, 6022.263, 31.34, true)
                if not IsPedInAnyVehicle(ped, false) then
                    break
                end
                Wait(100)
            end
            DeleteEntity(ped)
            ESX.ShowAdvancedNotification("Centrale", "~b~Garage LSPD", "Votre véhicule de service à été sortie.", "CHAR_CALL911", 8)
        end)
    else
        VehBlock = ESX.Game.GetVehiclesInArea(pointDeSpawn.coords, 10)
        for _, voiture in pairs(VehBlock) do
	    	ESX.Game.DeleteVehicle(voiture)
        end
        local ped = GetPlayerPed(-1)

        if vehicle == 'riot2' then
            ESX.Game.SpawnVehicle(vehicle,{ x=439.39,y= -1021.09, z= 28.75}, 92.88, function(veh)
                local plate = math.random(1000000, 9999999)
                SetVehicleNumberPlateText(veh, plate)
                TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                SetVehicleMaxMods(veh)
            end)
        else
        ESX.Game.SpawnVehicle(vehicle, pointDeSpawn.coords, heading, function(veh)
            local plate = math.random(1000000, 9999999)
            SetVehicleNumberPlateText(veh, plate)
            TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
            SetVehicleMaxMods(veh)
            blip = AddBlipForEntity(veh)
            SetBlipSprite(blip, 56)
            ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
            SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
            --SetBlipNameToPlayerName(blip, id) -- update blip name
            SetBlipScale(blip, 0.65) -- set scale
            --SetBlipAsShortRange(blip, true)
            SetBlipShowCone(blip, true)
            SetBlipShrink(blip, true)
            ShowFriendIndicatorOnBlip(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~b~Véhicule de service.")
            EndTextCommandSetBlipName(blip)
            couleurVehicule(veh)
            --exports["esx_legacyfuel"]:SetFuel(veh, 100)
            

            ESX.ShowAdvancedNotification("Centrale", "~b~Garage LSPD", "Votre véhicule de service est en train d'etre sortie.", "CHAR_CALL911", 8)

            local ped = CreatePedInsideVehicle(veh, 6, GetHashKey("s_m_y_cop_01"), -1, true, false)
            TaskVehicleDriveToCoord(ped, veh, 432.03, -1018.52, 28.85, 5.0, 1.0, GetHashKey(GetVehiclePedIsIn(ped, false)), 786603, 1.0, 1.0)
            local pedCoord = GetEntityCoords(ped, true)
            local voiture = GetVehiclePedIsIn(ped, false)
            local model = GetEntityModel(voiture)
            print(voiture)
            local name = GetDisplayNameFromVehicleModel(model)
            print(name)
            
            if name == "police112" then
                ModifyVehicleTopSpeed(voiture, 2*30.0)
                ModifyVehicleTopSpeed(veh, 2*30.0)
            end 
            SetVehicleDirtLevel(voiture, 0.1)
            WashDecalsFromVehicle(voiture, 1.0)
            local distance = GetDistanceBetweenCoords(pedCoord, 432.03, -1018.52, 28.85, true)
            while distance > 3.0 do
                pedCoord = GetEntityCoords(ped, true)
                distance = GetDistanceBetweenCoords(pedCoord, 432.03, -1018.52, 28.85, true)
                if not IsPedInAnyVehicle(ped, false) then
                    break
                end
                Wait(100)
            end
            DeleteEntity(ped)
            ESX.ShowAdvancedNotification("Centrale", "~b~Garage LSPD", "Votre véhicule de service à été sortie.", "CHAR_CALL911", 8)
        end)
    end
    end
    _menuPool3:CloseAllMenus()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(camera, true)
end


local count = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        while ESX == nil do
            Citizen.Wait(10)
        end
        _menuPool3:ProcessMenus()
        if count == 0 then
            menuVeh(NatveVehMenu)
            count = 1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if not _menuPool3:IsAnyMenuOpen() and open == 1 then
            RenderScriptCams(0, 1, 1500, 1, 1)
            DestroyCam(camera, true)
            DeleteEntity(previewVeh)
            open = 0
        end
        Wait(400)
    end
end)


_menuPool3:RefreshIndex()
_menuPool3:MouseControlsEnabled (false);
_menuPool3:MouseEdgeEnabled (false);
_menuPool3:ControlDisablingEnabled(false);
_menuPool3:WidthOffset(80)


function OpenVehicleSpawnerMenu(station)

    open = 1
    NatveVehMenu:Visible(not NatveVehMenu:Visible())


    DeleteEntity(previewVeh)
    if not HasModelLoaded(GetHashKey("policec")) then
        RequestModel(GetHashKey("policec"))
        while not HasModelLoaded(GetHashKey("policec")) do
            Wait(10)
        end
    end 
    previewVeh = CreateVehicle(GetHashKey("policec"), previewCoords.coords, heading, false, 0)
    PointCamAtEntity(camera, previewVeh, 0, 0, 0, 1)
    SetVehicleMaxMods(previewVeh)
    couleurVehicule(previewVeh)
    SetVehicleOnGroundProperly(previewVeh)
    FreezeEntityPosition(previewVeh, true)
    SetEntityCollision(previewVeh, false, false)

    local veh = ESX.Game.GetClosestVehicle(cameraCoords.coords)

    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(camera, cameraCoords.coords)
    PointCamAtEntity(camera, veh, 0, 0, 0, 1)
    SetCamNearDof(camera, 10)
    RenderScriptCams(1, 1, 2000, 1, 1)
    SetCamShakeAmplitude(camera, 13.0)
end
