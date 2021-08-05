ESX = nil 
TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

ESX.RegisterUsableItem('radio', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
     --xPlayer.removeInventoryItem('radio', 1)
       TriggerClientEvent('Radio.Set', source, true)
	TriggerClientEvent('Radio.Toggle', source)

end)