ESX = nil
local shopData = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    ESX.TriggerServerCallback('blackmarket:GetData', function(data)
        shopData = data
    end)

    while shopData == nil do Wait(0) end

    for k, v in pairs(shopData.pos) do

        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1)
        end
        local ped = CreatePed(4, v.model, v.x, v.y, v.z, v.a,  false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
		SetPedCanBeTargetted(ped, false)
		SetEntityInvincible(ped, true)
		FreezeEntityPosition(ped, true)
        RequestAnimDict("missfbi_s4mop")
        while not HasAnimDictLoaded("missfbi_s4mop") do
			Wait(1)
		end
		TaskPlayAnim(ped, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)
    end
    
end)


    
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","~b~Marché noir", 5, 100,nil,nil,nil,255,255,255,230)
_menuPool:Add(mainMenu)


function AddShopsMenu(shop)

    _menuPool:CloseAllMenus()
    mainMenu:Clear()
    mainMenu = NativeUI.CreateMenu("Marché noir","~b~J'aurais d'autres stocks demain", 5, 100,shop, shop,nil,255,255,255,230)
    _menuPool:Add(mainMenu)
 
    for _,v in pairs(shopData.items) do
        local item = NativeUI.CreateItem(v.label, "")
        item:RightLabel(v.price.."$", (v.sale and Colours.Red or Colours.Green) , Colours.Black)
        mainMenu:AddItem(item)
    end


    mainMenu.OnItemSelect = function(_,item,Index)

        TriggerServerEvent('blackmarket:buytruc', shopData.items[Index].objet, shopData.items[Index].price, shopData.items[Index].sale)
 
    end

    mainMenu:Visible(true)
end


_menuPool:RefreshIndex()
Citizen.CreateThread(function()
    while shopData == nil do Wait(0) end
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);
        isNearShop = false
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        for k,v in pairs(shopData.pos) do
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)

            if dist <= 2.5 then
                isNearShop = true
                ESX.ShowHelpNotification("~INPUT_TALK~ pour parlez avec le ~b~vendeur")
				if IsControlJustPressed(1,51) then 
                    AddShopsMenu(v.shopui)
				end
            end
        end
        if isNearShop and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isNearShop and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			mainMenu:Visible(false)
		end
    end
end)





