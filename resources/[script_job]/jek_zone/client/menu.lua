

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)
		TriggerEvent("izone:isPlayerInZone", "APO1", function(isIn)
			if isIn == true then 
              print('test')
			else
				print('ok')
			end
        end)
        TriggerEvent("izone:isPlayerInZone", "APO2", function(isIn)
            if isIn == true then 
              TriggerServerEvent('mrw_agriculture:CheckOwnedParcelle', 2)
            end
        end)
	end
	end)
