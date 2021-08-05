ESX                  = nil
_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()
local MaskTab  = {}

RegisterNetEvent('parow:SyncAccess')
AddEventHandler('parow:SyncAccess', function()
    ESX.TriggerServerCallback("parow:getMask", function(result)
        MaskTab = result
    end)
end)
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction6           = nil
local CurrentAction6Msg        = ''
local CurrentAction6Data       = {}

local MenuOn = false
local curSex = 0

function ClotheShopAdd(menu)

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
		curSex = skin.sex
	end)
	playerPed = GetPlayerPed(-1)
	local lunette = _menuPool:AddSubMenu(menu, "Lunette","",true,true)
	local chapeau = _menuPool:AddSubMenu(menu, "Chapeau","",true,true)
 	casqueFct(chapeau)
 	lunetteFct(lunette)
	 
	--[[menu.OnItemSelect = function(_,_,ind)
		if ind == 1 then
			_menuPool:CloseAllMenus()
			local clotheShop2 = NativeUI.CreateMenu("", "Magasin", 5, 100,"shopui_title_midfashion","shopui_title_midfashion")
			_menuPool:Add(clotheShop2)
			SavedTenues(clotheShop2)
			clotheShop2:Visible(not clotheShop2:Visible())
		end

	end--]]

	menu.OnMenuClosed = function(_, _, _)

		RecupTenues()
		MenuOn = false
		
	end

end
function refreshthisshit()
	_menuPool:CloseAllMenus(

	)
	local clotheShop2 = NativeUI.CreateMenu("Accessoire", "Magasin", 8, 200,"","", nil,100,0,0,255)
	_menuPool:Add(clotheShop2)
	SavedTenues(clotheShop2)
	clotheShop2:Visible(not clotheShop2:Visible())
end

function gettxt2(txtt)
    AddTextEntry('FMMC_MPM_NA', "Texte")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", txtt, "", "", "", 100)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
		local result = GetOnscreenKeyboardResult()
		if tonumber(result) ~= nil then
			if tonumber(result) >= 1 then

				return tonumber(result)
			else
				
			end
		else
		return result
		end
    end

end

function RecupTenues()

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

end


function lunetteFct(menu)
	if curSex == 0 then
	playerPed = GetPlayerPed(-1)
	lunetteItem = {
		"Aucune",
		"Lunette sport",
		"Lunette de soleil",
		"Lunette old school",
		"Lunette moyen-age",
		"Lunette de soleil",
		"Aucune",
		"Lunette de soleil",
		"Lunette",
		"Lunette sport",
		"Lunette mafieux",
		"Aucune",
		"Lunette luxe",
		"Lunette de baron",
		"Aucune",
		"Lunette sport",
		"Lunette sport",
		"Lunette teinté",
		"Lunette",
		"Fausse lunette",
		"Lunette moderne",
		"Lunette america",
		"Lunette america",
		"Lunette sport",
		"Lunette aviateur",
		"Lunette aviateur"
	}


	for i = 0,25,1 do
		--
		local amount = {}
		local ind = i+1
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 1, i), 1 do

			amount[c] = c 
			
		end
		if lunetteItem[i] == nil then
			lunetteItem[i] = "Lunette #"..i
		end
		x = NativeUI.CreateListItem(lunetteItem[ind], amount, 1, "",5)
	
		menu:AddItem(x)
		

	end
	_menuPool:RefreshIndex()
	local index2 = 1
	menu.OnIndexChange = function(menu,index6)
		playerPed = GetPlayerPed(-1)
		print(index2)
		index2 = 1
		SetPedPropIndex(playerPed, 1, index6-1, 0, 2)
		
		menu.OnListSelect = function(_, _, _)
			print(index2)
			TriggerServerEvent("parow:SetNewMasque",index6-1,index2-1,"Lunette",lunetteItem[index6],1)


		end
		menu.OnListChange = function(menu, _, index24)
			print(index2)
			
			index2 = index24
			print(index2)

			SetPedPropIndex(playerPed, 1, index6-1, index24-1, 2)
			

				menu.OnMenuClosed = function(_)
					
				end
			
		end
		
	end
