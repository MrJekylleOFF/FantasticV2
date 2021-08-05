-- Author : Morow 
-- GitHub : https://github.com/Morow73
-- No Edit, No Sell !!!!!!! 

ESX_READY = true 

if ESX_READY == true then 

  ESX = nil 

  Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()
  end)

end


RMenu.Add('mrw_clothes', 'Clothe Shop', RageUI.CreateMenu("Clothe Shop", "Vétements", 2, 200))
RMenu:Get('mrw_clothes', 'Clothe Shop'):SetRectangleBanner(255, 0, 0, 100)
RMenu:Get('mrw_clothes', 'Clothe Shop').EnableMouse = false


 --RageUI.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)

RMenu.Add('mrw_clothes', 'Tee-shirt', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Tee-shirt", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Haut', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Haut", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Calque', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Calque", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Bras', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Bras", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Chaine', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Chaine", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Sac', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Sac", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Pantalon', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Pantalon", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Chaussure', RageUI.CreateSubMenu(RMenu:Get('mrw_clothes', 'Clothe Shop'), "Clothe Shop", "Chaussure", nil, nil, nil, nil))

RMenu.Add('mrw_clothes', 'Clothe Menu', RageUI.CreateMenu("Vétements", 'Vos vétements', 10 , 200,  nil, nil, 255, nil, nil, nil))
RMenu:Get('mrw_clothes', 'Clothe Menu'):SetRectangleBanner(255, 0, 0, 100)



local tshirt_1c, torso_1c, torso_2c, pants_1c, tshirt_2c, pants_2c, shoes_1c, shoes_2c, plyClothe = {}, {}, {}, {}, {}, {}, {}, {}, {}
local decals_1c, decals_2c, arms_1c, arms_2c, bags_1c, bags_2c, chain_1c, chain_2c, PlayerClothe  = {}, {}, {}, {}, {}, {}, {}, {}, {}

local firstSpawn, debug = true, false
local index = {
  tshirt_1 = 1, 
  tshirt_2 = 1,
  torso_1  = 1,
  torso_2  = 1,
  decals_1 = 1,
  decals_2 = 1,
  arms = 1,
  chain_1 = 1,
  chain_2 = 1,
  arms_2 = 0,
  bags_1 = 1,
  bags_2 = 1,
  pants_1  = 1,
  pants_2  = 1,
  shoes_1  = 1,
  shoes_2  = 1,

  utils = 1
}

RMenu:Get('mrw_clothes', 'Clothe Menu').Closed = function()
  index.tshirt_1 = 1
  index.tshirt_2 = 1
  index.torso_1  = 1
  index.torso_2  = 1
  index.decals_1 = 1
 -- decals_2 = 1
  index.arms_1 = 1
  index.chain_1 = 1
  index.chain_2 = 1
  index.arms_2 = 1
  index.bags_1 = 1
 -- bags_2 = 0,
  index.pants_1  = 1
  index.pants_2  = 1
  index.shoes_1  = 1
  index.shoes_2  = 1

  utils = 1
end;




local function GetPlayers()
  local players = {}

  for _,player in ipairs(GetActivePlayers()) do
    local ped = GetPlayerPed(player)

    if DoesEntityExist(ped) then
      table.insert(players, player)
    end
  end

  return players
end

local function GetClosestPlayer()
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  
  for index,value in ipairs(players) do
    local target = GetPlayerPed(value)
    if(target ~= ply) then
      local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
      local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(closestDistance == -1 or closestDistance > distance) then
          closestPlayer = value
          closestDistance = distance
        end
      end
    end
  return closestPlayer, closestDistance
end

function OpenKeyboard()
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 100)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Citizen.Wait(1)
  end
  if (GetOnscreenKeyboardResult()) then
    result = GetOnscreenKeyboardResult()
    if result == nil or result == '' then
      RageUI.Popup({message = "~r~Valeur incorrect !."})
    else 
      return result  
    end     
  end 
end

