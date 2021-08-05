Citizen.CreateThread(function()
    local player = GetPlayerPed(-1)
    local currentItemIndex = 1
    local selectedItemIndex = 1
    WarMenu.CreateMenu('menu:main', 'Piratage de la ville')
    WarMenu.SetTitleBackgroundColor('menu:main', 100, 0, 0, 255)
    WarMenu.SetTitleColor('menu:main', 255, 255, 255, 255)

    while true do
        if WarMenu.IsMenuOpened('menu:main') then
			if WarMenu.MenuButton('~r~Stoper le ~w~Trafic', 'menu:main') then
                TriggerEvent("stoptraffic")
            elseif WarMenu.Button('~y~Trafic ~w~ralenti') then
                TriggerEvent("slowtraffic")
            elseif WarMenu.Button('~g~Reprendre le ~w~Trafic') then
                TriggerEvent("resumetraffic")
            elseif WarMenu.Button('_______________') then
            elseif WarMenu.Button('~r~Couper le courant de la ~w~ville') then
                TriggerEvent("control:lumieresstop")
            elseif WarMenu.Button('~r~Allumer le courant de la ~w~ville') then
                TriggerEvent("control:lumieresstart")
            elseif WarMenu.Button('~r~Appeler mes ~w~fans') then
                TriggerEvent("control:tom")
            elseif WarMenu.Button('~r~Vehicule de ~w~Tom') then
                TriggerEvent("control:ufo")
                displayHud = false
                ESX.UI.HUD.SetDisplay(0.0)
                TriggerEvent('esx_status:setDisplay', 0.0)
            elseif WarMenu.Button('~r~DETRUIRE la ~w~ville') then
                TriggerServerEvent("control:wtfboom")
            end

            WarMenu.Display()
       -- elseif IsDisabledControlJustPressed(1, KEYBIND) then -- *OPTIONAL* You can change 'KEYBIND' with an ID from here: https://docs.fivem.net/docs/game-references/controls/
         --   WarMenu.OpenMenu('menu:main')
        end
        Citizen.Wait(0)
    end
end)