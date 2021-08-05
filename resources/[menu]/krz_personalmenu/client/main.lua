ESX = nil

function notification(title, subject, msg)

	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
  
	ESX.ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
  
	UnregisterPedheadshot(mugshot)
  
end

_menuPool = nil

local personalmenu = {}
local PlayerData


local invItem, wepItem, billItem, mainMenu, itemMenu, weaponItemMenu = {}, {}, {}, nil, nil, nil

local isDead, inAnim = false, false
local Myjob = ""
local playerGroup, noclip, godmode, visible = nil, false, false, false

local wepList = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end


    PlayerData = ESX.GetPlayerData()



	ESX.PlayerData = ESX.GetPlayerData()

	while playerGroup == nil do
		ESX.TriggerServerCallback('Menu_DVR:Admin_getUsergroup', function(group) playerGroup = group end)
		Citizen.Wait(10)
	end

	while actualSkin == nil do
		TriggerEvent('skinchanger:getSkin', function(skin) actualSkin = skin end)
		Citizen.Wait(10)
	end

	RefreshMoney()

	wepList = ESX.GetWeaponList()

	_menuPool = NativeUI.CreatePool()
	

	mainMenu = NativeUI.CreateMenu(Config.servername, "Menu personnel",8, 200, "", "", nil,100,0,0,255)
	itemMenu = NativeUI.CreateMenu(Config.servername, "Inventaire :",8, 200, "", "", nil,100,0,0,255)
	weaponItemMenu = NativeUI.CreateMenu(Config.servername, "Arme :",8, 200, "", "", nil,100,0,0,255)
	_menuPool:Add(mainMenu)
	_menuPool:Add(itemMenu)
	_menuPool:Add(weaponItemMenu)
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
	_menuPool:CloseAllMenus()
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx_ambulancejob:multicharacter', function()
	isDead = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshMoney()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	RefreshMoney2()
end)

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSocietyMoney(money)
		end, ESX.PlayerData.job.name)
	end
end

function RefreshMoney2()
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSocietyMoney2(money)
			print(money)
		end, ESX.PlayerData.job2.name)
	end
end


RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		UpdateSocietyMoney(money)
	end

	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		UpdateSocietyMoney2(money)
	end
end)

function UpdateSocietyMoney(money)
	societymoney = ESX.Math.GroupDigits(money)
end

function UpdateSocietyMoney2(money)
	print(money)
	societymoney2 = ESX.Math.GroupDigits(money)
end

--Message text joueur
function Text(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(0)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.017, 0.977)
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
		blockinput = false
        return result
    else
        Citizen.Wait(500)
		blockinput = false
        return nil
    end
end

-- Weapon Menu --

RegisterNetEvent("Menu_DVR:Weapon_addAmmoToPedC")
AddEventHandler("Menu_DVR:Weapon_addAmmoToPedC", function(value, quantity)
	local weaponHash = GetHashKey(value)

	if HasPedGotWeapon(plyPed, weaponHash, false) and value ~= 'WEAPON_UNARMED' then
		AddAmmoToPed(plyPed, value, quantity)
	end
end)

-- Admin Menu --

RegisterNetEvent('Menu_DVR:Admin_BringC')
AddEventHandler('Menu_DVR:Admin_BringC', function(plyPedCoords)
	SetEntityCoords(plyPed, plyPedCoords)
end)

-- GOTO JOUEUR
function admin_tp_toplayer()
	local plyId = KeyboardInput("KORIOZ_BOX_ID", _U('dialogbox_playerid'), "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			local targetPlyCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(plyId)))
			SetEntityCoords(plyPed, targetPlyCoords)
		end
	end
end
-- FIN GOTO JOUEUR

-- TP UN JOUEUR A MOI
function admin_tp_playertome()
	local plyId = KeyboardInput("KORIOZ_BOX_ID", _U('dialogbox_playerid'), "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			local plyPedCoords = GetEntityCoords(plyPed)
			TriggerServerEvent('Menu_DVR:Admin_BringS', plyId, plyPedCoords)
		end
	end
end
-- FIN TP UN JOUEUR A MOI

-- TP A POSITION
function admin_tp_pos()
	local pos = KeyboardInput("KORIOZ_BOX_XYZ", _U('dialogbox_xyz'), "", 50)

	if pos ~= nil and pos ~= '' then
		local _, _, x, y, z = string.find(pos, "([%d%.]+) ([%d%.]+) ([%d%.]+)")

		if x ~= nil and y ~= nil and z ~= nil then
			SetEntityCoords(plyPed, x + .0, y + .0, z + .0)
		end
	end
end
-- FIN TP A POSITION

-- FONCTION NOCLIP 
function admin_no_clip()
	noclip = not noclip

	if noclip then
		SetEntityInvincible(plyPed, true)
		SetEntityVisible(plyPed, false, false)
		notification("NoClip", "Administration", "NoClip ~g~Activé")
	else
		SetEntityInvincible(plyPed, false)
		SetEntityVisible(plyPed, true, false)
		notification("NoClip", "Administration", "NoClip ~r~Désactivé")
	end
end



function getPosition()
	local x, y, z = table.unpack(GetEntityCoords(plyPed, true))

	return x, y, z
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(plyPed)
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading * math.pi/180.0)
	local y = math.cos(heading * math.pi/180.0)
	local z = math.sin(pitch * math.pi/180.0)

	local len = math.sqrt(x * x + y * y + z * z)

	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end

	return x, y, z
end

function isNoclip()
	return noclip
end

local timer = 10000
function course()
	if course then
		SetEntityInvincible(plyPed, true)
		SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
		SetSuperJumpThisFrame(PlayerId())
		Wait(timer)
		SetEntityInvincible(plyPed, false)
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end



-- FIN NOCLIP

-- GOD MODE
function admin_godmode()
	godmode = not godmode

	if godmode then
		SetEntityInvincible(plyPed, true)
		notification("GodMode", "Administration", "GodMode ~g~Activé")
	else
		SetEntityInvincible(plyPed, false)
		notification("GodMode", "Administration", "GodMode ~r~Désactivé")
	end
end
-- FIN GOD MODE

-- INVISIBLE
function admin_mode_fantome()
	invisible = not invisible

	if invisible then
		SetEntityVisible(plyPed, false, false)
		notification("Invisible", "Administration", "Mode Fantôme ~g~Activé")
	else
		SetEntityVisible(plyPed, true, false)
		notification("Invisible", "Administration", "Mode Fantôme ~r~Désactivé")
	end
end
-- FIN INVISIBLE

-- Réparer vehicule
function admin_vehicle_repair()
	local car = GetVehiclePedIsIn(plyPed, false)

	SetVehicleFixed(car)
	SetVehicleDirtLevel(car, 0.0)
end
-- FIN Réparer vehicule

-- Spawn vehicule
function admin_vehicle_spawn()
	local vehicleName = KeyboardInput("KORIOZ_BOX_VEHICLE_NAME", _U('dialogbox_vehiclespawner'), "", 50,8, 200, "", "", nil,100,0,0,255)

	if vehicleName ~= nil then
		vehicleName = tostring(vehicleName)
		
		if type(vehicleName) == 'string' then
			local car = GetHashKey(vehicleName)
				
			Citizen.CreateThread(function()
				RequestModel(car)

				while not HasModelLoaded(car) do
					Citizen.Wait(0)
				end

				local x, y, z = table.unpack(GetEntityCoords(plyPed, true))

				local veh = CreateVehicle(car, x, y, z, 0.0, true, false)
				local id = NetworkGetNetworkIdFromEntity(veh)

				SetEntityVelocity(veh, 2000)
				SetVehicleOnGroundProperly(veh)
				SetVehicleHasBeenOwnedByPlayer(veh, true)
				SetNetworkIdCanMigrate(id, true)
				SetVehRadioStation(veh, "OFF")
				SetPedIntoVehicle(plyPed, veh, -1)
			end)
		end
	end
end
-- FIN Spawn vehicule

-- flipVehicle
function admin_vehicle_flip()
	local plyCoords = GetEntityCoords(plyPed)
	local closestCar = GetClosestVehicle(plyCoords['x'], plyCoords['y'], plyCoords['z'], 10.0, 0, 70)
	local plyCoords = plyCoords + vector3(0, 2, 0)

	SetEntityCoords(closestCar, plyCoords)

	notification("Flip Véhicule", "Administration", "Retournement du véhicule ~g~effectué")
end
-- FIN flipVehicle

-- GIVE DE L'ARGENT
function admin_give_money()
	local amount = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 15)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('Menu_DVR:Admin_giveCash', amount)
		end
	end
