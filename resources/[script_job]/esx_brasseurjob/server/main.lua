
ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local biereblanche = 1
local bierebrune = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'brasseur', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'brasseur', _U('brasseur_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'brasseur', 'brasseur', 'society_brasseur', 'society_brasseur', 'society_brasseur', {type = 'private'})
local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "OrgeFarm" then
			local itemQuantity = xPlayer.getInventoryItem('orge').count
			if not xPlayer.canCarryItem('orge', 1) then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1000, function()
					xPlayer.addInventoryItem('orge', 1)
					Harvest(source, zone)
				end)
			end
		elseif zone == "HoublonFarm" then
			local item2Quantity = xPlayer.getInventoryItem('houblon').count
			if not xPlayer.canCarryItem('houblon', 1) then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
            else
				SetTimeout(1000, function()
					xPlayer.addInventoryItem('houblon', 1)
					Harvest(source, zone)
				end)
		end	end
	end
end


RegisterServerEvent('esx_brasseurjob:startHarvest')
AddEventHandler('esx_brasseurjob:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('orge_taken'))  
		Harvest(_source,zone) 	
	end  
end)    

RegisterServerEvent('esx_brasseurjob:startHarvestHoublon')
AddEventHandler('esx_brasseurjob:startHarvestHoublon', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('houblon_taken'))  
		Harvest(_source,zone) 	
	end  
end) 

RegisterServerEvent('esx_brasseurjob:stopHarvest')
AddEventHandler('esx_brasseurjob:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)

RegisterServerEvent('esx_brasseurjob:stopHarvestHoublon')
AddEventHandler('esx_brasseurjob:stopHarvestHoublon', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementBiereblanche" then
			local itemQuantity = xPlayer.getInventoryItem('orge').count 
			local item2Quantity = xPlayer.getInventoryItem('houblon').count
		    if itemQuantity <= 2 or item2Quantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez d\'orge')
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez de houblon')
				return
			elseif xPlayer.canCarryItem('biereblanche', 1) then
				SetTimeout(1000, function()
					xPlayer.removeInventoryItem('orge', 3)
					xPlayer.removeInventoryItem('houblon', 1)
					xPlayer.addInventoryItem('biereblanche', 1)
				
					Transform(source, zone)
				end)
			else
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
			end
		elseif zone == "TraitementBierebrune" then
			local itemQuantity = xPlayer.getInventoryItem('orge').count 
			local item2Quantity = xPlayer.getInventoryItem('houblon').count 
			if itemQuantity <= 0 or item2Quantity <= 2 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez d\'orge')
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez de houblon')
				return
			elseif xPlayer.canCarryItem('bierebrune', 1) then
				SetTimeout(1000, function()					
					xPlayer.removeInventoryItem('orge', 1)
					xPlayer.removeInventoryItem('houblon', 3)
					xPlayer.addInventoryItem('bierebrune', 1)
		  
					Transform(source, zone)	  
				end)
			else
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
			end
		end
	end	
end

RegisterServerEvent('esx_brasseurjob:startTransform')
AddEventHandler('esx_brasseurjob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_brasseurjob:stopTransform')
AddEventHandler('esx_brasseurjob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre orge ainsi que votre houblon')
		PlayersTransforming[_source]=true
		
	end
end)


local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		local societyAccount = nil
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('biereblanche').count <= 0 then
				biereblanche = 0
			else
				biereblanche = 1
			end
			
			if xPlayer.getInventoryItem('bierebrune').count <= 0 then
				bierebrune = 0
			else
				bierebrune = 1
			end
		
			if biereblanche == 0 and bierebrune == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('biereblanche').count <= 0 and bierebrune == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_biereblanche_sale'))
				biereblanche = 0
				return
			elseif xPlayer.getInventoryItem('bierebrune').count <= 0 and biereblanche == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_bierebrune_sale'))
				bierebrune = 0
				return
			else
				if (biereblanche == 1) then
					SetTimeout(1000, function()

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
						societyAccount = account
						end)
                       if societyAccount ~= nil then
						   local playerMoney  = 4
						   local societyMoney = 8

							xPlayer.removeInventoryItem('biereblanche', 1)
							xPlayer.addMoney(playerMoney)
	                        societyAccount.addMoney(societyMoney)

   						   TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. playerMoney)
                           TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. societyMoney)
						else
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (bierebrune == 1) then
					SetTimeout(1000, function()

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
						societyAccount = account
						end)
						if societyAccount ~= nil then
						   local playerMoney  = 3
						   local societyMoney = 5
						   xPlayer.removeInventoryItem('bierebrune', 1)
						   xPlayer.addMoney(playerMoney)
	                       societyAccount.addMoney(societyMoney)
		                      
                           TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. playerMoney)
                           TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. societyMoney)   
	                    else
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_brasseurjob:startSell')
AddEventHandler('esx_brasseurjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_brasseurjob:stopSell')
AddEventHandler('esx_brasseurjob:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_brasseurjob:getStockItem')
AddEventHandler('esx_brasseurjob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count and xPlayer.canCarryItem(itemName, count) then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_brasseurjob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_brasseurjob:putStockItems')
AddEventHandler('esx_brasseurjob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brasseur', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_brasseurjob:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)

ESX.RegisterUsableItem('biereblanche', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('biereblanche', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_biere_blanche'))

end)

ESX.RegisterUsableItem('bierebrune', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bierebrune', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_biere_brune'))

end)
