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

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj
            Citizen.Wait(0)
		end)
	end

end)


local Blips = {
	{name="Serrurier", color=3, sprite=68, Pos = {x= -236.56, y= 6232.58, z= 31.49}},
	{name="Concessionnaire Moto", size=1.0, color=1, sprite=226, Pos = {x= -222.62, y= 6247.84, z= 31.49}},
	{name="Avocat", color=3, sprite=351, Pos = {x= -1913.0737304688, y = -570.80529785156, z = 18.597213745117}},
	{name="Mairie", color=4, sprite=475, Pos = {x = -542.88, y = -207.98, z = 37.65}},
	{name="Ikea", color=4, sprite=605, Pos = {x = 62.97, y = -1728.26, z = 29.61}},
	{name="Psychologue", color=5, sprite=351, size=1.0, Pos = {x = 232.84, y = -419.25, z = 120.98}},
	--{name="Cinema", color=8, sprite=135, size=0.8, Pos = {x = 342.3, y = 201.76, z = 103.22}},
	{name="Occasion'Mosley's", color=1, sprite=669, size=0.8, Pos = {x = -96.49, y = -1793.1, z = 26.81}}
}

Citizen.CreateThread(function()
    for i = 1 , #Blips , 1 do
        local v = Blips[i]
        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite (blip, v.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, v.size or 0.8)
        SetBlipColour (blip,  v.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterCommand("noclip", function()
	print('CHEH')
end)

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)


RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(8000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it
--
local KeyList = {
    ["F5"] = "Ouverture/fermeture du menu personnel",
    ["L"] = "Ouverture/fermeture coffre véhicule",
    ["U"] = "Ouverture/fermeture véhicule (verrouillage)",
    ["G"] = "Fouiller un joueur",
	[","] = "Smartphone",
	["/vente"] = "Vente de votre automobile",
	["="] = "Tomber",
}

local function chatMessage(msg)
    TriggerEvent("chatMessage", "^3Fantastic", {0,255,0}, msg)
end

RegisterCommand("key", function()
    local helpText = ""
    for k , v in pairs(KeyList) do
        helpText = helpText .. "\n ^1[^3" ..k.. "^1]^0 " .. v 
    end
    chatMessage(helpText)
end)

Citizen.CreateThread(function(info,_)
	local info = 9*80000
	while true do
		Citizen.Wait(info)
		ESX.ShowNotification("~r~INFO ~s~: Vous cherchez le mappage des touches ? ~n~faites ~g~/key ")
	end
end)

function RemoveReticle()
	local isSniper = false
	local ped = GetPlayerPed(-1)
	local currentWeaponHash = GetSelectedPedWeapon(ped)

	if currentWeaponHash == 100416529 then
		isSniper = true
	elseif currentWeaponHash == 205991906 then
		isSniper = true
	elseif currentWeaponHash == -952879014 then
		isSniper = true
	elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
		isSniper = true
	else
		isSniper = false
	end

	if not isSniper then
		HideHudComponentThisFrame(14)
	end
end

Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)
		DisablePlayerVehicleRewards(PlayerId())	
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(9)
		RemoveReticle()
	end
end)

--[[
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			if chance_result < 0.5 then
				Citizen.Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.10)
				SetPedToRagdoll(ped, 5000, 1, 2)
			else
				Citizen.Wait(2000)
			end
		end
	end
end)]]--

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end


local pedindex = {}

function SetWeaponDrops() -- This function will set the closest entity to you as the variable entity.
    local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    repeat 
        if not IsEntityDead(ped) then
                pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then -- set all peds to not drop weapons on death.
            SetPedDropsWeaponsWhenDead(peds, false) 
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        SetWeaponDrops()
    end
end)

Citizen.CreateThread(function()
        SetDiscordAppId(645304861532880948)
        SetDiscordRichPresenceAsset('discord_1')
        SetDiscordRichPresenceAssetText('FanTasTic')
        SetDiscordRichPresenceAssetSmall('discord')
        SetDiscordRichPresenceAssetSmallText('discord.gg/RuFaD6p')
        
        while true do
            local t = GetActivePlayers()
            SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. #t .. "/ 128")
            Citizen.Wait(30000)
        end
end)



