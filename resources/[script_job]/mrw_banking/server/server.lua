-- Author : Morow 
-- GitHub : https://github.com/Morow73
-- No Edit, No Sell !!!!!!! 


ESX = nil 
local USEESX_Service = true
local LimitMoneyStartRob = 5000
local timerBeforeReroll = 30 * 60000 -- time before the player can turn an ATM again 
local startRob = false

--local boucle = false 
--local insert = false 

TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

if USEESX_Service then
   TriggerEvent('esx_service:activateService', 'brinks', 10)
end

TriggerEvent('esx_phone:registerNumber', 'brinks', 'brinks_client', true, true)
TriggerEvent('esx_society:registerSociety', 'brinks', 'brinks', 'society_brinks', 'society_brinks', 'society_brinks', {type = 'private'})

RegisterNetEvent('mrw_banking:withdrawMoney')
AddEventHandler('mrw_banking:withdrawMoney', function(AtmId, x,y,z, amount)
	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)
	local amountPlayerBank = xPlayer.getAccount('bank').money

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/Atm.json") 
	atmFile = json.decode(loadFile)

	print(AtmId, amount)

	for i,v in ipairs(atmFile) do
		if (v.position.x == x and v.position.y == y and v.position.z == z) then 
			print('test2')
			if v.id == AtmId then 
				if tonumber(v.money) > 0 then
					if tonumber(v.money) >= amount then 
						if amountPlayerBank >= amount then 
							local totalAmount = v.money - amount
							xPlayer.removeAccountMoney('bank', amount)
							xPlayer.addMoney(amount)
						
							v.money = totalAmount
							xPlayer.showNotification("vous avez retirer "..amount.." $")	
						else 
							xPlayer.showNotification("Vous n'avez pas assez d'argents dans votre compte !")	
						end	
					else 
						xPlayer.showNotification("Ce distributeur n'a pas une réserve suffisante, retirer une plus petite somme ou changer de distributeur !")	
					end	
				else 
				   xPlayer.showNotification("Ce distributeur est ~r~vide~w~ !")	
				end 
			end
		end
	end
	SaveResourceFile(GetCurrentResourceName(), "./server/Atm.json", json.encode(atmFile, {indent=true}), -1) 
end)

RegisterNetEvent('mrw_banking:depositMoney')
AddEventHandler('mrw_banking:depositMoney', function(AtmId, x,y,z, amount)
	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/Atm.json") 
	atmFile = json.decode(loadFile)

	for i,v in ipairs(atmFile) do
		if (v.position.x == x and v.position.y == y and v.position.z == z) then 
			if v.id == AtmId then 
				if xPlayer.getMoney() >= amount then 
					local totalAmount = v.money + amount
					xPlayer.removeMoney(amount)
					xPlayer.addAccountMoney('bank', amount)
					v.money = totalAmount
				else 
					xPlayer.showNotification("Vous n'avez pas assez d'argents !")	
				end	
			end
		end
	end
	SaveResourceFile(GetCurrentResourceName(), "./server/Atm.json", json.encode(atmFile, {indent=true}), -1) 
end)

RegisterNetEvent('mrw_banking:startRob')
AddEventHandler('mrw_banking:startRob', function(AtmId, x,y,z)
	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)
	local PoliceInService = exports['esx_service']:GetInServiceCount('police') + exports['esx_service']:GetInServiceCount('fbi')

	if xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'fbi' and xPlayer.job.name ~= 'sheriff' then 
		if PoliceInService >= 2 then
			if startRob == false then
			    startRob = true
                TriggerClientEvent('mrw_banking:startTimer', x_source, AtmId, x,y,z)	
            else 
                xPlayer.showNotification("Cet atm à déja subit une ~r~attaque~w~ veuillez patientez !")
                return
            end   
        else
            xPlayer.showNotification("Pas assez de policier en service (2 mini) !")   
        end
    else 
       xPlayer.showNotification("Hep hep hep, tu fait quoi la ?!")  
    end

	SetTimeout(timerBeforeReroll, function()
		startRob = false 
    end)
end)


