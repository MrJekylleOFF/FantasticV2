gangsData = nil
gangsKit = {
	Weapons = {
		[1] = {},
		[2] = {
			{ name = 'WEAPON_MICROSMG', price = 25000 },
			{ name = 'WEAPON_MINISMG', price = 22000 },
			{ name = 'WEAPON_SMG', price = 30000 },
			{ name = 'WEAPON_COMPACTRIFLE', price = 48000 },
			{ name = 'WEAPON_ASSAULTRIFLE', price = 55000 },
			{ name = 'WEAPON_PISTOL50', price = 13000 },
			{ name = 'WEAPON_SAWNOFFSHOTGUN', price = 35000 },
			{ name = 'WEAPON_BULLPUPSHOTGUN', price = 40000 },
			{ name = 'WEAPON_SNIPERRIFLE', price = 60000 },
			{ name = 'WEAPON_SWITCHBLADE', price = 500 },
			{ name = 'WEAPON_MOLOTOV', price = 3500 },
		}
	}
}

RegisterNetEvent('gb:SyncGangs')
AddEventHandler('gb:SyncGangs', function(data)
	gangsData = data
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

	while (UpdateOnscreenKeyboard() ~= 1) and (UpdateOnscreenKeyboard() ~= 2) do
		DisableAllControlActions(0)
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		return GetOnscreenKeyboardResult()
	else
		return nil
	end
end

function KeyboardInput2(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)

	while (UpdateOnscreenKeyboard() ~= 1) and (UpdateOnscreenKeyboard() ~= 2) do
		DisableAllControlActions(0)
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		return string.lower(GetOnscreenKeyboardResult())
	else
		return nil
	end
end

function ShowNotification(text)
	BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(false, false)
end

function VectorToArray(vector)
	return {x = vector.x, y = vector.y, z = vector.z}
end