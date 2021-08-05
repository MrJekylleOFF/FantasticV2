ESX = nil
menu = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.JEKYLLE.Positions) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)

		SetBlipSprite(blip, 110)
		SetBlipScale (blip, 0.7)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Armurerie')
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k, v in pairs(Config.JEKYLLE.Positions) do
			local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

            if distance < 10.0 then
                actualZone = v

                zoneDistance = GetDistanceBetweenCoords(playerCoords, actualZone.x, actualZone.y, actualZone.z, true)

				DrawMarker(29, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, nil, nil, false)
            end
            
            if distance <= 1.5 then
                ESX.ShowHelpNotification('~INPUT_CONTEXT~ pour ouvrir le menu')

                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(RMenu:Get('showcase', 'shopMenu'), not RageUI.Visible(RMenu:Get('showcase', 'shopMenu')))
                end
            end

            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    RageUI.CloseAll()
                end
            end
        end
    
	end
end)

-- spawn de Apu

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_ammucity_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	for k,v in pairs(Config.JEKYLLE.Apu) do
	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_ammucity_01", v.x, v.y, v.z, v.a, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
	end
end)

RMenu.Add('showcase', 'shopMenu', RageUI.CreateMenu("Armurerie", "Bienvenue !", nil, nil, nil, nil, 213, 170, 115))
RMenu:Get('showcase', 'shopMenu').EnableMouse = false

RMenu.Add('showcase', 'blanche', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Armurerie", "~b~Armes Blanches"))
RMenu.Add('showcase', 'armefeu', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Armurerie", "~b~Armes a feu | Tazer"))

RMenu.Add('showcase', 'chargeur', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Armurerie", "~b~Chargeurs"))
RMenu.Add('showcase', 'parametres', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Armurerie", "~b~Parametres"))


local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local index = {
    items = 1
}

local index2 = {
     items = 1
}

index3 = {
    "Bleu",
    "Rouge",
    "Vert",
    "Jaune",
    "Orange",
    "Rose",
    "Violet",
    "Gris",
    "Noir"
}

local max = 50 -- number of items that can be selected
Numbers = {}

Citizen.CreateThread(function()
    for i = 1, max do
        table.insert(Numbers, i)
    end
end)

local percent = 100
local a = 255
local nombre = {}

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('showcase', 'shopMenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Armes blanches", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                if (Selected) then
     
               end
               end, RMenu:Get('showcase', 'blanche'))

               ESX.TriggerServerCallback('jek_weaponshops:checkLicense', function(cb)            
                if cb then
                    ESX.TriggerServerCallback('jek_weaponshops:checkVisite', function(cb2)            
                        if cb2 then
                          menu = true 
                        else 
                            ESX.ShowNotification("~o~Tu n'as pas ta visite médicale.")
                         menu = false   
                        end 
                      end)
                else 
                 ESX.ShowNotification("~o~Tu n'as pas ta license d'armes.")
                 menu = false   
                end
                 
              end)
              
              if menu then 
              RageUI.Button("Armes a feu | Tazer", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                if (Selected) then
              
                end
              end, RMenu:Get('showcase', 'armefeu')) 
              
              else 
                RageUI.Button("Armes a feu | Tazer", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
                    if (Selected) then
                        print('testttt')
                    end
                  end) 
                end

              RageUI.Button("Chargeurs", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                if (Selected) then
           
                 end
              end, RMenu:Get('showcase', 'chargeur')) 

            RageUI.Button("Parametres", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                if (Selected) then
           
                 end
              end, RMenu:Get('showcase', 'parametres')) 

            end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'blanche')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for k, v in pairs(Config.JEKYLLE.Type.Blanche) do
                RageUI.Button(v.Label .. ' (Prix: ' .. v.Price .. '$)', nil, { }, true, function(Hovered, Active, Selected)

                    if Selected then
                        TriggerServerEvent('jek_weaponshops:giveWeapon', v)
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'armefeu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for k, v in pairs(Config.JEKYLLE.Type.Armes) do
                RageUI.Button(v.Label .. ' (Prix: ' .. v.Price .. '$)', nil, { }, true, function(Hovered, Active, Selected)

                    if Selected then
                        TriggerServerEvent('jek_weaponshops:giveWeapon', v)
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'chargeur')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for k, v in pairs(Config.JEKYLLE.Item.Chargeur) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1) .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index

                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('jek_weaponshops:giveItem', v, count)
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'parametres')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.List('Couleur', index3, index2.items, nil, { }, true, function(hovered, active, selected, Index)
                    index2.items = Index 

                    if active then
                        if index3[Index] == 'Bleu' then
                            colorX = 0
                            colorY = 0
                            colorZ = 255
                            color = '~b~'
                        elseif index3[Index] == 'Rouge' then
                            colorX = 255
                            colorY = 0
                            colorZ = 0
                            color = '~r~'
                        elseif index3[Index] == 'Vert' then
                            colorX = 0
                            colorY = 255
                            colorZ = 0
                            color = '~g~'
                        elseif index3[Index] == 'Jaune' then
                            colorX = 255
                            colorY = 255
                            colorZ = 0
                            color = '~y~'
                        elseif index3[Index] == 'Orange' then
                            colorX = 255
                            colorY = 123
                            colorZ = 0
                            color = '~o~'
                        elseif index3[Index] == 'Rose' then
                            colorX = 255
                            colorY = 0
                            colorZ = 255
                            color = '~w~'
                        elseif index3[Index] == 'Violet' then
                            colorX = 160
                            colorY = 0
                            colorZ = 255
                            color = '~p~'
                        elseif index3[Index] == 'Noir' then
                            colorX = 0
                            colorY = 0
                            colorZ = 0
                            color = '~w~'
                        elseif index3[Index] == 'Gris' then
                            colorX = 135
                            colorY = 135
                            colorZ = 135
                            color = '~c~'
                        end

                        RMenu:Get('showcase', 'shopMenu'):SetSubtitle(color .. "Armurerie")
                        RMenu:Get('showcase', 'blanche'):SetSubtitle(color .. "Armes Blanches")
                        RMenu:Get('showcase', 'armefeu'):SetSubtitle(color .. "Armes a feux | Tazer")
                        RMenu:Get('showcase', 'chargeur'):SetSubtitle(color .. "Chargeurs")
                        RMenu:Get('showcase', 'parametres'):SetSubtitle(color .. "Parametres")
                    end
                end)
        end, function()
            ---Panels
            RageUI.PercentagePanel(percent, "Opacité", "0%", "100%", function(Hovered, Selected, Percent)
                RMenu:Get('showcase', 'parametres').EnableMouse = true
                if Selected then
                a = Percent * 255
                percent = Percent
                end
                RMenu:Get('showcase', 'blanche'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'armefeu'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'chargeur'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'parametres'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'shopMenu'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
            end)
        end)
    end
end, 1)