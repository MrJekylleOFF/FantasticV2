local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = {}
local DragStatus              = {}
DragStatus.IsDragged          = false
local hasAlreadyJoined        = false
local blipsCops               = {}
local isDead                  = false
local CurrentTask             = {}
local playerInService         = false

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 3,
		modBrakes       = 3,
		modTransmission = 3,
		modTurbo        = true,
		 windowTint = 0,
    plateIndex = 1,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)

	TriggerEvent('skinchanger:getSkin', function(skin)

		if skin.sex == 0 then

			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end

		else

			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end

		end

	end)
end

function OpenCloakroomMenu()

	local elements = {
	  { label = '~r~Tenue Civil', value = 'citizen_wear' }
	}
  
	if PlayerData.job.grade_name == 'cadet' then
	  table.insert(elements, {label = '~g~Tenue Cadet', value = 'cadet_wear'})
	end
  
	if PlayerData.job.grade_name ~= 'cadet' then
	  table.insert(elements, {label = '~g~Tenue LSPD', value = 'flic_wear'})
	end

	table.insert(elements, {label = '~g~Tenue Motard', value = 'motard_wear'})
	table.insert(elements, {label = '~g~Tenue Pilote H', value = 'pilote_wear'})
	table.insert(elements, {label = '~g~Tenues Brigades', value = 'brigades_wear'})
	table.insert(elements, {label = '-------------------------------', value = ''})
	table.insert(elements, {label = '~g~Mettre Sac', value = 'sac_wear'})
	table.insert(elements, {label = '~r~Déposer Sac', value = 'sac1_wear'})
	table.insert(elements, {label = '-------------------------------', value = ''})
	table.insert(elements, {label = '~g~Prendre Gilet Pare-Balle', value = 'bullet_wear'})
	table.insert(elements, {label = '~r~Déposer Gilet Pare-Balle', value = 'bullet2_wear'})
	table.insert(elements, {label = '-------------------------------', value = ''})
	table.insert(elements, {label = '~g~Mettre Gilet Pare-Balle', value = 'bullet3_wear'})
	table.insert(elements, {label = '~r~Enlever Gilet Pare-Balle', value = 'bullet4_wear'})
	table.insert(elements, {label = '-------------------------------', value = ''})
	table.insert(elements, {label = '~g~Prendre Bracelet électronique', value = 'bra_wear'})
	table.insert(elements, {label = '~r~Déposer Bracelet électronique', value = 'bra2_wear'})
	table.insert(elements, {label = '-------------------------------', value = ''})
	table.insert(elements, {label = '~g~Prendre son service', value = 'priseservice'})
	table.insert(elements, {label = '~r~Fin de service', value = 'finservice'})

  
	ESX.UI.Menu.CloseAll()
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'cloakroom',
	  {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements,
	  },
	  function(data, menu)
		menu.close()
  
		if data.current.value == 'citizen_wear' then
		TriggerServerEvent("player:serviceOff", "police")
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local model = nil
  
			if skin.sex == 0 then
			  model = GetHashKey("mp_m_freemode_01")
			else
			  model = GetHashKey("mp_f_freemode_01")
			end
  
			RequestModel(model)
			while not HasModelLoaded(model) do
			  RequestModel(model)
			  Citizen.Wait(1)
			end
  
			SetPlayerModel(PlayerId(), model)
			SetModelAsNoLongerNeeded(model)
  
			TriggerEvent('skinchanger:loadSkin', skin)
			TriggerEvent('esx:restoreLoadout')
			local playerPed = GetPlayerPed(-1)
			SetPedArmour(playerPed, 0)
			ClearPedBloodDamage(playerPed)
			ResetPedVisibleDamage(playerPed)
			ClearPedLastWeaponDamage(playerPed)
		  end)

		  if Config.MaxInService ~= -1 then

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if isInService then

					playerInService = false

					local notification = {
						title    = 'Annonce Service',
						subject  = '',
						msg      = 'L\'agent ~g~' .. GetPlayerName(PlayerId()) .. '~s~ prend sa fin de service !', GetPlayerName(PlayerId()),
						iconType = 1
					}

					TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')

					TriggerServerEvent('esx_service:disableService', 'police')
					--TriggerEvent('jek_policejob:updateBlip')
					ESX.ShowNotification('~r~Fin de service')
				end
			end, 'police')
		end
		end

		if data.current.value == 'sac_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
			
				if skin.sex == 0 then
	
					local clothesSkin = {
						['bags_1'] = 44, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	
				else
	
					local clothesSkin = {
						['bags_1'] = 44, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
  
		  end

		  if data.current.value == 'sac1_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
			
				if skin.sex == 0 then
	
					local clothesSkin = {
						['bags_1'] = 0, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	
				else
	
					local clothesSkin = {
						['bags_1'] = 0, ['bags_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
  
		  end


		if data.current.value == 'cadet_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
			
				if skin.sex == 0 then
	
					local clothesSkin = {
						['tshirt_1'] = 59,  ['tshirt_2'] = 1,
						['torso_1']= 55,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 41,
						['pants_1'] = 25,   ['pants_2'] = 0,
						['shoes_1'] = 25,   ['shoes_2'] = 0,
						['helmet_1'] = 46,  ['helmet_2'] = 0,
						['chain_1'] = 0,    ['chain_2'] = 0,
						['ears_1'] = 2,     ['ears_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					TriggerServerEvent("player:serviceOn", "police")
	
				else
	
					local clothesSkin = {
						['tshirt_1'] = 36, ['tshirt_2'] = 1,
						['torso_1'] = 48, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 44,
						['pants_1'] = 34, ['pants_2'] = 0,
						['shoes_1'] = 27, ['shoes_2'] = 0,
						['helmet_1'] = 45, ['helmet_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = 2, ['ears_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					TriggerServerEvent("player:serviceOn", "police")
	
				end
	
				local playerPed = GetPlayerPed(-1)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
				playerInService = true
			end)
  
		  end
  
		if data.current.value == 'flic_wear' then
		  TriggerEvent('skinchanger:getSkin', function(skin)
			  if skin.sex == 0 then
  
				  local clothesSkin = {
					  ['tshirt_1'] = 38, ['tshirt_2'] = 0,
					  ['torso_1'] = 55, ['torso_2'] = 0,
					  ['decals_1'] = 0, ['decals_2'] = 0,
					  ['arms'] = 30,
					  ['pants_1'] = 35, ['pants_2'] = 0,
					  ['shoes_1'] = 25, ['shoes_2'] = 0,
					  ['helmet_1'] = -1, ['helmet_2'] = 0,
					  ['watches_1'] = 20, ['watches_2'] = 0,
					  ['ears_1'] = 2, ['ears_2'] = 0
				  }
				  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				  TriggerServerEvent("player:serviceOn", "police")
  
			  else
  
				  local clothesSkin = {
					  ['tshirt_1'] = 152, ['tshirt_2'] = 0,
					  ['torso_1'] = 48, ['torso_2'] = 0,
					  ['decals_1'] = 0, ['decals_2'] = 0,
					  ['arms'] = 57,
					  ['pants_1'] = 34, ['pants_2'] = 0,
					  ['shoes_1'] = 25, ['shoes_2'] = 0,
					  ['ears_1'] = 2, ['ears_2'] = 0
				  }
				  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				  TriggerServerEvent("player:serviceOn", "police")
  
			  end
  
			  local playerPed = GetPlayerPed(-1)
			  ClearPedBloodDamage(playerPed)
			  ResetPedVisibleDamage(playerPed)
			  ClearPedLastWeaponDamage(playerPed)
			  		  playerInService = true
		  end)

		end


		if data.current.value == 'motard_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
	
					local clothesSkin = {
						['tshirt_1'] = 122, ['tshirt_2'] = 0,
						['torso_1'] = 148, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 110, ['arms_2'] = 3,
						['pants_1'] = 67, ['pants_2'] = 3,
						['shoes_1'] = 47, ['shoes_2'] = 7,
						['helmet_1'] = 72, ['helmet_2'] = 8,
						['mask_1'] = 122, ['mask_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = 2, ['ears_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					TriggerServerEvent("player:serviceOn", "police")
	
				else
	
					local clothesSkin = {
						['tshirt_1'] = 152, ['tshirt_2'] = 0,
						['torso_1'] = 145, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 127,  ['arms_2'] = 3,
						['pants_1'] = 69, ['pants_2'] = 3,
						['shoes_1'] = 48, ['shoes_2'] = 7,
						['helmet_1'] = 71, ['helmet_2'] = 8,
						['mask_1'] = 122, ['mask_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = 2, ['ears_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					TriggerServerEvent("player:serviceOn", "police")
	
				end
	
				local playerPed = GetPlayerPed(-1)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
						  playerInService = true
			end)
  
		  end


		  if data.current.value == 'pilote_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
	
					local clothesSkin = {
						['tshirt_1'] = 15, ['tshirt_2'] = 0,
						['torso_1'] = 54, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 96, ['arms_2'] = 0,
						['pants_1'] = 92, ['pants_2'] = 4,
						['shoes_1'] = 24, ['shoes_2'] = 0,
						['helmet_1'] = 19, ['helmet_2'] = 0,
						['mask_1'] = 0, ['mask_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = 2, ['ears_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					TriggerServerEvent("player:serviceOn", "police")
	
				else
	
					local clothesSkin = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 47, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 111,  ['arms_2'] = 0,
						['pants_1'] = 95, ['pants_2'] = 4,
						['shoes_1'] = 24, ['shoes_2'] = 0,
						['helmet_1'] = 19, ['helmet_2'] = 0,
						['ears_1'] = 2, ['ears_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					TriggerServerEvent("player:serviceOn", "police")
	
				end
	
				local playerPed = GetPlayerPed(-1)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
						  playerInService = true
			end)
  
		  end


		  if data.current.value == 'brigades_wear' then
			local elements2 = {
				{ label = '~r~Retour', value = 'retour' }
			  }
		  
			  table.insert(elements2, {label = '~g~Tenue S.W.A.T', value = 'swat_wear'})
			  table.insert(elements2, {label = '~g~Tenue D.O.A', value = 'doa_wear'})
			  table.insert(elements2, {label = '~g~Tenue G.T.F', value = 'gtf_wear'})
			  table.insert(elements2, {label = '~g~Tenue S.A.H.P', value = 'sahp_wear'})
			  table.insert(elements2, {label = '~g~Tenue Agent Spécial', value = 'spe_wear'})
		  
			
			  ESX.UI.Menu.CloseAll()
			
			  ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'cloakroom2',
				{
				  title    = _U('cloakroom'),
				  align    = 'top-left',
				  elements = elements2,
				},
				function(data2, menu2)
				  menu2.close()

				  if data2.current.value == 'retour' then
					ESX.UI.Menu.CloseAll()
					OpenCloakroomMenu()
				  end 

				  if data2.current.value == 'swat_wear' then
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
			
							local clothesSkin = {
								['tshirt_1'] = 122, ['tshirt_2'] = 0,
								['torso_1'] = 49, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 17, ['arms_2'] = 0,
								['pants_1'] = 34, ['pants_2'] = 0,
								['shoes_1'] = 24, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 52, ['mask_2'] = 0,
								['chain_1'] = 0, ['chain_2'] = 0,
								['ears_1'] = 2, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						else
			
							local clothesSkin = {
								['tshirt_1'] = 152, ['tshirt_2'] = 0,
								['torso_1'] = 42, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 18,  ['arms_2'] = 0,
								['pants_1'] = 33, ['pants_2'] = 0,
								['shoes_1'] = 25, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 52, ['mask_2'] = 0,
								['ears_1'] = 2, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						end
			
						local playerPed = GetPlayerPed(-1)
						ClearPedBloodDamage(playerPed)
						ResetPedVisibleDamage(playerPed)
						ClearPedLastWeaponDamage(playerPed)
								  playerInService = true
					end)
				  end

				  if data2.current.value == 'doa_wear' then
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
			
							local clothesSkin = {
								['tshirt_1'] = 130, ['tshirt_2'] = 0,
								['torso_1'] = 220, ['torso_2'] = 20,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 17, ['arms_2'] = 0,
								['pants_1'] = 59, ['pants_2'] = 9,
								['shoes_1'] = 24, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 0, ['mask_2'] = 0,
								['chain_1'] = 0, ['chain_2'] = 0,
								['ears_1'] = 2, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						else
			
							local clothesSkin = {
								['tshirt_1'] = 160, ['tshirt_2'] = 0,
								['torso_1'] = 230, ['torso_2'] = 20,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 19,  ['arms_2'] = 0,
								['pants_1'] = 61, ['pants_2'] = 9,
								['shoes_1'] = 25, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 0, ['mask_2'] = 0,
								['ears_1'] = 2, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						end
			
						local playerPed = GetPlayerPed(-1)
						ClearPedBloodDamage(playerPed)
						ResetPedVisibleDamage(playerPed)
						ClearPedLastWeaponDamage(playerPed)
								  playerInService = true
					end)
				  end

				  if data2.current.value == 'gtf_wear' then
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
			
							local clothesSkin = {
								['tshirt_1'] = 130, ['tshirt_2'] = 0,
								['torso_1'] = 111, ['torso_2'] = 3,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 60, ['arms_2'] = 0,
								['pants_1'] = 31, ['pants_2'] = 0,
								['shoes_1'] = 25, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 121, ['mask_2'] = 0,
								['chain_1'] = 0, ['chain_2'] = 0,
								['ears_1'] = 0, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						else
			
							local clothesSkin = {
								['tshirt_1'] = 160, ['tshirt_2'] = 0,
								['torso_1'] = 136, ['torso_2'] = 3,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 62,  ['arms_2'] = 0,
								['pants_1'] = 30, ['pants_2'] = 0,
								['shoes_1'] = 25, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 121, ['mask_2'] = 0,
								['ears_1'] = 0, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						end
			
						local playerPed = GetPlayerPed(-1)
						ClearPedBloodDamage(playerPed)
						ResetPedVisibleDamage(playerPed)
						ClearPedLastWeaponDamage(playerPed)
								  playerInService = true
					end)
				  end

				  if data2.current.value == 'sahp_wear' then
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
			
							local clothesSkin = {
								['tshirt_1'] = 58, ['tshirt_2'] = 0,
								['torso_1'] = 98, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 22, ['arms_2'] = 0,
								['pants_1'] = 47, ['pants_2'] = 0,
								['shoes_1'] = 54, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 0, ['mask_2'] = 0,
								['chain_1'] = 0, ['chain_2'] = 0,
								['ears_1'] = 2, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						else
			
							local clothesSkin = {
								['tshirt_1'] = 35, ['tshirt_2'] = 0,
								['torso_1'] = 89, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 14,  ['arms_2'] = 0,
								['pants_1'] = 49, ['pants_2'] = 0,
								['shoes_1'] = 52, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 0, ['mask_2'] = 0,
								['ears_1'] = 2, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						end
			
						local playerPed = GetPlayerPed(-1)
						ClearPedBloodDamage(playerPed)
						ResetPedVisibleDamage(playerPed)
						ClearPedLastWeaponDamage(playerPed)
								  playerInService = true
					end)
				  end

				  if data2.current.value == 'spe_wear' then
					TriggerEvent('skinchanger:getSkin', function(skin)
						if skin.sex == 0 then
			
							local clothesSkin = {
								['tshirt_1'] = 35, ['tshirt_2'] = 0,
								['torso_1'] = 32, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 1, ['arms_2'] = 0,
								['pants_1'] = 28, ['pants_2'] = 0,
								['shoes_1'] = 40, ['shoes_2'] = 9,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 121, ['mask_2'] = 0,
								['chain_1'] = 128, ['chain_2'] = 0,
								['ears_1'] = 0, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						else
			
							local clothesSkin = {
								['tshirt_1'] = 41, ['tshirt_2'] = 2,
								['torso_1'] = 58, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 1,  ['arms_2'] = 0,
								['pants_1'] = 37, ['pants_2'] = 0,
								['shoes_1'] = 42, ['shoes_2'] = 2,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 121, ['mask_2'] = 0,
								['chain_1'] = 98,
								['ears_1'] = 0, ['ears_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							TriggerServerEvent("player:serviceOn", "police")
			
						end
			
						local playerPed = GetPlayerPed(-1)
						ClearPedBloodDamage(playerPed)
						ResetPedVisibleDamage(playerPed)
						ClearPedLastWeaponDamage(playerPed)
								  playerInService = true
					end)
				  end

				  OpenCloakroomMenu()
				end,

				function(data2, menu2)
			
				  menu2.close()

		
				end
			  )
		 end

		 if data.current.value == 'bullet_wear' then
			TriggerServerEvent('jek_policejob:buyproof')
		end

		if data.current.value == 'bra_wear' then
			TriggerServerEvent('jek_policejob:buybra')
		end

		if data.current.value == 'priseservice' then
			playerInService = true
			TriggerServerEvent("player:serviceOn", "police")
		end

		if data.current.value == 'finservice' then
			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then
	
						playerInService = false
	
						local notification = {
							title    = 'Annonce Service',
							subject  = '',
							msg      = 'L\'agent ~g~' .. GetPlayerName(PlayerId()) .. '~s~ prend sa fin de service !', GetPlayerName(PlayerId()),
							iconType = 1
						}
	
						TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
	
						TriggerServerEvent('esx_service:disableService', 'police')
						--TriggerEvent('jek_policejob:updateBlip')
						ESX.ShowNotification('~r~Fin de service')
					end
				end, 'police')
			end
			TriggerServerEvent("player:serviceOff", "police")
		end

		if data.current.value == 'bullet2_wear' then
			TriggerServerEvent('jek_policejob:rendproof')
		end

		if data.current.value == 'bullet3_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
	
					local clothesSkin = {
						['bproof_1']  = 7,  ['bproof_2']  = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	
				else
	
					local clothesSkin = {
						['bproof_1']  = 7,  ['bproof_2']  = 4
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	
				end
	
				local playerPed = GetPlayerPed(-1)
				SetPedArmour(playerPed, 100)
			end)
		end

		
		if data.current.value == 'bullet4_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
	
					local clothesSkin = {
						['bproof_1']  = 0,  ['bproof_2']  = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	
				else
	
					local clothesSkin = {
						['bproof_1']  = 0,  ['bproof_2']  = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	
				end
	
				local playerPed = GetPlayerPed(-1)
				SetPedArmour(playerPed, 0)
			end)
		end

		if data.current.value == 'bra2_wear' then
			TriggerServerEvent('jek_policejob:rendbra')
		end

		  if Config.MaxInService ~= -1 and playerInService then 
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						if not canTakeService then
							ESX.ShowNotification('Trop de collègues en services', inServiceCount, maxInService)
						else

							serviceOk = true
							playerInService = true

							local notification = {
								title    = 'Annonce Service',
								subject  = '',
								msg      = 'L\'agent ~g~' .. GetPlayerName(PlayerId()) .. '~s~ prend son service !', GetPlayerName(PlayerId()),
								iconType = 1
							}
	
							TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
							TriggerServerEvent('esx_service:ActivateService', 'police', 99)
							TriggerServerEvent('esx_service:startPayCheck', 'police', 'society_police')
							--TriggerEvent('jek_policejob:updateBlip')
							ESX.ShowNotification('~g~Prise de service')
						end
					end, 'police')

				else
					serviceOk = true
				end
			end, 'police')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		  end

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
  
	  end,
	  function(data, menu)
  
		menu.close()
  
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	  end
	)
  
  end


function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('jek_policejob:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('jek_policejob:getOtherPlayerData', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
			targetName = data.firstname .. ' ' .. data.lastname
		
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'top-left',
			css		 = 'police',
			elements = elements,
		},
		function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('jek_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end,
		function(data, menu)
			menu.close()
		end
		)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)

	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for i=1, #bills, 1 do
			table.insert(elements, {label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>', value = bills[i].id})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			css		 = 'police',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('jek_policejob:getVehicleInfos', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		{
			title    = _U('vehicle_info'),
			align    = 'top-left',
			css		 = 'police',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)
end

function OpenStocksMenu()
  
	  local elements = {
		{label = _U('remove_object'),  value = 'get_stock'},
		{label = _U('deposit_object'), value = 'put_stock'},
		{label = _U('get_weapon'),     value = 'get_weapon'},
		{label = _U('put_weapon'),     value = 'put_weapon'}
	  }
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'stocks',
		{
		  title    = _U('stocks'),
		  align    = 'left',
		  css    = 'police',
		  elements = elements,
		},
		function(data, menu)
  
		  if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		  elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		  elseif data.current.value == 'get_weapon' then
			  OpenGetWeaponMenu()
		  elseif data.current.value == 'put_weapon' then
			  OpenPutWeaponMenu()
		  end
  
		end,
		function(data, menu)
  
		  menu.close()
  
		  CurrentAction     = 'menu_stocks'
		  CurrentActionMsg  = _U('open_stocks')
		  CurrentActionData = {station = station}
		end
	 )
  end

  function OpenGetStocksMenu()

	ESX.TriggerServerCallback('jek_policejob:getStockItems', function(items)
  
  
	  local elements = {}
  
	  for i=1, #items, 1 do
		table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'stocks_menu',
		{
		  title    = _U('police_stock'),
		  align    = 'left',
		  css    = 'metier',
		  elements = elements
		},
		function(data, menu)
  
		  local itemName = data.current.value
  
		  ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
			{
			  title = _U('quantity')
			},
			function(data2, menu2)
  
			  local count = tonumber(data2.value)
  
			  if count == nil then
				ESX.ShowNotification(_U('quantity_invalid'))
			  else
				menu2.close()
				menu.close()
				TriggerServerEvent('jek_policejob:getStockItem', itemName, count)
  
				Citizen.Wait(300)
				OpenGetStocksMenu()
			  end
  
			end,
			function(data2, menu2)
			  menu2.close()
			end
		  )
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
  end

  function OpenPutStocksMenu()

	ESX.TriggerServerCallback('jek_policejob:getPlayerInventory', function(inventory)
  
	  local elements = {}
  
	  for i=1, #inventory.items, 1 do
  
		local item = inventory.items[i]
  
		if item.count > 0 then
		  table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
		end
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'stocks_menu',
		{
		  title    = _U('inventory'),
		  align    = 'left',
		  css    = 'police',
		  elements = elements
		},
		function(data, menu)
  
		  local itemName = data.current.value
  
		  ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
			{
			  title = _U('quantity')
			},
			function(data2, menu2)
  
			  local count = tonumber(data2.value)
  
			  if count == nil then
				ESX.ShowNotification(_U('quantity_invalid'))
			  else
				menu2.close()
				menu.close()
				TriggerServerEvent('jek_policejob:putStockItems', itemName, count)
  
				Citizen.Wait(300)
				OpenPutStocksMenu()
			  end
  
			end,
			function(data2, menu2)
			  menu2.close()
			end)
		end,
		function(data, menu)
		  menu.close()
		end)
	end)
  end

  function OpenGetWeaponMenu()

	ESX.TriggerServerCallback('jek_policejob:getArmoryWeapons', function(weapons)
  
	  local elements = {}
  
	  for i=1, #weapons, 1 do
		if weapons[i].count > 0 then
		  table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
		end
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory_get_weapon',
		{
		  title    = _U('get_weapon_menu'),
		  align    = 'left',
		  css    = 'metier',
		  elements = elements
		},
		function(data, menu)
  
		  menu.close()
  
		  ESX.TriggerServerCallback('jek_policejob:removeArmoryWeapon', function()
			OpenGetWeaponMenu()
		  end, data.current.value)
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
  end
  
  function OpenPutWeaponMenu()
  
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()
  
	for i=1, #weaponList, 1 do
  
	  local weaponHash = GetHashKey(weaponList[i].name)
  
	  if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
		table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
	  end
  
	end
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'armory_put_weapon',
	  {
		title    = _U('put_weapon_menu'),
		align    = 'left',
		css    = 'metier',
		elements = elements
	  },
	  function(data, menu)
  
		menu.close()
  
		ESX.TriggerServerCallback('jek_policejob:addArmoryWeapon', function()
		  OpenPutWeaponMenu()
		end, data.current.value, true)
  
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  
  end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
--	Citizen.Wait(5000)
--	TriggerServerEvent('jek_policejob:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'police',
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
	}
	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end) 


AddEventHandler('jek_policejob:hasEnteredMarker', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'Stocks' then
    CurrentAction     = 'menu_stocks'
    CurrentActionMsg  = _U('open_stocks')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'HelicopterSpawner' then

    local helicopters = Config.PoliceStation[station].Helicopters

    if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then

		ESX.Game.SpawnVehicle('polmav', helicopters[partNum].SpawnPoint, helicopters[partNum].Heading, function(vehicle)
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle, 0)
		  end)
	end

	if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint2.x, helicopters[partNum].SpawnPoint2.y, helicopters[partNum].SpawnPoint2.z,  3.0) then
		ESX.Game.SpawnVehicle('polmav', helicopters[partNum].SpawnPoint2, helicopters[partNum].Heading, function(vehicle)
        	SetVehicleModKit(vehicle, 0)
        	SetVehicleLivery(vehicle, 0)
      	  end)
	end
  end

  if part == 'HelicopterSpawner2' then

    local helicopters = Config.PoliceStation[station].Helicopters

	if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint3.x, helicopters[partNum].SpawnPoint3.y, helicopters[partNum].SpawnPoint3.z,  3.0) then
		  ESX.Game.SpawnVehicle('polmav', helicopters[partNum].SpawnPoint3, helicopters[partNum].Heading2, function(vehicle)
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle, 0)
		  end)
	end
  end


 

  if part == 'VehicleDeleter' then

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('jek_policejob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('jek_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('jek_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('jek_policejob:getarrested')
AddEventHandler('jek_policejob:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	IsHandcuffed = true
	TriggerEvent('jek_policejob:handcuff')
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('jek_policejob:doarrested')
AddEventHandler('jek_policejob:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 

RegisterNetEvent('jek_policejob:douncuffing')
AddEventHandler('jek_policejob:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('jek_policejob:getuncuffed')
AddEventHandler('jek_policejob:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	TriggerEvent('jek_policejob:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('jek_policejob:requestarrest')
AddEventHandler('jek_policejob:requestarrest', function()
	IsHandcuffed = not IsHandcuffed
	local playerPed = PlayerPedId()
	

	Citizen.CreateThread(function()
		if IsHandcuffed then
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player

		else
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)


		end
	end)

end)

RegisterNetEvent('jek_policejob:unrestrain')
AddEventHandler('jek_policejob:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

	end
end)

RegisterNetEvent('jek_policejob:drag')
AddEventHandler('jek_policejob:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('jek_policejob:Bracelet')
AddEventHandler('jek_policejob:Bracelet', function(playerheading, playercoords, playerlocation, type)

	local x, y, z   = table.unpack(playercoords + playerlocation * 0.8)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(500)
	TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_GUARD_STAND', 0, true)
	Citizen.Wait(200)
	ClearPedTasks(GetPlayerPed(-1))
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
	if type == "give" then
		TriggerServerEvent('jek_policejob:GiveBracelet', GetPlayerServerId(closestPlayer))
	elseif type == "remove" then
		TriggerServerEvent('jek_policejob:RemoveBracelet', GetPlayerServerId(closestPlayer))
	end
end
end)

RegisterNetEvent('jek_policejob:PlBracelet2')
AddEventHandler('jek_policejob:PlBracelet2', function()

	loadanimdict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 8.0, -8,3750, 2, 0, 20, 0, 0)
end)


RegisterNetEvent('jek_policejob:putInVehicle')
AddEventHandler('jek_policejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then

			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end

		end

	end
end)

RegisterNetEvent('jek_policejob:OutVehicle')
AddEventHandler('jek_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsHandcuffed then
			--DisableControlAction(2, 1, true) -- Disable pan
			DisableControlAction(2, 2, true) -- Disable tilt
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['SPACE'], true) -- Jump
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['F10'], true) -- Animations
			DisableControlAction(2, Keys['V'], true) -- Disable changing view
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
			DisableControlAction(2, 59, true) -- Disable steering in vehicle
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
			DisableControlAction(2, Keys['LEFTALT'], true) -- Disable LEFTALT
			DisableControlAction(2, Keys['X'], true) -- Disable LEFTALT
			DisableControlAction(0, 44, true)  -- X
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()

  for k,v in pairs(Config.PoliceStation) do

    local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

    SetBlipSprite (blip, v.Blip.Sprite)
    --SetBlipDisplay(blip, v.Blip.Display)
    SetBlipScale  (blip, v.Blip.Scale)
    SetBlipColour (blip, v.Blip.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('map_blip'))
    EndTextCommandSetBlipName(blip)
  end
end)





-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

      local playerPed = PlayerPedId()
      local coords    = GetEntityCoords(playerPed)

      for k,v in pairs(Config.PoliceStation) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
            DrawMarker(20, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, true, false, 2, true, false, false, false)
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
            DrawMarker(20, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.2, 0.2, 0.2, 101, 240, 55, 100, false, true, 2, true, false, false, false)
          end
		end
		
		for i=1, #v.Stocks, 1 do
			if GetDistanceBetweenCoords(coords,  v.Stocks[i].x,  v.Stocks[i].y,  v.Stocks[i].z,  true) < Config.DrawDistance then
			  DrawMarker(6, v.Stocks[i].x, v.Stocks[i].y, v.Stocks[i].z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.5, 2.0, 1.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
		  end
		end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            DrawMarker(36, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 68, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            DrawMarker(36, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
          end
        end

        if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end
        end
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

  while true do
    Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

      local playerPed      = PlayerPedId()
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.PoliceStation) do

        for i=1, #v.Cloakrooms, 1 do
		  if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < 2.0 then
			DrawMarker(20, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, true, false, 2, true, false, false, false)
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < 0.5 then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
		end
		
		for i=1, #v.Stocks, 1 do
			if GetDistanceBetweenCoords(coords,  v.Stocks[i].x,  v.Stocks[i].y,  v.Stocks[i].z,  true) < Config.MarkerSize.x then
			  isInMarker     = true
			  currentStation = k
			  currentPart    = 'Stocks'
			  currentPartNum = i
		  end
		end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.Helicopters, 1 do

			if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'HelicopterSpawner'
				currentPartNum = i
			  end

			  if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner2.x,  v.Helicopters[i].Spawner2.y,  v.Helicopters[i].Spawner2.z,  true) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'HelicopterSpawner2'
				currentPartNum = i
			  end

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].SpawnPoint.x,  v.Helicopters[i].SpawnPoint.y,  v.Helicopters[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawnPoint'
            currentPartNum = i
          end

        end


        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end

          

        end

      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('jek_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('jek_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('jek_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end

    end

  end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				
				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_stocks' then
					OpenStocksMenu()
				elseif CurrentAction == 'menu_armory' then
					if Config.MaxInService == -1 then
						OpenArmoryMenu(CurrentActionData.station)
					elseif playerInService then
						OpenArmoryMenu(CurrentActionData.station)
					else
						ESX.ShowNotification("Vous n'êtes pas en service !")
					end
				elseif CurrentAction == 'menu_vehicle_spawner' then
					if playerInService then 
					OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
					else 
						ESX.ShowNotification("Vous n'êtes pas en service !.")
					end	
				elseif CurrentAction == 'delete_vehicle' then
					TaskLeaveAnyVehicle(GetPlayerPed(-1), 1, 1)
					Wait(2000)
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					ESX.ShowAdvancedNotification("LSPD CENTRAL", "~b~Garage LSPD", "Votre véhicule de service a bien été ranger.", "CHAR_CALL911", 8)
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu1', 'police', function(data, menu)
						menu.close()
						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = false }) -- disable washing money
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
					
				end
				
				CurrentAction = nil
			end
		end -- CurrentAction end

		if IsControlJustReleased(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
			if Config.MaxInService == -1 then
				OpenPoliceActionsMenu()
			elseif playerInService then
				OpenPoliceActionsMenu()
			else
				ESX.ShowNotification("Vous n'êtes pas en service !")
			end
		end
		
		if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(CurrentTask.Task)
			ClearPedTasks(PlayerPedId())
			
			CurrentTask.Busy = false
		end
	end
end)

--[[
-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)
	local name = GetPlayerName(id)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		--SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		--SetBlipAsShortRange(blip, true)
		SetBlipShowCone(blip, true)
		SetBlipShrink(blip, true)
		ShowFriendIndicatorOnBlip(blip, true)
		BeginTextCommandSetBlipName("STRING")
    	AddTextComponentString("~b~Agent: ~w~"..name)
    	EndTextCommandSetBlipName(blip)
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('jek_policejob:updateBlip')
AddEventHandler('jek_policejob:updateBlip', function()
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
	
	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end
	
	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)--]]

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('jek_policejob:unrestrain')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('jek_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('jek_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('esx_service:disableService', 'police')
		end
	end
end)

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    if IsPedInAnyVehicle(playerPed, true) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    end
    local entity = vehicle
    carModel = GetEntityModel(entity)
    carName = GetDisplayNameFromVehicleModel(carModel)
    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity)) then 
        DeleteEntity(entity)
    end 
end

function openJailMenu(playerid)
  local elements = {
    {label = "Cellule 1",     value = 'JailPoliceStation1'},
	{label = "Cellule 2",     value = 'JailPoliceStation2'},
	{label = "Cellule 3",     value = 'JailPoliceStation3'},
	{label = "Cellule 4",     value = 'JailPoliceStation4'},
	{label = "Cellule 5",     value = 'JailPoliceStation5'},
    {label = "Libérer de cellule",     value = 'FreePlayer'},
  }
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'jail_menu',
	{
	  title    = 'Mettre en prison',
	  align    = 'top-left',
	  css		 = 'police',
	  elements = elements,
	},
	function(data3, menu)
		if data3.current.value ~= "FreePlayer" then
			maxLength = 4
			AddTextEntry('FMMC_KEY_TIP8', "Nombre de minutes en prison")
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", maxLength)
			ESX.ShowNotification("~b~Entrez le nombre de minutes que vous voulez mettre la personne en prison.")
			blockinput = true

			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				Citizen.Wait( 0 )
			end

			local jailtime = GetOnscreenKeyboardResult()

			UnblockMenuInput()

			if string.len(jailtime) >= 1 and tonumber(jailtime) ~= nil then
				TriggerServerEvent('esx_jb_jailer:PutInJail', playerid, data3.current.value, tonumber(jailtime)*60)
			else
				return false
			end
		else
			TriggerServerEvent('esx_jb_jailer:UnJailplayer', playerid)
		end
	end,
	function(data3, menu)
	  menu.close()
	end
  )
end

function UnblockMenuInput()
    Citizen.CreateThread(function()
        Citizen.Wait(150)
        blockinput = false
	end)
end

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end