-- Authors:Morow
-- Github:https://github.com/Morow73
-- No edit no changes without my perms

local Character   = {}
local LastSkin    = nil

ESX               = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu('Barbier','Barber Job by Morow', 8, 200,"","", nil,100,0,0,255)
_menuPool:Add(mainMenu)

_menuPool:RefreshIndex()

function Param()
  _menuPool:WidthOffset(80)
  _menuPool:MouseControlsEnabled(true)
  _menuPool:MouseEdgeEnabled(false)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)

    _menuPool:ProcessMenus()
    
      if IsControlPressed(0, 167) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'barbier' then
         mainMenu:Visible(not mainMenu:Visible())  
      end   
  end
end)


local CoupeHomme = { 
 "Chauve", -- 0
 "Rasé",   -- 1
 "Faux faucon", --2
 "Plaqué en arrière",--3 
 "Brossé", --4
 "Brossé 2",--5
 "Motard", --6
 "Queue de cheval", --7
 "Tresse", --8
 "Bouclé", --9
 "Court Brosser", --10
 "Cheveux Herisses", --11
 "Plaqué en avant", --12
 "Bieber", --13
 "Dread", --14
 "Cheveux longs",--15 
 "Long bouclé", --16
 "Mec Surfer", --17
 "Sur le coté", --18
 "Brossé 3", --19
 "Long Slicked", --20
 "Hipster Youth", --21
 "Mullet", --22
 "24", --nil
 "25", --nil
 "24", --nil
 "25", --nil
 "26", --nil
 "27", --nil
 "28", --nil
 "29", --nil
 "30", --nil
 "31", --nil
 "32", --nil
 "33", --nil
 "34", --nil
 "35", --nil
 "36", --nil
 "37", --nil
 "38", --nil
 "39", --nil
 "40", --nil
 "41", --nil
 "42", --nil
 "43", --nil
 "44", --nil
 "45", --nil
 "46", --nil
 "47", --nil
 "48", --nil
 "49", --nil
 "50", --nil
 "51", --nil
 "52", --nil
 "53", --nil
 "54", --nil
 "55", --nil
 "56", --nil
 "57", --nil
 "58", --nil
 "59", --nil
 "60", --nil
 "61", --nil
 "62", --nil
 "63", --nil
 "64", --nil
 "65", --nil
 "66", --nil
 "67", --nil
 "68", --nil
 "69", --nil
 "70", --nil
 "71", --nil
 "72", --nil
 "73", --nil
 "74", --nil
 "75", --nil
 "76", --nil
 "77", --nil
 "78", --nil
}

local CoupeFemme = {
  "Court",
  "Bob en couches",
  "Tresses",
  "Queue de cheval",
  "Mohawk tressé",
  "Tresses", "Bob",
  "Faux Faucon",
  "French Twist",
  "Long Bob",
  "Loose Tied",
  "Lutin",
  "Bangs Rasés",
  "noeuds supérieurs",
  "Bob ondulé",
  "Pin Up Girl",
  "Chignon décoiffé",
  "Inconnu",
  "Tight Bun",
  "Bob tordu",
  "Big Bangs",
  "Noeud supérieur tressé",
  "Mullet",
  "24", --nil
  "25", --nil
  "24", --nil
  "25", --nil
  "26", --nil
  "27", --nil
  "28", --nil
  "29", --nil
  "30", --nil
  "31", --nil
  "32", --nil
  "33", --nil
  "34", --nil
  "35", --nil
  "36", --nil
  "37", --nil
  "38", --nil
  "39", --nil
  "40", --nil
  "41", --nil
  "42", --nil
  "43", --nil
  "44", --nil
  "45", --nil
  "46", --nil
  "47", --nil
  "48", --nil
  "49", --nil
  "50", --nil
  "51", --nil
  "52", --nil
  "53", --nil
  "54", --nil
  "55", --nil
  "56", --nil
  "57", --nil
  "58", --nil
  "59", --nil
  "60", --nil
  "61", --nil
  "62", --nil
  "63", --nil
  "64", --nil
  "65", --nil
  "66", --nil
  "67", --nil
  "68", --nil
  "69", --nil
  "70", --nil
  "71", --nil
  "72", --nil
  "73", --nil
  "74", --nil
  "75", --nil
  "76", --nil
  "77", --nil
  "78", --nil
}


  local Couleur = {
  "Couleur 0",
  "Couleur 1",
  "Couleur 2",
  "Couleur 3",
  "Couleur 4",
  "Couleur 5",
  "Couleur 6",
  "Couleur 7",
  "Couleur 8",
  "Couleur 9",
  "Couleur 10",
  "Couleur 11",
  "Couleur 12",
  "Couleur 13",
  "Couleur 14",
  "Couleur 15",
  "Couleur 16",
  "Couleur 17",
  "Couleur 18",
  "Couleur 19",
  "Couleur 20",
  "Couleur 21",
  "Couleur 22",
  "Couleur 23",
  "Couleur 24",
  "Couleur 25",
  "Couleur 26",
  "Couleur 27",
  "Couleur 28",
  "Couleur 29",
  "Couleur 30",
  "Couleur 31",
  "Couleur 32",
  "Couleur 33",
  "Couleur 34",
  "Couleur 35",
  "Couleur 36",
  "Couleur 37",
  "Couleur 38",
  "Couleur 39",
  "Couleur 40",
  "Couleur 41",
  "Couleur 42",
  "Couleur 43",
  "Couleur 44",
  "Couleur 45",
  "Couleur 46",
  "Couleur 47",
  "Couleur 48",
  "Couleur 49",
  "Couleur 50",
  "Couleur 51",
  "Couleur 52",
  "Couleur 53",
  "Couleur 54",
  "Couleur 55",
  "Couleur 56",
  "Couleur 57",
  "Couleur 58",
  "Couleur 59",
  "Couleur 60",
  "Couleur 61",
}

