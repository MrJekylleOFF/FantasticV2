------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- Authors Morow https://github.com/Morow73 --------------------------------------------
ESX          = nil
local IsDead = false

AddEventHandler('esx_addonneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'force', 50000) 
end)


AddEventHandler('esx_addonneeds:resetStatus', function()
    TriggerEvent('esx_status:set', 'endu', 50000) 
end)



AddEventHandler('playerSpawned', function()

	if IsDead then
		TriggerEvent('esx_addonneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

   TriggerEvent('esx_status:registerStatus', 'force', 0, 'fas fa-fist-raised blue', ----- jaune 
        function(status)
            if Config.EnableHud == true then          
                if status.val > 0 then
                    return true
                else
                    return false
                end
            else 
              return false 
            end  
        end,
		function(status)
			status.remove(Config.RemoveForce)
		end
    )
	
	
   Citizen.CreateThread(function()
	    while true do
	        Wait(5000)
	        TriggerEvent('esx_status:getStatus', 'force', function(status)
                if status.val <= 0 then    
                    StatSetInt(GetHashKey('MP0_STAMINA'), 0, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 0, true)
                elseif status.val >= 250000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 25, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 25, true)
                elseif status.val >= 500000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 50, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 50, true)
                elseif status.val >= 750000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 75, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 75, true)    
                elseif status.val == 1000000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 100, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 100, true) 
                end  
            end)
        end
    end)
end)	

AddEventHandler('esx_status:loaded', function(status)
   TriggerEvent('esx_status:registerStatus', 'endu', 0, 'fas fa-running blue', -- marron
        function(status)
            if Config.EnableHud == true then   
              if status.val > 0 then
                return true
              else
                return false
              end
            else 
                return false
            end  
        end,
        function(status)
            status.remove(Config.RemoveEndurance)
        end
    )
    

    Citizen.CreateThread(function()
        while true do
            Wait(5000) 
            TriggerEvent('esx_status:getStatus', 'endu', function(status)        
                if status.val <= 0 then 
                    StatSetInt(GetHashKey('MP0_STAMINA'), 0, true)
                elseif status.val == 100000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 10, true)  
                elseif status.val == 250000 then 
                    StatSetInt(GetHashKey('MP0_STAMINA'), 25, true) 
                elseif status.val == 500000 then 
                    StatSetInt(GetHashKey('MP0_STAMINA'), 50, true)
                elseif status.val == 750000 then 
                   StatSetInt(GetHashKey('MP0_STAMINA'), 75, true)
                elseif status.val == 1000000 then 
                    StatSetInt(GetHashKey('MP0_STAMINA'), 100, true)      
                end      
            end)   
        end
    end)
    
end) 

Citizen.CreateThread(function()
    while true do
        Wait(5000)

        if IsPedRunning(GetPlayerPed(-1)) then 
            TriggerEvent('esx_status:add', 'endu', Config.ExpEndurance)  
        elseif IsPedInMeleeCombat(GetPlayerPed(-1)) then 
            TriggerEvent('esx_status:add', 'force', Config.ExpForce)          
        end    
    end
end) 



