local pedId = nil


-- ANIMATION DE PRISE D'ARME


ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
    end
		ESX.PlayerData = ESX.GetPlayerData()
		RefreshPed()
end)

--[[RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
	RefreshPed()
end)--]]

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	ESX.PlayerData["job"] = response
end)

GetWeaponByPed = function(hash, type)
	_menuPool:CloseAllMenus()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)


	local Location = { ["x"] = 452.32, ["y"] = -980.06, ["z"] = 30.69, ["h"] = 265.12 }
	local PedLocation = { ["x"] = 454.21, ["y"] = -980.02, ["z"] = 30.69, ["h"] = 90.0, ["hash"] = "s_m_y_cop_01" }

		local anim = type
		local weaponHash = hash



		local closestPed, closestPedDst = ESX.Game.GetClosestPed(PedLocation)


		if (DoesEntityExist(closestPed) and closestPedDst >= 5.0) or IsPedAPlayer(closestPed) then
			RefreshPed(true) -- failsafe if the ped somehow dissapear.

			ESX.ShowNotification("Essaye de nouveau.")

			return
		end

		if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter_cop", 3) or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter_cop", 3) then
			ESX.ShowNotification("Attendez s'il vous plait.")
			return
		end
		NetworkRequestControlOfEntity(closestPed)
		if not NetworkHasControlOfEntity(closestPed) then
			NetworkRequestControlOfEntity(closestPed)

			Citizen.Wait(1000)
		end

		SetEntityCoords(closestPed, PedLocation["x"], PedLocation["y"], PedLocation["z"] - 0.985)
		SetEntityHeading(closestPed, PedLocation["h"])

		SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
		SetEntityHeading(PlayerPedId(), Location["h"])
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)

		local animLib = "mp_cop_armoury"

		LoadModels({ animLib })

		if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
			FreezeEntityPosition(PlayerPedId(), true)
			TaskPlayAnim(closestPed, animLib, anim .. "_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(1100)

			GiveWeaponToPed(closestPed, GetHashKey(weaponHash), 1, false, true)
			SetCurrentPedWeapon(closestPed, GetHashKey(weaponHash), true)
			
			TaskPlayAnim(PlayerPedId(), animLib, anim .. "_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(3100)
			FreezeEntityPosition(PlayerPedId(), false)
			RemoveWeaponFromPed(closestPed, GetHashKey(weaponHash))

			Citizen.Wait(15)
			GiveWeaponToPed(PlayerPedId(), GetHashKey(weaponHash), 455, false, true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weaponHash), true)
			ClearPedTasks(closestPed)

		end

		UnloadModels()
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

end

function DeposeEquipement(hash, type)
	_menuPool:CloseAllMenus()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)


	local Location = { ["x"] = 452.32, ["y"] = -980.06, ["z"] = 30.69, ["h"] = 265.12 }
	local PedLocation = { ["x"] = 454.21, ["y"] = -980.02, ["z"] = 30.69, ["h"] = 90.0, ["hash"] = "s_m_y_cop_01" }

		local anim = type
		local weaponHash = hash



		local closestPed, closestPedDst = ESX.Game.GetClosestPed(PedLocation)


		if (DoesEntityExist(closestPed) and closestPedDst >= 5.0) or IsPedAPlayer(closestPed) then
			RefreshPed(true) -- failsafe if the ped somehow dissapear.

			ESX.ShowNotification("Essaye de nouveau.")

			return
		end

		if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter_cop", 3) or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter_cop", 3) then
			ESX.ShowNotification("Attendez s'il vous plait.")
			return
		end

		if not NetworkHasControlOfEntity(closestPed) then
			NetworkRequestControlOfEntity(closestPed)

			Citizen.Wait(1000)
		end

		SetEntityCoords(closestPed, PedLocation["x"], PedLocation["y"], PedLocation["z"] - 0.985)
		SetEntityHeading(closestPed, PedLocation["h"])

		SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
		SetEntityHeading(PlayerPedId(), Location["h"])
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)

		local animLib = "mp_cop_armoury"

		LoadModels({ animLib })

		if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
			TaskPlayAnim(PlayerPedId(), animLib, anim .. "_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(1100)

			--GiveWeaponToPed(closestPed, GetHashKey(weaponHash), 1, false, true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weaponHash), true)

			TaskPlayAnim(closestPed, animLib, anim .. "_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			
			Citizen.Wait(3100)
			RemoveAllPedWeapons(PlayerPedId(), false)
			RemoveWeaponFromPed(PlayerPedId(), GetHashKey(weaponHash))

			Citizen.Wait(15)
			GiveWeaponToPed(closestPed, GetHashKey(weaponHash), 455, false, true)
			SetCurrentPedWeapon(closestPed, GetHashKey(weaponHash), true)
			ClearPedTasks(PlayerPedId())
			Citizen.Wait(3000)
			RemoveWeaponFromPed(closestPed, GetHashKey(weaponHash))

		end

		UnloadModels()
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
end

function DeposeObjets()
	_menuPool:CloseAllMenus()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)


	local Location = { ["x"] = 452.32, ["y"] = -980.06, ["z"] = 30.69, ["h"] = 265.12 }
	local PedLocation = { ["x"] = 454.21, ["y"] = -980.02, ["z"] = 30.69, ["h"] = 90.0, ["hash"] = "s_m_y_cop_01" }

		local anim = "rifle"
		local weaponHash = hash



		local closestPed, closestPedDst = ESX.Game.GetClosestPed(PedLocation)


		if (DoesEntityExist(closestPed) and closestPedDst >= 5.0) or IsPedAPlayer(closestPed) then
			RefreshPed(true) -- failsafe if the ped somehow dissapear.

			ESX.ShowNotification("Essaye de nouveau.")

			return
		end

		if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter_cop", 3) or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter_cop", 3) then
			ESX.ShowNotification("Attendez s'il vous plait.")
			return
		end

		if not NetworkHasControlOfEntity(closestPed) then
			NetworkRequestControlOfEntity(closestPed)

			Citizen.Wait(1000)
		end

		SetEntityCoords(closestPed, PedLocation["x"], PedLocation["y"], PedLocation["z"] - 0.985)
		SetEntityHeading(closestPed, PedLocation["h"])

		SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
		SetEntityHeading(PlayerPedId(), Location["h"])
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)

		local animLib = "mp_cop_armoury"

		LoadModels({ animLib })

		if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
			TaskPlayAnim(PlayerPedId(), animLib, anim .. "_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(1100)

			GiveWeaponToPed(PlayerPedId(), 0x88C78EB7, 1, false, true)
			SetCurrentPedWeapon(PlayerPedId(), 0x88C78EB7, true)

			TaskPlayAnim(closestPed, animLib, anim .. "_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			
			Citizen.Wait(3100)

			RemoveWeaponFromPed(PlayerPedId(), 0x88C78EB7)

			Citizen.Wait(15)
			GiveWeaponToPed(closestPed, 0x88C78EB7, 455, false, true)
			SetCurrentPedWeapon(closestPed, 0x88C78EB7, true)
			ClearPedTasks(PlayerPedId())
			Citizen.Wait(3000)
			RemoveWeaponFromPed(closestPed, 0x88C78EB7)
			ClearPedTasks(closestPed)

		end

		UnloadModels()
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
end

function RefreshPed()

    local modelHash = GetHashKey('s_m_y_cop_01')
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    local SpawnedPed = CreatePed(2, modelHash, 454.15, -980.02, 30.69 - 0.985, 90.0, false, true)
    TaskSetBlockingOfNonTemporaryEvents(SpawnedPed, true)
    Citizen.Wait(1)

	SetPedCombatAttributes(SpawnedPed, 46, true)                     
	SetPedFleeAttributes(SpawnedPed, 0, 0)                      
	SetBlockingOfNonTemporaryEvents(SpawnedPed, true)

	SetEntityAsMissionEntity(SpawnedPed, true, true)
	SetEntityInvincible(SpawnedPed, true)

	SetCanAttackFriendly(SpawnedPed, false, true)
	SetPedAsCop(SpawnedPed, true)
	SetPedCombatAbility(SpawnedPed, 0)
	SetPedCombatAttributes(SpawnedPed, 0, 1)
	SetPedCombatAttributes(SpawnedPed, 1, 1)
	SetPedCombatAttributes(SpawnedPed, 3, 0)
	SetPedCombatAttributes(SpawnedPed, 5, 0)
	SetPedCombatAttributes(SpawnedPed, 20, 1)
	SetPedCombatAttributes(SpawnedPed, 46, 0)
	SetPedCombatAttributes(SpawnedPed, 52, 0)
	SetPedCombatRange(SpawnedPed, 0)
    PlaceObjectOnGroundProperly(SpawnedPed)
    SetModelAsNoLongerNeeded(modelHash)
    Citizen.CreateThread(function()
        local x_ped = SpawnedPed
        Citizen.Wait(1000)
        FreezeEntityPosition(x_ped, true)
    end)  
end    

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		DeleteEntity(pedId)
	end
end)

local CachedModels = {}

LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		table.insert(CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

UnloadModels = function()
	for modelIndex = 1, #CachedModels do
		local model = CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end

		table.remove(CachedModels, modelIndex)
	end
end