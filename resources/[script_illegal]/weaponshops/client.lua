

ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end

    for _, v in pairs(Config.ShopsIllegal) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1)
        end
        local ped = CreatePed(4, v.model, v.x, v.y, v.z, v.a,  false, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        RequestAnimDict("missfbi_s4mop")
        while not HasAnimDictLoaded("missfbi_s4mop") do
			Wait(1)
		end
        TaskPlayAnim(ped, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)
    end
    
end)


    
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","~b~Ammu-nation", 5, 100,"shopui_title_gunclub","shopui_title_gunclub",nil,255,255,255,230)
_menuPool:Add(mainMenu)

function AddShopsIllegalMenu(shop, stocks)

    _menuPool:CloseAllMenus()
    mainMenu:Clear()
    mainMenu = NativeUI.CreateMenu("","~o~Marché noir", 5, 100,shop, shop,nil,255,255,255,230)
    _menuPool:Add(mainMenu)
 
    for _,v in pairs(stocks) do
        local weapitem = NativeUI.CreateItem(ESX.GetWeaponLabel(v.weapon), "")
        weapitem:RightLabel(v.price.."$", Colours.Green , Colours.Black)
        if GetWeaponDamage(v.weapon) ~= 0 then
            local StatisticsPanel = NativeUI.CreateStatisticsPanel()

            StatisticsPanel:AddStatistics("Dégâts")
            StatisticsPanel:SetPercentage(1, GetWeaponDamage(v.weapon))

            weapitem:AddPanel(StatisticsPanel)
        end
        mainMenu:AddItem(weapitem)

    end


    mainMenu.OnItemSelect = function(_,item,Index)

        ESX.TriggerServerCallback('weaponshops:buyWeapon', function(bought)
            if bought then
                DisplayBoughtScaleform(stocks[Index].weapon, stocks[Index].price)
            else
                PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
            end
        end, stocks[Index].weapon, stocks[Index].price, false)
        
    end

    mainMenu:Visible(true)
end


_menuPool:RefreshIndex()
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);
        isNearShop = false
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        for k,v in pairs(Config.ShopsIllegal) do
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)

            if dist <= 1.5 then
                isNearShop = true
                ESX.ShowHelpNotification("~INPUT_TALK~ pour parlez avec le ~r~vendeur")
				if IsControlJustPressed(1,51) then 
                    AddShopsIllegalMenu(v.shopui, v.stocks)
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