end
-- FIN GIVE DE L'ARGENT

-- GIVE DE L'ARGENT EN BANQUE
function admin_give_bank()
	local amount = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('Menu_DVR:Admin_giveBank', amount)
		end
	end
end
-- FIN GIVE DE L'ARGENT EN BANQUE

-- GIVE DE L'ARGENT SALE
function admin_give_dirty()
	local amount = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('Menu_DVR:Admin_giveDirtyMoney', amount)
		end
	end
end
-- FIN GIVE DE L'ARGENT SALE

-- Afficher Coord
function modo_showcoord()
	showcoord = not showcoord
end
-- FIN Afficher Coord

-- Afficher Nom
function modo_showname()
	showname = not showname
end
-- FIN Afficher Nom

-- TP MARKER
function admin_tp_marker()
	local WaypointHandle = GetFirstBlipInfoId(8)

	if DoesBlipExist(WaypointHandle) then
		local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

				break
			end

			Citizen.Wait(0)
		end

		notification("Téléportation", "Administration", "Téléportation ~g~Effectuée")
	else
		notification("Téléportation", "Administration", "Aucun ~r~Marqueur")
	end
end
-- FIN TP MARKER

-- HEAL JOUEUR
function admin_heal_player()
	local plyId = KeyboardInput("KORIOZ_BOX_ID", _U('dialogbox_playerid'), "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			TriggerServerEvent('esx_ambulancejob:revive1', plyId)
		end
	end
end
-- FIN HEAL JOUEUR

function changer_skin()
	_menuPool:CloseAllMenus()
	Citizen.Wait(100)
	TriggerEvent('esx_skin:openSaveableMenu', source)
end





function save_skin()
	TriggerEvent('esx_skin:requestSaveSkin', source)
end

function startAttitude(lib, anim)
	Citizen.CreateThread(function()
		RequestAnimSet(anim)

		while not HasAnimSetLoaded(anim) do
			Citizen.Wait(0)
		end

		SetPedMotionBlur(plyPed, false)
		SetPedMovementClipset(plyPed, anim, true)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
	end)
end

function startScenario(anim)
	TaskStartScenarioInPlace(plyPed, anim, 0, false)
end










function AddMenuWeaponMenu(menu)
	weaponMenu = _menuPool:AddSubMenu(menu, _U('loadout_title'), "", 50,8, 200, "", "", nil,100,0,0,255)

	for i = 1, #wepList, 1 do
		local weaponHash = GetHashKey(wepList[i].name)

		if HasPedGotWeapon(plyPed, weaponHash, false) and wepList[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(plyPed, weaponHash)
			local label = wepList[i].label .. ' [' .. ammo .. ']'
			local value = wepList[i].name

			wepItem[value] = NativeUI.CreateItem(label, '')
			weaponMenu.SubMenu:AddItem(wepItem[value])
		end
	end

	local giveItem = NativeUI.CreateItem(_U('loadout_give_button'), "", 50, 8, 200,255,nil,nil)
	weaponItemMenu:AddItem(giveItem)

	local giveMunItem = NativeUI.CreateItem(_U('loadout_givemun_button'), "", 50,8, 200, "", "", nil,100,0,0,255)
	weaponItemMenu:AddItem(giveMunItem)

	local dropItem = NativeUI.CreateItem(_U('loadout_drop_button'), "", 50,8, 200, "", "", nil,100,0,0,255)
	dropItem:SetRightBadge(4)
	weaponItemMenu:AddItem(dropItem)

	weaponMenu.SubMenu.OnItemSelect = function(sender, item, index)
		_menuPool:CloseAllMenus(true)
		weaponItemMenu:Visible(true)

		for i = 1, #wepList, 1 do
			local weaponHash = GetHashKey(wepList[i].name)

			if HasPedGotWeapon(plyPed, weaponHash, false) and wepList[i].name ~= 'WEAPON_UNARMED' then
				local ammo = GetAmmoInPedWeapon(plyPed, weaponHash)
				local value = wepList[i].name
				local label = wepList[i].label

				if item == wepItem[value] then
					weaponItemMenu.OnItemSelect = function(sender, item, index)
						if item == giveItem then
							local foundPlayers = false
							personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

							if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
								foundPlayers = true
							end

							if foundPlayers == true then
								local closestPed = GetPlayerPed(personalmenu.closestPlayer)

								if not IsPedSittingInAnyVehicle(closestPed) then
									TriggerServerEvent('esx:giveInventoryItem1', GetPlayerServerId(personalmenu.closestPlayer), 'item_weapon', value, ammo)
									_menuPool:CloseAllMenus()
								else
									ESX.ShowNotification(_U('in_vehicle_give', label))
								end
							else
								ESX.ShowNotification(_U('players_nearby'))
							end
						elseif item == giveMunItem then
							local quantity = KeyboardInput('KORIOZ_BOX_AMMO_AMOUNT', _U('dialogbox_amount_ammo'), '', 8)

							if quantity ~= nil then
								local post = true
								quantity = tonumber(quantity)

								if type(quantity) == 'number' then
									quantity = ESX.Math.Round(quantity)

									if quantity <= 0 then
										post = false
									end
								end

								local foundPlayers = false
								personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

								if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
									foundPlayers = true
								end

								if foundPlayers == true then
									local closestPed = GetPlayerPed(personalmenu.closestPlayer)

									if not IsPedSittingInAnyVehicle(closestPed) then
										if ammo > 0 then
											if post == true then
												if quantity <= ammo and quantity >= 0 then
													local finalAmmo = math.floor(ammo - quantity)
													SetPedAmmo(plyPed, value, finalAmmo)
													TriggerServerEvent('KorioZ-PersonalMenu:Weapon_addAmmoToPedS', GetPlayerServerId(personalmenu.closestPlayer), value, quantity)

													ESX.ShowNotification(_U('gave_ammo', quantity, GetPlayerName(personalmenu.closestPlayer)))
													_menuPool:CloseAllMenus()
												else
													ESX.ShowNotification(_U('not_enough_ammo'))
												end
											else
												ESX.ShowNotification(_U('amount_invalid'))
											end
										else
											ESX.ShowNotification(_U('no_ammo'))
										end
									else
										ESX.ShowNotification(_U('in_vehicle_give', label))
									end
								else
									ESX.ShowNotification(_U('players_nearby'))
								end
							end
						elseif item == dropItem then
							if not IsPedSittingInAnyVehicle(plyPed) then
								TriggerServerEvent('esx:removeInventoryItem1', 'item_weapon', value)
								_menuPool:CloseAllMenus()
							else
								ESX.ShowNotification(_U('in_vehicle_drop', label))
							end
						end
					end
				end
			end
		end
	end
end



function AddMenuWalletMenu(menu)
	local currentWeight = 0
	for k,v in ipairs(ESX.PlayerData.inventory) do 
		if v.count > 0 then
	 currentWeight = currentWeight + (v.weight * v.count)
		end
	end
		poid = currentWeight
	
	if poid < 15000 then 
	   Texte = "~b~".. poid/1000 .." ~s~/~r~ 35 KG" 
	elseif poid >= 15000 and poid < 27000 then
	   Texte = "~o~".. poid/1000 .." ~s~/~r~ 35 KG"    
	else
		 Texte = "~r~".. poid/1000 .." ~s~/~r~ 35 KG" 
	end 
	personalmenu.moneyOption = {
		_U('wallet_option_give'),
		_U('wallet_option_drop')
	}

	walletmenu = _menuPool:AddSubMenu(menu, "Mes Poches","",8, 200, "", "", nil,100,0,0,255)


	local inventaire = NativeUI.CreateItem("Inventaire ( " .. Texte .."~s~ )", "", 50,8, 200, "", "", nil,100,0,0,255)
	walletmenu.SubMenu:AddItem(inventaire)

	local walletJob = NativeUI.CreateItem(_U('wallet_job_button', ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label), "")
	walletmenu.SubMenu:AddItem(walletJob)
	local walletJob2 = NativeUI.CreateItem(_U('wallet_job2_button', ESX.PlayerData.job2.label, ESX.PlayerData.job2.grade_label), "")
	walletmenu.SubMenu:AddItem(walletJob2)

	local showID = nil
	local showDriver = nil
	local showFirearms = nil
	local checkID = nil
	local checkDriver = nil
	local checkFirearms = nil
	local serverID = GetPlayerServerId(PlayerId())

	if Config.EnableJsfourIDCard then
		--showID = NativeUI.CreateItem(_U('wallet_show_idcard_button'), "")
		--walletmenu.SubMenu:AddItem(showID)
		_menuPool:WidthOffset(80)

		--checkID = NativeUI.CreateItem(_U('wallet_check_idcard_button'), "")
		--walletmenu.SubMenu:AddItem(checkID)

		showDriver = NativeUI.CreateItem(_U('wallet_show_driver_button'), "")
        walletmenu.SubMenu:AddItem(showDriver)
       
        checkDriver = NativeUI.CreateItem(_U('wallet_check_driver_button'), "")
		walletmenu.SubMenu:AddItem(checkDriver)

		showFirearms = NativeUI.CreateItem('Montrer votre license d\'arme', "")
		walletmenu.SubMenu:AddItem(showFirearms)

		checkWeapon = NativeUI.CreateItem('Regarder votre license d\'arme', "")
		walletmenu.SubMenu:AddItem(checkWeapon)

		val = NativeUI.CreateItem('Regardez si vous avez la visite médicale', "")
		walletmenu.SubMenu:AddItem(val)
		
		

	end

	local ID = NativeUI.CreateColouredItem("Vos informations", Description, Colours.RedDark, Colours.White)
	walletmenu.SubMenu:AddItem(ID)

	walletmenu.SubMenu.OnItemSelect = function(sender, item, index)
		if Config.EnableJsfourIDCard then
			if item == showID then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer))
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			elseif item == checkID then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			elseif item == ID then
				player = {}
				local serverID = GetPlayerServerId(PlayerId())
					players = {}
				for i = 0, 256 do
					if NetworkIsPlayerActive( i ) then
						table.insert( players, i )
					end
				end
				ESX.ShowNotification("Votre ID est le " .. serverID .. " ~b~∑")
				ESX.ShowNotification("Il y a actuellement  " .. #players .. " joueurs(s) connecté(s)")
			elseif item == showDriver then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'driver')
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			elseif item == inventaire then
				ESX.ShowInventory()
				_menuPool:CloseAllMenus()
			elseif item == checkDriver then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
			elseif item == checkWeapon then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
			elseif item == showFirearms then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'weapon')
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			elseif item == val then
				ESX.TriggerServerCallback('jek:checkVisite', function(cb)            
					if cb then
						ESX.ShowNotification("~g~Tu as ta visite médicale.")
					else 
						ESX.ShowNotification("~r~Tu n'as pas ta visite médicale.")
					end
				end)
			end							
		end
	end

	walletmenu.SubMenu.OnListSelect = function(sender, item, index)
		if index == 1 then
			local quantity = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

			if quantity ~= nil then
				local post = true
				quantity = tonumber(quantity)

				if type(quantity) == 'number' then
					quantity = ESX.Math.Round(quantity)

					if quantity <= 0 then
						post = false
					end
				end

				local foundPlayers = false
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
					foundPlayers = true
				end

				if foundPlayers == true then
					local closestPed = GetPlayerPed(personalmenu.closestPlayer)

					if not IsPedSittingInAnyVehicle(closestPed) then
						if post == true then
							if item == walletMoney then
								TriggerServerEvent('esx:giveInventoryItem1', GetPlayerServerId(personalmenu.closestPlayer), 'item_money', 'money', quantity)
								_menuPool:CloseAllMenus()
							elseif item == walletdirtyMoney then
								TriggerServerEvent('esx:giveInventoryItem1', GetPlayerServerId(personalmenu.closestPlayer), 'item_account', 'black_money', quantity)
								_menuPool:CloseAllMenus()
							end
						else
							ESX.ShowNotification(_U('amount_invalid'))
						end
					else
						if item == walletMoney then
							notification("Portefeuilles", "Notification", _U('in_vehicle_give', 'de l\'argent'))
							elseif item == walletdirtyMoney then
							notification("Portefeuilles", "Notification", _U('in_vehicle_give', 'de l\'argent sale'))
						end
					end
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			end
		elseif index == 2 then
			local quantity = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

			if quantity ~= nil then
				local post = true
				quantity = tonumber(quantity)

				if type(quantity) == 'number' then
					quantity = ESX.Math.Round(quantity)

					if quantity <= 0 then
						post = false
					end
				end
			end
		end
	end
