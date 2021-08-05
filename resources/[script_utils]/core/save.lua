ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj
            Citizen.Wait(0)
        end)
    end
end)

---- notif save ESX save qui sert a rien juste  ( pour faire jolie )
local timer = 3*60000
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(timer) -- 5 M
        SetNotificationBackgroundColor(20)
        ESX.ShowNotification("✅ Position sauvegardée")
    end
end)


