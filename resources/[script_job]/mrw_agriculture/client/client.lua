ESX = nil
local PlayerData                = {}


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(100)
  end

  ESX.PlayerData = ESX.GetPlayerData()

end)

local Plant                      = {}
local transform = false
local transform2 = false

local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}


RegisterNetEvent('mrw_agriculture:PlantationGrBle')
AddEventHandler('mrw_agriculture:PlantationGrBle', function()
  local currentPos = GetEntityCoords(GetPlayerPed(-1))
  
  x, y, z = table.unpack(currentPos);
  TriggerServerEvent('mrw_agriculture:createPlante', x, y, z -1)
  TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_gardener_plant", 0, false)
  Citizen.Wait(10000)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(2000)
  CreatePlanteB()
end)

function CreatePlanteB()
  ESX.TriggerServerCallback('mrw_agriculture:checkPlante', function(data)
    for i=1, #data, 1 do
      local data = data[i]
      --if data.identifier == GetPlayerName(PlayerId()) then 
        DeleteObject(Plant[data.x])
        if data.percent <= 25 then  
          Plant[data.x] = CreateObject(GetHashKey("prop_veg_corn_01"), data.x , data.y , data.z -3.0,  true,  false, false)
  		    SetEntityAsMissionEntity(Plant[data.x],true,true)
          SetEntityAlwaysPrerender(Plant[data.x],true)
          SetEntityHeading(Plant[data.x], 213)
          FreezeEntityPosition(Plant[data.x],true)
          ESX.ShowNotification('Ton plant n° : ~b~'..data.id..'~w~  est à : ~b~'..data.percent..'~w~ % de sa croissance')
        elseif data.percent >= 26 and data.percent <= 50 then
          Plant[data.x] = CreateObject(GetHashKey("prop_veg_corn_01"), data.x , data.y , data.z -2.0,  true,  false, false)
  		    SetEntityAsMissionEntity(Plant[data.x],true,true)
          SetEntityAlwaysPrerender(Plant[data.x],true)
          SetEntityHeading(Plant[data.x], 213)
          FreezeEntityPosition(Plant[data.x],true)
          ESX.ShowNotification('Ton plant n° : ~b~'..data.id..'~w~  est à : ~b~'..data.percent..'~w~ % de sa croissance')
        elseif data.percent >= 51 and data.percent <= 75 then
          Plant[data.x] = CreateObject(GetHashKey("prop_veg_corn_01"), data.x , data.y , data.z -1.0,  true,  false, false)
  		    SetEntityAsMissionEntity(Plant[data.x],true,true)
          SetEntityAlwaysPrerender(Plant[data.x],true)
          SetEntityHeading(Plant[data.x], 213)
          FreezeEntityPosition(Plant[data.x],true)
           ESX.ShowNotification('Ton plant n° : ~b~'..data.id..'~w~  est à : ~b~'..data.percent..'~w~ % de sa croissance')
        elseif data.percent >= 76 and data.percent <= 150 then
          Plant[data.x] = CreateObject(GetHashKey("prop_veg_corn_01"), data.x , data.y , data.z,  true,  false, false)
  		    SetEntityAsMissionEntity(Plant[data.x],true,true)
          SetEntityAlwaysPrerender(Plant[data.x],true)
          FreezeEntityPosition(Plant[data.x],true)
           ESX.ShowNotification('Ton plant n° : ~b~'..data.id..'~w~  est à : ~b~'..data.percent..'~w~ % de sa croissance')
        elseif data.percent >= 151 then
          ESX.ShowNotification('Vous avez oubliez de récuperez votre plant n° : ~b~'..data.id..'~w~')
          TriggerServerEvent('mrw_agriculture:deletePlant', data.x)
        end
      --end  
    end
  end)
end

