ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('jek_elecshops:giveItem')
AddEventHandler('jek_elecshops:giveItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= (item.Price * count) then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_journaliste', function(account)
            account.addMoney(item.Price * count)
            xPlayer.addInventoryItem(item.Value, count)
            xPlayer.removeMoney(item.Price * count)
            xPlayer.showNotification('Vous avez acheté ~g~' .. count .. ' ' .. item.Label .. '~s~ pour ~g~' ..item.Price * count .. '$')
        end)
    else
        xPlayer.showNotification('Vous ne pouvez pas acheter ' .. '~g~' .. item.Label .. '~s~' .. ' il vous manque ' .. '~g~' .. item.Price * count - playerMoney .. '$')
    end
end)