-- AFK Camera
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- The idle camera activates after 30 second so we don't need to call this per frame

        N_0xf4f2c0d4ee209e20() -- Disable the pedestrian idle camera
        N_0x9e4cfff989258472() -- Disable the vehicle idle camera
    end
end)

-------------------------------------- ( Degats -- Vehicules ) ------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 100.0, 0)
    end
end)

function GetVehHealthPercent()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehiclehealth = GetEntityHealth(vehicle) - 100
	local maxhealth = GetEntityMaxHealth(vehicle) - 100
	local procentage = (vehiclehealth / maxhealth) * 100
	return procentage
end




function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end



Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsUsing(ped)
		local damage = GetVehHealthPercent(vehicle)
		if IsPedInAnyVehicle(ped, false) then
			SetPlayerVehicleDamageModifier(PlayerId(), 100)
			if damage < 48 then
				SetVehicleUndriveable(vehicle, true)
				ShowNotification("~g~Ton vehicule est endomagé")
				StartVehicleHorn(vehicle, 100, 1, false)
				SetVehicleLights(vehicle, 2)
			end
		end
	end
end)

--[[Citizen.CreateThread(function()
	while true do
		local time = 535
		Citizen.Wait(0)
		if(GetLastInputMethod(0)) then
        	if IsControlPressed(1, 121) then
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
			ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.1)
			Wait(time)
			end
		end
    end
end)]]--

function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()

    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    AddTextEntry('FE_THDR_GTAO', 'FanTasTic | ID: ' .. id .. ' | Nom: ' .. name )
    AddTextEntry('PM_PANE_LEAVE', 'Déconnecter')
    AddTextEntry('PM_PANE_QUIT', 'Quitter')
    AddTextEntry('PM_SCR_MAP', 'Carte')
    AddTextEntry('PM_SCR_GAM', 'Jeu')
    AddTextEntry('PM_SCR_INF', 'Logs')
    AddTextEntry('PM_SCR_SET', 'Configuration')
    AddTextEntry('PM_SCR_STA', 'Statistiques')
    AddTextEntry('PM_SCR_RPL', 'Éditeur ∑')
end)

local serverID = GetPlayerServerId(PlayerId())
RegisterCommand('id', function(source, args, raw)
	local serverID = GetPlayerServerId(PlayerId())
	ESX.ShowNotification("Votre ID est le " .. serverID .. " ~b~∑")
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 100.0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
      RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
      RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
      RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
    end
  end)
  
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
     	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local ped = GetPlayerPed(-1)
		local vehicleClass = GetVehicleClass(vehicle)
		PlayerData = ESX.GetPlayerData()
		
		
		if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == ped then
			if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
				if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic' and PlayerData.job.name ~= 'avocat' then
					local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
					local chance_kick = math.random()
					local time = 9000
					if chance_kick < 0.7 then
						ClearPedTasksImmediately(ped)
						TaskLeaveVehicle(ped,vehicle,0)
						ESX.ShowNotification("Le vol de vehicules de fonction est interdit !")
					else
						print("^7 - KICK ......................................... KICK")
						print("^7 - KICK ......................................... KICK")
						print("^7 - KICK ......................................... KICK")
						print("^7 - KICK ......................................... KICK")
						print("^7 - KICK ......................................... KICK")
						print("^7 - KICK ......................................... KICK")
						ESX.ShowNotification("Le vol de vehicules de fonction est interdit !")
						ClearPedTasksImmediately(ped)
						TaskLeaveVehicle(ped,vehicle,0)
						Citizen.Wait(time)
						Citizen.InvokeNative(0xE574A662ACAEFBB1)
					end
				end
			end
		end
	end
end)--]]

Citizen.CreateThread(function()
    local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 56) and GetLastInputMethod(0) then
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

---------------------------------------------------------------------------------------
----------------------------------------   ME   ---------------------------------------

-- Settings
local color = { r = 255, g = 255, b = 255, alpha = 255 } -- Color of the text 
local font = 6 -- Font of the text
local time = 5000 -- Duration of the display of the text : 1000ms = 1sec
local background = {
    enable = false,
    color = { r = 45, g = 35, b = 35, alpha = 25 },
}
local chatMessage = true
local dropShadow = false

-- Don't touch
local nbrDisplaying = 1

