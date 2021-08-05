ESX = nil

local weapons = {
    [0x1B06D571] = {
        label = 'WEAPON_PISTOL',
        silencieux = 0x65EA7EBB, 
        lampe = 0x359B7AAE, 
        poignee = nil, 
        skin = 0xD7391086, 
        extentionchargeur = 0xED265A1C,
        scope = nil,
        munitions = '9 mm'
    },

    [GetHashKey('WEAPON_PISTOL_MK2')] = {
        label = 'WEAPON_PISTOL_MK2',
        silencieux = 0x65EA7EBB, 
        lampe = 0x43FD595B, 
        poignee = nil, 
        skin = nil, 
        extentionchargeur = 0x5ED6C128,
        scope = nil,
        munitions = '9 mm'
    },

    [-1716589765] = { 
        label = 'WEAPON_PISTOL50',
        silencieux = 0xA73D4664,
        lampe = 0x359B7AAE,
        poignee = nil,
        skin = 0x77B8AB2F,
        extentionchargeur = 0xD9D3AC92,
        scope = nil,
        munitions = '357 Magnum'
    },

    [0x5EF9FEC4] = { 
        label = 'WEAPON_COMBATPISTOL',
        silencieux = 0xC304849A,
        lampe = 0x359B7AAE,
        poignee = nil,
        skin = 0xC6654D72,
        extentionchargeur = 0xD67B4F2D,
        scope = nil,
        munitions = '9 mm'
    },

    [0x22D8FE39] = { 
        label = 'WEAPON_APPISTOL',
        silencieux = 0xC304849A, 
        lampe = 0x359B7AAE,
        poignee = nil, 
        skin = 0x9B76C72C,
        extentionchargeur = 0x249A17D5,
        scope = nil,
        munitions = '9 mm'
    },

    --[GetHashKey('WEAPON_HEAVYPISTOL')] = { silencieux = GetHashKey('COMPONENT_AT_PI_SUPP'), lampe = GetHashKey('COMPONENT_AT_PI_FLSH'), poignee = nil, skin = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE') },
    --[GetHashKey('WEAPON_VINTAGEPISTOL')] = { silencieux = GetHashKey('COMPONENT_AT_PI_SUPP'), lampe = nil, poignee = nil, skin = nil },
   
    [0x2BE6766B] = { 
        label = 'WEAPON_SMG',
        silencieux = 0xC304849A, 
        lampe = 0x7BC4CDDC,
        poignee = nil,
        skin = 0x27872C90, 
        extentionchargeur = 0x350966FB,
        scope = 0x3CC6BA57,
        munitions = '.45 ACP'
    },

    [0x13532244] = { 
        label = 'WEAPON_MICROSMG',
        silencieux = 0xA73D4664, 
        lampe = 0x359B7AAE, 
        poignee = nil, 
        skin = 0x487AAE09, 
        extentionchargeur = 0x10E6BA2B, 
        scope = 0x9D2FBF29,
        munitions = '9 mm',
    },
   
    [-270015777] = { 
        label = 'WEAPON_ASSAULTSMG',
        silencieux = 0xA73D4664, 
        lampe = 0x7BC4CDDC, 
        poignee = nil, 
        skin = 0x278C78AF, 
        extentionchargeur = 0xB1214F9B,
        scope = 0x9D2FBF29,
        munitions = '.45 ACP'
    },

    [-1074790547] = { 
        label = 'WEAPON_ASSAULTRIFLE',
        silencieux = 0xA73D4664, 
        lampe = 0x7BC4CDDC, 
        poignee = 0xC164F53, 
        skin = 0x4EAD7533,
        extentionchargeur = 0xB1214F9B,
        scope = 0x9D2FBF29,
        munitions = '7.62 mm'
    },

    [-2084633992] = { 
        label = 'WEAPON_CARBINERIFLE',
        silencieux = 0x837445AA, 
        lampe = 0x7BC4CDDC, 
        poignee = 0xC164F53, 
        skin = 0xD89B9658,
        extentionchargeur = 0x91109691,
        scope = 0xA0D89C42,
        munitions = '9 mm',
    },

    [-1357824103] = { 
        label = 'WEAPON_ADVANCEDRIFLE',
        silencieux = 0x837445AA, 
        lampe = 0x7BC4CDDC,
        poignee = nil, 
        skin = 0x377CD377,
        extentionchargeur = 0x8EC1C979,
        scope = 0xAA2C45B4,
        munitions = '7.62 mm'
    },

    [-1063057011] = { 
        label = 'WEAPON_SPECIALCARBINE',
        silencieux = 0xA73D4664, 
        lampe = 0x7BC4CDDC,
        poignee = 0xC164F53, 
        skin = 0x730154F2, 
        extentionchargeur = 0x7C8BD10E,
        scope = 0xA0D89C42,
        munitions = '9 mm'
    },

    [GetHashKey('WEAPON_BULLPUPRIFLE')] = {
        label = "WEAPON_BULLPUPRIFLE",
        silencieux = 0x837445AA, 
        lampe = 0x7BC4CDDC, 
        poignee = 0xC164F53, 
        extentionchargeur = 0xB3688B0F,
        skin = 0xA857BC78,
        scope = 0xAA2C45B4,
        munitions = '7.62 mm' 
    },
 
    [0x1D073A89] = { 
        label = 'WEAPON_PUMPSHOTGUN',
        silencieux = 0xE608B35E, 
        lampe = 0x7BC4CDDC, 
        poignee = nil,
        skin = 0xA2D79DDB,
        extentionchargeur = nil,
        scope = nil,
        munitions = '12 mm'
    },
   
    --[GetHashKey('WEAPON_MARKSMANRIFLE')] = { silencieux = GetHashKey('COMPONENT_AT_AR_SUPP'), lampe = GetHashKey('COMPONENT_AT_AR_FLSH'), poignee = GetHashKey('COMPONENT_AT_AR_AFpoignee'), skin = nil },
   
    [0x05FC3C11] = { 
        label = 'WEAPON_SNIPERRIFLE',
        silencieux = 0xA73D4664, 
        lampe = nil, 
        poignee = nil, 
        skin = 0x4032B5E7,
        extentionchargeur = nil,
        scope = 0xBC54DA77,
        munitions = '7.62 mm'
    },
   -- [GetHashKey('WEAPON_COMBATPDW')] = { silencieux = nil, lampe = GetHashKey('COMPONENT_AT_AR_FLSH'), poignee = GetHashKey('COMPONENT_AT_AR_AFpoignee'), skin = nil }
}
 
-- ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
 
-- ESX, playerloaded
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
 
-- Use item
RegisterNetEvent('eden_accesories:use')
AddEventHandler('eden_accesories:use', function( type )

    local label = GetlabelWeapon()

    if weapons[GetSelectedPedWeapon(PlayerPedId())] and weapons[GetSelectedPedWeapon(PlayerPedId())][type] then
        if not HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type]) then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            ESX.ShowNotification(string.format('%s %s', "Vous avez équiper ", type))
            if label then 
               TriggerServerEvent('eden_accesories:SaveComponnent', label, type)
            end   
        else
            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            ESX.ShowNotification(string.format('%s %s', "vous avez retiré ", type))

        end
    else
        ESX.ShowNotification(string.format('%s %s %s', 'Le ', type, " ne tient pas sur votre arme.."))
        TriggerServerEvent('eden_accesories:ReturnIsNotValid', type)
    end
