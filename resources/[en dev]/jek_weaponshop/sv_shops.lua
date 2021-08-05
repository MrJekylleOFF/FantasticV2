ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jek_weaponshops:giveWeapon')
AddEventHandler('jek_weaponshops:giveWeapon', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= (item.Price) then
        if not xPlayer.hasWeapon(item.Value) or item.Value == "WEAPON_BALL" then
        xPlayer.addWeapon(item.Value, 20)
        xPlayer.removeMoney(item.Price)
        xPlayer.showNotification('Vous avez acheté ~g~1x ' .. item.Label .. '~s~ pour ~g~' ..item.Price .. '$')
        else
            xPlayer.showNotification('~r~Vous avez déjà cette arme sur vous')
        end

    else
        xPlayer.showNotification('Vous ne pouvez pas acheter ~g~1x ' .. item.Label .. '~s~' .. ' il vous manque ' .. '~r~' .. item.Price - playerMoney .. '$')
    end
end)

RegisterServerEvent('jek_weaponshops:giveItem')
AddEventHandler('jek_weaponshops:giveItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= (item.Price * count) then
        if xPlayer.canCarryItem(item.Value, count) then
        xPlayer.addInventoryItem(item.Value, count)
        xPlayer.removeMoney(item.Price * count)
        xPlayer.showNotification('Vous avez acheté ~g~' .. count .. 'x ' .. item.Label .. '~s~ pour ~g~' ..item.Price * count .. '$')
        else
            xPlayer.showNotification('~r~Vous n\'avez pas assez de place sur vous')
        end
    else
        xPlayer.showNotification('Vous ne pouvez pas acheter ~g~' .. count .. 'x ' .. item.Label .. '~s~' .. ' il vous manque ' .. '~r~' .. item.Price * count - playerMoney .. '$')
    end
end)

function CheckLicense(source, type, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier

	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end

	end)
end

ESX.RegisterServerCallback('jek_weaponshops:checkLicense', function(source, cb, type)
    CheckLicense(source, 'weapon', cb)
end)


ESX.RegisterServerCallback('jek_weaponshops:checkVisite', function(source, cb, type)
    CheckLicense(source, 'visite', cb)
end)
