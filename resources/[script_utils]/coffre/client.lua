--[[-----------------------------------------------------------------------|
Made by Cheleber - Hope you Enjoy
My Server: www.grandetheftlusitan.com
If you need my help or wanna help me, here is my Discord: Cheleber#0967
--]]-----------------------------------------------------------------------|

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------- STARTING!
local minutes = 0
local hours = 0
local timechecked = false
ESX = nil

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------ CHECK THE TIME ON SPAWN
Citizen.CreateThread(function()
    TriggerServerEvent('coffre:time')
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------ RETRIEVING THE TIME ON SPAWN
RegisterNetEvent('coffre:sendDados')
AddEventHandler('coffre:sendDados', function(m, h)
	minutes = m
    hours = h 
    timechecked = true -- STARTS THE COUNT OF THE ONLINE TIME
end)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- THE MASTER COUNTER 
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
	while true do
		Citizen.Wait(60000)
		if timechecked == true then
            
            minutes = minutes + 1
            if minutes == 60 then
                minutes = 0
                hours = hours + 1
                if hours % 2 == 0 then
                    TriggerServerEvent("coffre:recomp", hours) 
                end
            end
            TriggerServerEvent("coffre:savetimedb", minutes, hours) 
		end
	end
end)

function DrawSprt(dict, name, x, y, width, height, h, r, g, b, a)
	RequestStreamedTextureDict(dict, true)
		while not HasStreamedTextureDictLoaded(dict) do
			Wait(0)
		end
	--width = width * 0.9
	--height = height * 1.6
	--height = height * GetAspectRatio(0)
	--DrawSprite(dict, name, x + width/2, y + height/2, width, height, h, r, g, b, a)
    DrawSprite(dict, name, x, y, width, height, h, r, g, b, a)
end

function DrawTxt(x, y, scale, text, r,g,b,a)
    SetTextFont(1)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

RegisterNetEvent('coffre:open')
AddEventHandler('coffre:open', function(result, special)
local timeOpen = GetGameTimer() + 3000
local timeEnd = GetGameTimer() + 5000
local soundPlayed = false
local gaveVehicle = false
    
	while true do Wait(0)		
		if timeOpen >= GetGameTimer() then
            DrawSprt("coffre", "coffre", 0.5, 0.5, 0.25, 0.25, 0.0, 255, 255, 255, 255 )
        else
            if not soundPlayed then
                PlaySoundFrontend(-1, "WOODEN_DOOR_OPEN_HANDLE_AT", 0, 0)
                soundPlayed = true
            end
            if special and not gaveVehicle then
                gaveVehicle = true
                SetVehicle()
            end
            DrawTxt(0.5, 0.465, 1.0, result, 255,255,255,255)
            DrawSprt("coffre", "coffre_open", 0.5, 0.5, 0.25, 0.25, 0.0, 255, 255, 255, 255 )
        end
        if timeEnd < GetGameTimer() then
            return
        end
	end
end)

function SetVehicle()
    local vehicleProps
    SpawnVehicle("xa21", {x = 0.0, y = 0.0, z = 0.0}, 0.0, true, function(vehicle)
        SetVehicleNumberPlateText(vehicle, GeneratePlate())
        SetVehicleDirtLevel(vehicle, 0.0)
        vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        TriggerServerEvent("coffre:setVehicleOwned", vehicleProps)
        DeleteVehicle(vehicle)
    end)
    
end

function SpawnVehicle(modelName, coords, heading, network, cb)

  local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

  Citizen.CreateThread(function()

    RequestModel(model)

    while not HasModelLoaded(model) do
      Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, network, false)
    local id      = NetworkGetNetworkIdFromEntity(vehicle)

    SetNetworkIdCanMigrate(id, true)
    SetEntityAsMissionEntity(vehicle, true, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(model)

    RequestCollisionAtCoord(coords.x, coords.y, coords.z)

    while not HasCollisionLoadedAroundEntity(vehicle) do
      RequestCollisionAtCoord(coords.x, coords.y, coords.z)
      Citizen.Wait(0)
    end

    SetVehRadioStation(vehicle, 'OFF')

    if cb ~= nil then
      cb(vehicle)
    end

  end)

end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Wait(0)
		math.randomseed(GetGameTimer())
		
        generatedPlate = string.upper(GetRandomNumber(2) .. GetRandomLetter(3) .. GetRandomNumber(3))
		
		ESX.TriggerServerCallback('coffre:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

---- KICK

secondsUntilKick = 20000

kickWarning = true

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1Vous serez kick dans " .. time .. " secondes pour être AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)