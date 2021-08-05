RMenu.Add('showcase', 'shopMenu', RageUI.CreateMenu("Superette", "~b~Apu", 8, 200, nil, nil, 213, 170, 115))
RMenu:Get('showcase', 'shopMenu').EnableMouse = false

RMenu.Add('showcase', 'submenu1', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Superette", "~b~Nourriture"))
RMenu.Add('showcase', 'submenu2', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Superette", "~b~Boisson"))
RMenu.Add('showcase', 'submenu3', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Superette", "~b~Autres"))
RMenu.Add('showcase', 'submenu4', RageUI.CreateSubMenu(RMenu:Get('showcase', 'shopMenu'), "Superette", "~b~Parametres"))

RMenu:Get('showcase', 'submenu1'):SetRectangleBanner(100, 0, 0, 255)
RMenu:Get('showcase', 'submenu2'):SetRectangleBanner(100, 0, 0, 255)
RMenu:Get('showcase', 'submenu3'):SetRectangleBanner(100, 0, 0, 255)
RMenu:Get('showcase', 'submenu4'):SetRectangleBanner(100, 0, 0, 255)
RMenu:Get('showcase', 'shopMenu'):SetRectangleBanner(100, 0, 0, 255)

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

local percent = 100
local a = 255
local nombre = {}

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('showcase', 'shopMenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Nourriture", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                if (Selected) then
     
               end
               end, RMenu:Get('showcase', 'submenu1'))

            RageUI.Button("Boisson", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                 if (Selected) then
            
                  end
               end, RMenu:Get('showcase', 'submenu2'))
            
            RageUI.Button("Autres", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                if (Selected) then
           
                 end
              end, RMenu:Get('showcase', 'submenu3')) 

            RageUI.Button("Parametres", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)     
                if (Selected) then
           
                 end
              end, RMenu:Get('showcase', 'submenu4')) 

            end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'submenu1')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for k, v in pairs(Config.JEKYLLE.Items.Manger) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1) .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index

                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('jek_shops:giveItem', v, count)
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'submenu2')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for k, v in pairs(Config.JEKYLLE.Items.Boire) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1)  .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index


                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('jek_shops:giveItem', v, count)
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'submenu3')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for k, v in pairs(Config.JEKYLLE.Items.Autres) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1)  .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index


                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('jek_shops:giveItem', v, count)
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'submenu4')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.List('Couleur', index3, index2.items, nil, { }, true, function(hovered, active, selected, Index)
                    index2.items = Index 

                    if active then
                        if index3[Index] == 'Bleu' then
                            colorX = 0
                            colorY = 0
                            colorZ = 255
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~b~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~b~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~b~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~b~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~b~Parametres")
                        elseif index3[Index] == 'Rouge' then
                            colorX = 255
                            colorY = 0
                            colorZ = 0
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~r~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~r~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~r~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~r~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~r~Parametres")
                        elseif index3[Index] == 'Vert' then
                            colorX = 0
                            colorY = 255
                            colorZ = 0
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~g~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~g~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~g~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~g~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~g~Parametres")
                        elseif index3[Index] == 'Jaune' then
                            colorX = 255
                            colorY = 255
                            colorZ = 0
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~y~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~y~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~y~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~y~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~y~Parametres")
                        elseif index3[Index] == 'Orange' then
                            colorX = 255
                            colorY = 123
                            colorZ = 0
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~o~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~o~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~o~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~o~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~o~Parametres")
                        elseif index3[Index] == 'Rose' then
                            colorX = 255
                            colorY = 0
                            colorZ = 255
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~w~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~w~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~w~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~w~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~w~Parametres")
                        elseif index3[Index] == 'Violet' then
                            colorX = 160
                            colorY = 0
                            colorZ = 255
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~p~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~p~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~p~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~p~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~p~Parametres")
                        elseif index3[Index] == 'Noir' then
                            colorX = 0
                            colorY = 0
                            colorZ = 0
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~w~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~w~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~w~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~w~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~w~Parametres")
                        elseif index3[Index] == 'Gris' then
                            colorX = 135
                            colorY = 135
                            colorZ = 135
                            RMenu:Get('showcase', 'shopMenu'):SetSubtitle("~c~Superette")
                            RMenu:Get('showcase', 'submenu1'):SetSubtitle("~c~Nourriture")
                            RMenu:Get('showcase', 'submenu2'):SetSubtitle("~c~Boisson")
                            RMenu:Get('showcase', 'submenu3'):SetSubtitle("~c~Autres")
                            RMenu:Get('showcase', 'submenu4'):SetSubtitle("~c~Parametres")
                        end
                    end
                end)
        end, function()
            ---Panels
            RageUI.PercentagePanel(percent, "Opacité", "0%", "100%", function(Hovered, Selected, Percent)
                RMenu:Get('showcase', 'submenu4').EnableMouse = true
                if Selected then
                a = Percent * 255
                percent = Percent
                end
                RMenu:Get('showcase', 'submenu1'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'submenu2'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'submenu3'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'submenu4'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
                RMenu:Get('showcase', 'shopMenu'):SetRectangleBanner(colorX, colorY, colorZ, math.round(a))
            end)
        end)
    end
end, 1)