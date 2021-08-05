ESX = nil
local PlayerData = {}
local npc = nil
local canSell = true

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","VENTE", 8, 200,nil,nil,nil,255,255,255,230)
_menuPool:Add(mainMenu)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    print("Pawnshop fait par Thom512 avec amour :)")
	local blip = AddBlipForCoord(Config.Loc.x, Config.Loc.y, Config.Loc.z)
	SetBlipSprite(blip, 431)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 24)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Point de vente")
	EndTextCommandSetBlipName(blip)
	Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

function OpenPawnshop(shopData)
	_menuPool:CloseAllMenus()
	mainMenu:Clear()
	mainMenu = NativeUI.CreateMenu("VENTE","~b~Vente", 8, 200,nil,nil,nil,nil,nil,nil,nil)
	_menuPool:Add(mainMenu)

	PlayerData = ESX.GetPlayerData()
	local inventory = PlayerData.inventory
	local fakeInv = {}
	
	for _,item in pairs(inventory) do
		if item.count > 0 then
			local price = getItemPrice(shopData, item.name)
			table.insert(fakeInv, {count = item.count, label = item.label, name = item.name, price = price})
			local xitem = NativeUI.CreateItem(item.count.." "..item.label, "")
			if type(price) == "number" then
				xitem:RightLabel(price.."$", Colours.Green, Colours.Black)
			else
				xitem:SetRightBadge(BadgeStyle.Lock)
				--xitem:RightLabel(price, Colours.Red, Colours.Black)
			end
			mainMenu:AddItem(xitem)
		end
	end

	mainMenu.OnItemSelect = function(_,_,Index)
		if type(fakeInv[Index].price) == "number" then
			AddTextEntry('pawnshop', "Vente de ".. fakeInv[Index].label.." :")
			DisplayOnscreenKeyboard(1, "pawnshop", "", tostring(fakeInv[Index].count), "", "", "", 8)
			while (UpdateOnscreenKeyboard() == 0) do
				DisableAllControlActions(0)
				Wait(0)
			end
			if (GetOnscreenKeyboardResult()) ~= "" and (GetOnscreenKeyboardResult()) ~= nil then
				local quantity = tonumber(GetOnscreenKeyboardResult())
				if quantity <= fakeInv[Index].count then
					mainMenu:Visible(false)
					Analyse(quantity, fakeInv[Index].name, fakeInv[Index].price)
				else
					ESX.ShowNotification("Quantité invalide")
				end
			end
		end
	end
	_menuPool:WidthOffset(80)
	mainMenu:Visible(true)
end


function getItemPrice(shopData, item)
	for _,v in pairs(shopData) do
		if v.item == item then
			return v.price
		end
	end
	return "J'achète pas ça"
end

function Analyse(count, item, value)
	canSell = false
	--TaskGoToCoordAnyMeans(npc, 377.86, 332.95, 103.56, 1.0, 0, 0, 786603)
	--ESX.ShowAdvancedNotification(Config.Name, "~b~Prêteur sur gage", "Attends là, je vais vérifier ce que tu m'as donné", Config.ImageNotif, 1)
	--Wait(10000)
	--TriggerServerEvent('pawnshop:analyse', count, item, value, legal)
	
		TaskGoToCoordAnyMeans(npc, Config.Loc.x, Config.Loc.y, Config.Loc.z, 1.0, 0, 0, 786603)
		while GetDistanceBetweenCoords(Config.Loc.x, Config.Loc.y, Config.Loc.z, GetEntityCoords(npc), false) > 0.5 do Wait(0) end
		--if GetInteriorFromEntity(GetPlayerPed(-1)) == 0 then
		--	ESX.ShowAdvancedNotification(Config.Name, "~b~Prêteur sur gage", "Tu es parti où ?", Config.ImageNotif, 1)
		--	SetEntityHeading(npc, Config.Loc.heading)
		--	canSell = true
		--else
			SetEntityHeading(npc, Config.Loc.heading)
			TriggerServerEvent('pawnshop:sellItem', count, item, value, legal)
			--TriggerServerEvent('Logs:custom', "a vendu ".. count.." ".. item .." au préteur sur gage pour ".. count * value.." $")
			canSell = true
		--end
end



Citizen.CreateThread(function()
	RequestModel(GetHashKey(Config.Model))
	while not HasModelLoaded(GetHashKey(Config.Model)) do
		Citizen.Wait(10)
	end
	npc = CreatePed(5, Config.Model, Config.Loc.x, Config.Loc.y, Config.Loc.z, Config.Loc.heading, false, false)
	SetPedFleeAttributes(npc, 0, 0)
	SetPedDropsWeaponsWhenDead(npc, false)
	SetPedDiesWhenInjured(npc, false)
	Citizen.Wait(1500)
	SetEntityInvincible(npc , true)
	--FreezeEntityPosition(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)

	while true do Wait(1)
		_menuPool:ProcessMenus()
   		_menuPool:MouseEdgeEnabled(false);
		local distance = GetDistanceBetweenCoords(Config.Loc.x, Config.Loc.y, Config.Loc.z, GetEntityCoords(GetPlayerPed(-1)), true)
		if distance < 3 and canSell then
			ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour parler au ~b~" .. Config.Name)
			if IsControlJustReleased(0, 38) then
				--TriggerServerEvent('pawnshop:showMenu')
				--OpenShopMenu()
				ESX.TriggerServerCallback('pawnshop:getPrices', function(data)
					print(json.encode(data))
					OpenPawnshop(data)
				end)
			end
		else 
			mainMenu:Visible(false)
		end
	end
end)

RegisterNetEvent('pawnshop:policeNotif')
AddEventHandler('pawnshop:policeNotif', function(label)
	if PlayerData.job.name == 'police' then
		SetNotificationBackgroundColor(6)
		ESX.ShowAdvancedNotification(Config.Name, "~h~~b~Prêteur sur gage", "~h~Y'a une personne bizarre qui me vend des ~b~"..label, Config.ImageNotif, 1)
		PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
		Wait(250)
		PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
		
		local transT = 250
		local Blip = AddBlipForCoord(Config.Loc.x, Config.Loc.y, Config.Loc.z)
		SetBlipSprite(Blip,  431)
		SetBlipColour(Blip,  1)
		SetBlipAlpha(Blip,  transT)
		SetBlipAsShortRange(Blip,  false)
		Wait(12000)
		while transT ~= 0 do
			Wait(50)
			transT = transT - 1
			SetBlipAlpha(Blip,  transT)
			if transT == 0 then
				SetBlipSprite(Blip,  2)
				return
			end
		end
	end
end)