RegisterNetEvent('mrw_clothes:loadPlayerClothe')
AddEventHandler('mrw_clothes:loadPlayerClothe', function(data)
  print("CLOTHE", #data)
  PlayerClothe = data
end)

RegisterNetEvent('mrw_clothes:Notification')
AddEventHandler('mrw_clothes:Notification', function(text)
 RageUI.Popup({message = ""..text..""})
end)

RegisterNetEvent('mrw_clothes:refreshClothe')
AddEventHandler('mrw_clothes:refreshClothe', function(data)
  print("REFRESH_CLOTHE", #data)
  PlayerClothe = data
end)

AddEventHandler('onClientResourceStart', function (resourceName)
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
  TriggerServerEvent('mrw_clothes:loadClothe')
end)

local utils = {
 'Mettre',
 'Jeter',
 'Donner',
}

function GetComponent()

	local tshirt_1Comp = GetNumberOfPedDrawableVariations(PlayerPedId(), 8)
	local torso_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 11)
	local decals_1Comp = GetNumberOfPedDrawableVariations(PlayerPedId(), 10)
	local chain_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 7)
	local arms_1Comp   = GetNumberOfPedDrawableVariations(PlayerPedId(), 3)
	local bags_1Comp   = GetNumberOfPedDrawableVariations(PlayerPedId(), 5)
	local pants_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 4) 
	local shoes_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 6) 
 
  for i=0, tshirt_1Comp, 1 do
	table.insert(tshirt_1c, 'Article n° : '..i)
	end  

	for i=0, torso_1Comp, 1 do
	table.insert(torso_1c, 'Article n° : '..i)
  end
  
	for i=0, decals_1Comp, 1 do
	table.insert(decals_1c, 'Article n° : '..i)
  end

  for i=0, chain_1Comp, 1 do
	table.insert(chain_1c, 'Article n° : '..i)
  end
  
	for i=0, arms_1Comp, 1 do
	table.insert(arms_1c, 'Article n° : '..i)
	end

	for i=0, bags_1Comp, 1 do
	table.insert(bags_1c, 'Article n° : '..i)
	end

  for i=0, pants_1Comp, 1 do
	table.insert(pants_1c, 'Article n° : '..i)
  end 
  
	for i=0, shoes_1Comp, 1 do
	table.insert(shoes_1c, 'Article n° : '..i)
	end
end


GetComponent()


RageUI.CreateWhile(1.0, function()

    if RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Shop')) then
        RageUI.DrawContent({ header = true, instructionalButton = true }, function()

          RageUI.Button("Rayon tee-shirt" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
          end, RMenu:Get('mrw_clothes', 'Tee-shirt')) 

          RageUI.Button("Rayon haut" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
          end, RMenu:Get('mrw_clothes', 'Haut')) 

          RageUI.Button("Rayon calque" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
          end,RMenu:Get('mrw_clothes', 'Calque')) 

          RageUI.Button("Rayon bras" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
            end
          end, RMenu:Get('mrw_clothes', 'Bras')) 

          RageUI.Button("Rayon chaine" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then

            end
          end, RMenu:Get('mrw_clothes', 'Chaine')) 

          RageUI.Button("Rayon sac" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then

            end
          end, RMenu:Get('mrw_clothes', 'Sac')) 

          RageUI.Button("Rayon pantalon" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then

            end
          end, RMenu:Get('mrw_clothes', 'Pantalon')) 

         RageUI.Button("Rayon Chaussure" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then

            end
          end, RMenu:Get('mrw_clothes', 'Chaussure')) 

          RageUI.Button("Passer à la caisse !" , nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then
              local name = OpenKeyboard()
              if name == nil or name == '' then 
                RageUI.Popup({ message = "~r~Vous devez ENTRER un nom pour votre tenue !." })
              else  
                table.insert(plyClothe, {
                  tshirt_1 = ptshirt_1 ,
                  tshirt_2 = ptshirt_2 ,
                  torso_1  = ptorso_1,
                  torso_2  = ptorso_2 ,
                  decals_1 = pdecals_1 ,
               --   decals_2 = pdecals_2,
                  chain_1 = pchain_1 ,
                  chain_2 = pchain_2 ,
                  arms = parms_1 ,
                  arms_2 = parms_2,
                  bags_1 = pbags_1 ,
               --   bags_2 = pbags_2,
                  pants_1  = ppants_1,
                  pants_2  = ppants_2,
                  shoes_1  = pshoes_1,
                  shoes_2  = pshoes_2
                })

                 if ESX_READY == true then  
                      ESX.TriggerServerCallback('mrw_clothes:getPlayerSkin', function(cb)
                      comp = cb
                      if ptshirt_1 ~= nil then 
                        comp.tshirt_1 = ptshirt_1
                      end  
                      if ptshirt_2 ~= nil then  
                        comp.tshirt_2 = ptshirt_2
                      end
                      if ptorso_1 ~= nil then 
                        comp.torso_1  = ptorso_1
                      end
                      if ptorso_2 ~= nil then 
                        comp.torso_2  = ptorso_2
                      end
                      if pdecals_1 ~= nil then 
                        comp.decals_1 = pdecals_1
                      end
                      if pchain_1 ~= nil then 
                        comp.chain_1  = pchain_1
                      end
                      --comp.chain_2  = v.chain_2
                      if parms_1 ~= nil then
                        comp.arms     = parms_1
                      end
                      if parms_2 ~= nil then
                        comp.arms_2  = parms_2
                      end
                      if pbags_1 ~= nil then 
                        comp.bags_1   = pbags_1
                      end
                      if ppants_1 ~= nil then 
                        comp.pants_1  = ppants_1
                      end
                      if ppants_2 ~= nil then 
                        comp.pants_2  = ppants_2
                      end
                      if pshoes_1 ~= nil then 
                        comp.shoes_1  = pshoes_1 
                      end
                      if pshoes_2 ~= nil then 
                        comp.shoes_2  = pshoes_2
                      end

                      TriggerEvent('skinchanger:loadSkin', comp)
                      TriggerServerEvent('esx_skin:save1', comp)
                    end)  
                end

                TriggerServerEvent('mrw_clothes:saveClothe', name, plyClothe) 
                RageUI.GoBack()
              end  
            end
          end) 
        end, function()
            ---Panels
        end)
    end
end, 1)

RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Tee-shirt')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()
        RageUI.List("Tee-shirt : ", tshirt_1c, index.tshirt_1, nil, {}, true, function(Hovered, Active, Selected, Index)

          index.tshirt_1 = Index
      
          if (Active) then

            SetPedComponentVariation(PlayerPedId(), 8,  Index-1, ptshirt_2 or 0, 2)
 
            local tshirt_2Comp = 1
            tshirt_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 8, Index-1)
            tshirt_2c = {}

            if debug then 
              print(tshirt_2Comp)
            end  

            for i=0, tshirt_2Comp, 1 do
              table.insert(tshirt_2c, 'Variation n° : '..i)
            end
             ptshirt_1 = Index-1
          end
        end)

        if #tshirt_2c ~= 0 and ptshirt_1 ~= 15 then 
          RageUI.List('Variation tee-shirt : ', tshirt_2c, index.tshirt_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.tshirt_2 = Index

            if (Active) then
              SetPedComponentVariation(PlayerPedId(), 8, ptshirt_1, Index-1, 2) 
              ptshirt_2 = Index-1
            end
          end)
        end 
         RageUI.Button('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
             RageUI.GoBack()
            end
         end)
        end, function()
            ---Panels
        end)
    end
end, 1)

RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Haut')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()
         RageUI.List('Haut : ', torso_1c, index.torso_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          
          index.torso_1 = Index

          if (Active) then
            
            SetPedComponentVariation(PlayerPedId(), 11, Index-1, ptorso_2 or 0, 2)

            local torso_2Comp = 1 
            torso_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 11, Index-1)
            torso_2c = {}

            if debug then 
              print(torso_2Comp)
            end 

            for i=0, torso_2Comp, 1 do
              table.insert(torso_2c, 'Variation n° : '..i)
            end

            ptorso_1 = Index-1
          end
        end)

        if #torso_2c ~= 0 then 
          RageUI.List('Variation haut', torso_2c, index.torso_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.torso_2 = Index 

            if (Active) then 
 
              SetPedComponentVariation(PlayerPedId(), 11, ptorso_1, Index-1, 2)
              ptorso_2 = Index-1
            end 
          end)
        end

        RageUI.Button('Valider vos articles', "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
            ---Panels
        end)
    end
end, 1)

RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Calque')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()
        RageUI.List('Calque', decals_1c, index.decals_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.decals_1 = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 10, Index-1, 0, 2)

            local decals_2Comp = 1 
            decals_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 10, Index-1)
            decals_2c = {}

            if debug then 
              print(decals_2c)
            end  

            for i=0, decals_2Comp, 1 do
              table.insert(decals_2c, 'Variation n° : '..i)
            end
              pdecals_1 = Index-1
          end
        end) 

        RageUI.Button('Valider vos articles', "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
               RageUI.GoBack()
            end
         end)

        end, function()
            ---Panels
        end)
    end
