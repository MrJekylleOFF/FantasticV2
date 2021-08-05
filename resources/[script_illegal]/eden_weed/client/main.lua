ESX = nil
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

local GUI                       = {}
local PlayerData
GUI.Time                        = 0
local Weed                      = {}
local WeedPNJ = {
	--{id=1, Name=PnjWeed, VoiceName="GENERIC_INSULT_HIGH", Ambiance="AMMUCITY", Weapon=1649403952, modelHash="s_m_y_dockwork_01", x = 2636.52, y = 3668.45, z = 101.22, heading=133.0},
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
    for i=1, #WeedPNJ do
        RequestModel(GetHashKey(WeedPNJ[i].modelHash))
        while not HasModelLoaded(GetHashKey(WeedPNJ[i].modelHash)) do
            Citizen.Wait(1)
        end

        WeedPNJ[i].id = CreatePed(28, WeedPNJ[i].modelHash, WeedPNJ[i].x, WeedPNJ[i].y, WeedPNJ[i].z, WeedPNJ[i].heading, false, false)
        TaskStartScenarioInPlace(WeedPNJ[i].id,'WORLD_HUMAN_SMOKING_POT', 0 , false )
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  CreateWeed()
end)

RegisterNetEvent('eden_drugs:plantation')
AddEventHandler('eden_drugs:plantation', function()
  local currentPos = GetEntityCoords(GetPlayerPed(-1))
  local id = math.random(000001,999999)

  x, y, z = table.unpack(currentPos);
  TriggerServerEvent('eden_drugs:createweed', x, y, z -1,id)
  TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_gardener_plant", 0, false)
  Citizen.Wait(10000)
  ClearPedTasks(GetPlayerPed(-1))
  Citizen.Wait(2000)
  CreateWeed()
end)

function CreateWeed()
  ESX.TriggerServerCallback('eden_drugs:checkplan', function(data)
		RequestModel(GetHashKey("prop_weed_01"))
			while not HasModelLoaded(GetHashKey("prop_weed_01")) do
			Citizen.Wait(10)
			end
    for i=1, #data, 1 do
      local data = data[i]
      DeleteObject(Weed[data.x])
      --[[if data.percent <= 25 then
        Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z - 1.4 ,  true,  false, false)
		    SetEntityAsMissionEntity(Weed[data.x],true,true)
        SetEntityAlwaysPrerender(Weed[data.x],true)
        FreezeEntityPosition(Weed[data.x],true)
      elseif data.percent >= 26 and data.percent <= 50 then
        Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z - 1.2 ,  true,  false, false)
		    SetEntityAsMissionEntity(Weed[data.x],true,true)
        SetEntityAlwaysPrerender(Weed[data.x],true)
        FreezeEntityPosition(Weed[data.x],true)
      elseif data.percent >= 51 and data.percent <= 75 then
        Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z - 0.8 ,  true,  false, false)
		    SetEntityAsMissionEntity(Weed[data.x],true,true)
        SetEntityAlwaysPrerender(Weed[data.x],true)
        FreezeEntityPosition(Weed[data.x],true)
      elseif data.percent >= 76 then
        Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z - 0.2 , true, false, false)
		    SetEntityAsMissionEntity(Weed[data.x],true,true)
        SetEntityAlwaysPrerender(Weed[data.x],true)
        FreezeEntityPosition(Weed[data.x],true)
      end]]
        if data.percent > 100 then
            data.percent = 100
        end
        local height = (-1.4 + (1.2*(data.percent/100)))
        Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z + height , true, false, false)
		SetEntityAsMissionEntity(Weed[data.x],true,true)
        SetEntityAlwaysPrerender(Weed[data.x],true)
        SetEntityHeading(Weed[data.x], math.random(0,360))
        FreezeEntityPosition(Weed[data.x],true)
    end
  end)
end

RegisterNetEvent('eden_drugs:usetruelle')
AddEventHandler('eden_drugs:usetruelle', function(x)
  ESX.TriggerServerCallback('eden_drugs:checkplan', function(data)
    for i=1, #data, 1 do
      local data = data[i]

        distance = GetDistanceBetweenCoords(data.x, data.y, data.z, GetEntityCoords(GetPlayerPed(-1)))

        if distance < 1 then
          if data.percent <= 99 then
            ESX.ShowNotification('~r~Le plan n\'est pas encore prêt : '..data.percent.."%")
          elseif data.percent >= 100 then
            TriggerServerEvent('eden_drugs:deleteweed', data.x)
            TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_gardener_plant", 0, false)
            Citizen.Wait(5000)
            --TriggerEvent('eden_drugs:deleteweed', data.x)
            DeleteObject(Weed[data.x])
            Wait(1)
            Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z - 0.6 ,  true,  false, false)
            Citizen.Wait(5000)
            --TriggerEvent('eden_drugs:deleteweed', data.x)
            DeleteObject(Weed[data.x])
            Wait(1)
            Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z - 1.2 ,  true,  false, false)
            Citizen.Wait(5000)
            --TriggerEvent('eden_drugs:deleteweed', data.x)
            DeleteObject(Weed[data.x])
            Wait(1)
            Weed[data.x] = CreateObject(GetHashKey("prop_weed_01"), data.x , data.y , data.z - 1.4 ,  true,  false, false)
            Citizen.Wait(5000)
            DeleteObject(Weed[data.x])
            ClearPedTasks(GetPlayerPed(-1))
            TriggerServerEvent('eden_drugs:giveweed',data.x)
          end
        end
    end
  end)
