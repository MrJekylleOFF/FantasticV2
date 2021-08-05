ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)




function poursuiteEngager(voiture, veh)
    PlaySoundFrontend(-1, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
    local ped = GetPedInVehicleSeat(voiture, -1)
   -- TaskVehicleChase(ped, veh)
    TaskVehicleEscort(ped, voiture, veh, -1, 320.0, 2883621, 1.0, 1, 30.0)
    SetVehicleSiren(voiture, true)

    -- BLIP
    local blipZone = AddBlipForEntity(voiture)
    SetBlipSprite(blipZone, 42)
    SetBlipScale(blipZone, 0.85)
    SetBlipAlpha(blipZone, 150)
    
    local coordsJoueur = GetEntityCoords(veh, true)
    local coordsModlu = GetEntityCoords(voiture, true)
    local distanceNPC = GetDistanceBetweenCoords(coordsJoueur, coordsModlu, true)

    while distanceNPC <= 200 do
        local coordsJoueur = GetEntityCoords(veh, true)
        local coordsModlu = GetEntityCoords(voiture, true)
        distanceNPC = GetDistanceBetweenCoords(coordsJoueur, coordsModlu, true)
        Wait(1000)
    end
    PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
    PlaySoundFrontend(-1, "5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset", 1)
    Wait(5000)

    -- FIN BLIP

    RemoveBlip(blipZone)


    PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
    ESX.Scaleform.ShowFreemodeMessage('~o~Échappée', '~y~La police moldu à perdu votre trace!', 3)
    TaskVehicleDriveWander(ped, voiture, 50.0, 786603)
    SetVehicleSiren(voiture, false)
    ForceAmbientSiren(false)

end