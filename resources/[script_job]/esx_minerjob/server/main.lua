ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_mineurjob:recolte")
AddEventHandler("esx_mineurjob:recolte", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local picoitem = xPlayer.getInventoryItem('pico').count 

if picoitem < 1  then 
 xPlayer.showNotification("~r~Vous n\'avez pas de pioche pour faire ce travail ")
 print(picoitem)
else
        if xPlayer ~= nil then
             if xPlayer.getInventoryItem('stone').count < 7 and xPlayer.canCarryItem('stone', 1) then
                
                xPlayer.addInventoryItem('stone', 1)
           
                xPlayer.showNotification("~r~Vous avez trouvé des roches ")
               else
               xPlayer.showNotification("~r~Vous ne pouvez pas prendre plus de roches ")
               print(picoitem)
             end
        end
     end   
end)

    
RegisterNetEvent("esx_mineurjob:lavage")
AddEventHandler("esx_mineurjob:lavage", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
  local washstonecantidad = xPlayer.getInventoryItem('washed_stone').count    
  local picoitem = xPlayer.getInventoryItem('pico').count    

--if picoitem < 1  then 
--    xPlayer.showNotification("~r~Vous n\'avez pas de pioche pour faire ce travail ")
--else
        if xPlayer ~= nil then


if washstonecantidad  > 6 then   
    xPlayer.showNotification("~r~Vous ne pouvez pas prendre plus de roches lavées ")
        else    
           
            if xPlayer.getInventoryItem('stone').count > 0 and xPlayer.canCarryItem('washed_stone', 1) then
                        TriggerClientEvent("esx_mineurjob:lavage", source)
                        Citizen.Wait(15900)
                        xPlayer.addInventoryItem('washed_stone', 1)
                        xPlayer.removeInventoryItem("stone", 1)
                
                    elseif xPlayer.getInventoryItem('stone').count < 1 then

                        xPlayer.showNotification("~r~Tu n\'as pas de pierre à laver ")
                    
                    else
                xPlayer.showNotification("~r~Vous n\'avez pas assez de roche pour vous laver ou vous n\'avez pas assez de place ")

            end
        end     
      end
   -- end
end)

RegisterNetEvent("give:item")
AddEventHandler("give:item", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem("pico", 1)
end)

RegisterNetEvent("remove:item")
AddEventHandler("remove:item", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem("pico", 1)
end)

RegisterNetEvent("esx_mineurjob:fonderie")
AddEventHandler("esx_mineurjob:fonderie", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
    local picoitem = xPlayer.getInventoryItem('pico').count    
   
    local limitediamante =  xPlayer.getInventoryItem('diamond').count 
    local limiteoro =       xPlayer.getInventoryItem('gold').count 
    local limitehierro =    xPlayer.getInventoryItem('stone_pooch').count 
    local limitecobre =     xPlayer.getInventoryItem('copper').count 


--if picoitem < 1  then 
--         xPlayer.showNotification("~r~Vous n\'avez pas de pioche pour faire ce travail ")
--else

        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('washed_stone').count > 0 then
                TriggerClientEvent("esx_mineurjob:fonderie", source)
                Citizen.Wait(15900)
                if randomChance < 10 then

               if limitediamante > 9 and not xPlayer.canCarryItem('diamond', 2) then
                 xPlayer.showNotification("~r~Vous ne pouvez pas prendre plus de diamant  ")
                else
                    xPlayer.addInventoryItem("diamond", 2)
                    xPlayer.removeInventoryItem("washed_stone", 1)
             end
               
                elseif randomChance > 9 and randomChance < 25 then

                 if limiteoro > 9 and not xPlayer.canCarryItem('gold', 2) then
                 xPlayer.showNotification("~r~Vous ne pouvez pas prendre plus d\'or ")
                else
                    xPlayer.addInventoryItem("gold", 2)
                    xPlayer.removeInventoryItem("washed_stone", 1)
               end

                elseif randomChance > 24 and randomChance < 50 then
                

                if limitehierro > 9 and not xPlayer.canCarryItem('stone_pooch', 2) then
                 xPlayer.showNotification("~r~Vous ne pouvez pas transporter plus de fer ")
                else

                    xPlayer.addInventoryItem("stone_pooch", 2)
                    xPlayer.removeInventoryItem("washed_stone", 1)
                end
              
                elseif randomChance > 49 then

            
                   if limitecobre > 14 and not xPlayer.canCarryItem('copper', 2) then
                    xPlayer.showNotification("~r~Vous ne pouvez pas prendre plus de cuivre  ")
                    else
                    xPlayer.addInventoryItem("copper", 2)
                    xPlayer.removeInventoryItem("washed_stone", 1)
                     end
                
                end
           
            elseif xPlayer.getInventoryItem('washed_stone').count < 1 then
        xPlayer.showNotification("~r~Vous n\'avez pas assez de roche lavée pour en faire fondre ")

            end
        end
   --end
end)


