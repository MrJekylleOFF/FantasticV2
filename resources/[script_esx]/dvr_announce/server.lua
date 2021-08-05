ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dvr:Annonces')
AddEventHandler('dvr:Annonces', function(msg, prix, type)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

 --   if xPlayer.getMoney() >= prix then
   --     xPlayer.removeMoney(prix)
		--TriggerClientEvent('dvr:ToAnnonces', _source, msg, type)
        TriggerClientEvent('dvr:ToAnnonces', -1, msg, type)
  --  else
  --      TriggerClientEvent('esx:showAdvancedNotification', _source, "WEAZEL-NEWS", "", "Tu n'as pas assez d'argent" , "CHAR_LIFEINVADER", 1)
 --   end
end)	