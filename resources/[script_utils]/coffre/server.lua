ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("coffre:time")
AddEventHandler("coffre:time", function()
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[2]
	MySQL.Async.fetchAll('SELECT * FROM coffres WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
		    TriggerClientEvent("coffre:sendDados", _source, gotInfo[1].Minutes, gotInfo[1].Hours)
		else
			MySQL.Async.execute("INSERT INTO coffres (identifier, Minutes, Hours) VALUES (@Identifier, 0, 0)", {['@Identifier'] = identifier})
			TriggerClientEvent("coffre:sendDados", _source, 0, 0)
		end
	end)
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ESX.RegisterUsableItem('coffre', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('coffre', 1)
    
    math.randomseed(tonumber(os.time()))
    if math.random(0, 1000) >= 500 then
        local chance = math.random(1,20000)
        local money = 0
        if chance <= 10000 then
            money = math.random(5,15)
            
        elseif chance <= 14000 then
            money = math.random(20,45)
            
        elseif chance <= 16000 then
            money = math.random(50,65)
            
        elseif chance <= 18000 then
            money = math.random(70,95)
            
        elseif chance <= 19999 then
            money = math.random(100,180)
            
        elseif chance == 20000 then
            TriggerClientEvent('coffre:open', _source, "~b~Véhicule", true)
            return
        end
        TriggerClientEvent('coffre:open', _source, "~g~"..money.." $")
        SetTimeout(3000, function()
            TriggerClientEvent('esx:showAdvancedNotification', _source, "Fantastic ", "~y~Coffre", "Tu as reçu ~g~"..money.." $", "CHAR_SOCIAL_CLUB", 1)
            xPlayer.addMoney(money)
        end)
    else
        TriggerClientEvent('coffre:open', _source, "*Vide*")
    end
end)

ESX.RegisterServerCallback('coffre:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function (result)
        --print(tostring(result[1].plate))
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('coffre:setVehicleOwned')
AddEventHandler('coffre:setVehicleOwned', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	},
	function (rowsChanged)
        TriggerEvent("Logs:ServerLog", "ID: ".._source, "ID: ".. _source .. "a gagné un véhicule dans un coffre immatriculé **" ..vehicleProps.plate.."**")
        TriggerClientEvent('esx:showAdvancedNotification', _source, "Fantastic ", "~y~Coffre", "~g~Tu as gagné un véhicule ! ~s~~n~Immatriculation : ~y~" .. vehicleProps.plate , "CHAR_SOCIAL_CLUB", 1)
	end)
end)




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SAVING THE TIME IN THE DB
RegisterServerEvent("coffre:savetimedb")
AddEventHandler("coffre:savetimedb", function(m, h)
    --print('mrv le roi arouf')

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local identifier = xPlayer.getIdentifier()

        MySQL.Async.execute("UPDATE coffres SET Minutes=@MINUTES,Hours=@HOURS WHERE identifier=@identifier", {["@MINUTES"] = m, ["@HOURS"] = h, ['@identifier'] = 'license:' .. identifier})
    end
end)
RegisterCommand('cc', function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    print(xPlayer.getIdentifier())
end)

RegisterServerEvent("coffre:recomp")
AddEventHandler("coffre:recomp", function(hour)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem("coffre", 1)
    TriggerClientEvent('esx:showAdvancedNotification', _source, "Fantastic", "~b~"..hour.."h de jeu", "Tu as reçu un coffre, bonne chance !", "CHAR_SOCIAL_CLUB", 1)
end)

-- KICK

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "Tu étais AFK depuis trop longtemps.")
end)