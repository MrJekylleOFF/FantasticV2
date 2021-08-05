ESX       = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local PlayerData



_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","~b~Faites votre annonce", 5, 100,"shopui_weazelnews","shopui_weazelnews",nil,255,255,255,230)
_menuPool:Add(mainMenu)


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()

    RequestModel(GetHashKey("cs_josh"))
        while not HasModelLoaded(GetHashKey("cs_josh")) do
            Wait(1)
        end
    local ped = CreatePed(4, "cs_josh",Config.pos.x, Config.pos.y, Config.pos.z, Config.pos.h,  false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanBeTargetted(ped, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    RequestAnimDict("missfbi_s4mop")
    while not HasAnimDictLoaded("missfbi_s4mop") do
        Wait(1)
    end
    TaskPlayAnim(ped, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)

    AddAnnonceMenu(mainMenu)
    _menuPool:RefreshIndex()
    _menuPool:WidthOffset(80)
end)

function AddAnnonceMenu(menu)
    local annonce = NativeUI.CreateItem("Passer une annonce", "~b~~h~JOBS~w~, ~h~EVENEMENTS~w~, ~y~~h~DIVERS")
  --  annonce:RightLabel("20$", Colours.Green , Colours.Black)
    menu:AddItem(annonce)

    local event = NativeUI.CreateItem("Proposer un événement", "~b~~h~JOBS~w~, ~h~EVENEMENTS~w~, ~y~~h~DIVERS")
  --  event:RightLabel("70$", Colours.Green , Colours.Black)
    menu:AddItem(event)

    local jobs = NativeUI.CreateItem("Publier votre publicité", "~b~~h~JOBS~w~, ~h~EVENEMENTS~w~, ~y~~h~DIVERS")
  ----  jobs:RightLabel("100$", Colours.Green , Colours.Black)
    menu:AddItem(jobs)

    local recherche
   -- if PlayerData.job.name == "police" then
        recherche = NativeUI.CreateItem("~r~Passer un avis de recherche", "~b~~h~JOBS~w~, ~h~EVENEMENTS~w~, ~y~~h~DIVERS")
        menu:AddItem(recherche)
  --  end


    menu.OnItemSelect = function(_, item, Index)
        if item == annonce then
            Clavier(20, "annonce", "Passer votre annonce:")
        end
        if item == event then
            Clavier(70, "event", "Proposer un événement:")
        end
        if item == jobs then
            Clavier(100, "jobs", "Publier votre publicité:")
        end
        if item == recherche then
            Clavier(0, "recherche", "Passer un avis de recherche:")
        end
    end
end

function Clavier(prix, type, title)
    _menuPool:CloseAllMenus()
    AddTextEntry("dvr_annonce", title)
    DisplayOnscreenKeyboard(1, "dvr_annonce", "", "", "", "", "", 99)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(1)
    end

    if (GetOnscreenKeyboardResult()) then
        local msg = GetOnscreenKeyboardResult()
        print(msg)
        if msg ~= nil and msg ~= "" then
            TriggerServerEvent('dvr:Annonces', msg, prix, type)
        end
    end
end

RegisterNetEvent('dvr:ToAnnonces')
AddEventHandler('dvr:ToAnnonces', function(msg, type)
    local subtitle, color, icon
    if type == "annonce" then
        color = 6
        subtitle = "Annonce"
        icon = "CHAR_LIFEINVADER"
    end
    if type == "event" then
        color = 200
        subtitle = "Événement"
        icon = "DIA_TANNOY"
    end
    if type == "jobs" then
        color = 120
        subtitle = "Emploi"
        icon = "CHAR_LIFEINVADER"
    end
    if type == "recherche" then
       -- color = 211
        color = 202
        subtitle = "Avis de recherche"
        icon = "DIA_POLICE"
    end
	SetNotificationBackgroundColor(color)
	ESX.ShowAdvancedNotification('WEAZEL-NEWS',subtitle, "<C>~u~Message:</C>~n~~s~"..msg, icon, 1)

end)

Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
    while true do
        Wait(0)
        
        _menuPool:ProcessMenus()
        _menuPool:MouseControlsEnabled(false)
        _menuPool:MouseEdgeEnabled(false)
        _menuPool:ControlDisablingEnabled(false)

        --local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        if IsEntityAtCoord(PlayerPedId(), Config.pos.x, Config.pos.y, Config.pos.z, 2.5, 2.5, 2.5, 0, 1, 0) then 

                ESX.ShowHelpNotification("~INPUT_TALK~ pour passer une annonce")

            if IsControlJustPressed(1,51) then
                mainMenu:Visible(not mainMenu:Visible())
            end

        else
            
            mainMenu:Visible(false)
        end    
    end
end)
        