RegisterNetEvent('mrw_agriculture:usetruelle')
AddEventHandler('mrw_agriculture:usetruelle', function(x)
  ESX.TriggerServerCallback('mrw_agriculture:checkPlante', function(data)
    num2 = 1
    for i=1, #data, 1 do
      local data = data[i]
      distance = GetDistanceBetweenCoords(data.x, data.y, data.z, GetEntityCoords(GetPlayerPed(-1)))
    
      if distance < 2 then
        if num2 == 1 then
          num2 = 0
        if data.percent < 99 then
          ESX.ShowNotification('~r~ Le plan n\'est pas mature')
        elseif data.percent >= 100 or data.percent <= 150 then
          TriggerServerEvent('mrw_agriculture:deletePlant', data.x)
          TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_gardener_plant", 0, false)
          Citizen.Wait(5000)
          TriggerEvent('mrw_agriculture:deletePlant', data.x)
          Plant[data.x] = CreateObject(GetHashKey("prop_veg_corn_01"), data.x , data.y , data.z - 0.8 ,  true,  false, false)
          Citizen.Wait(5000)
          TriggerEvent('mrw_agriculture:deletePlant', data.x)
          Plant[data.x] = CreateObject(GetHashKey("prop_veg_corn_01"), data.x , data.y , data.z - 1.2 ,  true,  false, false)
          Citizen.Wait(5000)
          TriggerEvent('mrw_agriculture:deletePlant', data.x)
          Plant[data.x] = CreateObject(GetHashKey("prop_veg_corn_01"), data.x , data.y , data.z - 1.4 ,  true,  false, false)
          Citizen.Wait(5000)
          ClearPedTasks(GetPlayerPed(-1))
          TriggerServerEvent('mrw_agriculture:GiveItem',data.x)
          TriggerEvent('mrw_agriculture:deletePlant', data.x)
        end
      end
      end
    end
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(300000)
    CreatePlanteB()
  end
end)


RegisterNetEvent('mrw_agriculture:deletePlant')
AddEventHandler('mrw_agriculture:deletePlant', function(x)
  DeleteObject(Plant[x])
end)

---------------------------------||||||||||||||||||||||||||||| TRAITEMENT |||||||||||||||||||||||||--------------------------------------

AddEventHandler('mrw_agriculture:hasEnteredMarker', function(zone)
  if zone == 'Zone' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then
    CurrentAction     = 'Zone'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour transformer votre grain en farine'
    CurrentActionData = {zone= zone}
  end
    
  if zone == 'Zone2' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then
    CurrentAction     = 'Zone2'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour transformer votre farine'
    CurrentActionData = {zone= zone}
  end   
    
end)

AddEventHandler('mrw_agriculture:hasExitedMarker', function(zone)
  ESX.UI.Menu.CloseAll()
  if (zone == 'Zone') and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then
    TriggerServerEvent('mrw_agriculture:StopTransform')
  end  
  if (zone == 'Zone2') and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then
    TriggerServerEvent('mrw_agriculture:StopTransform2')
  end  

  if (zone == 'Sell') and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then
    TriggerServerEvent('esx_brasseurjob:StopSell')
  end  
  CurrentAction = nil
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then
        if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
          DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then

      local coords      = GetEntityCoords(GetPlayerPed(-1))
      local isInMarker  = false
      local currentZone = nil

      for k,v in pairs(Config.Zones) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInMarker  = true
          currentZone = k
        end
      end

      if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
        HasAlreadyEnteredMarker = true
        LastZone                = currentZone
        TriggerEvent('mrw_agriculture:hasEnteredMarker', currentZone)
      end

      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('mrw_agriculture:hasExitedMarker', LastZone)
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then
      
      ESX.ShowHelpNotification(CurrentActionMsg)

      if IsControlPressed(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur'  then
        if CurrentAction == 'Zone' then
          RequestAnimDict('pickup_object')
          TaskPlayAnim(PlayerPedId(), 'pickup_object', 'pickup_low', 1.0, -1.0, 600000, 1, 1, true, true, true)
          TriggerServerEvent('mrw_agriculture:Transform', CurrentActionData.zone) 
        end
        if CurrentAction == 'Zone2' then
          RequestAnimDict('pickup_object')
          TaskPlayAnim(PlayerPedId(), 'pickup_object', 'pickup_low', 1.0, -1.0, 600000, 1, 1, true, true, true)
          TriggerServerEvent('mrw_agriculture:Transform2', CurrentActionData.zone) 
        end
        CurrentAction = nil
      end
    end   
  end
end)

RegisterNetEvent('mrw_agriculture:StopAnim')
AddEventHandler('mrw_agriculture:StopAnim', function()
 ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'agriculteur',
		number     = 'agriculteur',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
	}
	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end) 

---------------------------------||||||||||||||||||||||||||||| COFFRE |||||||||||||||||||||||||||||--------------------------------------

--[[function OpenParcelleInventoryMenu(owner)

  ESX.TriggerServerCallback('mrw_agriculture:getParcelleInventory', function(inventory)

    local elements = {}


    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'room_inventory',
      {
        title    = 'Coffre',
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_standard' then

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'get_item_count',
            {
              title = 'Montant',
            },
            function(data2, menu)

              local quantity = tonumber(data2.value)

              if quantity == nil then
                ESX.ShowNotification('montant invalide')
              else

                menu.close()

                TriggerServerEvent('mrw_agriculture:getItem', owner, data.current.type, data.current.value, quantity)

                ESX.SetTimeout(300, function()
                  OpenParcelleInventoryMenu(owner)
                end)

              end

            end,
            function(data2,menu)
              menu.close()
            end
          )

        end

      end,
      function(data, menu)
        menu.close()
      end
    )
  end, owner)
end

function OpenPlayerInventoryMenu(owner)

  ESX.TriggerServerCallback('mrw_agriculture:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'player_inventory',
      {
        title    = 'Votre sac',
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_standard' then

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'put_item_count',
            {
              title = 'Montant',
            },
            function(data2, menu)

              menu.close()

              TriggerServerEvent('mrw_agriculture:putItem', owner, data.current.type, data.current.value, tonumber(data2.value))

              ESX.SetTimeout(300, function()
                OpenPlayerInventoryMenu(parcelle, owner)
              end)

            end,
            function(data2,menu)
              menu.close()
            end
          )

        end
      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end]]

-----------------||||||||||||| Blip |||||||||||--------------------------------

Citizen.CreateThread(function()

  local BlipCulture = AddBlipForCoord(2243.5197, 5154.311, 56.89)
  SetBlipSprite(BlipCulture, 89)
  SetBlipScale(BlipCulture, 0.7)
  SetBlipColour(BlipCulture, 64)
  SetBlipAsShortRange(BlipCulture, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Culture")
  EndTextCommandSetBlipName(BlipCulture)

end)

function BlipJob()
  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'agriculteur' then
    local BlipTransfo = AddBlipForCoord(1991.0679, 5022.4003, 41.00)
    SetBlipSprite(BlipTransfo, 89)
    SetBlipScale(BlipTransfo, 0.7)
    SetBlipColour(BlipTransfo, 64)
    SetBlipAsShortRange(BlipTransfo, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Transformation grain")
    EndTextCommandSetBlipName(BlipTransfo)

    local BlipTransfo2 = AddBlipForCoord(2403.3203, 4990.7089, 46.33)
    SetBlipSprite(BlipTransfo2, 89)
    SetBlipScale(BlipTransfo2, 0.7)
    SetBlipColour(BlipTransfo2, 64)
    SetBlipAsShortRange(BlipTransfo2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Transformation farine")
    EndTextCommandSetBlipName(BlipTransfo2)
  end  
end

AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
    Citizen.CreateThread(function()
    BlipJob()
    end)
	end
end)