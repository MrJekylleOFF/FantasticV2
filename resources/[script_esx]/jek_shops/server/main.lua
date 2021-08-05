ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('jek_shops:giveItem')
AddEventHandler('jek_shops:giveItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= (item.Price * count) then
        xPlayer.addInventoryItem(item.Value, count)
        xPlayer.removeMoney(item.Price * count)
        xPlayer.showNotification('Vous avez acheté ~g~' .. count .. ' ' .. item.Label .. '~s~ pour ~g~' ..item.Price * count .. '$')
    else
        xPlayer.showNotification('Vous ne pouvez pas acheter ' .. '~g~' .. item.Label .. '~s~' .. ' il vous manque ' .. '~g~' .. item.Price * count - playerMoney .. '$')
    end
end)