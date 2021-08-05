ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('BuyCNI')
AddEventHandler('BuyCNI', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = Config.BuyCNI
    local cnicount = xPlayer.getInventoryItem('cni').count

    if cnicount > 0 then 
      --  TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous en avez déjà une sur vous")
        xPlayer.showNotification("~r~Vous en avez déjà une sur vous")
    elseif xPlayer.getMoney() >= Config.BuyCNI then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem('cni', 1)
        --TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, "Mairie", "Vous avez reçu votre carte d\'identité", "", "CHAR_MP_FM_CONTACT", 1)
        --TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez payez ~r~" .. Config.BuyCNI .. '$')
        xPlayer.showNotification("~r~Vous avez reçu votre carte d\'identité")
        xPlayer.showNotification("Vous avez payez ~r~" .. Config.BuyCNI .. '$')
    else
      --  TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        xPlayer.showNotification("~r~Vous en avez déjà une sur vous")
    end
end)

-- cni
ESX.RegisterUsableItem('cni', function(_source)
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('sh_cni:showcni', _source)
end)