end, 1)


RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Bras')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()
       
          RageUI.List('Bras', arms_1c, index.arms, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.arms = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 3, Index-1, parms_2 or 0, 2)

            local arms_2Comp = 1 
            arms_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 3, Index-1)
            arms_2c = {}

            if debug then 
              print(arms_2c)
            end  

            for i=0, arms_2Comp, 1 do
              table.insert(arms_2c, 'Variation n° : '..i)
            end

            parms_1 = Index-1

          end
        end) 

        if #arms_2c ~= 0 then
          RageUI.List('Variation bras : ', arms_2c, index.arms_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.arms_2 = Index

            if (Active) then 

              SetPedComponentVariation(PlayerPedId(), 3, parms_1, Index-1, 2)
               arms_2 = Index-1
            end
          end)
        end  

        RageUI.Button('Valider vos articles', "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
            ---Panels
        end)
    end
end, 1)

RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Chaine')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()
       
        RageUI.List('Chaine', chain_1c, index.chain_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.chain_1 = Index 

            if (Active) then 
                SetPedComponentVariation(PlayerPedId(), 7, Index-1, pchain_2 or 0, 2)
                local chain_2Comp = 1 
                chain_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 7, Index-1)
                chain_2c = {}

              if debug then 
                print(chain_2c)
              end  

              for i=0, chain_2Comp, 1 do
                table.insert(chain_2c, 'Variation n° : '..i)
              end
               pchain_1 = Index-1
            end
        end) 


        RageUI.Button('Valider vos articles', "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
               RageUI.GoBack() 
            end
         end)

        end, function()
            ---Panels
        end)
    end
end, 1)


RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Sac')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()

          RageUI.List('Sac', bags_1c, index.bags_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.bags_1 = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 5, Index-1, 0, 2)

            local bags_2Comp = 1 
            bags_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 5, Index-1)
            bags_2c = {}

            if debug then 
              print(bags_2c)
            end  

            for i=0, bags_2Comp, 1 do
              table.insert(bags_2c, 'Variation n° : '..i)
            end

            pbags_1 = Index-1
          end

        end) 

        RageUI.Button('Valider vos articles', "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
            ---Panels
        end)
    end
end, 1)

RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Pantalon')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()

         RageUI.List('Pantalon : ', pants_1c, index.pants_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.pants_1 = Index

          if (Active) then 
      
            SetPedComponentVariation(PlayerPedId(), 4, Index-1, ppants_2 or 0, 2)

            local pants_2Comp = 1
            pants_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 4, Index-1)
            pants_2c = {}

            if debug then 
              print(pants_2Comp)
            end 

            for i=0, pants_2Comp, 1 do
              table.insert(pants_2c, 'Variation n° : '..i)
            end
             ppants_1 = Index-1
          end 
        end)

        if #pants_2c ~= 0 then
          RageUI.List('Variation pantalon : ', pants_2c, index.pants_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.pants_2 = Index

            if (Active) then 

              SetPedComponentVariation(PlayerPedId(), 4, ppants_1, Index-1, 2)
               ppants_2 = Index-1
            end
          end)
        end  

        RageUI.Button('Valider vos articles', "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
              RageUI.GoBack()
            end
         end)

        end, function()
            ---Panels
        end)
    end
end, 1)

RageUI.CreateWhile(1.0, function()
      if RageUI.Visible(RMenu:Get('mrw_clothes', 'Chaussure')) then
        RageUI.DrawContent({ header = false, instructionalButton = true }, function()

         RageUI.List('Chaussure : ', shoes_1c, index.shoes_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.shoes_1 = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 6, Index-1, pshoes_2 or 0, 2)

            local shoes_2Comp = 1
            shoes_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 6, Index-1) 
            shoes_2c = {}

            if debug then 
              print(shoes_2Comp)
            end 

            for i=0, shoes_2Comp, 1 do
              table.insert(shoes_2c, 'Variation n° : '..i)
            end

             pshoes_1 = Index-1
          end

        end)

        if #shoes_2c ~= 0 then 
          RageUI.List('Variation chaussures : ',shoes_2c, index.shoes_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.shoes_2 = Index

            if (Active) then 
  
              SetPedComponentVariation(PlayerPedId(), 6, pshoes_1, Index-1, 2)
               pshoes_2 = Index-1 
            end
          end)
        end  



        RageUI.Button('Valider vos articles', "", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
            ---Panels
        end)
    end