end

-----------

function AddActionMenu(menu)
	local actionmenu = _menuPool:AddSubMenu(mainMenu, "Actions","",8, 200, "", "", nil,100,0,0,255)
	local por = NativeUI.CreateItem("Porter la personne","")
	actionmenu.SubMenu:AddItem(por)

	local por2 = NativeUI.CreateItem("Porter la personne sur son dos", "")
	actionmenu.SubMenu:AddItem(por2)

	local otage = NativeUI.CreateColouredItem("Prendre en otage la personne", Description, Colours.RedDark, Colours.White)
	actionmenu.SubMenu:AddItem(otage)

	actionmenu.SubMenu.OnItemSelect = function(menu, item)
		if item == por then
			TriggerEvent("carry:anim")
			_menuPool:CloseAllMenus()
		elseif item == por2 then
			TriggerEvent("carry2:anim")
			_menuPool:CloseAllMenus()
		elseif item == otage then
			TriggerEvent("carry3:anim")
			_menuPool:CloseAllMenus()
		else
			ESX.ShowNotification("Il te faut une arme")
		end
	end
end

local hasCinematic = false
-- Hide/Show HUD
local interface = true
local isPaused = false
function openInterface()
interface = not interface
	if interface then -- shown
		DisplayRadar(true)
		isPaused = true 
		displayHud = true
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('esx_status:setDisplay', 1.0)
		
	elseif not interface then -- hidden
		DisplayRadar(false)
		isPaused = false 
		displayHud = false
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
	end
