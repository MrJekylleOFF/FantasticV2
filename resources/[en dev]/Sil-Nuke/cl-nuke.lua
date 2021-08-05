
--[[	
	Nuclear bomb server restarts
		By Samuel & Silence	
		
	InteractionSound by Scott
		Allows sounds to be played on single clients, all clients, or all clients within
		a specific range from the entity to which the sound has been created.

--]]

	local biohazard = false
	local alpha = 255
	--local standardVolumeOutput = 0.5

RegisterNetEvent("nuclear:bomb.cl")
RegisterNetEvent("nuclear.cl")
RegisterNetEvent("nuclear:bombfx.cl")
RegisterNetEvent("nuke:explodevehicles")
RegisterNetEvent('InteractSound_CL:Incoming')
RegisterNetEvent('InteractSound_CL:CountDownBeep')
RegisterNetEvent('InteractSound_CL:NukeExplosion')

AddEventHandler("nuclear:bomb.cl", function(resName)
	-- Start all triggers and timers.
	TriggerEvent("nuclear.cl")
	TriggerEvent("nuclear:bombfx.cl")
	  Wait(3000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
	  Wait(1000)
	TriggerEvent("InteractSound_CL:CountDownBeep", "countbeep", 1.0)
end)
AddEventHandler("nuclear.cl", function(resName)
	local dict = "Biohazard"
	local fadedtxd = "nukefaded"
	local littxd = "nukeilluminated"
	if biohazard == false then
		Notif("~y~Attaque nucléaire ~r~ ACTIVER.")
		TriggerEvent("nuclear:bombfx.cl")
		biohazard = true
		RequestStreamedTextureDict(dict, true)
		while not HasStreamedTextureDictLoaded(dict) do
			RequestStreamedTextureDict(dict, true)
		  Wait(0)
		end
		if biohazard then
			TriggerEvent("InteractSound_CL:Incoming", "nukeincome", 1.0)
			  Wait(2000)
			while true do
				DrawSprite(dict, littxd, 0.80, 0.80, 0.1205, 0.20, 0.00, 255, 255, 255, alpha)
				StartNuke = true
			  Wait(0)
			end
		else
			biohazard = false
			StartNuke = false
		end
	else
		Notif("~y~Attaque nucléaire ~r~ DESACTIVER.")
		while true do
			biohazard = false
			StartNuke = false
		  Wait(0)
		end
	end
end)
AddEventHandler("nuclear:bombfx.cl", function(resName)
	local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	  Wait(15*1000)
	TriggerEvent("InteractSound_CL:NukeExplosion", "nukeboom", 1.0)
	StartScreenEffect("PeyoteIn", 1000, false) -- BIG FLASH
	TriggerEvent("nuke:explodevehicles")
	SetCamEffect(1)
	StartEntityFire(ped)
	biohazard = false
	StartNuke = false
	SetWeatherTypeNow("FOGGY")
	SetWeatherTypePersist("FOGGY")
	SetWeatherTypeNowPersist("FOGGY")
	if IsPedOnFoot(ped) then
		local PedPos = GetEntityCoords(ped)
		SetPedToRagdoll(ped, 5000, 5000, 0, true, true, false)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(ped, 1, 0.00, 0.00, 1000.00, true, false, false, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(ped, 1, 0.00, 0.00, 1000.00, true, false, false, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(ped, 1, 0.00, 0.00, 1000.00, true, false, false, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(ped, 1, 0.00, 0.00, 1000.00, true, false, false, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(ped, 1, 0.00, 0.00, 1000.00, true, false, false, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(ped, 1, 0.00, 0.00, 1000.00, true, false, false, true)
	elseif IsPedInAnyVehicle then
		local VehPos = GetEntityCoords(veh)
		ApplyForceToEntityCenterOfMass(veh, 1, 0.00, -99999999.00, 99999999.00, true, true, true, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(veh, 1, 0.00, -1000*1000.00, 100*1000.00, true, true, true, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(veh, 1, 0.00, -1000*1000.00, 100*1000.00, true, true, true, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(veh, 1, 0.00, -1000*1000.00, 100*1000.00, true, true, true, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(veh, 1, 0.00, -1000*1000.00, 100*1000.00, true, true, true, true)
		  Wait(250)
		ApplyForceToEntityCenterOfMass(veh, 1, 0.00, -1000*1000.00, 100*1000.00, true, true, true, true)
	end
	  Wait(3000)
	StopScreenEffect("PeyoteIn") -- Stop flash intro
	StartScreenEffect("PeyoteEndOut", 10*1000, false) -- Big flash fase out
	StartScreenEffect("Damage", 60*1000, false) -- Red damage effect
	--StartScreenEffect("RaceTurbo", 60*1000, false) -- Adrenaline start
	  Wait(60*1000)
	SetCamEffect(0)
	StopAllScreenEffects()
end)
AddEventHandler("nuke:explodevehicles", function ()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
			SetVehicleHasBeenOwnedByPlayer(vehicle, false)
			SetEntityAsMissionEntity(vehicle, false, false)
			ApplyForceToEntityCenterOfMass(vehicle, 1, 0.00, -1000*1000.00, 100*1000.00, true, true, true, true)
			NetworkExplodeVehicle(vehicle, true, false, 0)
			ExplodeVehicle(vehicle, true, false)
            if (DoesEntityExist(vehicle)) then
				NetworkExplodeVehicle(vehicle, true, false, 0)
				ExplodeVehicle(vehicle, true, false)
				ApplyForceToEntityCenterOfMass(vehicle, 1, 0.00, -1000*1000.00, 100*1000.00, true, true, true, true)
			end
        end
    end
end)

local loop = false
Citizen.CreateThread(function()
    while true do
        while biohazard == true do
            if loop == false then
                if alpha < 255 then
                    alpha = alpha+25
                  Wait(1)
                else
                    loop = true
                end
            else
                if alpha > 0 then
                    alpha = alpha-25
                  Wait(1)
                else
                    loop = false
                end
            end
        end
        if biohazard == false then
            if alpha > 0 then
                alpha = alpha-10
              Wait(1)
            end
		end
	  Wait(0)
    end
end)

-- Audio Triggers
AddEventHandler('InteractSound_CL:Incoming', function(soundFile, soundVolume)
	local soundFile = 'nukeincome'
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = Config.standardVolumeOutput
    })
end)
AddEventHandler('InteractSound_CL:CountDownBeep', function(soundFile, soundVolume)
	local soundFile = 'countbeep'
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = Config.standardVolumeOutput
    })
end)
AddEventHandler('InteractSound_CL:NukeExplosion', function(soundFile, soundVolume)
	local soundFile = 'nukeboom'
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = Config.standardVolumeOutput
    })
end)

-- Functions
function Notif( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

	-- I actually didn't make this part, I believe this comes from the Delete all vehicles script, Can't remember.
local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
	enum.handle = nil
  end
}
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
    	local iter, id = initFunc()
    	if not id or id == 0 then
      		disposeFunc(iter)
      	return
    end
    	local enum = {handle = iter, destructor = disposeFunc}
    	setmetatable(enum, entityEnumerator)
    	local next = true
    repeat
      	coroutine.yield(id)
      	next, id = moveFunc(iter)
    until not next
    	enum.destructor, enum.handle = nil, nil
    	disposeFunc(iter)
  	end)
end
function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
