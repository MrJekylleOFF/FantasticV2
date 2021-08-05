local callActive = false
local haveTarget = false
local work
local target = {}
ESX = nil


Citizen.CreateThread(function()
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    TriggerServerEvent("player:serviceOff", nil)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        -- if IsControlJustPressed(1, 56) then
        --     local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
        --     TriggerServerEvent("call:makeCall", "uber", {x=plyPos.x,y=plyPos.y,z=plyPos.z})
        -- end

        -- Press y key to get the call
        if IsControlJustPressed(1, 246) and callActive then
            TriggerServerEvent("call:getCall", work)
            SendNotification("~g~Vous avez pris l'appel")
            target.blip = AddBlipForCoord(target.pos.x, target.pos.y, target.pos.z)
            SetBlipRoute(target.blip, true)
            haveTarget = true
            callActive = false
        -- Press h key to declie the call
        elseif IsControlJustPressed(1, 74) and callActive then
            SendNotification("~r~Vous avez refusé l'appel")
            callActive = false
        end
        if haveTarget then
            --DrawMarker(1, target.pos.x, target.pos.y, target.pos.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
            local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
            if Vdist(target.pos.x, target.pos.y, target.pos.z, playerPos.x, playerPos.y, playerPos.z) < 2.0 then
                RemoveBlip(target.blip)
                haveTarget = false
            end
        end
        if IsControlJustPressed(1, 74)  then
            RemoveBlip(target.blip)
        end
        -- Press h key to declie the call
    end
end)

RegisterNetEvent("call:callIncoming")
AddEventHandler("call:callIncoming", function(job, pos, msg, phonenumber)
    callActive = true
    work = job
    target.pos = pos
    local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
    local dist = math.floor(Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z))
    SendAdvNotification(msg, job, dist, phonenumber)
    SendNotification("~g~<C>[Y]</C>~s~ pour prendre l'appel ~n~ ~r~<C>[H]</C>~s~ pour le refuser")
end)

RegisterNetEvent("call:taken")
AddEventHandler("call:taken", function()
    callActive = false
    SendNotification("Un collègue a pris l'appel")
end)

RegisterNetEvent("target:call:taken")
AddEventHandler("target:call:taken", function(taken)
    if taken == 1 then
        SendNotification("~g~Quelqu'un arrive !")
    elseif taken == 0 then
        SendNotification("~r~Personne ne viendra, désolé...")
    elseif taken == 2 then
        SendNotification("~y~Veuillez rappeler dans quelques instants")
    end
end)

-- If player disconnect, remove him from the inService server table
AddEventHandler('playerDropped', function()
	TriggerServerEvent("player:serviceOff", nil)
end)

AddEventHandler("call:gcphone", function(data)
    local message = data.message
    if data.message == nil then
        AddTextEntry("vdkcallgcphone", "Message: ")
        DisplayOnscreenKeyboard(1, "vdkcallgcphone", "", "", "", "", "", 200)
        while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            message =  GetOnscreenKeyboardResult()
        end
    end
    if message ~= nil and message ~= "" then
        SendNotification("Appel envoyé...")
        local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
        TriggerServerEvent("call:makeCall", data.number, {x=plyPos.x,y=plyPos.y,z=plyPos.z}, message)
    end
end)

function SendNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, false)
end

function SendAdvNotification(message, job, dist, phonenumber)
    print(phonenumber)
    icon = "CHAR_CHAT_CALL"
    if job == "police" or job == "ambulance" then
        icon = "CHAR_CALL911"
    end
    RequestStreamedTextureDict(icon, true)
	while not HasStreamedTextureDictLoaded(icon) do Wait(1) end
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName("~r~Message :~s~~n~"..message)
	SetNotificationMessage(icon, icon, false, 1, "Appel métier" , "~b~Distance : ~s~".. dist .. "m")
	DrawNotification(true, true)
end