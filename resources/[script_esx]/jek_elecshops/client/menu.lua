RMenu.Add('showcase', 'shopMenu', RageUI.CreateMenu("Informatique", "~b~Magasin", 8, 200, nil, nil, 213, 170, 115))
RMenu:Get('showcase', 'shopMenu').EnableMouse = false

local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end


local nombre = {}

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('showcase', 'shopMenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for k, v in pairs(Config.JEKYLLE.Items) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1) .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index

                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('jek_elecshops:giveItem', v, count)
                    end
                end)
            end
        end)
    end
end, 1)