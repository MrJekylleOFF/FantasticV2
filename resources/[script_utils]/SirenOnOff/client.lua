local sirene = 1
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- Check si le joueurs est dans un véhicule
		local playerped = GetPlayerPed(-1)		
		if IsPedInAnyVehicle(playerped, false) then	
			-- Check si le joueurs est conducteur
			local veh = GetVehiclePedIsUsing(playerped)	
			local NetId = NetworkGetNetworkIdFromEntity(veh)
			if GetPedInVehicleSeat(veh, -1) == playerped then
				-- Check si il est dans un véhicule de police / EMS
				if GetVehicleClass(veh) == 18 then
					--DisableControlAction(0, 34, true)
					if IsDisabledControlJustReleased(0, 47) then
						if sirene == 0 then
							-- on
							TriggerServerEvent("siren:sync", sirene, NetId)
							sirene = 1
						else
							-- off
							TriggerServerEvent("siren:sync", sirene, NetId)
							sirene = 0
						end
					end
				end
			end
		end
	end
end)





-- Server side sync
RegisterNetEvent("siren:ClientSync")
AddEventHandler("siren:ClientSync", function(sync, NetId)
	local veh = NetworkGetEntityFromNetworkId(NetId)
	if sync == 0 then
		DisableVehicleImpactExplosionActivation(veh, 0)
	elseif sync == 1 then
		DisableVehicleImpactExplosionActivation(veh, 1)
	end
end)