end)

function GetlabelWeapon()
    for k,v in pairs(weapons) do
        local PlayerChoise = GetSelectedPedWeapon(PlayerPedId())

        if PlayerChoise == k then
          label = v.label
          break
        end 
    end
    return label 
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 56) then
            local label = GetlabelWeapon()
			if weapons[GetSelectedPedWeapon(PlayerPedId())] then
				for k,v in pairs(weapons) do
					if GetSelectedPedWeapon(PlayerPedId()) == k then
						if HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.silencieux) then
							TriggerServerEvent('eden_accesories:giveBack', 'silent')
							ESX.ShowNotification("Vous avez retiré un silencieux")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.silencieux)
                            TriggerServerEvent('eden_accesories:RemoveComponnent', label , 'silencieux')

						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.lampe) then
							TriggerServerEvent('eden_accesories:giveBack', 'flashlight')
							ESX.ShowNotification("Vous avez retiré une lampe")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.lampe)
                            TriggerServerEvent('eden_accesories:RemoveComponnent', label , 'lampe')

						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.skin) then
							TriggerServerEvent('eden_accesories:giveBack', 'yusuf')
							ESX.ShowNotification("Vous avez retiré skin")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.skin)
                            TriggerServerEvent('eden_accesories:RemoveComponnent', label , 'skin')

						elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.poignee) then
							TriggerServerEvent('eden_accesories:giveBack', 'grip')
							ESX.ShowNotification("Vous avez retiré une poignée")
							RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.poignee)
                            TriggerServerEvent('eden_accesories:RemoveComponnent', label , 'poignee')

                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.extentionchargeur) then
                            TriggerServerEvent('eden_accesories:giveBack', 'magazine')
                            ESX.ShowNotification("Vous avez retiré un chargeur grande capacité")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.extentionchargeur)
                            TriggerServerEvent('eden_accesories:RemoveComponnent', label , 'extentionchargeur')

                        elseif HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope) then
                            TriggerServerEvent('eden_accesories:giveBack', 'scope')
                            ESX.ShowNotification("Vous avez retiré une lunette")
                            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), v.scope)
                            TriggerServerEvent('eden_accesories:RemoveComponnent', label , 'lunette')
						end
					end
				end
			end
		end
	end
end)