end

end

Citizen.CreateThread(function()

    for i = 1, #ConfigclotheShop.Map, 1 do
        local blip = AddBlipForCoord(ConfigclotheShop.Map[i].x, ConfigclotheShop.Map[i].y, ConfigclotheShop.Map[i].z)
        SetBlipSprite(blip, ConfigclotheShop.Map[i].id)
        SetBlipDisplay(blip, 4)
    	SetBlipColour(blip, ConfigclotheShop.Map[i].color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.7)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ConfigclotheShop.Map[i].name)
        EndTextCommandSetBlipName(blip)
    end

end)
function casqueFct(menu)
	if curSex == 0 then
playerPed = GetPlayerPed(-1)
	
	
	local chapeauItem = {
		"Casque",
		"Bonnet d'âne",
		"Bonnet",
		"Bob",
		"Casquette LS",
		"Bonnet",
		"Casquette miliaire",
		"Beret",
		"Aucun",
		"Casquette à l'envers",
		"Casquette",
		"Aucun",
		"Chapeau",
		"Chapeau Cowboy",
		"Bandana",
		"Casque de musique",
		"Casque",
		"Casque",
		"Casque",
		"Casque de pilote",
		"Bob de pêcheur",
		"Chapeau chill",
		"Chapeau de noël",
		"Chapeau de lutin",
		"Corne de noël",
		"Chapeau",
		"Chapeau melon",
		"Chapeau haut",
		"Bonnet",
		"Chapeau",
		"Chapeau",
		"Chapeau USA",
		"Chapeau USA",
		"Chapeau USA",
		"Bonnet USA",
		"USA",
		"Entenne USA",
		"Casque à bière",
		"Casque aviation",
		"Casque d'intervention",
		"Chapeau noël",
		"Chapeau noël",
		"Chapeau noël",
		"Chapeau noël",
		"Casquette",
		"Casquette à l'envers",
		"Casquette LSPD",
		"Casque d'aviateur",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casquette",
		"Casquette",
		"Casquette",
		"Chapeau Alien",
		"Casquette",
		"Casque",
		"Casquette",
		"Chapeau",
		"Casque",
		"Casquette",
		"Chapeau",
		"Casquette",
		"Casquette a l'envers",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casquette",
		"Casquette a l'envers",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Bonnet",
		"Casque a pique",
		"Casque",
		"Casque",
		"Casque a pique",
		"Casque a pique",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Chapeau",
		"Chapeau",
		"Casquette",
		"Bonnet noël",
		"Bonnet noël",
		"Bonnet noël",
		"Bonnet noël",
		"Cerf tête",
		"Casquette",
		"Casquette",
		"Chapeau",
		"Chapeau",
		"Bonnet",
		"Casquette",
		"Casquette",
		"Casquette",
		"Casquette a l'envers",
		"Casque d'aviation",
		"Casque militaire",
		"Casquette militaire",
		"Bonnet",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Bonnet",
		"Aucun",
		"Casquette",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Casque",
		"Bulle",
		"Casquette",
		"Casquette a l'envers",
		"Chapeau",
		"Casque",
		"Bulle"
	}


	for i = -1,GetNumberOfPedPropDrawableVariations(playerPed, 0)-2,1 do
		--
		local amount = {}
		local ind = i+2
		for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 0, i+1), 1 do

			amount[c] = c 
			
		end
		if chapeauItem[i] == nil then
			chapeauItem[i] = i
		end
		v = NativeUI.CreateListItem(chapeauItem[ind], amount, 1, "",5)
	
		menu:AddItem(v)
		

	end
	_menuPool:WidthOffset(120)
	_menuPool:RefreshIndex()
	
	menu.OnIndexChange = function(menu,index6)
		local index2 = 1
		
		playerPed = GetPlayerPed(-1)
		SetPedPropIndex(playerPed, 0, index6-1, 0, 2)
		menu.OnListSelect = function(_, _, _)
			pdka = index2 - 1 
			TriggerServerEvent("parow:SetNewMasque",index6-1,pdka,	"Chapeau",chapeauItem[index6],0)
		end
		menu.OnListChange = function(_, _, index26)
			index2 = index26
			SetPedPropIndex(playerPed, 0, index6-1, index26-1, 2)
		end
	end