RegisterCommand('me', function(source, args)
    local text = '*La personne' -- edit here if you want to change the language : EN: the person / FR: la personne
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' *'
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.10)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true

    -- Chat message
    if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        if dist < 2500 then
            TriggerEvent('chat:addMessage', {
                color = { color.r, color.g, color.b },
                multiline = true,
                args = { text}
            })
        end
    end

    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        print(nbrDisplaying)
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then

        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)
        if dropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
        end

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if background.enable then
            DrawRect(_x, _y+scale/45, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
        end
    end
end

-------------------------------- RADAR -------------------------------------------
local radar = 
{
	shown = false, 
	freeze = false, 
	info = "~g~Radar~n~Active", 
-- Touch this if u want
	minSpeed = 10.0,
	maxSpeed = 500.0,
}
-- The distance to check in front of the player for a vehicle
local distanceToCheckFront = 60.0


function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/1, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustPressed(1, 168) and GetLastInputMethod( 0 ) and not IsPauseMenuActive() and not blockinput and (IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then -- K
			if radar.shown then radar.shown = false else radar.shown = true end		
                Wait(75)
	    end
		if IsControlJustPressed(1, 168) and GetLastInputMethod( 0 ) and not IsPauseMenuActive() and not blockinput then -- K
		    if radar.shown then radar.shown = false end
				Wait(75)
		end
		if IsControlJustPressed(1, 311)then -- E
			if radar.freeze then radar.freeze = false else radar.freeze = true end
		end

		if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and radar.shown then
			if not radar.freeze then radar.freeze = true  end
		end

		if radar.shown then
			if radar.freeze == false then
					local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
					local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, distanceToCheckFront, 0.0)
					local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( vehicle, 0.0, distanceToCheckFront, 0.0 )
					local veh = getVehicleInDirection(coordA, coordB)
				if veh ~= nil then

					local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh));
					local plate = GetVehicleNumberPlateText(veh)
					local vehSpeedKmh = GetEntitySpeed(veh)*3.6
					local vehSpeedMph = GetEntitySpeed(veh)*2.236936
				    if model == "rocoto" then model = "ROCOTO" end
				    if model == "CARNOTFOUND" then model = "" end
					
					if vehSpeedMph > radar.minSpeed then			  
						if vehSpeedMph < radar.maxSpeed then 
							radar.info = string.format("| ~b~Model:~w~ %s ~n~| ~b~Plaque:~w~ %s ~n~| ~y~Km/h:~g~ %s",model,plate,math.ceil(vehSpeedKmh))
						else
							radar.info = string.format("| ~b~Model:~w~ %s ~n~| ~b~Plaque:~w~ %s ~n~| ~y~Km/h:~r~ %s",model,plate,math.ceil(vehSpeedKmh))
						end
					end
				end
			end
            drawTxt(0.360,0.900,0.187,0.215,0.365,radar.info,255,255,255,255)		
		end
	end  
end)

-- From point A to B -- Use GetOffsetFromEntityInWorldCoords for distance
function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

------------------------- TOMBER QUAND ON SE FAIT TOUCHER DANS LA JAMBE ------------------------------

local BONES = {
	--[[Pelvis]][11816] = true,
	--[[SKEL_L_Thigh]][58271] = true,
	--[[SKEL_L_Calf]][63931] = true,
	--[[SKEL_L_Foot]][14201] = true,
	--[[SKEL_L_Toe0]][2108] = true,
	--[[IK_L_Foot]][65245] = true,
	--[[PH_L_Foot]][57717] = true,
	--[[MH_L_Knee]][46078] = true,
	--[[SKEL_R_Thigh]][51826] = true,
	--[[SKEL_R_Calf]][36864] = true,
	--[[SKEL_R_Foot]][52301] = true,
	--[[SKEL_R_Toe0]][20781] = true,
	--[[IK_R_Foot]][35502] = true,
	--[[PH_R_Foot]][24806] = true,
	--[[MH_R_Knee]][16335] = true,
	--[[RB_L_ThighRoll]][23639] = true,
	--[[RB_R_ThighRoll]][6442] = true,
}


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
			--if IsShockingEventInSphere(102, 235.497,2894.511,43.339,999999.0) then
			if HasEntityBeenDamagedByAnyPed(ped) then
			--if GetPedLastDamageBone(ped) = 
					Disarm(ped)
			end
			ClearEntityLastDamageEntity(ped)
	 end
