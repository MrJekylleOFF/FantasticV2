ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

print("Ped GOOD")
Citizen.CreateThread(function(Ped, anim, animbone)
    while true do
        Citizen.Wait(10)
        for _,location in ipairs(pnj) do
            x = location[1]
            y = location[2]
            z = location[3]
            heading = location[4]

            model = location[5]

            anim = location[6]
            animbone = location[7]
        
            local Hash = GetHashKey(model)
            local Ped = CreatePed(1, Hash, x,y,z-0.95, 0.0, false, true)
            if not HasModelLoaded(Hash) then
                RequestModel(Hash)
                Citizen.Wait(20)
            end
            SetEntityHeading(Ped, heading)
            FreezeEntityPosition(Ped, true)
            loadAnimDict(anim)
            TaskPlayAnim(Ped, anim, animbone, 1.0,-1.0, -1, 1, 1, true, true, true)
            
        end
    end
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

pnj = {
    {-1766.54,-262.22,49.05,231.39,     "ig_milton","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1760.42,-262.45,49.09,97.06,      "cs_milton","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1763.55,-267.0,48.38,354.8,       "cs_movpremmale","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1765.95,-261.52,49.17,229.2,      "s_m_m_movprem_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1765.3,-260.81,49.24,241.2,       "u_m_m_jewelsec_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"}, 
    {-1764.3,-260.19,49.29,196.9,       "ig_chengsr","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1760.95,-264.32,48.83,39.74,      "s_m_y_dealer_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1767.0,-263.31,48.95,271.03,      "mp_f_boatstaff_01","amb@world_human_hang_out_street@female_arms_crossed@base","base"},
    {-1760.54,-263.47,48.95,72.03,      "a_c_chop"},
}