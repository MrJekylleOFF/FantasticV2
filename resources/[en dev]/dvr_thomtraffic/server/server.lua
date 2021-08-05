ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("control:Lockdown")
AddEventHandler("control:Lockdown", function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	math.randomseed(tonumber(os.time()))
	if math.random(0, 3) >= 2 then
		local chance = math.random(1,3)
		if chance <= 3 then
			xPlayer.showNotification("Echec ~r~~n~APPEL DE LA LSPD EN COURS ...")
		end
	else
		TriggerClientEvent('control:Lockdown', source)
		return
	end
end)
