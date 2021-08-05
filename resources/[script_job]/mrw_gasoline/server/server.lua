ESX = nil 

TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

local USEESX_Service = true

if USEESX_Service then
   TriggerEvent('esx_service:activateService', 'fueler', 10)
end

TriggerEvent('esx_phone:registerNumber', 'fueler', 'fueler', true, true)
TriggerEvent('esx_society:registerSociety', 'fueler', 'fueler', 'society_fueler', 'society_fueler', 'society_fueler', {type = 'private'})

RegisterNetEvent('mrw_gasoline:checkLiter')
AddEventHandler('mrw_gasoline:checkLiter', function(id, x,y,z, amountLiter, priceLiter, currentFuel)

	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)
 
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/Gasoline.json") 
	gasolineFile = json.decode(loadFile)
    
    if priceLiter ~= 0 or priceLiter ~= -1 then 
		if gasolineFile[id].id == id then 
			local GasolineReserve = gasolineFile[id].reserve
			if GasolineReserve >= amountLiter then 
				if amountLiter + currentFuel <= 100 then
					if xPlayer.getMoney() >= priceLiter then 
				  		TriggerClientEvent('mrw_gasoline:startAnimation', x_source, id, amountLiter, priceLiter)
					else
				   	xPlayer.showNotification("Vous ne disposez pas d'assez d'argent !") 
					end   
				else
					xPlayer.showNotification("Votre véhicule ne peut pas recevoir autant de litre !")
				end
			else
				xPlayer.showNotification("La station ne dispose pas d'une reserve suffisante !")
			end
		end
	else 
		print("Le joueurs : "..xPlayer.identifier.." triche")
	end	
end)


RegisterNetEvent('mrw_gasoline:payGasole')
AddEventHandler('mrw_gasoline:payGasole', function(id, amountLiter, priceLiter)

	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)
 
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/Gasoline.json") 
	gasolineFile = json.decode(loadFile)
    
    if priceLiter ~= 0 or priceLiter ~= -1 then 
		if gasolineFile[id].id == id then 
			local totalFuelReserve = gasolineFile[id].reserve - amountLiter
	        gasolineFile[id].reserve = totalFuelReserve
	        xPlayer.removeMoney(priceLiter) 
		end
	else
		print("Le joueurs : "..xPlayer.identifier.." triche")
	end	

    SaveResourceFile(GetCurrentResourceName(), "./server/Gasoline.json", json.encode(gasolineFile, {indent=true}), -1) 
end)

RegisterNetEvent('mrw_gasoline:addGasole')
AddEventHandler('mrw_gasoline:addGasole', function(id)

	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)
	local addLiter = 500
	local salary = 200
	local salaryentreprise = 150
 
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/Gasoline.json") 
	gasolineFile = json.decode(loadFile)
    
    if xPlayer.job.name == 'fueler' then 
		if gasolineFile[id].id == id then 
        	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_fueler', function(account)
        		local totalFuelReserve = gasolineFile[id].reserve + addLiter
	            gasolineFile[id].reserve = totalFuelReserve
				account.addMoney(salaryentreprise)
            	xPlayer.addMoney(salary)
				xPlayer.showNotification("Vous avez gagné : "..salary.." ~g~$~w~")
				xPlayer.showNotification("Vous entreprise a gagné : "..salaryentreprise.." ~g~$~w~")
			end)
		end	
	end

    SaveResourceFile(GetCurrentResourceName(), "./server/Gasoline.json", json.encode(gasolineFile, {indent=true}), -1) 
end)