end

function AddVracMenu(menu)
	local hasCinematic = false

    local diversmenu = _menuPool:AddSubMenu(mainMenu, "Divers","",8, 200, "", "", nil,100,0,0,255)
	_menuPool:WidthOffset(80)
	local car = NativeUI.CreateItem("Mes Véhicules", "")
	diversmenu.SubMenu:AddItem(car)

	local cle = NativeUI.CreateItem("Mes Clefs", "")
	diversmenu.SubMenu:AddItem(cle)

	local sim = NativeUI.CreateItem("Mes cartes sim", "")
	diversmenu.SubMenu:AddItem(sim)

	local acc = NativeUI.CreateItem("Mes Accessoires", "")
	diversmenu.SubMenu:AddItem(acc)

	local ani = NativeUI.CreateItem("Mes Animations", "")
	diversmenu.SubMenu:AddItem(ani)

	local hud = NativeUI.CreateItem("Afficher | Cacher - l'HUD", "")
	diversmenu.SubMenu:AddItem(hud)

	local cinema = NativeUI.CreateItem("Mode Cinematique", "")
	diversmenu.SubMenu:AddItem(cinema)

	local save = NativeUI.CreateColouredItem("Sauvegarder sa position", Description, Colours.GreenDark, Colours.Green)
	diversmenu.SubMenu:AddItem(save)
	
	diversmenu.SubMenu.OnItemSelect = function(menu, item)
		if item == car then
			_menuPool:CloseAllMenus()
			TriggerEvent("garage:ListVehicle")
		elseif item == cle then
			OpenKeyMenu()
			_menuPool:CloseAllMenus()
		elseif item == sim then
			TriggerEvent('NB:carteSIM')
			_menuPool:CloseAllMenus()
		elseif item == acc then
			TriggerEvent("acc:openMenu")
			_menuPool:CloseAllMenus()
		elseif item == ani then
			TriggerEvent("dp:RecieveMenu")
			_menuPool:CloseAllMenus()
		elseif item == hud then
			openInterface()
			_menuPool:CloseAllMenus()
		elseif item == cinema then
			TriggerEvent('cinema:open')
		elseif item == save then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local playerHeading = ESX.Math.Round(GetEntityHeading(playerPed), 1)
            local formattedCoords = {x = ESX.Math.Round(playerCoords.x, 1), y = ESX.Math.Round(playerCoords.y, 1), z = ESX.Math.Round(playerCoords.z, 1), heading = playerHeading}
            TriggerServerEvent('esx:updateCoords', formattedCoords)
			ESX.ShowNotification('~g~Position sauvegarder')
		--elseif item == skin then
		--	TriggerEvent('esx_skin:getLastSkin', function(skin)
		--		TriggerEvent('skinchanger:loadSkin', skin)
		--	end)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPauseMenuActive() then
			ESX.UI.HUD.SetDisplay(0.0)
		elseif hasCinematic == true then
			ESX.UI.HUD.SetDisplay(0.0)
		end
	end
end)

