ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_bucheronsjob:darmadera")
AddEventHandler("esx_bucheronsjob:darmadera", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local hachaitem = xPlayer.getInventoryItem('hacha').count 

if hachaitem < 1  then 
 xPlayer.showNotification("Vous n'avez pas de hache pour faire ce travail ")
else
        if xPlayer ~= nil then
             if xPlayer.getInventoryItem('bois').count < 10 and xPlayer.canCarryItem('bois', 1) then
                xPlayer.addInventoryItem('bois', 1)
               else
               xPlayer.showNotification("Vous ne pouvez pas transporter plus de bois ")
             end
        end
    end   
end)

RegisterNetEvent("esx_bucheronsjob:giveitem")
AddEventHandler("esx_bucheronsjob:giveitem", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('hacha', 1)
end)

RegisterNetEvent("esx_bucheronsjob:removeitem")
AddEventHandler("esx_bucheronsjob:removeitem", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('hacha', 1)
end)

RegisterNetEvent("esx_bucheronsjob:Procesamientomadera")
AddEventHandler("esx_bucheronsjob:Procesamientomadera", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local maderacortadacantidad = xPlayer.getInventoryItem('bois_pooch').count    

    if xPlayer ~= nil then
        if  maderacortadacantidad  > 6 then   -- el limite seria 7
            xPlayer.showNotification("Vous ne pouvez pas transporter plus de bois coupé ")
                else    
                    if xPlayer.getInventoryItem('bois').count > 0 and xPlayer.canCarryItem('bois_pooch', 1) then
                        TriggerClientEvent("esx_bucheronsjob:Procesamientomadera", source)
                        Citizen.Wait(15900)
                        xPlayer.addInventoryItem('bois_pooch', 1)
                        xPlayer.removeInventoryItem("bois", 1)
                    elseif xPlayer.getInventoryItem('bois').count < 1 then
                        xPlayer.showNotification("Vous n'avez pas de bois à couper ")
                    end
                end
        end    

end)

RegisterNetEvent("esx_bucheronsjob:refinadomadera")
AddEventHandler("esx_bucheronsjob:refinadomadera", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
  
    local limitelevel4 =       xPlayer.getInventoryItem('maderaroble').count 
    local limitelevel3 =       xPlayer.getInventoryItem('maderanogal').count 
    local limitelevel2 =       xPlayer.getInventoryItem('maderacaoba').count 
    local limitelevel1 =       xPlayer.getInventoryItem('packaged_plank').count 

        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('bois_pooch').count >= 2 then
                TriggerClientEvent("esx_bucheronsjob:refinadomadera", source)
             Citizen.Wait(15900)
             if randomChance < 10 then
               if limitelevel4 <= 11 and xPlayer.canCarryItem("maderaroble", 4) then
                xPlayer.removeInventoryItem("bois_pooch", 2)
                xPlayer.addInventoryItem("maderaroble", 4)
                  else
                    xPlayer.showNotification("Vous ne pouvez pas prendre plus de planches de chêne ")
             end
                elseif randomChance > 9 and randomChance < 25 then
                 if limitelevel3 > 11 and not xPlayer.canCarryItem("maderanogal", 4) then
                 xPlayer.showNotification("Vous ne pouvez pas prendre plus de panneaux en noyer ")
                else
                    xPlayer.removeInventoryItem("bois_pooch", 2)
                    xPlayer.addInventoryItem("maderanogal", 4)
               end
                elseif randomChance > 24 and randomChance < 50 then
                
                if limitelevel2 > 11 and not xPlayer.canCarryItem("maderacaoba", 4) then
                 xPlayer.showNotification("Vous ne pouvez pas transporter plus de bois d'acajou ")
                else
                    xPlayer.removeInventoryItem("bois_pooch", 2)
                    xPlayer.addInventoryItem("maderacaoba", 4)
                end

                elseif randomChance > 49 then
                   if limitelevel1 > 27 and not xPlayer.canCarryItem("packaged_plank", 4) then
                    xPlayer.showNotification("Vous ne pouvez pas prendre plus de planche emballée ")
                    else
                            xPlayer.removeInventoryItem("bois_pooch", 2)
                            xPlayer.addInventoryItem("packaged_plank", 4)
                    end
                end

            elseif xPlayer.getInventoryItem('bois_pooch').count < 1 then
        xPlayer.showNotification("Vous n\'avez pas assez de bois coupé pour emballer ")
            end
        end
end)

