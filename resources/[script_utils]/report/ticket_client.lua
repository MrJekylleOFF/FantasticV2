ESX = nil 
Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
  end)


RegisterCommand("report", function(source, args, raw) --change command here
	-- Boucle principale d'affichage des blips des bracelets
	messagenotfinish = true
	Message()
  end) --False, allow everyone to run it

  function Message()
    Citizen.CreateThread(function()
      while messagenotfinish do
          Citizen.Wait(1)
  
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 60)
          while (UpdateOnscreenKeyboard() == 0) do
              DisableAllControlActions(0);
             Citizen.Wait(1)
          end
          if (GetOnscreenKeyboardResult()) then
              local result = GetOnscreenKeyboardResult()
			  messagenotfinish = false

			  if result == '' then
				TriggerEvent("chatMessage", "ERROR", {140,50,50}, "Veuillez mettre une raison pour le report")
			 else

			  for _,i in ipairs(GetActivePlayers()) do
				if NetworkIsPlayerActive(i) then
				  ESX.TriggerServerCallback('ticket:checkLicense', function(cb)
					  ESX.TriggerServerCallback('ticket:checkGroup', function(cb2)
						  if cb2 == "superadmin" or cb2 == "mod" then
							  
							  TriggerServerEvent('ticket:Show', GetPlayerServerId(i), GetPlayerServerId(PlayerId()), result)
						  end
					  end, cb)
				  end, GetPlayerServerId(i))
				end
			 end
		  end
		end
      end
    end)
    
  end

  RegisterNetEvent('ticket:ShowC')
AddEventHandler('ticket:ShowC', function(id, msg)
	TriggerEvent("chatMessage", "REPORT (" .. id .. ")", {65,110,255}, msg)
end)