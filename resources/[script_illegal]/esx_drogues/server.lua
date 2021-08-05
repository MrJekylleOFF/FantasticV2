ESX 						   = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj 
    ESX.RegisterServerCallback('jek:getItemAmount', function(source, cb, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)
        
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
    end)
end)

for _,zone in pairs(Config.Zones) do
   _G["sellPrice_"..zone.Name]          = zone.SellPrice
   _G["itemRecolte_"..zone.Name]        = zone.ItemsName[1]
   _G["itemTraitement_"..zone.Name]     = zone.ItemsName[2]
end


RegisterServerEvent('Farm2:Recolte')
AddEventHandler('Farm2:Recolte', function(Farm)
    local xPlayer       = ESX.GetPlayerFromId(source)
    local FarmItem      = xPlayer.getInventoryItem(_G["itemRecolte_"..Farm])

    local xPlayers = ESX.GetPlayers()
    local cops = 0

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' then
            cops = cops + 1
        end
    end

    if cops >= 2 then
        if xPlayer.canCarryItem(_G["itemRecolte_"..Farm], 1) then
         xPlayer.addInventoryItem(_G["itemRecolte_"..Farm], 1)
        else
            TriggerClientEvent('esx:showNotification', source, "Je n'ai plus de place")
        end
    else
        TriggerClientEvent('esx:showNotification', source, "Pas assez de policier en ville ~r~" .. cops .. "/1")
    end
end)

RegisterServerEvent('Farm2:Vente')
AddEventHandler('Farm2:Vente', function(Farm)
    local xPlayer       = ESX.GetPlayerFromId(source)
    local FarmQty = (xPlayer.getInventoryItem(_G["itemTraitement_"..Farm]).count)
    if FarmQty <= 0 then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez plus rien a vendre")
    else
        xPlayer.removeInventoryItem(_G["itemTraitement_"..Farm], 1)
        xPlayer.addMoney(_G["sellPrice_"..Farm])
    end
end)

