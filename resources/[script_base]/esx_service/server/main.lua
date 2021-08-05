ESX                = nil
local InService, MaxInService, Dropped = {}, {}, {}
local timerPayCheck = 20 * 60000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetInServiceCount(name)
	local count = 0
	print('test', name)
	if #InService[name] ~= nil then 
		for k,v in pairs(InService[name]) do
			if v == true then
				count = count + 1
			end
		end
	end	
    print('count', count)
	return count
end

--GetInServiceCount()

AddEventHandler('esx_service:activateService', function(name, max)
	InService[name]    = {}
	MaxInService[name] = max
end)

RegisterServerEvent('esx_service:disableService')
AddEventHandler('esx_service:disableService', function(name)
	InService[name][source] = nil
end)

RegisterServerEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, name)
	for k,v in pairs(InService[name]) do
		if v == true then
			TriggerClientEvent('esx_service:notifyAllInService', k, notification, source)
		end
	end
end)

ESX.RegisterServerCallback('esx_service:enableService', function(source, cb, name)
	local inServiceCount = GetInServiceCount(name)

	if inServiceCount >= MaxInService[name] then
		cb(false, MaxInService[name], inServiceCount)
	else
		InService[name][source] = true
		print(name)
		cb(true, MaxInService[name], inServiceCount)
	end
end)

ESX.RegisterServerCallback('esx_service:isInService', function(source, cb, name)
	local isInService = false

	if InService[name][source] then
		isInService = true
	end

	cb(isInService)
end)

ESX.RegisterServerCallback('esx_service:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

AddEventHandler('playerDropped', function()
	local _source = source
		
	for k,v in pairs(InService) do
		if v[_source] == true then
			Dropped[_source] = true 
			v[_source] = nil
		end
	end
end)


RegisterServerEvent('esx_service:startPayCheck')
AddEventHandler('esx_service:startPayCheck', function(name, society)
   
	if name ~= nil and society ~= nil then 
		local xPlayer = ESX.GetPlayerFromId(source)	
		if InService[name][source] == true then
			startPayCheck(source, name, society)
		end 
	end	
end)	

function startPayCheck(source, name, society)
	local xPlayer = ESX.GetPlayerFromId(source)	

	if xPlayer == nil then do return end  
	else 
		SetTimeout(timerPayCheck, function()
			if InService[name][source] == nil or Dropped[source] == true then do return end 				
			else 
				local job     = xPlayer.job.grade_name
				local salary  = xPlayer.job.grade_salary

				if salary > 0 and society ~= nil then
					TriggerEvent('esx_addonaccount:getSharedAccount', society, function (account)
						if account.money >= salary then					
							xPlayer.addAccountMoney('bank', salary)
							account.removeMoney(salary)	 

							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Banque', 'Paie', 'Vous avez reçu votre paie: '..salary..' ~g~$', 'CHAR_BANK_MAZE', 1)						    	
						else
							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Banque', 'Paie','~r~Votre employeur n\'a plus de quoi vous payer', 'CHAR_BANK_MAZE', 1)
						end	
					end)
				end	
			end	
			startPayCheck(source, name, society)
	    end)
	end	
end