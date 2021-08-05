local working = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if IsControlJustPressed(1, 117) then --N7
            if not working then
                print("SERVICE ON")
                TriggerServerEvent("player:serviceOn", "uber")
            else
                print("SERVICE OFF")
                TriggerServerEvent("player:serviceOff", "uber")
            end
            working = not working
        end

        -- Trigger a call of Uber with F9
        if IsControlJustPressed(1, 118) then --N9
            print("Call")
            local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
            TriggerServerEvent("call:makeCall", "uber", {x=plyPos.x,y=plyPos.y,z=plyPos.z})
        end
    end
end)