local Barbe = {

  "Barbe 1",
  "Barbe 2",
  "Barbe 3",
  "Barbe 4",
  "Barbe 5",
  "Barbe 6",
  "Barbe 7",
  "Barbe 8",
  "Barbe 9",
  "Barbe 10",
  "Barbe 11",
  "Barbe 12", 
  "Barbe 13", 
  "Barbe 14", 
  "Barbe 15",
  "Barbe 16",
  "Barbe 17",
  "Barbe 18",
  "Barbe 19",
  "Barbe 20",
  "Barbe 21",
  "Barbe 22",
  "Barbe 23",
  "Barbe 24",
  "Barbe 25",
  "Barbe 26",
  "Barbe 27",
  "Barbe 28",
  "Barbe 29",
  "Barbe 30",
}


function AddBarberMenu(menu)

  Param()

  local CoupeHomme = NativeUI.CreateListItem("Coupe Homme", CoupeHomme, 0, 'Test')
  menu:AddItem(CoupeHomme)

  local CoupeFemme = NativeUI.CreateListItem("Coupe Femme", CoupeFemme, 0, 'Test')
  menu:AddItem(CoupeFemme)

  local barbeSelect = NativeUI.CreateListItem("Barbe", Barbe, 1, 'Test')
  local PercentageItem = NativeUI.CreatePercentagePanel("0%", "longueur", "100%")
  barbeSelect:AddPanel(PercentageItem)
  PercentageItem:Percentage(0.0)
  menu:AddItem(barbeSelect)

  local hairSelect = NativeUI.CreateListItem("Couleur", { { Name =  "Couleur", Value = 1 } }, 0, 'Test' )
  local hairBaseColor = NativeUI.CreateColourPanel("Couleur", ColoursPanel.HairCut)
  hairSelect:AddPanel(hairBaseColor)
  menu:AddItem(hairSelect)

  local hairSelect2 = NativeUI.CreateListItem("Couleur secondaire", { { Name =  "Couleur secondaire", Value = 1 } }, 0, 'Test' )
  local hairBaseColor2 = NativeUI.CreateColourPanel("Couleur secondaire", ColoursPanel.HairCut)
  hairSelect2:AddPanel(hairBaseColor2)
  menu:AddItem(hairSelect2)

  local Valider = NativeUI.CreateItem("~g~Valider","~g~Valider la coupe")
  menu:AddItem(Valider)

  local Facture = NativeUI.CreateItem("Facture","Faire une facture")
  menu:AddItem(Facture)

  local Annuler = NativeUI.CreateItem("~r~Annuler","~r~Annuler la coupe")
  menu:AddItem(Annuler)

    menu.OnListSelect = function(mainMenu, item, index)

 

	    if item == CoupeHomme then 
	      
	      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 2.5 then

      	  local currentSelectedIndex = item:IndexToItem(index)
      	  Hair = index
          local targetHair = GetPlayerServerId(closestPlayer)  
          Hair = Hair - 1
			    SetPedComponentVariation(closestPlayer, 2, Hair, 0, 0) 
			      --SetPedComponentVariation(GetPlayerPed(-1), 2, Hair, 0, 0)                           
			    TriggerServerEvent('mrw_barberjob:ActualizeHair', targetHair, Hair)
  
	      end
	    end 

	    if item == CoupeFemme then 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 2.5 then
			    Hair = index
	      	local currentSelectedIndex = item:IndexToItem(index)
	      	Hair = Hair - 1

          SetPedComponentVariation(closestPlayer, 2, Hair, 0, 0) 
          local targetHairF = GetPlayerServerId(closestPlayer)                                
          TriggerServerEvent('mrw_barberjob:ActualizeHairFemme', targetHairF, Hair)

	    end 
    end
  end  
   
    barbeSelect.OnListChanged = function(ParentMenu, SelectedItem, Index)

	    local ActiveItem3 = SelectedItem:IndexToItem(Index)
	    local percentage = (ActiveItem3.Panels and ActiveItem3.Panels[1] or 0.0)
	    

		 local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
     if closestPlayer ~= -1 and closestDistance <= 2.5 then
		    choise = Index-1

        SetPedHeadOverlay(closestPlayer,1,choise,percentage) 
       -- SetPedHeadOverlay(GetPlayerPed(-1),1,choise,percentage) 
        local targetBarbe = GetPlayerServerId(closestPlayer)                          
        TriggerServerEvent('mrw_barberjob:ActualizeBarbe',targetBarbe,choise,percentage)    
        hBarbe = tonumber(choise)  
        hPercentage  = tonumber(percentage * 10) 
	    end   
    end 

    hairSelect.OnListChanged = function(ParentMenu, SelectedItem, Couleur)
	    local ActiveItem = SelectedItem:IndexToItem(Couleur)
	    local hairBaseColor = (ActiveItem.Panels and ActiveItem.Panels[1] or 1) 
	  
	    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
      if closestPlayer ~= -1 and closestDistance <= 2.5 then
	      SetPedHairColor(closestPlayer,hairBaseColor,0)
	   
		    --SetPedHairColor(GetPlayerPed(-1),hairBaseColor,0)
		     
		    local targetHairCouleur = GetPlayerServerId(closestPlayer)                                
		    TriggerServerEvent('mrw_barberjob:ActualizeCouleur', targetHairCouleur, hairBaseColor)    
		    hColor = tonumber(hairBaseColor)  
      end  
		end      


	 hairSelect2.OnListChanged = function(ParentMenu, SelectedItem, Couleur)
	   local ActiveItem2 = SelectedItem:IndexToItem(Couleur)
	   local hairBaseColor2 = (ActiveItem2.Panels and ActiveItem2.Panels[1] or 1)

      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
      if closestPlayer ~= -1 and closestDistance <= 2.5 then

        SetPedHairColor(closestPlayer, hColor, hairBaseColor2)   
        local targetHairCouleur2 = GetPlayerServerId(closestPlayer)  
       --SetPedHairColor(GetPlayerPed(-1), hColor, hairBaseColor2)                                
        TriggerServerEvent('mrw_barberjob:ActualizeCouleur2', targetHairCouleur2, hColor, hairBaseColor2)  
        hColor2 = tonumber(hairBaseColor2) 
      end   
    end 

    menu.OnItemSelect = function(menu, item)
	    if item == Valider then 
	        print('Valider')

	      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 2.5 then
	          	         
          ESX.TriggerServerCallback('mrw_barberjob:getClosestPlayerSkin', function(cb)

            comp = cb

  			    if tonumber(Hair) ~= nil then
             comp.hair_1 = 'hair_1'
             comp.hair_1 = nil
             comp.hair_1 = Hair
  			    end
  			        
  	        if hColor ~= nil then
  		        if hColor >= 1 then
                comp.hair_color_1 = 'hair_color_1'
                comp.hair_color_1 = nil
                comp.hair_color_1 = hColor
  		        end
  	        end


  	        if hColor2 ~= nil then
  	        	if hColor2 >= 1 then
                comp.hair_color_2 = 'hair_color_2'
                comp.hair_color_2 = nil
                comp.hair_color_2 = hColor2
  	        	end
  	        end	  

  	        if hBarbe ~= nil then
  	        	if hBarbe >= 1 then 
                comp.beard_1 = 'beard_1'
                comp.beard_1 = nil
                comp.beard_1 = hBarbe
  	        	end
  	        end	

  	        if hPercentage ~= nil then
  	        	if hPercentage >= 1 then 
                comp.beard_2 = 'beard_2'
                comp.beard_2 = nil
                comp.beard_2 = hPercentage
  	        	end
  	        end	



            PlayAnim()
            TriggerServerEvent('mrw_barberjob:save',GetPlayerServerId(closestPlayer), comp)
            ESX.ShowNotification('Coupe effectuer')
            
          end, GetPlayerServerId(closestPlayer))
        end  
	    end 

	    if item == Facture then 
	      
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()   
        if closestPlayer ~= -1 and closestDistance <= 2.5 then
           _menuPool:CloseAllMenus()

	        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 100)
	        while (UpdateOnscreenKeyboard() == 0) do
	          DisableAllControlActions(0);
	          Citizen.Wait(1)
	        end
	        if (GetOnscreenKeyboardResult()) then
	         result = tonumber(GetOnscreenKeyboardResult())
            if tonumber(result) == nil then
              ESX.ShowNotification('~r~Vous devez entrer un nombre') 
            else
	            local amount = tonumber(result)
	            TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
	            Citizen.Wait(5000)
	            ClearPedTasks(GetPlayerPed(-1))
	            TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(closestPlayer), 'society_barbier', 'Barbier', amount)   
            end     
	        end                      
        end 
	    end 

	    if item == Annuler then 
        print('Annuler')
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 2.5 then
          ReturnSkin(closestPlayer)
        else                
          _menuPool:CloseAllMenus()
        end   
     end
    end    
