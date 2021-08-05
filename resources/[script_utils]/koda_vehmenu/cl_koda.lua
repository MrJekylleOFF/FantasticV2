Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()

end)


local function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result --Returns the result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function KodaAdvancedNotification (title, subject, msg, icon, iconType)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    SetNotificationMessage(icon, icon, false, iconType, title, subject)
    DrawNotification(false, false)
end


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Menu Véhicule",'Menu pour gérer les paramètres du véhicule')
mainMenu:SetMenuWidthOffset(30)
_menuPool:Add(mainMenu)

local kodaPed = PlayerPedId()





function AddkodavehiclesMenu(menu)
    kodaunite = false
    if kodaunite == false then 

        kodakm = 3.6 

    else
        kodakm = 2.237
    end

        local LimitateurSubMenu = _menuPool:AddSubMenu(menu ,"Options du limitateur","Options du limitateur de véhicule")
        LimitateurSubMenu.Item:RightLabel("Suivant >") 
        local vehicle = GetVehiclePedIsIn(playerPed,false)
        LimitateurSubMenu.SubMenu:SetMenuWidthOffset(60)

        local definirItem = NativeUI.CreateItem("Définir :","Ce paramètre permettra de bloquer votre vitesse limite a 50 km")
        LimitateurSubMenu.SubMenu:AddItem(definirItem)

        local kodaItem = NativeUI.CreateItem("Vitesse :~g~ 50 km","Ce paramètre permettra de bloquer votre vitesse limite a 50 km")
        LimitateurSubMenu.SubMenu:AddItem(kodaItem)

        local kodaaItem = NativeUI.CreateItem("Vitesse :~g~ 80 km","Ce paramètre permettra de bloquer votre vitesse limite a 80 km")
        LimitateurSubMenu.SubMenu:AddItem(kodaaItem)

        local kodaaaItem = NativeUI.CreateItem("Vitesse :~g~ 120 km","Ce paramètre permettra de bloquer votre vitesse limite a 120 km")
        LimitateurSubMenu.SubMenu:AddItem(kodaaaItem)

        local kodaaaaItem = NativeUI.CreateItem("Vitesse :~g~ 150 km","Ce paramètre permettra de bloquer votre vitesse limite a 150 km")
        LimitateurSubMenu.SubMenu:AddItem(kodaaaaItem)

        local kodaaaaaItem = NativeUI.CreateItem("Vitesse :~r~ par défault","Ce paramètre permettra de bloquer votre vitesse limite a 150 km")
        LimitateurSubMenu.SubMenu:AddItem(kodaaaaaItem)

        LimitateurSubMenu.SubMenu.OnItemSelect = function(sender, item, index)
            if item == definirItem then
                local vitesseKoda = KeyboardInput("Vitesse :", "", 6)
            if tonumber(vitesseKoda) == nil then
                ESX.ShowAdvancedNotification("Limitateur", "", "Veuillez inserer un nombre correct !", "CHAR_CARSITE", 1)
                return nil
            end
                SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), vitesseKoda/kodakm )
            elseif item == kodaItem then
                SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 50.0/kodakm )
            elseif item == kodaaItem then
                SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 80.0/kodakm )
            elseif item == kodaaaItem then
                SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 120.0/kodakm )
            elseif item == kodaaaaItem then
                SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 150.0/kodakm )
            elseif item == kodaaaaaItem then
                SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 1000.0/kodakm )                
            end
        end
    end








