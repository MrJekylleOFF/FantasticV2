_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Garage", "Four", 8, 200, "", "", nil,100, 0, 0, 255)
_menuPool:Add(mainMenu)
fourriereMenu = NativeUI.CreateMenu("Fourrière", "Four", 8, 200, "", "", nil,100, 0, 0, 255)
_menuPool:Add(fourriereMenu)
vehMenu = NativeUI.CreateMenu("Garage", "~b~Menu garage", 8, 200, "", "", nil,100, 0, 0, 255)
_menuPool:Add(vehMenu)
listvehMenu = NativeUI.CreateMenu("Garage", "Vos véhicules", 8, 200, "", "", nil,100, 0, 0, 255)
_menuPool:Add(listvehMenu)
adminMenu = NativeUI.CreateMenu("Garage", "~r~!!! MENU ADMIN  !!!", 8, 200, "", "", nil,100, 0, 0, 255)
_menuPool:Add(adminMenu)
_menuPool:WidthOffset(80)

function GarageMenu()
    
    ESX.TriggerServerCallback('garage:getVehicles', function(vehicles)
        _menuPool:CloseAllMenus()
        mainMenu:Clear()
        mainMenu = NativeUI.CreateMenu("Garage", "~b~GARAGE "..string.upper(this_Garage.Id), 8, 200, "", "", nil,100, 0, 0, 255)
        _menuPool:Add(mainMenu)
        MenuSettings()
        local nbveh = 0
        local currVehs = {}
		for _,v in pairs(vehicles) do
            if v.garage == this_Garage.Id then
                nbveh = nbveh + 1
                local hashVehicule = v.vehicle.model
                local plate       = v.vehicle.plate
                local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(hashVehicule))
                local labelvehicle
                local engHealth = "⠇"
                if v.health < 800 and v.health > 400 then
                    engHealth = "⠆"
                elseif v.health < 400 then
                    engHealth = "⠄"
                end
                if v.name ~= nil then
                    vehicleName = v.name
                end
                local vehitem = NativeUI.CreateItem(vehicleName, "Plaque: ~y~"..plate)
                
                if(v.volee)then
                    label = "Volée/Détruite"
                    color = Colours.Orange
                elseif(v.state)then
                    label = "Dispo"
                    color = Colours.Green
                elseif(v.garageperso)then
                    label = "Garage perso"
                    color = Colours.Red
                else
                    label = "Sortie"
                    color = Colours.Red
                end	
                table.insert(currVehs, {vehicle = v.vehicle, health = v.health, plate = plate, volee = v.volee, state = v.state})
                vehitem:RightLabel(label, color , Colours.Black)
                mainMenu:AddItem(vehitem)
                
                mainMenu.OnItemSelect = function(_,item,Index)
                    if(currVehs[Index].state) and not (currVehs[Index].volee) then
                        OpenMenuVehicle(currVehs[Index].vehicle, currVehs[Index].health)
                    elseif (currVehs[Index].volee) then
                        ESX.ShowAdvancedNotification("Garage", "", "Vas voir l'assurance afin de récupérer ton véhicule", "CHAR_CARSITE",1)
                    elseif (currVehs[Index].garageperso) then
                        ESX.ShowAdvancedNotification("Garage", "", "Vas voir l'assurance afin de récupérer ton véhicule", "CHAR_CARSITE",1)
                    else 
                        ESX.ShowAdvancedNotification("Garage", "", "Ton véhicule est déjà sorti", "CHAR_CARSITE",1)
                    end
                end
            end
		end
		if nbveh == 0 then
            mainMenu:AddItem(NativeUI.CreateItem("Pas de véhicules dans ce garage", ""))
		end
        
       mainMenu:Visible(true)
	end)
end

function OpenMenuVehicle(vehicle, health)
    _menuPool:CloseAllMenus()
	vehMenu:Clear()
    vehMenu = NativeUI.CreateMenu("Garage", "~b~Menu garage", 8, 200, "", "", nil,100, 0, 0, 255)
    _menuPool:Add(vehMenu)
    MenuSettings()
    
    local sortiritem = NativeUI.CreateItem("Sortir", "Sortir votre véhicule")
    --sortiritem:RightLabel(label, color , Colours.Black)
    vehMenu:AddItem(sortiritem)

    local renameitem = NativeUI.CreateItem("Renommer", "Renommer votre véhicule")
    --sortiritem:RightLabel(label, color , Colours.Black)
    vehMenu:AddItem(renameitem)

    vehMenu.OnItemSelect = function(_,item,Index)
        if item == sortiritem then
            _menuPool:CloseAllMenus()
            SpawnVehicle(vehicle, health) 
        end
        if item == renameitem then
            RenameVehicle(vehicle.plate) 
        end
    end
	vehMenu:Visible(true)	
end

AddEventHandler('garage:ListVehicle', function()
	ListeVehMenu()
end)