function opencinema()
	hasCinematic = not hasCinematic
	if hasCinematic == true then
		DisplayRadar(false)
		SendNUIMessage({openCinema = true})
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('es:setMoneyDisplay', 0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
	else
		DisplayRadar(true)
		SendNUIMessage({openCinema = false})
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('es:setMoneyDisplay', 1.0)
		TriggerEvent('esx_status:setDisplay', 1.0)
	end
end

RegisterNetEvent('cinema:open')
AddEventHandler('cinema:open', function()
	opencinema()
end)



function AddMenuFacturesMenu(menu)
	billMenu = _menuPool:AddSubMenu(menu, "Factures","",8, 200, "", "", nil,100,0,0,255)
	billItem = {}

	ESX.TriggerServerCallback('Menu_DVR:Bill_getBills', function(bills)
		for i = 1, #bills, 1 do
			local label = bills[i].label
			local amount = bills[i].amount
			local value = bills[i].id

			table.insert(billItem, value)

			billItem[value] = NativeUI.CreateItem(label, "")
			billItem[value]:RightLabel( ESX.Math.GroupDigits(amount).. " $")
			billMenu.SubMenu:AddItem(billItem[value])
		end
		if #bills == 0 then
			local nobill = NativeUI.CreateItem("Pas de factures", "")
			billMenu.SubMenu:AddItem(nobill)
		end

		billMenu.SubMenu.OnItemSelect = function(sender, item, index)
			for i = 1, #bills, 1 do
				local label  = bills[i].label
				local value = bills[i].id

				if item == billItem[value] then
					ESX.TriggerServerCallback('esx_billing:payBill', function()
						_menuPool:CloseAllMenus()
					end, value)
				end
			end
		end
	end)
end

function AddMenuClothesMenu(menu)
	clothesMenu = _menuPool:AddSubMenu(menu, "Vetements", "",8, 200, "", "", nil,100,0,0,255)
	local vet = NativeUI.CreateItem('~r~Mes vetements', "")
	clothesMenu.SubMenu:AddItem(vet)
	local torsoItem = NativeUI.CreateItem(_U('clothes_top'), "")
	clothesMenu.SubMenu:AddItem(torsoItem)
	_menuPool:WidthOffset(80)
	local pantsItem = NativeUI.CreateItem(_U('clothes_pants'), "")
	clothesMenu.SubMenu:AddItem(pantsItem)
	_menuPool:WidthOffset(80)
	local shoesItem = NativeUI.CreateItem(_U('clothes_shoes'), "")
	clothesMenu.SubMenu:AddItem(shoesItem)
	_menuPool:WidthOffset(80)
	local bagItem = NativeUI.CreateItem(_U('clothes_bag'), "")
	clothesMenu.SubMenu:AddItem(bagItem)
	_menuPool:WidthOffset(80)
	local bproofItem = NativeUI.CreateItem(_U('clothes_bproof'), "")
	clothesMenu.SubMenu:AddItem(bproofItem)
	_menuPool:WidthOffset(80)
	clothesMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == vet then
			Citizen.Wait(Config.Timer) --- time pour ne pas faire beug le menu
			TriggerEvent('morow:openMenu')
			_menuPool:CloseAllMenus(true)

		elseif item == torsoItem then
			setUniform('torso', plyPed)
		elseif item == pantsItem then
			setUniform('pants', plyPed)
		elseif item == shoesItem then
			setUniform('shoes', plyPed)
		elseif item == bagItem then
			setUniform('bag', plyPed)
		elseif item == bproofItem then
			setUniform('bproof', plyPed)
		end
	end
end

function setUniform(value, plyPed)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:getSkin', function(skina)
			if value == 'torso' then
				startAnimAction("clothingtie", "try_tie_neutral_a")
				Citizen.Wait(1000)
				ClearPedTasks(plyPed)

				if skin.torso_1 ~= skina.torso_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
				end
			elseif value == 'pants' then
				if skin.pants_1 ~= skina.pants_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 61, ['pants_2'] = 1})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 15, ['pants_2'] = 0})
					end
				end
			elseif value == 'shoes' then
				if skin.shoes_1 ~= skina.shoes_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 34, ['shoes_2'] = 0})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 35, ['shoes_2'] = 0})
					end
				end
			elseif value == 'bag' then
				if skin.bags_1 ~= skina.bags_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = skin.bags_1, ['bags_2'] = skin.bags_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = 0, ['bags_2'] = 0})
				end
			elseif value == 'bproof' then
				startAnimAction("clothingtie", "try_tie_neutral_a")
				Citizen.Wait(1000)
				ClearPedTasks(plyPed)

				if skin.bproof_1 ~= skina.bproof_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = skin.bproof_1, ['bproof_2'] = skin.bproof_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = 0, ['bproof_2'] = 0})
				end
			end
		end)
	end)
end

local function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result --Returns the result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function AddMenuVehicleMenu(menu)
	kodaunite = false
    if kodaunite == false then 

        kodakm = 3.6 

    else
        kodakm = 2.237
	end
	
	personalmenu.frontLeftDoorOpen = false
	personalmenu.frontRightDoorOpen = false
	personalmenu.backLeftDoorOpen = false
	personalmenu.backRightDoorOpen = false
	personalmenu.hoodDoorOpen = false
	personalmenu.trunkDoorOpen = false
	personalmenu.doorList = {
		_U('vehicle_door_frontleft'),
		_U('vehicle_door_frontright'),
		_U('vehicle_door_backleft'),
		_U('vehicle_door_backright')
	}

	vehicleMenu = _menuPool:AddSubMenu(menu,"Vehicules","",8, 200, "", "", nil,100,0,0,255)

	local vehEngineItem = NativeUI.CreateItem(_U('vehicle_engine_button'), "")
	_menuPool:WidthOffset(80)
	vehicleMenu.SubMenu:AddItem(vehEngineItem)
	local vehDoorListItem = NativeUI.CreateListItem(_U('vehicle_door_button'), personalmenu.doorList, 1)
	vehicleMenu.SubMenu:AddItem(vehDoorListItem)
	local vehHoodItem = NativeUI.CreateItem(_U('vehicle_hood_button'), "")
	vehicleMenu.SubMenu:AddItem(vehHoodItem)
	local vehTrunkItem = NativeUI.CreateItem(_U('vehicle_trunk_button'), "")
	vehicleMenu.SubMenu:AddItem(vehTrunkItem)


	local vehicle = GetVehiclePedIsIn(kodaPed, false)
	local definirItem = NativeUI.CreateItem("Définir :","Ce paramètre permettra de bloquer votre vitesse limite a 50 km")
	vehicleMenu.SubMenu:AddItem(definirItem)
	local kodaItem = NativeUI.CreateItem("Vitesse :~g~ 50 km","Ce paramètre permettra de bloquer votre vitesse limite a 50 km")
	vehicleMenu.SubMenu:AddItem(kodaItem)
	local kodaaItem = NativeUI.CreateItem("Vitesse :~g~ 80 km","Ce paramètre permettra de bloquer votre vitesse limite a 80 km")
	vehicleMenu.SubMenu:AddItem(kodaaItem)
	local kodaaaItem = NativeUI.CreateItem("Vitesse :~g~ 120 km","Ce paramètre permettra de bloquer votre vitesse limite a 120 km")
	vehicleMenu.SubMenu:AddItem(kodaaaItem)
	local kodaaaaItem = NativeUI.CreateItem("Vitesse :~g~ 150 km","Ce paramètre permettra de bloquer votre vitesse limite a 150 km")
	vehicleMenu.SubMenu:AddItem(kodaaaaItem)
	local kodaaaaaItem = NativeUI.CreateItem("Vitesse :~r~ par défault","Ce paramètre permettra de bloquer votre vitesse limite a 150 km")
	vehicleMenu.SubMenu:AddItem(kodaaaaaItem)

	vehicleMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if not IsPedSittingInAnyVehicle(plyPed) then
			ESX.ShowNotification(_U('no_vehicle'))
		elseif IsPedSittingInAnyVehicle(plyPed) then
			plyVehicle = GetVehiclePedIsIn(plyPed, false)
			if item == vehEngineItem then
				if GetIsVehicleEngineRunning(plyVehicle) then
					SetVehicleEngineOn(plyVehicle, false, false, true)
					SetVehicleUndriveable(plyVehicle, true)
				elseif not GetIsVehicleEngineRunning(plyVehicle) then
					SetVehicleEngineOn(plyVehicle, true, false, true)
					SetVehicleUndriveable(plyVehicle, false)
				end
			elseif item == vehHoodItem then
				if not personalmenu.hoodDoorOpen then
					personalmenu.hoodDoorOpen = true
					SetVehicleDoorOpen(plyVehicle, 4, false, false)
				elseif personalmenu.hoodDoorOpen then
					personalmenu.hoodDoorOpen = false
					SetVehicleDoorShut(plyVehicle, 4, false, false)
				end
			elseif item == vehTrunkItem then
				if not personalmenu.trunkDoorOpen then
					personalmenu.trunkDoorOpen = true
					SetVehicleDoorOpen(plyVehicle, 5, false, false)
				elseif personalmenu.trunkDoorOpen then
					personalmenu.trunkDoorOpen = false
					SetVehicleDoorShut(plyVehicle, 5, false, false)
				end          
			end
		end
	end

