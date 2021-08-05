ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('weed', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('weed', 1)
	
	print("Quelqun ce drogue avec de la weed", xPlayer)
	TriggerClientEvent('esx_status:add', _source, 'drug', 250000)
	TriggerClientEvent('dvr_foodeffects:onWeed', source)
end)


ESX.RegisterUsableItem('shit_pooch', function(source)
        
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('shit_pooch', 1)

	print("Quelqun ce drogue avec du shit", xPlayer)
	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('dvr_foodeffects:onShit', source)
end)

ESX.RegisterUsableItem('meth_pooch', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth_pooch', 1)

	print("Quelqun ce drogue a la meth (effect)", xPlayer)
	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('dvr_foodeffects:starteffectmeth', source)
	TriggerClientEvent('dvr_foodeffects:onwtf', source)
end)


ESX.RegisterUsableItem('baraking', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('baraking', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('dvr_foodeffects:starteffectmeth', source)
	TriggerClientEvent('dvr_foodeffects:onwtf2', source)
end)


ESX.RegisterUsableItem('legacy', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('legacy', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 666000)
	TriggerClientEvent('dvr_foodeffects:starteffectlegacy', source)
	TriggerClientEvent('dvr_foodeffects:onwtf3', source)
end)

ESX.RegisterUsableItem('ghb', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('ghb', 1)


	TriggerClientEvent('dvr_foodeffects:onGHB', source)
end)


ESX.RegisterUsableItem('moukate', function(source)
        
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('moukate', 1)

	print("Quelqun ce drogue a la moukate (effect)", xPlayer)
	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('dvr_foodeffects:starteffectmoukate', source)
	TriggerClientEvent('dvr_foodeffects:onwtf', source)
end)

ESX.RegisterUsableItem('meth', function(source)
        
	local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeInventoryItem('meth', 1)

print("Quelqun ce drogue a la meth", xPlayer)
TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
TriggerClientEvent('dvr_foodeffects:starteffectmeth', source)
end)

ESX.RegisterUsableItem('coke_pooch', function(source)
        
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke_pooch', 1)

	print("Quelqun ce drogue a la coke ( vitesse )", xPlayer)
	TriggerClientEvent('Farm:boostFarm', source, 5, 100)
	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('dvr_foodeffects:starteffectmeth', source)
end)

ESX.RegisterUsableItem('coke', function(source)
        
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke', 1)

	print("Quelqun ce drogue a la coke", xPlayer)
	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('dvr_foodeffects:starteffectmeth', source)
end)

ESX.RegisterUsableItem('doliprane', function(source)
        
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('doliprane', 1)

	print("Quelqun prend un doliprane", xPlayer)
	TriggerClientEvent('esx_status:add', _source, 'drug', 33300)
	TriggerClientEvent('doli:startdoli', source)
	TriggerClientEvent('esx_ambulancejob:heal', source, 'small')
end)

ESX.RegisterUsableItem('cigaret', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigaret', 1)
			TriggerClientEvent('esx_cigaret:startSmoke', source)
			TriggerClientEvent('esx_status:remove', source, 'hunger', -5000)
			TriggerClientEvent('esx_status:remove', source, 'thirst', -5000)
			TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, '~g~Fantastic', '~g~Vous avez fumer une Cigarette', '', 'CHAR_SOCIAL_CLUB', 0)
		else
			TriggerClientEvent('esx:showAdvancedNotification', source, "Fantastic", "~r~Tu n\'as pas de briquet", "", 'CHAR_SOCIAL_CLUB', 0)
		end
end)


ESX.RegisterUsableItem('dolophine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('dolophine', 1)
	TriggerClientEvent('dvr_foodeffects:reset', source)
	TriggerClientEvent('Farm:boostFarm', source, 5, 100)
end)


