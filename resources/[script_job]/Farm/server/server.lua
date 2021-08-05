ESX 						   = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('location:buyVehicle', function (source, cb, price)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		cb(true)
	else
		cb(false)
	end
end)

for _,zone in pairs(Config.Zones) do
   _G["sellPrice_"..zone.Name]          = zone.SellPrice
   _G["itemRecolte_"..zone.Name]        = zone.ItemsName[1]
   _G["itemTraitement_"..zone.Name]     = zone.ItemsName[2]
end

RegisterServerEvent('Farm:Recolte')
AddEventHandler('Farm:Recolte', function(Farm)
    local xPlayer       = ESX.GetPlayerFromId(source)
    local FarmItem      = xPlayer.getInventoryItem(_G["itemRecolte_"..Farm])
    if xPlayer.canCarryItem(_G["itemRecolte_"..Farm], 1) then
        --TriggerClientEvent("Farm:animRammase", source)
        xPlayer.addInventoryItem(_G["itemRecolte_"..Farm], 1)
    else
        TriggerClientEvent('esx:showNotification', source, "Je n'ai plus de place")
    end
end)

RegisterServerEvent('Farm:Traitement')
AddEventHandler('Farm:Traitement', function(Farm)
    local xPlayer       = ESX.GetPlayerFromId(source)
	local FarmItem      = xPlayer.getInventoryItem(_G["itemRecolte_"..Farm])
    local FarmResult    = xPlayer.getInventoryItem(_G["itemTraitement_"..Farm])
    if not xPlayer.canCarryItem(_G["itemTraitement_"..Farm], 1) then
        TriggerClientEvent('esx:showNotification', source, "Mes poches sont pleines")
    elseif FarmItem.count < 5 then
        TriggerClientEvent('esx:showNotification', source, "Pas assez de matos")
    else
        xPlayer.removeInventoryItem(_G["itemRecolte_"..Farm], 5)
        xPlayer.addInventoryItem(_G["itemTraitement_"..Farm], 1)
    end
end)

RegisterServerEvent('Farm:Vente')
AddEventHandler('Farm:Vente', function(Farm)
	local xPlayer       = ESX.GetPlayerFromId(source)
    local FarmQty = xPlayer.getInventoryItem(_G["itemTraitement_"..Farm]).count

    if FarmQty <= 0 then
        TriggerClientEvent('esx:showNotification', source, "Je n'ai plus rien a vendre")
    else
        xPlayer.removeInventoryItem(_G["itemTraitement_"..Farm], 1)
        xPlayer.addMoney(_G["sellPrice_"..Farm])
    end
end)