--[[	vehicleMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == definirItem then
			local vitesseKoda = KeyboardInput("Vitesse :", "", 6)
		if tonumber(vitesseKoda) == nil then
			ESX.ShowAdvancedNotification("Limitateur", "", "Veuillez inserer un nombre correct !", "CHAR_CARSITE", 1)
			return nil
		end
			SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), vitesseKoda/kodakm )
		elseif item == kodaItem then
			SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 50.0/kodakm )
		elseif item == kodaaItem then
			SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 80.0/kodakm )
		elseif item == kodaaaItem then
			SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 120.0/kodakm )
		elseif item == kodaaaaItem then
			SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 150.0/kodakm )
		elseif item == kodaaaaaItem then
			SetEntityMaxSpeed(GetVehiclePedIsIn(kodaPed, false), 1000.0/kodakm )                
		end
	end--]]


	vehicleMenu.SubMenu.OnListSelect = function(sender, item, index)
		if not IsPedSittingInAnyVehicle(plyPed) then
			ESX.ShowNotification(_U('no_vehicle'))
		elseif IsPedSittingInAnyVehicle(plyPed) then
			plyVehicle = GetVehiclePedIsIn(plyPed, false)
			if item == vehDoorListItem then
				if index == 1 then
					if not personalmenu.frontLeftDoorOpen then
						personalmenu.frontLeftDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 0, false, false)
					elseif personalmenu.frontLeftDoorOpen then
						personalmenu.frontLeftDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 0, false, false)
					end
				elseif index == 2 then
					if not personalmenu.frontRightDoorOpen then
						personalmenu.frontRightDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 1, false, false)
					elseif personalmenu.frontRightDoorOpen then
						personalmenu.frontRightDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 1, false, false)
					end
				elseif index == 3 then
					if not personalmenu.backLeftDoorOpen then
						personalmenu.backLeftDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 2, false, false)
					elseif personalmenu.backLeftDoorOpen then
						personalmenu.backLeftDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 2, false, false)
					end
				elseif index == 4 then
					if not personalmenu.backRightDoorOpen then
						personalmenu.backRightDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 3, false, false)
					elseif personalmenu.backRightDoorOpen then
						personalmenu.backRightDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 3, false, false)
					end
				end
			end
		end
	end
end

function AddMenuBossMenu(menu)
	bossMenu = _menuPool:AddSubMenu(menu, "Entreprise","", ESX.PlayerData.job.label,8, 200, "", "", nil,100,0,0,255)

	local coffreItem = nil
	_menuPool:WidthOffset(80)

	local recruterItem = NativeUI.CreateItem(_U('bossmanagement_hire_button'), "")
	bossMenu.SubMenu:AddItem(recruterItem)
	local virerItem = NativeUI.CreateItem(_U('bossmanagement_fire_button'), "")
	bossMenu.SubMenu:AddItem(virerItem)
	local promouvoirItem = NativeUI.CreateItem(_U('bossmanagement_promote_button'), "")
	bossMenu.SubMenu:AddItem(promouvoirItem)
	local destituerItem = NativeUI.CreateItem(_U('bossmanagement_demote_button'), "")
	bossMenu.SubMenu:AddItem(destituerItem)

	if societymoney ~= nil then
		--coffreItem = NativeUI.CreateItem(_U('bossmanagement_chest_button'), "")
		--coffreItem = NativeUI.CreateColouredItem( "","",Description, Colours.RedDark, Colours.White)
		coffreItem = NativeUI.CreateColouredItem("Compte de votre entreprise", Description, Colours.RedDark, Colours.White)
		coffreItem:RightLabel(societymoney.. " $")
		bossMenu.SubMenu:AddItem(coffreItem)
	end

	bossMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruterItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_recruterplayer', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.job.name, 0)
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == virerItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_virerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == promouvoirItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_promouvoirplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == destituerItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_destituerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		end
	end
end

function AddMenuBossMenu2(menu)
	bossMenu2 = _menuPool:AddSubMenu(menu, "Gestion Faction","", ESX.PlayerData.job.label,8, 200, "", "", nil,100,0,0,255)

	local coffreItem2 = nil
	_menuPool:WidthOffset(80)

	local recruterItem = NativeUI.CreateItem(_U('bossmanagement_hire_button'), "")
	bossMenu2.SubMenu:AddItem(recruterItem)
	local virerItem = NativeUI.CreateItem(_U('bossmanagement_fire_button'), "")
	bossMenu2.SubMenu:AddItem(virerItem)
	local promouvoirItem = NativeUI.CreateItem(_U('bossmanagement_promote_button'), "")
	bossMenu2.SubMenu:AddItem(promouvoirItem)
	local destituerItem = NativeUI.CreateItem(_U('bossmanagement_demote_button'), "")
	bossMenu2.SubMenu:AddItem(destituerItem)

	if societymoney2 ~= nil then
		coffreItem2 = NativeUI.CreateColouredItem("Compte de votre faction", Description, Colours.RedDark, Colours.White)
		coffreItem2:RightLabel(societymoney2.. "~r~ $")
		bossMenu2.SubMenu:AddItem(coffreItem2)
	end

	bossMenu2.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruterItem then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Faction", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_recruterplayer2', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.job2.name, 0)
				end
			else
				notification("Faction", "Notification", _U('missing_rights'))
			end
		elseif item == virerItem then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Faction", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_virerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Faction", "Notification", _U('missing_rights'))
			end
		elseif item == promouvoirItem then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Faction", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_promouvoirplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Faction", "Notification", _U('missing_rights'))
			end
		elseif item == destituerItem then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Faction", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('Menu_DVR:Boss_destituerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Faction", "Notification", _U('missing_rights'))
			end
		end
	end
end


