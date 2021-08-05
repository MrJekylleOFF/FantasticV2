ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

RegisterServerEvent("alert:sv")
AddEventHandler("alert:sv", function (msg, msg2)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'army' then
			TriggerClientEvent("SendAlert", -1, msg, msg2, xPlayers[i])
		end
	end
end)

AddEventHandler('chatMessage', function(source, name, msg)
	local command = stringsplit(msg, " ")[1];

	if command == "/alert" then
	CancelEvent()
	TriggerClientEvent("alert:Send", source, string.sub(msg, 8), Config.EAS.Departments)
	end
end)
