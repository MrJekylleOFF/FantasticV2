RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('dvr_flash:syncCL')
AddEventHandler('dvr_flash:syncCL', function(ped, need, sex)
    if need == 'flash' then
      TriggerEvent("flash:start")
    end
end)

local Player = ped
local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))
local particleDictionary = "core"
local particleName = "exp_grd_flare"

RegisterCommand("flash", function(source,args,raw)
	TriggerEvent("flash:start")
	TriggerServerEvent('dvr_flash:sync', GetPlayerServerId(PlayerId()), 'flash')
end)

RegisterNetEvent("flash:start")
AddEventHandler("flash:start", function(ped)
	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(0)
			RequestNamedPtfxAsset(particleDictionary)
			bone = GetPedBoneIndex(PlayerPed, 11816)
			StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -1.3, 0.0, 0.0, 0.0, bone, 0.4, false, false, false)
			--StopParticleFxLooped(ped, 0)
		end
	end)
end)

RegisterCommand("stopflash", function(source,args,raw)
	stop()
end)

function stop(ped)
	StopParticleFxLooped( 0)
	print("stop")
end

-- exp_grd_flare = rouge
-- exp_sht_flame = flame
-- exp_grd_train = flame enorme
-- exp_grd_molotov_lod = molotov
-- exp_grd_plane_lod = Flame de ouf
-- exp_grd_grenade_smoke = fumer
-- veh_respray_smoke = fumer orange