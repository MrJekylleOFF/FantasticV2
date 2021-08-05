ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for k, v in ipairs(GetGangData()) do
	TriggerEvent('esx_society:registerSociety', v.Name, v.Label, 'society_' .. v.Name, 'society_' .. v.Name, 'society_' .. v.Name, {type = 'public'})
end

RegisterServerEvent('GangsBuilderJob:giveWeapon')
AddEventHandler('GangsBuilderJob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weapon, ammo)
end)

ESX.RegisterServerCallback('jek:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()

	if plyGroup ~= nil then 
		cb(plyGroup)
	else
		cb('user')
	end
end)

RegisterServerEvent('GangsBuilderJob:handcuff')
AddEventHandler('GangsBuilderJob:handcuff', function(target)
	print(target)
	TriggerClientEvent('GangsBuilderJob:handcuff', target)
end)

RegisterServerEvent('GangsBuilderJob:drag')
AddEventHandler('GangsBuilderJob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('GangsBuilderJob:drag', target, source)
end)

RegisterServerEvent('GangsBuilderJob:putInVehicle')
AddEventHandler('GangsBuilderJob:putInVehicle', function(target)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	if xPlayerTarget ~= nil then
			TriggerClientEvent('GangsBuilderJob:putInVehicle', target)
	end
end)

RegisterServerEvent('GangsBuilderJob:OutVehicle')
AddEventHandler('GangsBuilderJob:OutVehicle', function(target)
	TriggerClientEvent('GangsBuilderJob:OutVehicle', target)
end)

function LoadJson(gang, cb)

	local gang = gang
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./data/gangData.json") 
	local vehicle = {}

	Loading = json.decode(loadFile)

	for i,v in ipairs(Loading) do
		if gang == v.Name then 
				
			table.insert(vehicle, {name=v.Vehicule1.name, label=v.Vehicule1.label, color=v.VehiculeColor, color2=v.VehiculeColor2})

			if v.Vehicule2 ~= nil then
				table.insert(vehicle, {name=v.Vehicule2.name, label=v.Vehicule2.label, color=v.VehiculeColor, color2=v.VehiculeColor2})
			end

			if v.Vehicule3 ~= nil then
				table.insert(vehicle, {name=v.Vehicule3.name, label=v.Vehicule3.label, color=v.VehiculeColor, color2=v.VehiculeColor2})
			end

			if v.Vehicule4 ~= nil then
				table.insert(vehicle, {name=v.Vehicule4.name, label=v.Vehicule4.label, color=v.VehiculeColor, color2=v.VehiculeColor2})
			end

			if v.Vehicule5 ~= nil then
				table.insert(vehicle, {name=v.Vehicule5.name, label=v.Vehicule5.label ,color=v.VehiculeColor, color2=v.VehiculeColor2})
			end

			cb(vehicle)
		end 
	end
end

ESX.RegisterServerCallback('GangsBuilderJob:loadjson', function(source, cb, gang)
	LoadJson(gang, cb)
end)