else

end 

end






local menuLoaded = false
local clotheShop = NativeUI.CreateMenu("Accessoire", "Magasin", 8, 200,"","", nil,100,0,0,255)
function OpenClotheShop()
	TriggerEvent("parow:exit")
	
	if menuLoaded == false  then
		
		_menuPool:Add(clotheShop)
		ClotheShopAdd(clotheShop)
		menuLoaded = true
	--	clotheShop:Visible(not clotheShop:Visible())
--	Citizen.Wait(200)
	_menuPool:RefreshIndex()
	clotheShop:Visible(not clotheShop:Visible())
	else
		_menuPool:CloseAllMenus()
		print("MENULOADED")
		clotheShop:Visible(not clotheShop:Visible())
		
end
	
	

end



_menuPool:RefreshIndex()


-- function

Citizen.CreateThread(function()
	--OpenClotheShop()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)

	end
	
	TriggerEvent('parow:exit')
end)



AddEventHandler('clothesShop:hasEnteredMarker', function(zone)

	CurrentAction6     = 'shop_menu'
	CurrentAction6Msg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique'
	CurrentAction6Data = {zone = zone}

end)

AddEventHandler('clothesShop:hasExitedMarker', function(_)

	CurrentAction6 = nil
	CurrentAction6Msg = nil
	TriggerEvent("parow:exit")
	_menuPool:CloseAllMenus()
	if MenuOn then
		RecupTenues()
		MenuOn = false
	end
end)
 


-- Display markers
Citizen.CreateThread(function()
  while true do
	Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for _,v in pairs(ConfigclotheShop.Zones) do
      for i = 1, #v.Pos, 1 do
        if(ConfigclotheShop.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < ConfigclotheShop.DrawDistance) then
          DrawMarker(ConfigclotheShop.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, ConfigclotheShop.Size.x, ConfigclotheShop.Size.y, ConfigclotheShop.Size.z, ConfigclotheShop.Color.r, ConfigclotheShop.Color.g, ConfigclotheShop.Color.b, 100, false, true, 2, false, false, false, false)
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

		for k,v in pairs(ConfigclotheShop.Zones) do
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
			TriggerEvent('clothesShop:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('clothesShop:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  
	  if CurrentAction6 ~= nil then
		SetTextComponentFormat('STRING')
		AddTextComponentString(CurrentAction6Msg)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
		if IsControlJustReleased(0, 38) then
		--	TriggerEvent("onClientMaspStart")
		
			
			OpenClotheShop()
			recp()
			MenuOn = true
	--	  CurrentAction6 = nil
  
		end
  
	  end
	end
  end)


  function recp()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
  end

  Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)
        _menuPool:ProcessMenus()
		if bite then
			
            _menuPool:CloseAllMenus()
            OpenAccessMenus()
		end
    end
end)
local mainMenu = nil
function OpenAccessMenus()
    _menuPool:CloseAllMenus()
    mainMenu = NativeUI.CreateMenu("Mes accessoires", "Accessoires disponibles", 8, 200, "","", nil,100,0,0,255)
    _menuPool:Add(mainMenu)
    RefreshData()
	


end
function RefreshData()
    ESX.TriggerServerCallback("parow:getMask", function(result)
		MaskTab = result
		maskMenu(mainMenu)
    end)
