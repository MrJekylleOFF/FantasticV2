RegisterServerEvent("siren:sync")
AddEventHandler("siren:sync", function(state, veh)
    TriggerClientEvent("siren:ClientSync", -1, state, veh)
end)