ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

lockdown = false
Cooldown = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)
		if lockdown == false then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Lockdown.x, Config.Lockdown.y, Config.Lockdown.z, true ) < 1 then
				DrawText3D(Config.Lockdown.x, Config.Lockdown.y, Config.Lockdown.z+0.9, Config.ActiveText)
				if IsControlJustReleased(1, 38) then
					TriggerServerEvent('control:Lockdown')
				end
			end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)
		if Cooldown == true then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Lockdown.x, Config.Lockdown.y, Config.Lockdown.z, true ) < 1 then
				DrawText3D(Config.Lockdown.x, Config.Lockdown.y, Config.Lockdown.z+0.9, Config.LockdownText)
			end
        end
    end
end)

RegisterNetEvent('control:Lockdown')
AddEventHandler('control:Lockdown', function()
	local ped = PlayerPedId()
	local code = "22"
	lockdown = true	
	prop = GetHashKey("prop_cs_hand_radio")
	object = CreateObject(GetHashKey("prop_police_radio_main"), GetEntityCoords(PlayerPedId()), true)
	AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
 
	RequestAnimDict('weapons@projectile@sticky_bomb')
	while not HasAnimDictLoaded('weapons@projectile@sticky_bomb') do
		Citizen.Wait(100)
	end 
	TaskPlayAnim(ped, 'weapons@projectile@sticky_bomb', 'plant_vertical', 8.0, -8, -1, 49, 0, 0, 0, 0)	
	ESX.ShowNotification("~r~Connexion en cours")
	Citizen.Wait(1000)
	DeleteEntity(object)
	Citizen.Wait(700)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	Citizen.Wait(200)
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
	ESX.ShowNotification("~g~Connexion a votre smartphone")
	Citizen.Wait(2600)
	ESX.ShowNotification("~r~Acces en cours au panel du gouvernement ")
	Citizen.Wait(7100)
	AddTextEntry('FMMC_MPM_NA', "Code d'accès")
	DisplayOnscreenKeyboard(false, "FMMC_MPM_NA", "Code d'accès", "", "", "", "", 5)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		text = GetOnscreenKeyboardResult()
	end
	local text = GetOnscreenKeyboardResult()
	if text == code then 
		if text ~= nil and text ~= "" then
			ESX.ShowNotification("~g~Connexion en cours ~n~ ~r~Veuillez patienter ... ")
			Wait(2000)
			ESX.ShowNotification("~g~Connexion reussi ~n~ ~r~Veuillez patienter ... ")
			Wait(2000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 0%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 10%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 20%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 30%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 40%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 50%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 60%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 70%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 80%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 90%")
			Wait(1000)
			ESX.ShowNotification("~g~Piratage en cours ... ~n~~r~ 100%")
			TriggerEvent("control:AktiverLockdown")
		end
	else
		ESX.ShowNotification("~r~Code d'entrer incorrect")
		Cooldown = true
		lockdown = true
		ClearPedTasksImmediately(GetPlayerPed(-1))
		DeleteEntity(object)
	end
end)

RegisterNetEvent('control:AktiverLockdown')
AddEventHandler('control:AktiverLockdown', function()
	local ped = PlayerPedId()
	ESX.ShowNotification("Mise a jour en cours")
	Citizen.Wait(5000)
	ESX.ShowNotification("Connexion a la central ~b~LSPD")
	Citizen.Wait(5000)
	ESX.ShowNotification("~r~Les lumieres sont desormais éteintes !")
	TriggerEvent("control:lumieresstop")
	--TriggerEvent("openmenu:traffic")
end)

RegisterNetEvent('control:lumieresstop')
AddEventHandler('control:lumieresstop', function()
	SetBlackout(true)
	Cooldown = true
	ClearPedTasksImmediately(GetPlayerPed(-1))
	DeleteEntity(object)
end)

RegisterNetEvent('control:lumieresstart')
AddEventHandler('control:lumieresstart', function()
	SetBlackout(false)
	Cooldown = false
	lockdown = false
end)

RegisterNetEvent('control:setblip')
AddEventHandler('control:setblip', function()
	blipLockdown = AddBlipForCoord(Config.Lockdown.x, Config.Lockdown.y, Config.Lockdown.z)
	SetBlipSprite(blipLockdown , 161)
	SetBlipScale(blipLockdown , 1.0)
	SetBlipColour(blipLockdown, 1)
	PulseBlip(blipLockdown)
	Citizen.Wait(Config.KillBlip)
	RemoveBlip(blipLockdown)
end)

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextDropshadow(0, 0, 0, 155)
	SetTextEdge(1, 0, 0, 0, 250)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
end

AddEventHandler("onResourceStop",function(a)
	if a== GetCurrentResourceName() then
		SetBlackout(false)
	end
end)