end
function maskMenu(menu)
    local accessories = { "Masque", "Chapeau", "Lunette" }
	local accessoriesIndex = { "mask", "hat", "glasses"}
	
    xss = NativeUI.CreateListItem("Enlever", accessories, 1, "")
    menu:AddItem(xss)
    menu.OnListSelect = function(m, item, index)
        if item == xss then
            accessory = accessoriesIndex[index]

            if accessory == "mask" then
                SetPedComponentVariation(playerPed, 1, 0, 0, 2)
            end
            if accessory == "glasses" then
                ClearPedProp(playerPed, 1)


            end
            if accessory == "hat" then
                ClearPedProp(playerPed, 0)

            end
        end


    end
        result = MaskTab
        --(json.encode(result))
        if #result == 0 then
            u = NativeUI.CreateItem("Vide", "")
            menu:AddItem(u)
        else

            for i = 1, #result, 1 do
				menumbk = menu
				_menuPool:RefreshIndex()
                local xfvde = _menuPool:AddSubMenu(menu, result[i].label, "", 5, 200)

                xl = NativeUI.CreateItem("Équiper", "")
                xc = NativeUI.CreateItem("Renommer", "")
                xv = NativeUI.CreateItem("Donner", "")
                xb = NativeUI.CreateItem("Jeter", "")
                xfvde:AddItem(xl)
                xfvde:AddItem(xc)
                xfvde:AddItem(xv)
                xfvde:AddItem(xb)
                xfvde.OnItemSelect = function(menu, _, index)
                 --   i = i+1
                    if index == 1 then
                        k = json.decode(result[i].mask)
                        ped = GetPlayerPed(-1)
                        uno = k.mask_1
                        dos = k.mask_2
                        typos = result[i].type
                        --(typos)
                        if typos == "Masque" then

                            if ped then
                                local dict = 'missfbi4'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'takeoff_mask'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedComponentVariation(playerPed, 1, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end
                        elseif typos == "Lunette" then

                            if ped then
                                local dict = 'clothingspecs'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'try_glasses_positive_a'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 1, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end

                        elseif typos == "Chapeau" then

                            if ped then
                                local dict = 'missheistdockssetup1hardhat@'
                                local myPed = PlayerPedId()
                                RequestAnimDict(dict)

                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(0)
                                end

                                local animation = ''
                                local flags = 0 -- only play the animation on the upper body
                                animation = 'put_on_hat'
                                TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                Citizen.Wait(1000)
                                SetEntityCollision(GetPlayerPed(-1), true, true)
                                playerPed = GetPlayerPed(-1)
                                SetPedPropIndex(playerPed, 0, k.mask_1, k.mask_2, 2)
                                Citizen.Wait(200)
                                ClearPedTasks(playerPed)
                            end

                        end
                    end
                    if index == 2 then
                        typos = result[i].type
                        txt = gettxt2(result[i].label)
                        txt = tostring(txt)
                        if txt ~= nil then
                            TriggerServerEvent("parow:RenameMasque", result[i].id, txt, typos)
                          k = menumbk:GetItemAt(i+1)
                          k:UpdateText(txt)
                          menu:GoBack()
                          result[i].label = txt

                        end
						
                    end
                    if index == 3 then
                        local myPed = PlayerPedId()
                        if result[i].index == 99 then
                            SetPedComponentVariation(playerPed, 1, 0, 0, 2)
                        else
                            ClearPedProp(myPed, result[i].index)
                        end
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        local closestPed = GetPlayerPed(closestPlayer)

                        if IsPedSittingInAnyVehicle(closestPed) then
                            ESX.ShowNotification('~r~Impossible de donner un objet dans un véhicule')
                            return
                        end

                        if closestPlayer ~= -1 and closestDistance < 3.0 then

                            TriggerServerEvent('prw:GiveAccessories', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)


                            menu:GoBack()

                          --  _menuPool:RefreshIndex()
                            table.remove( MaskTab, i  )
                            menumbk:RemoveItemAt(i+1)

                        else
                            ESX.ShowNotification("~r~Aucun joueurs proche")

                        end


                    end
                    if index == 4 then
                        TriggerServerEvent('prw:Delclo', result[i].id, result[i].label,result[i])

                        menu:GoBack()

                        --_menuPool:RefreshIndex()
                        table.remove( MaskTab, i  )
                        menumbk:RemoveItemAt(i+1)

                    end
				end
			
                --    menu:AddItem(psp)
                -- _menuPool:RefreshIndex()
            end
		end
		
		_menuPool:WidthOffset(120)
		menu:Visible(true)
end

RegisterNetEvent('acc:openMenu')
AddEventHandler('acc:openMenu', function()
	OpenAccessMenus()
end)