end)

RegisterNetEvent('eden_drugs:deleteweed')
AddEventHandler('eden_drugs:deleteweed', function(x)
    SetEntityAsMissionEntity(Weed[x],false,false)
    DeleteObject(Weed[x])
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(15*60*1000)
    CreateWeed()
  end
end)

RegisterNetEvent('eden_drugs:usepelle')
AddEventHandler('eden_drugs:usepelle', function(x)
  ESX.TriggerServerCallback('eden_drugs:checkplan', function(data)
    for i=1, #data, 1 do
      local data = data[i]

        distance = GetDistanceBetweenCoords(data.x, data.y, data.z, GetEntityCoords(GetPlayerPed(-1)))

        if distance < 1 then
          TriggerServerEvent('eden_drugs:deleteweed', data.x)
        end
    end
  end)
end)





Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    for i=1, #WeedPNJ do

      distanceWeedPNJ = GetDistanceBetweenCoords(WeedPNJ[i].x, WeedPNJ[i].y, WeedPNJ[i].z, GetEntityCoords(GetPlayerPed(-1)), true)-- WeedPNJ[i].x, WeedPNJ[i].y, WeedPNJ[i].z,

      if distanceWeedPNJ <= 2 then
        ESX.ShowHelpNotification('~INPUT_CONTEXT~ pour acheter des graines (100$)')
        if IsControlJustPressed(1, Keys["E"]) then
		  TriggerServerEvent('eden_drugs:buyseed')
        end
      end

    end
  end
end)

Citizen.CreateThread(function()
    
    while false do
        Wait(1)
        local player = GetPlayerPed(-1)
        local pid = PlayerPedId()
        local playerloc = GetEntityCoords(player, 0)
        local handle, ped = FindFirstPed()
        local success
      
                
------------------------------------------------------                
        repeat
            success, ped = FindNextPed(handle)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
            --print(ped .. distance)
            if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped)then
                    local pedType = GetPedType(ped)
                    if  pedType ~= 28 and not IsPedAPlayer(ped)  then
                        if distance <= 1.5 and ped  ~= GetPlayerPed(-1) and not IsOldPed(ped) then
                            --ESX.ShowHelpNotification("~INPUT_DETONATE~")
                            if IsControlJustPressed(1, 47) then --G
                                CycleOldPeds(ped)
                                local cops = 0
                                ESX.TriggerServerCallback('eden_drugs:countCops', function(enoughCops)
                                    cops = enoughCops
                                end)
                                if cops then
                                    if math.random(1,100) >= 30 then
                                        RequestAnimDict("mp_common")
                                        while not HasAnimDictLoaded("mp_common") do Wait(0) end
                                        SetPedDesiredHeading(ped, (GetEntityHeading(player) - 180.0))
                                        Wait(1000)
                                        TaskPlayAnim(GetPlayerPed(-1),"mp_common","givetake1_a",100.0, 100.0, 0.3, 120, 0.2, 0, 0, 0)
                                        TaskPlayAnim(ped,"mp_common","givetake1_a",100.0, 100.0, 0.3, 120, 0.2, 0, 0, 0)
                                        TriggerServerEvent("eden_drugs:sellweed")
                                    else
                                        SetPedDiesWhenInjured(ped, false)
										SetPedCombatAbility(ped, 100)
										TaskCombatPed(ped, PlayerPedId(), 0, 16)
                                        --TaskReactAndFleePed(ped, PlayerPedId())
                                        TriggerServerEvent('eden_drugs:appelPolice', playerloc['x'], playerloc['y'], playerloc['z'])
                                    end
                                else
                                    TaskReactAndFleePed(ped, PlayerPedId())
                                end
                            end
                        end
                    end
                end
            end
        until not success
      
        EndFindPed(handle)
    end    
end)

function IsOldPed(currentped)
    local PedFound = false
    for i=1, 20 do
        if _G["oldped_"..i] == nil then
            _G["oldped_"..i] = 0
        end
        if currentped == _G["oldped_"..i] then
            PedFound = true
        end
    end
    
    return PedFound
end

function CycleOldPeds(currentped)
    oldped_1 = currentped
    for i=19, 1, -1 do
        _G["oldped_"..i+1] = _G["oldped_"..i]
    end
end

RegisterNetEvent('eden_drugs:policeNotif')
AddEventHandler('eden_drugs:policeNotif', function(tx, ty, tz)

	if PlayerData.job.name == 'police' then
		local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, tx, ty, tz, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
			if s2 == 0 then
				ESX.ShowNotification("Quelqu'un veux me vendre de la drogue.~n~Je suis à ~y~".. street1)
			else
				ESX.ShowNotification("Quelqu'un veux me vendre de la drogue.~n~Je suis entre ~y~".. street1.. "~s~ et ~y~".. street2)
			end
		--BLIP VOL
		local transT = 250
		local Blip = AddBlipForCoord(tx, ty, tz)
		SetBlipSprite(Blip,  10)
		SetBlipColour(Blip,  1)
		SetBlipAlpha(Blip,  transT)
		SetBlipAsShortRange(Blip,  false)
		Wait(4000)
		while transT ~= 0 do
			Wait(10)
			transT = transT - 1
			SetBlipAlpha(Blip,  transT)
			if transT == 0 then
				SetBlipSprite(Blip,  2)
				return
			end
		end
	end
end)