end 


function ReturnSkin(closestPlayer)
    ESX.TriggerServerCallback('mrw_barberjob:getClosestPlayerSkin', function(cb)
    skin = cb
    TriggerServerEvent('mrw_barberjob:testSync',skin, GetPlayerServerId(closestPlayer))
  end, GetPlayerServerId(closestPlayer))
end

function Notification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function PlayAnim()

  Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
        FreezeEntityPosition(GetPlayerPed(-1), true)
    RequestAnimDict('misshair_shop@barbers')

    while not HasAnimDictLoaded('misshair_shop@barbers') do
      
      Citizen.Wait(1)
    end
       
    TaskPlayAnim(playerPed, 'misshair_shop@barbers', 'keeper_idle_b', 1.0, -1.0, 6000, 0, 1, GetEntityCoords(GetPlayerPed(-1)))
    Citizen.Wait(6000)
    FreezeEntityPosition(GetPlayerPed(-1), false)
  end)
end

--[[function PlayAnim()
  disableUI = true
  TriggerEvent('barbershop:disableUI')
  TaskPedSlideToCoord(PlayerPedId(), 137.12, -1709.45, 29.3, 205.75, 1.0)
  DoScreenFadeOut(1000)
  while not IsScreenFadedOut() do
      Citizen.Wait(0)
  end
  SetEntityCoords(PlayerPedId(), 137.72, -1710.64, 28.60)
  SetEntityHeading(PlayerPedId(), 237.22)
  ClearPedTasks(GetPlayerPed(-1))
  BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
  TaskStartScenarioAtPosition(GetPlayerPed(-1), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
  Citizen.Wait(1300)
  DoScreenFadeIn(5000)
end]]--

AddBarberMenu(mainMenu)

RegisterNetEvent('mrw_barberjob:ActualizeHairH')
AddEventHandler('mrw_barberjob:ActualizeHairH', function(HairH)
   SetPedComponentVariation(GetPlayerPed(-1), 2, HairH,0, 0) 
end)

RegisterNetEvent('mrw_barberjob:ActualizeBeardH')
AddEventHandler('mrw_barberjob:ActualizeBeardH', function(choise, percentage)  
choise = choise  
   SetPedHeadOverlay(GetPlayerPed(-1), 1,choise,percentage)
end)


RegisterNetEvent('mrw_barberjob:ActualizeHairF')
AddEventHandler('mrw_barberjob:ActualizeHairF', function(HairF)
   SetPedComponentVariation(GetPlayerPed(-1), 2, HairF,0, 0) 
end)

RegisterNetEvent('mrw_barberjob:ActualizeHairCouleur')
AddEventHandler('mrw_barberjob:ActualizeHairCouleur', function(hairBaseColor)   
   SetPedHairColor(GetPlayerPed(-1),hairBaseColor,0)
end)

RegisterNetEvent('mrw_barberjob:ActualizeHairCouleur2')
AddEventHandler('mrw_barberjob:ActualizeHairCouleur2', function(hairBaseColor, hairBaseColor2)
   SetPedHairColor(GetPlayerPed(-1),hairBaseColor,hairBaseColor2)
end)

AdvancedColorNotification = function(title, subject, msg, icon, iconType, bgColor)
  SetNotificationBackgroundColor(bgColor)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(msg)
  SetNotificationMessage(icon, icon, false, iconType, title, subject)
  DrawNotification(false, false)
end

ColorNotification = function(msg, bgColor)
  SetNotificationBackgroundColor(bgColor)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(msg)
  DrawNotification(false, true)
end

RegisterNetEvent('MRW:ColorNotification')
AddEventHandler('MRW:ColorNotification', function(msg,bgColor)
    ColorNotification(msg, bgColor)
end)

RegisterNetEvent('MRW:AdvancedColorNotification')
AddEventHandler('MRW:AdvancedColorNotification', function(title, subject, msg, icon, iconType, bgColor)
    AdvancedColorNotification(title, subject, msg, icon, iconType, bgColor)
end)




-- v_ilev_hd_chair