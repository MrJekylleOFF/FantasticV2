
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, 58) and IsControlPressed(1, 21) then
            ExecuteCommand('JEKMENU')
        end
    end
end)

RegisterNetEvent('OpenMenu:JEK')
AddEventHandler('OpenMenu:JEK', function()
	RageUI.Visible(RMenu:Get('showcase', 'menu'), not RageUI.Visible(RMenu:Get('showcase', 'menu')))
end)


--[[Citizen.CreateThread(function()
	while true do
		Wait(200)
		local ped = GetPlayerPed(-1)
		if IsPedModel(ped, "a_c_mtlion") then
			if IsControlJustReleased(0, 246) then 
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 20, 'tigre', 0.9)
				Wait(4000)
			end
		end
	end
end)--]]

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

p_smoke_location = {
	20279,
	0x4B2,
	0xe175,
	0x60e6,
	0x192a,
	0x5c57,
	0x9000,
	0xf9bb,
	0x8cbd,
	0x188e,
--	0x29d2,
	0x9d4d,
--	0x62ac,
--	0xb2b6
}
p_smoke_particle = {
	--"fire_petroltank_truck",
	"ent_ray_ch2_farm_fire_u_l",
--	"fire_wrecked_car"
}

p_smoke_particle_asset2 = "core" 
local have = false

p_smoke_particle_asset = "core" 
RegisterNetEvent("c_smoke")
AddEventHandler("c_smoke", function(c_ped, location, particle, state, main, pied, bras, brasg, oeil, crane, maind)
	--SetEntityInvincible(NetToPed(c_ped), false)
	--StartEntityFire(NetToPed(c_ped))
	--SetEntityInvincible(NetToPed(c_ped), true)
	if state then
		if DoesEntityExist(NetToPed(c_ped)) and not IsEntityDead(NetToPed(c_ped)) then
			createdSmoke = UseParticleFxAssetNextCall(p_smoke_particle_asset)
			if main then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.13, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.2, 0.0, 0.0, 0.0)
			elseif maind then
				print('ok')
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.2, 0.0, 0.0, 0.0)
			elseif pied then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.35, 0.0, 0.0, 0.0)
			elseif bras then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), -0.2, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.4, 0.0, 0.0, 0.0)
			elseif oeil then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.1, 0.0, 0.0, 0.0)
			elseif crane then
				print('test')
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), -0.2, 0.14, -0.16, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location),0.4, 0.0, 0.0, 0.0)
			elseif brasg then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), -0.1, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.4, 0.0, 0.0, 0.0)
			else
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.5, 0.0, 0.0, 0.0)
			end
		end
	else
		RemoveParticleFxFromEntity(NetToPed(c_ped))
--	if DoesParticleFxLoopedExist(createdPart) then 
--		RemoveParticleFx(createdPart, true)
--	 endcc
	end
end)


p_smoke_particle_asset = "core" 
RegisterNetEvent("c_smoke3")
AddEventHandler("c_smoke3", function(c_ped, location, particle, state, main, pied, bras, brasg, oeil, crane, maind)
	--SetEntityInvincible(NetToPed(c_ped), false)
	--StartEntityFire(NetToPed(c_ped))
	--SetEntityInvincible(NetToPed(c_ped), true)
	if state then
		if DoesEntityExist(NetToPed(c_ped)) and not IsEntityDead(NetToPed(c_ped)) then
			createdSmoke = UseParticleFxAssetNextCall(p_smoke_particle_asset)
			if main then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.13, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.2, 0.0, 0.0, 0.0)
			elseif maind then
				print('ok')
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.2, 0.0, 0.0, 0.0)
			elseif pied then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.35, 0.0, 0.0, 0.0)
			elseif bras then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), -0.2, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.4, 0.0, 0.0, 0.0)
			elseif oeil then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.1, 0.0, 0.0, 0.0)
			elseif crane then
				print('test')
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), -0.2, 0.14, -0.16, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location),0.4, 0.0, 0.0, 0.0)
			elseif brasg then
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), -0.1, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.4, 0.0, 0.0, 0.0)
			else
				createdPart = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.5, 0.0, 0.0, 0.0)
			end
		end
	else
		RemoveParticleFxFromEntity(NetToPed(c_ped))
--	if DoesParticleFxLoopedExist(createdPart) then 
--		RemoveParticleFx(createdPart, true)
--	 endcc
	end
end)


RegisterNetEvent("c_smoke4")
AddEventHandler("c_smoke4", function(c_ped, location, particle, state)
	if state then
		createdSmoke = UseParticleFxAssetNextCall(p_smoke_particle_asset)
		createdPart2998 = StartParticleFxLoopedOnEntityBone(particle, NetToPed(c_ped), -0.04, 0.15, 0.0, -90.0, -40.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), location), 0.8, 0.0, 0.0, 0.0)
	else
		if DoesParticleFxLoopedExist(createdPart2998) then 
			RemoveParticleFx(createdPart2998, true)
		end
	end
end)

RegisterNetEvent("c_opa")
AddEventHandler("c_opa", function(c_ped, opac)
	SetEntityAlpha(NetToPed(c_ped), opac)
end)


RegisterNetEvent("c_smoke2")
AddEventHandler("c_smoke2", function(c_ped, state)
	have = not have
			local coords = GetEntityCoords(NetToPed(c_ped))
			if have then 

		
			SetEntityInvincible(NetToPed(c_ped), false)
			StartEntityFire(NetToPed(c_ped))
			SetEntityInvincible(NetToPed(c_ped), true)
			createdSmoke2 = UseParticleFxAssetNextCall(p_smoke_particle_asset2)
			createdPart2 = StartParticleFxLoopedOnEntityBone("veh_trailer_petrol_spray",NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), 0x322c), 0.0, 0.0, 0.0, 0.0)
			createdSmoke2 = UseParticleFxAssetNextCall(p_smoke_particle_asset2)
			createdPart2 = StartParticleFxLoopedOnEntityBone("fire_petroltank_heli", NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), 0x322c), 0.4, 0.0, 0.0, 0.0)
			else
				StopEntityFire(NetToPed(c_ped))
				RemoveParticleFxFromEntity(NetToPed(c_ped))
			end
end)
