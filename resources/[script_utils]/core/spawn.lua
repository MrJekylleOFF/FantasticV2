-- CHARGEMENT PERSONNAGE (-- DVR --)
local isBlackedOut = false
local time = 9000
local PlayerLoaded
local FirstSpawn = true
local displayHud = true

local function blackout()
	if not isBlackedOut then
		isBlackedOut = true
		Citizen.CreateThread(function()
			DoScreenFadeOut(100)
			while not IsScreenFadedOut() do
				Citizen.Wait(0)
			end
			Citizen.Wait(time)
			DoScreenFadeIn(250)
		end)
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function(spawn)
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(0)
		end
		if FirstSpawn then
			blackout()
			displayHud = false
			ESX.UI.HUD.SetDisplay(0.0)
			TriggerEvent('esx_status:setDisplay', 0.0)
		-----------------------------------------------------
			LoadingPrompt("Chargement du mode Fantastic", 4)
			Wait(9000) -- temps de chargement et local = time 9000
			RemoveLoadingPrompt()
		-----------------------------------------------------
			displayHud = true
			ESX.UI.HUD.SetDisplay(1.0)
			TriggerEvent('esx_status:setDisplay', 1.0)
			isBlackedOut = false
			FirstSpawn = false
		end
	end)
end)

LoadingSpinnerType = {
    Clockwise1 = 1,
    Clockwise2 = 2,
    Clockwise3 = 3,
    SocialClubSaving = 4,
    RegularClockwise = 5
}

function LoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString("STRING")
        AddTextComponentSubstringPlayerName(showText)
        EndTextCommandBusyString(showType)
    end)
end

function LoadingPromptHide()
    if IsLoadingPromptBeingDisplayed() then
        RemoveLoadingPrompt()
    end
end



    