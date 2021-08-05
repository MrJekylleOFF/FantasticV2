RegisterServerEvent('dvr_flash:sync')
AddEventHandler('dvr_flash:sync', function(player, need, gender)
    TriggerClientEvent('dvr_flash:syncCL', -1, player, need, gender)
end)