function OpenKeyMenu()
    local elements = {}
    local elements2 = {}
    local elements3 = {}

    ESX.TriggerServerCallback('esx_vehiclelock:allkey', function(mykey)

   	   	KeyList = {}

		for i=1, #mykey, 1 do
			if mykey[i].got == 'true' then 
				if 	mykey[i].NB == 1 then	

					local label = mykey[i].plate
					local value = mykey[i].plate

					table.insert(elements2,{
						label = mykey[i].plate,
						value = mykey[i].plate
					})

                    table.insert(KeyList, label)
                    
                    table.insert(elements, {label= ('Clé: ' .. label), value = label})

				elseif mykey[i].NB == 2 then

                    local label = mykey[i].plate
                    local value = nil

                   	table.insert(elements2,{
						label = mykey[i].plate,
						value = nil
					})

                    table.insert(KeyList, label)
                    
                    table.insert(elements, {label= ('[DOUBLE] Clé: ' .. label), value = label})
				end	
			end	
        end	
        ESX.UI.Menu.CloseAll()	

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'test_menu',
            {
                css      = 'emploi',
                title    = 'Mes Clés',
                align    = 'top-left',
                elements = elements
            },
        function(data, menu)	
            for i=1,#elements2,1 do
                local values = elements2[i].value
                local label = elements2[i].label

                if data.current.value == values then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local playerPed = GetPlayerPed(-1)
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

                    table.insert(elements3, {label = "Donner", value = "donner"})
                    table.insert(elements3, {label = "Prêter", value = "preter"})
                    ESX.UI.Menu.CloseAll()	

                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'test2_menu',
                        {
                            css      = 'emploi',
                            title    = KeyList[label],
                            align    = 'top-left',
                            elements = elements3
                        },
                        function(data2, menu2)	

                            if data2.current.value == 'donner' then
                                if player ~= -1 and distance < 3.0 then		                		
                                    TriggerServerEvent('esx_vehiclelock:donnerkey', GetPlayerServerId(player), values)
                                    TriggerServerEvent('esx_vehiclelock:deletekey', values)
                                    TriggerServerEvent('esx_vehiclelock:changeownerkey', GetPlayerServerId(player), values)
                                  else 
                                      ESX.ShowQNotification(Config.NotificationProxi)
                                end
                            elseif data2.current.value == 'preter' then
                                if player ~= -1 and distance < 3.0 then 
                                    TriggerServerEvent('esx_vehiclelock:preterkey', GetPlayerServerId(player), values)
                                else 
                                     ESX.ShowNotification(Config.NotificationProxi)
                                end
                            end
                    end)
                end
            end
        end)
    end)
end



function AddMenuAdminMenu(menu)
	--local AdminMenu = NativeUI.CreateColouredItem("Modération", Description, Colours.BlueLight, Colours.BlueDark)
	--menu:AddItem(AdminMenu)
	AdminMenu = _menuPool:AddSubMenu(menu, "~r~Modération","",8, 200, "", "", nil,100,0,0,255)
	--NativeUI.CreateColouredItem("Déposer", Description, Colours.GreenDark, Colours.White)
	if playerGroup == 'mod' then
		_menuPool:WidthOffset(80)
		local noclipItem = NativeUI.CreateItem(_U('admin_noclip_button'), "")
		AdminMenu.SubMenu:AddItem(noclipItem)
		local showPlrNameItem = NativeUI.CreateItem(_U('admin_showname_button'), "")
		AdminMenu.SubMenu:AddItem(showPlrNameItem)
		local skinPlrItem = NativeUI.CreateItem(_U('admin_changeskin_button'), "")
		AdminMenu.SubMenu:AddItem(skinPlrItem)

		AdminMenu.SubMenu.OnItemSelect = function(sender, item, index)
			if item == noclipItem then
				admin_no_clip()
				_menuPool:CloseAllMenus()
			elseif item == showPlrNameItem then
				modo_showname()
			elseif item == skinPlrItem then
				changer_skin()
			end
		end
	elseif playerGroup == 'admin' then
		_menuPool:WidthOffset(80)
		local noclipItem = NativeUI.CreateItem(_U('admin_noclip_button'), "")
		AdminMenu.SubMenu:AddItem(noclipItem)
		local godmodeItem = NativeUI.CreateItem(_U('admin_godmode_button'), "")
		AdminMenu.SubMenu:AddItem(godmodeItem)
		local ghostmodeItem = NativeUI.CreateItem(_U('admin_ghostmode_button'), "")
		AdminMenu.SubMenu:AddItem(ghostmodeItem)
		local showXYZItem = NativeUI.CreateItem(_U('admin_showxyz_button'), "")
		AdminMenu.SubMenu:AddItem(showXYZItem)
		local showPlrNameItem = NativeUI.CreateItem(_U('admin_showname_button'), "")
		AdminMenu.SubMenu:AddItem(showPlrNameItem)
		local repairVehItem = NativeUI.CreateItem(_U('admin_repairveh_button'), "")
		AdminMenu.SubMenu:AddItem(repairVehItem)
		local skinPlrItem = NativeUI.CreateItem(_U('admin_changeskin_button'), "")
		AdminMenu.SubMenu:AddItem(skinPlrItem)
		local givecashItem = NativeUI.CreateItem(_U('admin_givemoney_button'), "")
		AdminMenu.SubMenu:AddItem(givecashItem)

		AdminMenu.SubMenu.OnItemSelect = function(sender, item, index)
			if item == noclipItem then
				admin_no_clip()
				_menuPool:CloseAllMenus()
			elseif item == godmodeItem then
				admin_godmode()
			elseif item == ghostmodeItem then
				admin_mode_fantome()
			elseif item == showXYZItem then
				modo_showcoord()
			elseif item == showPlrNameItem then
				modo_showname()
			elseif item == repairVehItem then
				admin_vehicle_repair()
			elseif item == skinPlrItem then
				changer_skin()
			elseif item == givecashItem then
				admin_give_money()
				_menuPool:CloseAllMenus()
			end
		end
	elseif playerGroup == 'superadmin' or playerGroup == 'owner' then
		_menuPool:WidthOffset(80)
		local noclipItem = NativeUI.CreateItem(_U('admin_noclip_button'), "")
		AdminMenu.SubMenu:AddItem(noclipItem)
		local godmodeItem = NativeUI.CreateItem(_U('admin_godmode_button'), "")
		AdminMenu.SubMenu:AddItem(godmodeItem)
		local ghostmodeItem = NativeUI.CreateItem(_U('admin_ghostmode_button'), "")
		AdminMenu.SubMenu:AddItem(ghostmodeItem)
		local repairVehItem = NativeUI.CreateItem(_U('admin_repairveh_button'), "")
		AdminMenu.SubMenu:AddItem(repairVehItem)
		local returnVehItem = NativeUI.CreateItem(_U('admin_flipveh_button'), "")
		AdminMenu.SubMenu:AddItem(returnVehItem)
		local givecashItem = NativeUI.CreateItem(_U('admin_givemoney_button'), "")
		AdminMenu.SubMenu:AddItem(givecashItem)
		local givebankItem = NativeUI.CreateItem(_U('admin_givebank_button'), "")
		AdminMenu.SubMenu:AddItem(givebankItem)
		local givedirtyItem = NativeUI.CreateItem(_U('admin_givedirtymoney_button'), "")
		AdminMenu.SubMenu:AddItem(givedirtyItem)
		local showXYZItem = NativeUI.CreateItem(_U('admin_showxyz_button'), "")
		AdminMenu.SubMenu:AddItem(showXYZItem)
		local showPlrNameItem = NativeUI.CreateItem(_U('admin_showname_button'), "")
		AdminMenu.SubMenu:AddItem(showPlrNameItem)
		local skinPlrItem = NativeUI.CreateItem(_U('admin_changeskin_button'), "")
		AdminMenu.SubMenu:AddItem(skinPlrItem)
		local courseItem = NativeUI.CreateColouredItem("Courir vite", Description, Colours.GreenDark, Colours.White)
		AdminMenu.SubMenu:AddItem(courseItem)


		AdminMenu.SubMenu.OnItemSelect = function(sender, item, index)
			if item == noclipItem then
				admin_no_clip()
				_menuPool:CloseAllMenus()
			elseif item == godmodeItem then
				admin_godmode()
			elseif item == ghostmodeItem then
				admin_mode_fantome()
			elseif item == spawnVehItem then
				admin_vehicle_spawn()
				_menuPool:CloseAllMenus()
			elseif item == repairVehItem then
				admin_vehicle_repair()
			elseif item == returnVehItem then
				admin_vehicle_flip()
			elseif item == givecashItem then
				admin_give_money()
				_menuPool:CloseAllMenus()
			elseif item == givebankItem then
				admin_give_bank()
				_menuPool:CloseAllMenus()
			elseif item == givedirtyItem then
				admin_give_dirty()
				_menuPool:CloseAllMenus()
			elseif item == showXYZItem then
				modo_showcoord()
			elseif item == showPlrNameItem then
				modo_showname()
				_menuPool:CloseAllMenus()
			elseif item == skinPlrItem then
				changer_skin()
			elseif item == courseItem then
				course()
			end
		end
	end
