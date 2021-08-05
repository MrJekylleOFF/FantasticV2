ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local PlateArray = {
   -- {plate = "22AAA333", kms = 999999999999}
}

AddEventHandler('onMySQLReady', function()
	local kmsAll = 0
	--Wait(3000)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {}, function (result)
        for i=1, #result do
            kmsAll = kmsAll + result[i].kms
        end
        print("Kilometres parcourus par tout le monde: "..kmsAll.." km")
	end)
end)

ESX.RegisterServerCallback('esx_kmveh:getVehicle', function (source, cb, plate)

    for i=1, #PlateArray do
        if PlateArray[i].plate == plate then
            cb(PlateArray[i].kms)
            return
        end                
    end
        
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function (result)
        if result[1] ~= nil then
            local kms = result[1].kms or 0
            cb(kms)
        else
            table.insert(PlateArray, {plate = plate, kms = math.random(1500000, 200000000)})
            cb(PlateArray[#PlateArray].kms)
        end
	end)
end)

RegisterServerEvent('esx_kmveh:setKms')
AddEventHandler('esx_kmveh:setKms', function(plate, kms)
    --print("esx_kmveh:setKms "..plate.." "..kms)
    for i=1, #PlateArray do
        if PlateArray[i].plate == plate then
            PlateArray[i].kms = kms
            break
        end                
    end
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `kms` = @kms WHERE `plate` = @plate',
	{
		['@plate'] = plate,
		['@kms'] = kms,
	})
    
end)