end, 1)

Citizen.CreateThread(function()

  while true do
    Citizen.Wait(1)

  --[[  if IsControlJustPressed(1, 56) then -- F9
      if not RageUI.Visible() then 
        RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Menu'), true)  
      end 
    end  --]]

    if RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Menu')) then 

      RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
        if PlayerClothe == nil or #PlayerClothe == 0 then 
          RageUI.Button("Aucune tenue enregistrée", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
              RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Menu'), false) 
            end  
          end)
        else 
          for k,v in pairs(PlayerClothe) do
            RageUI.List(v.name, utils, index.utils, nil, {}, true, function(Hovered, Active, Selected, Index)
              index.utils = Index
              if (Selected) then
                if Index == 1 then                  
                   LoadClothe(v.clothe)
                   RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Menu'), false) 
                elseif Index == 2 then 
                   TriggerServerEvent('mrw_clothes:dropClothe', v.name)
                   RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Menu'), false) 
                elseif Index == 3 then
                  local ClosestPlayer, ClosestDistance = GetClosestPlayer()
                  if ClosestPlayer ~= -1 and ClosestDistance <= 3.0 then 
                    TriggerServerEvent('mrw_clothes:giveClothe', v.name, GetPlayerServerId(ClosestPlayer)) 
                    RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Menu'), false) 
                  else
                    RageUI.Popup({message = "~r~Personne à proximité"})
                  end 
                end  
              end 
            end)
          end  
        end 
      end, function()
      end)
    end  
  end  
end)

function LoadClothe(clothe)
    for _,v in pairs(clothe) do


	    --[[SetPedComponentVariation(PlayerPedId(), 8, v.tshirt_1, v.tshirt_2, 2)
	    SetPedComponentVariation(PlayerPedId(), 11, v.torso_1, v.torso_2, 2)

	    SetPedComponentVariation(PlayerPedId(), 10, v.decals_1, 0, 2) 

	    SetPedComponentVariation(PlayerPedId(), 7, v.chain_1, v.chain_2, 2) 

	    SetPedComponentVariation(PlayerPedId(), 3, v.arms_1, 0, 2)

	    SetPedComponentVariation(PlayerPedId(), 5, v.bags_1, 0, 2) 
	    SetPedComponentVariation(PlayerPedId(), 4, v.pants_1, v.pants_2, 2)

	    SetPedComponentVariation(PlayerPedId(), 6, v.shoes_1, v.shoes_2, 2) ]]


	    if ESX_READY == true then  
	        ESX.TriggerServerCallback('mrw_clothes:getPlayerSkin', function(cb)
			    comp = cb
			    comp.tshirt_1 = v.tshirt_1 or 15
			    comp.tshirt_2 = v.tshirt_2 
			    comp.torso_1  = v.torso_1
			    comp.torso_2  = v.torso_2
			    --comp.decals_1 = v.decals_1
			    comp.chain_1  = v.chain_1
			    --comp.chain_2  = v.chain_2
			    comp.arms     = v.arms or v.arms_1 or 5
			    comp.bags_1   = v.bags_1
			    comp.pants_1  = v.pants_1
			    comp.pants_2  = v.pants_2
			    comp.shoes_1  = v.shoes_1 
		      comp.shoes_2  = v.shoes_2

		        TriggerEvent('skinchanger:loadSkin', comp)
		        TriggerServerEvent('esx_skin:save1', comp)
		    end)  
		end
    end

    Citizen.CreateThread(function()
	    RequestAnimDict('clothingtie')
	    while not HasAnimDictLoaded('clothingtie') do
	      Citizen.Wait(1)
	    end
	    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 1.0, -1.0, 2667, 0, 1, true, true, true)
    end)
end


RegisterNetEvent('morow:openMenu')
AddEventHandler('morow:openMenu', function()
  if not RageUI.Visible() then 
    RageUI.Visible(RMenu:Get('mrw_clothes', 'Clothe Menu'), true)  
  end
end)

