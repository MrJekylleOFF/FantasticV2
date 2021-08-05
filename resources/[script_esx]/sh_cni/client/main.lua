ESX = nil

local cni = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	_menuPool = NativeUI.CreatePool()
	mainMenu = NativeUI.CreateMenu("Ma CNI", "Carte D'identité", 8, 200,"","", nil,100,0,0,255)
	_menuPool:Add(mainMenu)
	_menuPool:RefreshIndex()
	_menuPool:MouseControlsEnabled (false);
	_menuPool:MouseEdgeEnabled (false);
	_menuPool:ControlDisablingEnabled(false);
	_menuPool:WidthOffset(80)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function AddMenuCNI(menu)
	local cni = NativeUI.CreateItem("Montrer Ma Pièces D'identité", "")
	local lookcni = NativeUI.CreateItem("Regarder Ma Pièces D'identité", "")
	local retour = NativeUI.CreateItem("~r~Retour", "")
	menu:AddItem(cni)
	menu:AddItem(lookcni)
	menu:AddItem(retour)

	menu.OnItemSelect = function(menu, item, _)
	   if item == cni then
	   	
		    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
										
			if closestDistance ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification("~r~Personne à Proximité")
			end
		elseif item == lookcni then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		elseif item == retour then 
			mainMenu:Visible(false)
	   end
	end
end 

Citizen.CreateThread(function()
    while true do
        if _menuPool ~= nil then
            _menuPool:ProcessMenus()
        end        
        Citizen.Wait(0)
    end
end)

-- Start of CNI
RegisterNetEvent('sh_cni:showcni')
AddEventHandler('sh_cni:showcni', function()
	mainMenu:Clear()
    ESX.UI.Menu.CloseAll()
    Wait(10)
	ESX.UI.Menu.CloseAll()
    AddMenuCNI(mainMenu)
    mainMenu:Visible(true)
end)
-- End of CNI


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        if IsEntityAtCoord(PlayerPedId(), -544.5, -205.1, 37.22, 1.5, 1.5, 1.5, 0, 1, 0) then 
            ESX.ShowHelpNotification("~INPUT_TALK~ Pour récupérer votre ~r~carte d'identité ")
            if IsControlJustPressed(1,51) then
                TriggerServerEvent('BuyCNI')
            end
        end    
    end
end)