RegisterNetEvent('mrw_banking:finishTimer')
AddEventHandler('mrw_banking:finishTimer', function(AtmId, x,y,z)
	local x_source = source 
    local xPlayer = ESX.GetPlayerFromId(x_source)

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/Atm.json") 
	atmFile = json.decode(loadFile)

	for i,v in ipairs(atmFile) do
		if (v.position.x == x and v.position.y == y and v.position.z == z) then 
			if v.id == AtmId then 
				if v.money >= 2000 then
					 butinAmount = math.random(0, 2000)
				elseif v.money ~= 0 then
					butinAmount = math.random(0, tonumber(v.money))
				end
                if v.money == 0 then 
                   xPlayer.showNotification("Malheureusement l'atm est ~r~vide~w~ !")   
                else
                    if butinAmount ~= 0 then  
	                   local totalAmount = v.money - butinAmount 
	                   v.money = totalAmount
	                   xPlayer.addMoney(butinAmount)
	                   xPlayer.showNotification("Le braquage est terminer vous avez récuperer ~g~"..butinAmount.."~w~ $")   
	                else 
	                	xPlayer.showNotification("Malheureusement de l'encre à été versé sur les billets les rendants inutilisable !")  
	                end   
                end
			end
		end
	end
	SaveResourceFile(GetCurrentResourceName(), "./server/Atm.json", json.encode(atmFile, {indent=true}), -1) 
end)

RegisterNetEvent('mrw_banking:addMoneyInAtm')
AddEventHandler('mrw_banking:addMoneyInAtm', function(AtmId, x,y,z)
	local x_source = source 
	local xPlayer = ESX.GetPlayerFromId(x_source)
	local quantity = xPlayer.getInventoryItem('lingot').count

	if quantity == 0 then 
		xPlayer.showNotification("Vous n'avez pas de lingots d'or sur vous")
		return
	end

    local sacBillet = 2000 + quantity * 500
	local salary = 30 + quantity * 2.2
	local salaryentreprise = 40 + quantity * 1.8

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/Atm.json") 
	atmFile = json.decode(loadFile)

	for i,v in ipairs(atmFile) do
		if (v.position.x == x and v.position.y == y and v.position.z == z) then 
			if v.id == AtmId then 
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brinks', function(account)
                	local totalAmount = v.money + sacBillet
					v.money = totalAmount
					account.addMoney(salaryentreprise)
                	xPlayer.addMoney(salary)
					xPlayer.showNotification("Vous avez gagné : "..salary.." ~g~$~w~")
					xPlayer.showNotification("Vous entreprise a gagné : "..salaryentreprise.." ~g~$~w~")
				end)
			end
		end
	end

	SaveResourceFile(GetCurrentResourceName(), "./server/Atm.json", json.encode(atmFile, {indent=true}), -1) 
end)

RegisterNetEvent('mrw_banking:addWeaponToBrinks')
AddEventHandler('mrw_banking:addWeaponToBrinks', function(weapon, price)
	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brinks', function(account)
	    societyAccount = account

		local totalAccount = societyAccount.money - price

		if societyAccount ~= nil then 
			if societyAccount.money >= price and totalAccount >= 0 then 
				societyAccount.removeMoney(price)
				xPlayer.addWeapon(weapon, 100)
				xPlayer.showNotification("Vous venez de reçevoir une arme")
			else
				xPlayer.showNotification("Votre entreprise ne dispose pas des fonds nécessaires pour cet achat !")
			end
		end
	end)
end)

RegisterServerEvent('mrw_banking:menotter')
AddEventHandler('mrw_banking:menotter', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('mrw_banking:menotter', targetid, playerheading, playerCoords, playerlocation)
end)

RegisterServerEvent('mrw_banking:demenotter')
AddEventHandler('mrw_banking:demenotter', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('mrw_banking:demenotter', targetid, playerheading, playerCoords, playerlocation)
end)

RegisterNetEvent('mrw_banking:RemoveWeapon')
AddEventHandler('mrw_banking:RemoveWeapon', function(weapon)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeWeapon(weapon)
end)