function ListeVehMenu()
    ESX.TriggerServerCallback('garage:getVehicles', function(vehicles)
        _menuPool:CloseAllMenus()
        listvehMenu:Clear()
        listvehMenu = NativeUI.CreateMenu("Garage", "~b~VOS VEHICULES", 8, 200, "", "", nil,100, 0, 0, 255)
        _menuPool:Add(listvehMenu)
        MenuSettings()
		for _,v in pairs(vehicles) do
            local hashVehicule = v.vehicle.model
            local plate       = v.vehicle.plate
            local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(hashVehicule))
            local labelvehicle
            if v.name ~= nil then
                vehicleName = v.name
            end

            local vehitem = NativeUI.CreateItem(vehicleName, "Plaque: ~y~"..plate)	
            vehitem:RightLabel(string.upper(v.garage), Colours.Purple , Colours.Black)
            listvehMenu:AddItem(vehitem)
            
            listvehMenu.OnItemSelect = function(_,item,Index)
                --ESX.ShowNotification(vehicles[Index].garage)
                ESX.ShowAdvancedNotification("Garage", "", "Votre véhicule est au garage ~b~"..string.upper(vehicles[Index].garage), "CHAR_CARSITE",1)
                for k,v in pairs(Config.Garages) do
                    if v.Id == vehicles[Index].garage then		
                        SetNewWaypoint(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)
                        break
                    end
                end
            end
		end
        listvehMenu:Visible(true)
	end)
end

function ReturnVehicleMenu()

    ESX.TriggerServerCallback('garage:getOutVehicles', function(vehicles)
        _menuPool:CloseAllMenus()
        fourriereMenu:Clear()
        fourriereMenu = NativeUI.CreateMenu("Garage", "~b~FOURRIERE (300$)", 8, 200, "", "", nil,100, 0, 0, 255)
        _menuPool:Add(fourriereMenu)
        MenuSettings()
		local currVehs = {}

		for _,v in pairs(vehicles) do

            local hashVehicule = v.vehicle.model
            local plate       = v.vehicle.plate
    		local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(hashVehicule))
    		local labelvehicle
			
			local vehitem = NativeUI.CreateItem(vehicleName, "Plaque: ~y~"..plate)
                
            if(v.volee)then
                label = "Volée/Détruite"
                color = Colours.Orange
            elseif(v.state)then
                label = "Dispo"
                color = Colours.Green
            else
                label = "Sortie"
                color = Colours.Red
            end	
            table.insert(currVehs, {vehicle = v.vehicle, health = v.health, plate = plate, volee = v.volee, state = v.state})
            vehitem:RightLabel(label, color , Colours.Black)
            fourriereMenu:AddItem(vehitem)

            fourriereMenu.OnItemSelect = function(_,item,Index)
                ESX.TriggerServerCallback('garage:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then	
						local tempsFourriere = math.random(300,400)
						ESX.ShowAdvancedNotification("Garage", "", "La fourrière cherche ton véhicule... ~n~Temps d'attente éstimé : ~y~~n~"..math.floor(tempsFourriere/60).."~s~ minutes", "CHAR_CARSITE",1)--1=chatbox 9=$
						TriggerServerEvent('garage:modifystate',currVehs[Index].vehicle, true, "cubes", 1000, tempsFourriere)	
						TriggerServerEvent('garage:pay')
					else
						ESX.ShowAdvancedNotification("Garage", "", "Vous n\'avez pas assez d\'argent", "CHAR_CARSITE",1)						
					end
				end)
            end
        end
        if #currVehs == 0 then
            fourriereMenu:AddItem(NativeUI.CreateItem("Pas de véhicules en fourrière", ""))
		end
        fourriereMenu:Visible(true)
	end)
end

RegisterNetEvent('garage:PV')
AddEventHandler('garage:PV', function()
    local currVehs = {}
    _menuPool:CloseAllMenus()
    adminMenu:Clear()

    ESX.TriggerServerCallback('garage:getVehicles', function(vehicles)
        
        for _,v in pairs(vehicles) do
            
            local hashVehicule = v.vehicle.model
            local plate       = v.vehicle.plate
            local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(hashVehicule))
            local labelvehicle
            if v.name ~= nil then
                vehicleName = v.name
            end
            local vehitem = NativeUI.CreateItem(vehicleName, "Plaque: ~y~"..plate)
            
            
            table.insert(currVehs, {vehicle = v.vehicle, health = v.health, plate = plate, volee = v.volee, state = v.state})
            vehitem:RightLabel(string.upper(v.garage), Colours.Purple , Colours.Black)
            adminMenu:AddItem(vehitem)
            
            adminMenu.OnItemSelect = function(_,item,Index)
                _menuPool:CloseAllMenus()
                local playerPed   = PlayerPedId()
                local coords      = GetEntityCoords(playerPed)
                local heading     = GetEntityHeading(playerPed)
                local vehicleData = currVehs[Index].vehicle
            
                ESX.Game.SpawnVehicle(vehicleData.model, {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z
                    }, heading, function (vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleData)
                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                end)
            end
		end
		if #currVehs == 0 then
			adminMenu:AddItem(NativeUI.CreateItem("Pas de véhicules en fourrière", ""))
		end
        adminMenu:Visible(true)
			
	end)
end)

function MenuSettings()
    _menuPool:WidthOffset(80)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    --_menuPool:TotalItemsPerPage(15)
end

_menuPool:MouseEdgeEnabled(false);
_menuPool:RefreshIndex()
