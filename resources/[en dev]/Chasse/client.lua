ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    
    while true do
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
            if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
                if DoesEntityExist(ped) and GetEntityHealth(ped) < 1 and IsPedInAnyVehicle(ped) == false then
                    local pedType = GetPedType(ped)
                    if  pedType == 28 and IsPedAPlayer(ped) == false then
                        if distance <= 1.5 and ped  ~= GetPlayerPed(-1) and ped ~= oldped and ped ~= oldped2 then
                            local valid = IsAnimalLegal(ped)
                            if valid then
                                ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour dépecer l'animal")
                                if IsControlJustPressed(1, 38) then --E
                                    if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_KNIFE") then
                                        oldped2 = oldped
                                        oldped = ped
                                        TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_KNEEL", 0, 1)
                                        Citizen.Wait(8000)
                                        ClearPedTasksImmediately(GetPlayerPed(-1))    
                                        TriggerServerEvent('Chasse:depece')
                                    else
                                        ESX.ShowNotification("Il vous faut un couteau pour récupérer la viande")
                                    end
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

function IsAnimalLegal(ped)
    if GetHashKey("a_c_cat_01") == GetEntityModel(ped) 
    or GetHashKey("a_c_chop") == GetEntityModel(ped) 
    or GetHashKey("a_c_westy") == GetEntityModel(ped) 
    or GetHashKey("a_c_poodle") == GetEntityModel(ped) 
    or GetHashKey("a_c_retriever") == GetEntityModel(ped) 
    or GetHashKey("a_c_rottweiler") == GetEntityModel(ped) 
    or GetHashKey("a_c_shepherd") == GetEntityModel(ped)
    or GetHashKey("a_c_husky") == GetEntityModel(ped) 
    or GetHashKey("a_c_pug") == GetEntityModel(ped) then
        return true
    elseif GetHashKey("a_c_boar") == GetEntityModel(ped)
    or GetHashKey("a_c_pig") == GetEntityModel(ped)
    or GetHashKey("a_c_cow") == GetEntityModel(ped)
    or GetHashKey("a_c_rabbit_01") == GetEntityModel(ped)
    or GetHashKey("a_c_mtlion") == GetEntityModel(ped) 
    or GetHashKey("a_c_hen") == GetEntityModel(ped) 
    or GetHashKey("a_c_deer") == GetEntityModel(ped) then
        return true
    else 
        return false
    end
end
