
_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
		end)
        Citizen.Wait(0)
	end
	TriggerEvent('dqp:exit')
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction66           = nil
local CurrentAction66Msg        = ''
local CurrentAction66Data       = {}

function OpenMask()
	TriggerEvent("dqp:exit")
		local maskShop = NativeUI.CreateMenu("", "Magasin de masques", 8, 200,"shopui_title_movie_masks","shopui_title_movie_masks")
		_menuPool:Add(maskShop)
		maskShopAdd(maskShop)
		maskShop:Visible(not maskShop:Visible())
		_menuPool:RefreshIndex()
		_menuPool:WidthOffset(80)

end



_menuPool:RefreshIndex()



AddEventHandler('Mask:hasEnteredMarker', function(zone)

	CurrentAction66     = 'shop_menu'
	CurrentAction66Msg  = 'Appuie sur ~INPUT_CONTEXT~ pour ouvrir le magasin'
	CurrentAction66Data = {zone = zone}

end)

AddEventHandler('Mask:hasExitedMarker', function(_)

	CurrentAction66 = nil
	_menuPool:CloseAllMenus()
	
	if MenuOn then
		yoyo()
		MenuOn = false
	end
end)
 

-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for _,v in pairs(MaskConfig.Zones) do
      for i = 1, #v.Pos, 1 do
        if(MaskConfig.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < MaskConfig.DrawDistance) then
          DrawMarker(MaskConfig.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, MaskConfig.Size.x, MaskConfig.Size.y, MaskConfig.Size.z, MaskConfig.Color.r, MaskConfig.Color.g, MaskConfig.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)
-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(MaskConfig.Zones) do
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1.5) then
					isInMarker  = true
					
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			
			TriggerEvent('Mask:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('Mask:hasExitedMarker', LastZone)
			yoyo()

		end
	end
end)

function maskShopAdd(menu)
	playerPed = GetPlayerPed(-1)
	maskName = {}
	for i=0,GetNumberOfPedDrawableVariations(playerPed, 1)-1,1 do 
		amount = {}
		for c = 1, GetNumberOfPedTextureVariations(playerPed, 1, i), 1 do

			amount[c] = c 
			
		end
		if maskName[i+1] == nil then
			maskName[i+1] = GetLabelText(MaskConfig.Name[tostring(i)]["0"]["GXT"])
		end
		qdqs = NativeUI.CreateListItem(maskName[i+1] , amount, 1, "",5)
		menu:AddItem(qdqs)
		menu.OnIndexChange = function(menu,index6)
			playerPed = GetPlayerPed(-1)
			SetPedComponentVariation(playerPed, 1, index6-1, 0, 2)
			local index2 = 1
			menu.OnListSelect = function(_, _, index)
				TriggerServerEvent("dqp:SetNewMasque",index6-1,index2-1,"Masque",maskName[index6])
				_menuPool:RefreshIndex()
			end
			menu.OnMenuClosed = function(_, _, _)
				yoyo()
			end
			menu.OnListChange = function(_, _, index24)
				index2 = index24
				SetPedComponentVariation(playerPed, 1, index6-1, index24-1, 2)
	
			end
		end
	end
	menu.OnMenuClosed = function(_)
		yoyo()
	end
end
function yoyo()
	playerPed = GetPlayerPed(-1)
	SetPedComponentVariation(playerPed, 1, 0, 0, 2)
end

-- Key controls
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  _menuPool:ProcessMenus()


	  if CurrentAction66 ~= nil then
		SetTextComponentFormat('STRING')
		AddTextComponentString(CurrentAction66Msg)
		DisplayHelpTextFromStringLabel(0, 0, 0, -1)
  
		if IsControlJustReleased(0, 38) then
			OpenMask()
			yoyo()
			MenuOn = true
		end
  
	  end
	end
  end)