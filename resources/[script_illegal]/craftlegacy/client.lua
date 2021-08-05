local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local display = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function isWeapon(item)
	local weaponList = ESX.GetWeaponList()
	for i=1, #weaponList, 1 do
		if weaponList[i].label == item then
			return true
		end
	end
	return false
end

local function craftItem(ingredients)
	local ingredientsPrepped = {}
	for name, count in pairs(ingredients) do
		if count > 0 then
			table.insert(ingredientsPrepped, { item = name , quantity = count})
		end
	end
	TriggerServerEvent('craftlegacy:craftItem', ingredientsPrepped)
end

RegisterNetEvent('craftlegacy:openMenu')
AddEventHandler('craftlegacy:openMenu', function(playerInventory)
	SetNuiFocus(true,true)
	local preppedInventory = {}
	for i=1, #playerInventory, 1 do
		if playerInventory[i].count > 0 and not isWeapon(playerInventory[i].label) then
			table.insert(preppedInventory, playerInventory[i])
		end
	end
	SendNUIMessage({
		inventory = preppedInventory,
		display = true
	})
	display = true
end)

RegisterNUICallback('craftItemNUI', function(data, cb)
	craftItem(data)
end)

RegisterCommand("d", function(source, args, rawCommand)
	SetNuiFocus(false)
  end, false)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		display = false
	})
	display = false
end)

-- Handle menu input
--Citizen.CreateThread(function()
	--while true do
	--	Citizen.Wait(0)
	--	if (IsControlPressed(1, Keys["F3"])) then
	--		TriggerServerEvent('craftlegacy:getPlayerInventory')
	--	end
	--end
--end)


if Config.Shop.useShop then
	local inDrawingRange = false
	local function isPlayerInRange(coords1, coords2, range)	
		return (Vdist2(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z) < range)
	end
	
	Citizen.CreateThread(function()
		local blip = AddBlipForCoord(Config.Shop.shopCoordinates.x, Config.Shop.shopCoordinates.y, Config.Shop.shopCoordinates.z)
		SetBlipSprite (blip, Config.Shop.shopBlipID)
		SetBlipDisplay(blip, 0)
		SetBlipScale  (blip, 1.0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Shop.shopName)
		EndTextCommandSetBlipName(blip)
		
		while true do
			Citizen.Wait(250)
			inDrawingRange = isPlayerInRange(GetEntityCoords(PlayerPedId()), Config.Shop.shopCoordinates, 100)
		end
	end)
		
	Citizen.CreateThread(function()		
		while true do
			Citizen.Wait(0)
			if inDrawingRange then
				DrawMarker(1, Config.Shop.shopCoordinates.x, Config.Shop.shopCoordinates.y, Config.Shop.shopCoordinates.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Shop.zoneSize.x, Config.Shop.zoneSize.y, Config.Shop.zoneSize.z, Config.Shop.zoneColor.r, Config.Shop.zoneColor.g, Config.Shop.zoneColor.b, Config.Shop.zoneColor.a, false, true, 2, false, false, false, false)
				if not display and isPlayerInRange(GetEntityCoords(PlayerPedId()), Config.Shop.shopCoordinates, Config.Shop.zoneSize.x) then
					SetTextComponentFormat('STRING')
					AddTextComponentString("Appuie sur ~INPUT_CONTEXT~ pour craft un item")
					DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					if IsControlJustReleased(1, 38) then
						TriggerServerEvent('craftlegacy:getPlayerInventory')
					end
				end
			end
		end
	end)
end