RegisterNetEvent('mrw_banking:GiveWeapon')
AddEventHandler('mrw_banking:GiveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('mrw_banking:AppelRenfort')
AddEventHandler('mrw_banking:AppelRenfort', function(coords)
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' or thePlayer.job.name == 'sheriff' then
			TriggerClientEvent('mrw_banking:setBlip', xPlayers[i], coords)
		end
	end
end)

RegisterNetEvent('mrw_banking:GiveItem')
AddEventHandler('mrw_banking:GiveItem', function(item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem(item, count) then
		xPlayer.addInventoryItem(item, count)
	else
		xPlayer.showNotification("~r~Vous n'avez pas assez de place dans votre inventaire !")
	end
end)

RegisterNetEvent('mrw_banking:RemoveItem')
AddEventHandler('mrw_banking:RemoveItem', function()
	item = 'lingot'
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count
	print(quantity)
	if quantity > 0 then
		xPlayer.removeInventoryItem(item, quantity)
	end
end)


InService = {}
WeaponsList = {}
RegisterNetEvent('mrw_banking:ActiveService')
AddEventHandler('mrw_banking:ActiveService', function(weapons)
	InService[source] = true
	WeaponsList[source] = {}
	
	for k,v in pairs(weapons) do
		table.insert(WeaponsList[source], { source = source, mun = v.mun, name = v.value})
	end
end)

AddEventHandler('playerDropped', function()
	if InService[source] == true then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeWeapon('WEAPON_NIGHTSTICK')
		xPlayer.removeWeapon('WEAPON_FLASHLIGHT')
		xPlayer.removeWeapon('WEAPON_COMBATPISTOL')
		xPlayer.removeWeapon('WEAPON_STUNGUN')
		for k,v in pairs(WeaponsList[source]) do
			xPlayer.addWeapon(v.name, v.mun)
		end
		local quantity = xPlayer.getInventoryItem('lingot').count
		if quantity > 0 then
			xPlayer.removeInventoryItem('lingot', quantity)
		end
	end
end)

ESX.RegisterServerCallback('mrw_banking:checkItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count
	if quantity > 0 then
		cb(true)
	else
		cb(false)
	end
end)

-- TOUCHE PAS JEKYLLE DE MON CUL !!! 

--[[function checkCode(code, license)
  
    local checkCode = MySQL.Sync.fetchAll('SELECT cb_number FROM users WHERE identifier = @identifier', {['@identifier'] = license})

	if checkCode[1].cb_number == code then 
		return true
	else 
		return false
	end
end

RegisterNetEvent('mrw_banking:checkCode')
AddEventHandler('mrw_banking:checkCode', function(code)
	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)

	local check = checkCode(code, xPlayer.identifier)

	if not check then 
		xPlayer.showNotification("Le code est ~r~invalide~w~ !")	
	else 
	    TriggerClientEvent('mrw_banking:openAtmMenu', x_source)	
	end
end)

RegisterNetEvent('mrw_banking:sellCB')
AddEventHandler('mrw_banking:sellCB', function()
	local x_source = source
	local xPlayer = ESX.GetPlayerFromId(x_source)
	local cb_price = 10

	if xPlayer.getInventoryItem('cartebleue').count >= 1 then 
		xPlayer.showNotification("Vous possedez déja une carte bleue !")
		return
	end

	if xPlayer.getMoney() < cb_price then 
		xPlayer.showNotification("Vous ne possedez pas assez d'argent ~r~( 10$ )~w~ !")
		return
	end

    local result = MySQL.Sync.fetchAll('SELECT cb_number FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})

    if result[1].cb_number == nil or result[1].cb_number == 0 then 
    	local numberAttribuate = math.random(0000, 9999)
    	boucle = true 

    	while boucle do 
	    	local checkNumber = MySQL.Sync.fetchScalar("SELECT COUNT(cb_number) FROM users WHERE cb_number = @cb_number", {['@cb_number'] = numberAttribuate})
	    	if checkNumber < 1 then
	    		boucle = false 
	    		insert = true 
	    		okNumber = numberAttribuate
	    	end 
    	end
    else 
       	xPlayer.showNotification("Vous possedez déja un numéro de carte bleue !")
    end

    if insert then 
	    MySQL.Async.execute('UPDATE users SET cb_number = @cb_number WHERE identifier = @identifier',
	        {
	            ['@identifier']   = xPlayer.identifier,
	            ['@cb_number'] = okNumber
	        },
	        function(result)
	        	xPlayer.showNotification("Un numéro ainsi qu'une carte bleue vous à été attribué. Votre code : ~b~"..numberAttribuate)
	        	xPlayer.removeMoney(cb_price)
	        	xPlayer.addInventoryItem('cartebleue', 1)
	        end
	    )
    end
end)
]]