end



function GeneratePersonalMenu()	
	AddMenuWalletMenu(mainMenu)
	AddMenuWeaponMenu(mainMenu)
	AddMenuFacturesMenu(mainMenu)
	AddVracMenu(mainMenu)
	AddMenuClothesMenu(mainMenu)

	

	if IsPedSittingInAnyVehicle(plyPed) then
		if (GetPedInVehicleSeat(GetVehiclePedIsIn(plyPed, false), -1) == plyPed) then
			AddMenuVehicleMenu(mainMenu)
		end
	end

	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		AddMenuBossMenu(mainMenu)
	end

	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		AddMenuBossMenu2(mainMenu)
	end





	AddActionMenu(mainMenu)
	if playerGroup ~= nil and (playerGroup == 'mod' or playerGroup == 'admin' or playerGroup == 'superadmin' or playerGroup == 'owner') then
		AddMenuAdminMenu(mainMenu)
	end




	_menuPool:RefreshIndex()
end

Citizen.CreateThread(function()
	while true do
		if IsControlJustReleased(0, Config.Menu.clavier) and not isDead then
			if mainMenu ~= nil and not mainMenu:Visible() then
				ESX.PlayerData = ESX.GetPlayerData()
				GeneratePersonalMenu()
				
				mainMenu:Visible(true)
				Citizen.Wait(10)
			end
		end
		if _menuPool ~= nil then
			_menuPool:ProcessMenus()
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while false do
		if _menuPool ~= nil then
			_menuPool:ProcessMenus()
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		while _menuPool ~= nil and _menuPool:IsAnyMenuOpen() do
			Citizen.Wait(0)

			if not _menuPool:IsAnyMenuOpen() then
				mainMenu:Clear()
				itemMenu:Clear()
				weaponItemMenu:Clear()

				_menuPool:Clear()
				_menuPool:Remove()

				personalmenu = {}

				invItem = {}
				wepItem = {}
				billItem = {}

				collectgarbage()

				_menuPool = NativeUI.CreatePool()

				mainMenu = NativeUI.CreateMenu(Config.servername, "Menu personnel",8, 200, "", "", nil,100,0,0,255)
				itemMenu = NativeUI.CreateMenu(Config.servername, "Inventaire :",8, 200, "", "", nil,100,0,0,255)
				weaponItemMenu = NativeUI.CreateMenu(Config.servername, "Arme :",8, 200, "", "", nil,100,0,0,255)
				_menuPool:Add(mainMenu)
				_menuPool:Add(itemMenu)
				_menuPool:Add(weaponItemMenu)
				_menuPool:WidthOffset(80)
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ESX ~= nil then
			ESX.TriggerServerCallback('Menu_DVR:Admin_getUsergroup', function(group) playerGroup = group end)
			return --TEST A DELETE SI PROB
			Citizen.Wait(30 * 1000)
		else
			Citizen.Wait(100)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		plyPed = PlayerPedId()
		
		if IsControlJustReleased(0, Config.stopAnim.clavier) and GetLastInputMethod(2) and not isDead then
			ClearPedTasks(plyPed)
		end

		if playerGroup ~= nil and (playerGroup == 'mod' or playerGroup == 'admin' or playerGroup == 'superadmin' or playerGroup == 'owner') then
			if IsControlPressed(1, Config.TPMarker.clavier1) and IsControlJustReleased(1, Config.TPMarker.clavier2) and GetLastInputMethod(2) and not isDead then
				admin_tp_marker()
			end
		end

		if showcoord then
			local playerPos = GetEntityCoords(plyPed)
			local playerHeading = GetEntityHeading(plyPed)
			Text("~r~X~s~: " .. playerPos.x .. " ~b~Y~s~: " .. playerPos.y .. " ~g~Z~s~: " .. playerPos.z .. " ~y~Angle~s~: " .. playerHeading)
		end

		if noclip then
			local x, y, z = getPosition()
			local dx, dy, dz = getCamDirection()
			local speed = Config.noclip_speed

			SetEntityVelocity(plyPed, 0.0001, 0.0001, 0.0001)

			if IsControlPressed(0, 32) then
				x = x + speed * dx
				y = y + speed * dy
				z = z + speed * dz
			end

			if IsControlPressed(0, 269) then
				x = x - speed * dx
				y = y - speed * dy
				z = z - speed * dz
			end

			SetEntityCoordsNoOffset(plyPed, x, y, z, true, true, true)
		end

		if showname then
			for id = 0, 256 do
				if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= plyPed then
					local headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, GetPlayerPed(id), (GetPlayerServerId(id) .. ' - ' .. GetPlayerName(id)), false, false, "", false)
				end
			end
		end
		
		Citizen.Wait(0)
	end
end)


