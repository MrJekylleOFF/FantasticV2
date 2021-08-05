ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Chasse:depece')
AddEventHandler('Chasse:depece', function(legal)
    local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem('viande', math.random(Config.nbParAnimalMin , Config.nbParAnimalMax))
end)