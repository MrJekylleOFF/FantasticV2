ESX = nil
local grade = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    grade = PlayerData.job.grade
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData = ESX.GetPlayerData()
    grade = PlayerData.job.grade
end)

AddEventHandler('playerSpawned', function(spawn)
    Wait(10000)
    grade = PlayerData.job.grade
end)


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("LSPD Armurerie", "~b~Armurerie de la LSPD")
_menuPool:Add(mainMenu)
_menuPool:WidthOffset(80)

--Citizen.CreateThread(function()
--    while true do
--        while ESX == nil do
--            Wait(100)
--        end
--        if not _menuPool:IsAnyMenuOpen() then
--            mainMenu:Clear()
--            FirstItem(mainMenu)
--        end
--        Wait(5000)
--    end
--end)


function FirstItem(menu) 

    local depose = NativeUI.CreateColouredItem("Déposer son équipement", "Déposez votre ~b~équipement.", Colours.RedDark, Colours.Red)
    depose:SetRightBadge(BadgeStyle.Alert)
    menu:AddItem(depose)

    if grade >= 0 then
        matraque = NativeUI.CreateItem("Matraque", "Permet de récuperer une matraque")
        menu:AddItem(matraque)
        lampe = NativeUI.CreateItem("Lampe torche", "Permet de récuperer une lampe torche")
        menu:AddItem(lampe)
        tazer = NativeUI.CreateItem("Tazer", "Permet de récuperer un tazer")
        menu:AddItem(tazer)
        parachute = NativeUI.CreateItem("Parachute", "Permet de récuperer un parachute")
        menu:AddItem(parachute)
    end

    if grade >= 1 then
        pistolc = NativeUI.CreateItem("Pistolet de combat", "Permet de récuperer un pistolet de combat")
        menu:AddItem(pistolc)
        fumigene = NativeUI.CreateItem("Fumigène", "Permet de récuperer une fumigène")
        menu:AddItem(fumigene)
        sniper = NativeUI.CreateItem("Sniper", "Permet de récuperer un sniper")
        menu:AddItem(sniper)
        carabine = NativeUI.CreateItem("Carabine", "Permet de récuperer un fusil d'assault")
        menu:AddItem(carabine)
        smg = NativeUI.CreateItem("Smg", "Permet de récuperer une smg")
        menu:AddItem(smg)
        fusil = NativeUI.CreateItem("Fusil a pompe", "Permet de récuperer un fusil a pompe")
        menu:AddItem(fusil)
    end

    if grade >= 2 then

    end

    if grade >= 4 then

    end

    if grade >= 5 then
    end 

    menu.OnItemSelect = function(sender, item, index)
        if item == pistolc then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_COMBATPISTOL", "pistol")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_COMBATPISTOL", 255, false, false)

            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ton pistolet de combat, le perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == matraque then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_NIGHTSTICK", "pistol")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_NIGHTSTICK", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ton matraque téléscopique, le perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == lampe then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_FLASHLIGHT", "pistol")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_COMBATPISTOL", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ta lampe torche, le perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == smg then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_SMG", "pistol")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_SMG", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ta SMG, la perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == carabine then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_CARBINERIFLE", "rifle")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_CARBINERIFLE", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ton fusil d\'assault, le perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == fusil then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_PUMPSHOTGUN", "shotgun")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_PUMPSHOTGUN", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ton fusil a pompe, le perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == tazer then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_STUNGUN", "pistol")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_STUNGUN", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ton tazer, le perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == fumigene then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_SMOKEGRENADE", "pistol")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_SMOKEGRENADE", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ta fumigène, la perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == sniper then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("WEAPON_HEAVYSNIPER", "rifle")
            GiveWeaponToPed(PlayerPedId(), "WEAPON_SMOKEGRENADE", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ton sniper, la perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == parachute then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            GetWeaponByPed("GADGET_PARACHUTE", "rifle")
            GiveWeaponToPed(PlayerPedId(), "GADGET_PARACHUTE", 255, false, false)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Voila ton parachute, la perd pas.', 'CHAR_AMMUNATION', 1)
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
            OpenArmoryMenu()
        elseif item == depose then
            PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
            ESX.ShowAdvancedNotification('LSPD INFO', '~b~Armurie LSPD', 'Vous voulez déposez vos armes de services ? Aucun problème je m\'en occupe.', 'CHAR_AMMUNATION', 1)
            local ped = GetPlayerPed(-1)
            DeposeEquipement("WEAPON_PISTOL", "pistol")
            RemoveAllPedWeapons(ped, false)
        end
    end 

end


local count = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        while ESX == nil do
            Citizen.Wait(10)
        end
        _menuPool:ProcessMenus()
        if count == 0 then
            FirstItem(mainMenu)
            count = 1
        end
    end
end)


_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false);
_menuPool:MouseEdgeEnabled (false);
_menuPool:ControlDisablingEnabled(false);
_menuPool:WidthOffset(80)



function OpenArmoryMenu(station)
    mainMenu:Clear()
    FirstItem(mainMenu)
    Wait(100)
    mainMenu:Visible(not mainMenu:Visible())
end

RegisterNetEvent('armory')
AddEventHandler('armory', function()
	OpenArmoryMenu(station)
end)