function Addkodavehicles1Menu(menu)
        kodaveh = {}

        local PortieresSubMenu = _menuPool:AddSubMenu(menu ,"Options des portières","Options des portières de véhicule")
        PortieresSubMenu.Item:RightLabel("Suivant >") 
        PortieresSubMenu.SubMenu:SetMenuWidthOffset(60)
        kodaveh.frontLeftDoorOpen = false

        local pkoda = NativeUI.CreateItem("Ouvrir/Fermer la portiere avant gauche" , "Cela permet d'ouvrir/fermer la portiere avant gauche")
        PortieresSubMenu.SubMenu:AddItem(pkoda)
        kodaveh.frontRightDoorOpen = false

        local pkodaa = NativeUI.CreateItem("Ouvrir/Fermer la portiere avant droite", "Cela permet d'ouvrir/fermer la portiere avant droite")
        PortieresSubMenu.SubMenu:AddItem(pkodaa)
        kodaveh.backLeftDoorOpen = false

        local pkodaaa = NativeUI.CreateItem("Ouvrir/Fermer la portiere arrière gauche" , "Cela permet d'ouvrir/fermer la portiere arrière gauche")
        PortieresSubMenu.SubMenu:AddItem(pkodaaa)
        kodaveh.backRightDoorOpen = false

        local pkodaaaa = NativeUI.CreateItem("Ouvrir/Fermer la portiere arrière droite" , "Cela permet d'ouvrir/fermer la portiere arrière droite")
        PortieresSubMenu.SubMenu:AddItem(pkodaaaa)
        kodaveh.hoodDoorOpen = false

        local pkodaaaaa = NativeUI.CreateItem("Ouvrir/Fermer le coffre", "Cela permet d'ouvrir/fermer le coffre")
        PortieresSubMenu.SubMenu:AddItem(pkodaaaaa)
        kodaveh.trunkDoorOpen = false

        local pkodaaaaaa = NativeUI.CreateItem("Ouvrir/Fermer le capot", "Cela permet d'ouvrir/fermer le capot")
        PortieresSubMenu.SubMenu:AddItem(pkodaaaaaa)


        PortieresSubMenu.SubMenu.OnItemSelect = function(sender, item, index)
			kodavehi = GetVehiclePedIsIn(kodaPed, false)
			if item == pkoda then
					if not kodaveh.frontLeftDoorOpen then
						kodaveh.frontLeftDoorOpen = true
						SetVehicleDoorOpen(kodavehi, 0, false, false)
					elseif kodaveh.frontLeftDoorOpen then
						kodaveh.frontLeftDoorOpen = false
						SetVehicleDoorShut(kodavehi, 0, false, false)
                    end
            elseif item == pkodaa then
					if not kodaveh.frontRightDoorOpen then
						kodaveh.frontRightDoorOpen = true
						SetVehicleDoorOpen(kodavehi, 1, false, false)
					elseif kodaveh.frontRightDoorOpen then
						kodaveh.frontRightDoorOpen = false
						SetVehicleDoorShut(kodavehi, 1, false, false)
                    end
            elseif item == pkodaaa then
					if not kodaveh.backLeftDoorOpen then
						kodaveh.backLeftDoorOpen = true
						SetVehicleDoorOpen(kodavehi, 2, false, false)
					elseif kodaveh.backLeftDoorOpen then
						kodaveh.backLeftDoorOpen = false
						SetVehicleDoorShut(kodavehi, 2, false, false)
                    end
            elseif item == pkodaaaa then
					if not kodaveh.backRightDoorOpen then
						kodaveh.backRightDoorOpen = true
						SetVehicleDoorOpen(kodavehi, 3, false, false)
					elseif kodaveh.backRightDoorOpen then
						kodaveh.backRightDoorOpen = false
                        SetVehicleDoorShut(kodavehi, 3, false, false)
                    end
            elseif item == pkodaaaaa then
                    if not kodaveh.trunkDoorOpen then
                        kodaveh.trunkDoorOpen = true
                        SetVehicleDoorOpen(kodavehi, 5, false, false)
                    elseif kodaveh.trunkDoorOpen then
                        kodaveh.trunkDoorOpen = false
                        SetVehicleDoorShut(kodavehi, 5, false, false)   
                end
            elseif item == pkodaaaaaa then
                if not kodaveh.hoodDoorOpen then
                    kodaveh.hoodDoorOpen = true
                    SetVehicleDoorOpen(kodavehi, 4, false, false)
                elseif kodaveh.hoodDoorOpen then
                    kodaveh.hoodDoorOpen = false
                    SetVehicleDoorShut(kodavehi, 4, false, false)   
                end
            end         
        end
    end



	
    function Addkodavehicles2Menu(menu)


        local MoteurSubMenu = _menuPool:AddSubMenu(menu ,"Options du moteur","Options du moteur du véhicule")
        MoteurSubMenu.Item:RightLabel("Suivant >") 
        MoteurSubMenu.SubMenu:SetMenuWidthOffset(60)


        local mkoda = NativeUI.CreateItem("Allumer/Eteindre le moteur" , "Cela permet d'allumer/éteindre la moteur du véhicule")
        MoteurSubMenu.SubMenu:AddItem(mkoda)

        local mkoda1 = NativeUI.CreateItem("Vérifier l'êtat du moteur" , "Cela permet de vérifier l'êtat du moteur")
        MoteurSubMenu.SubMenu:AddItem(mkoda1)

        MoteurSubMenu.SubMenu.OnItemSelect = function(sender, item, index)
            if item == mkoda then
                if GetIsVehicleEngineRunning(vehiclekoda) then
                    SetVehicleEngineOn(vehiclekoda, false, false, true)
                    SetVehicleUndriveable(vehiclekoda, true)
                elseif not GetIsVehicleEngineRunning(vehiclekoda) then
                    SetVehicleEngineOn(vehiclekoda, true, false, true)
                    SetVehicleUndriveable(vehiclekoda, false)
                end
            elseif item == mkoda1 then
                pedkoda = GetPlayerPed(-1)
                vehiclekoda = GetVehiclePedIsIn(pedkoda, false)
                vievehicule = GetVehicleEngineHealth(vehiclekoda)
                KodaAdvancedNotification("Tableau de bord", "Etat du moteur :","~g~"..vievehicule.. "~w~ / 1000", "CHAR_CARSITE", 1)
            end
        end      
    end


Addkodavehicles2Menu(mainMenu)
Addkodavehicles1Menu(mainMenu)
AddkodavehiclesMenu(mainMenu)
_menuPool:RefreshIndex()
_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)
_menuPool:DisableInstructionalButtons(false)
mainMenu:SetMenuWidthOffset(60)




Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5)
        _menuPool:ProcessMenus()
        
        if IsPedInAnyVehicle(PlayerPedId(), true) then
               
        if IsControlJustReleased(1, 51)  then
               
                mainMenu:Visible(true)
            end
        else
            mainMenu:Visible(false)   
            Wait(100)
            mainMenu:Visible(false)  
        end
    end
end)

_menuPool:MouseEdgeEnabled (false);


