
--[[	
			Nuclear bomb server restarts
				By Samuel & Silence
--]]

RegisterServerEvent('InteractSound_SV:NukeExplosion')
RegisterServerEvent('InteractSound_SV:Incoming')
RegisterServerEvent('InteractSound_SV:CountDownBeep')

RegisterNetEvent('control:wtfboom')
AddEventHandler('control:wtfboom', function()
	TriggerClientEvent("nuclear:bomb.cl", -1, 0)
	print("22")
end)

--Audio Triggers
AddEventHandler('InteractSound_SV:NukeExplosion', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:NukeExplosion', source, soundFile, soundVolume)
end)
AddEventHandler('InteractSound_SV:Incoming', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:Incoming', source, soundFile, soundVolume)
end)
AddEventHandler('InteractSound_SV:CountDownBeep', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:CountDownBeep', source, soundFile, soundVolume)
end)