end)



function Bool (num) return num == 1 or num == true end

-- WEAPON DROP OFFSETS
local function GetDisarmOffsetsForPed (ped)
	local v

	if IsPedWalking(ped) then v = { 0.6, 4.7, -0.1 }
	elseif IsPedSprinting(ped) then v = { 0.6, 5.7, -0.1 }
	elseif IsPedRunning(ped) then v = { 0.6, 4.7, -0.1 }
	else v = { 0.4, 4.7, -0.1 } end

	return v
end

function Disarm (ped)
	if IsEntityDead(ped) then return false end

	local boneCoords
	local hit, bone = GetPedLastDamageBone(ped)

	hit = Bool(hit)

	if hit then
		if BONES[bone] then
			

			boneCoords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, bone))
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
			

			return true
		end
	end

	return false
end


 local relationshipTypes = {
	'GANG_1',
	'GANG_2',
	'GANG_9',
	'GANG_10',
	'AMBIENT_GANG_LOST',
	'AMBIENT_GANG_MEXICAN',
	'AMBIENT_GANG_FAMILY',
	'AMBIENT_GANG_BALLAS',
	'AMBIENT_GANG_MARABUNTE',
	'AMBIENT_GANG_CULT',
	'AMBIENT_GANG_SALVA',
	'AMBIENT_GANG_WEICHENG',
	'AMBIENT_GANG_HILLBILLY'
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)

		for _, group in ipairs(relationshipTypes) do
			SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetHashKey(group)) -- could be removed
			SetRelationshipBetweenGroups(1, GetHashKey(group), GetHashKey('PLAYER'))
		end
	end
end)



RegisterCommand('music', function(source, args, raw) --change command here)
	TriggerServerEvent('music')
end)

RegisterNetEvent("c_music")
AddEventHandler("c_music", function()
	TriggerServerEvent('InteractSound_SV:PlayOnSource', 'a', 0.2)
end)


----

local TeleportFromTo = {
	
	["FLASH"] = {
		positionFrom = { ['x'] = 1937.29, ['y'] = 595.54, ['z'] = 175.88, nom = "ENTRER."},
		positionTo = { ['x'] = 2030.60, ['y'] = 3003.70, ['z'] = -72.70, nom = "SORTIE."},
	},	
}

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing


function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function Drawing.drawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	--DisplayHelpTextFromStringLabel(0, 0, 0, -1)			---A 0 Enleve le son de la notif
end

function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), true)

		for k, j in pairs(TeleportFromTo) do

			if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 150.0) then
				DrawMarker(1, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 0.99, 0, 0, 0, 0, 0, 0, 3.5, 3.5, 0.5001, 0, 255, 0, 105, 0, 0, 2, 2, 0, 0, 0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 5.0)then
					if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 1.0)then
						ClearPrints()
						DisplayHelpText("Appuyez sur ~INPUT_PICKUP~ pour ~b~".. j.positionFrom.nom,1, 1, 0.5, 0.8, 0.9, 255, 255, 255, 255)
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2000)
							SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
							DoScreenFadeIn(1000)
						end
					end
				end
			end

			if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 150.0) then
				DrawMarker(1, j.positionTo.x, j.positionTo.y, j.positionTo.z - 0.99, 0, 0, 0, 0, 0, 0, 3.5, 3.5, 0.5001, 0, 255, 0, 105, 0, 0, 2, 2, 0, 0, 0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 5.0)then
					if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 1.0)then
						ClearPrints()
						DisplayHelpText("Appuyez sur ~INPUT_PICKUP~ pour ~r~".. j.positionTo.nom,1, 1, 0.5, 0.8, 0.9, 255, 255, 255, 255)
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2000)
							SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
							DoScreenFadeIn(1000)
						end
					end
				end
			end
		end
	end
end)

---- pnj

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		SetVehicleDensityMultiplierThisFrame(0.5)
		SetPedDensityMultiplierThisFrame(0.5)
		SetRandomVehicleDensityMultiplierThisFrame(0.5)
		SetParkedVehicleDensityMultiplierThisFrame(0.5)
		SetScenarioPedDensityMultiplierThisFrame(0.5, 0.5)
	end
end)






