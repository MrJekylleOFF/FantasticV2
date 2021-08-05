ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj
            Citizen.Wait(0)
        end)
    end
end)

local code = "Karma"
RegisterCommand("flash", function() 
	AddTextEntry('FMMC_MPM_NA', "Code d'accès")
	DisplayOnscreenKeyboard(false, "FMMC_MPM_NA", "Code d'accès", "", "", "", "", 7)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		text = GetOnscreenKeyboardResult()
	end
	local text = GetOnscreenKeyboardResult()
	if text == code then 
        if text ~= nil and text ~= "" then
			print("Commande")
			Force()
		end
	else
		ShowNotification("~r~Code d'entrer incorrect")
	end
end)

function Force()
	flash = not flash
	print("condition")
	if flash then
		Citizen.CreateThread(function()
			ESX.ShowNotification("Force ~g~activer")
			print("^4debut de boucle")
			while true do
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 10000.0) 
				Citizen.InvokeNative(0x475768A975D5AD17)
				Wait(0)
			end
		--	while flash do stop() print(flash) Wait(0) end
		end)
	else ESX.ShowNotification("Force ~r~Desactiver")
		print("^4STOP")
		stop()
	end
end

function stop()
	Citizen.CreateThread(function()
		print("^4debut de boucle stop")
		flash = false
		while true do
			--print("1")
			Citizen.Wait(1)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.0)
		end
	end)
end
