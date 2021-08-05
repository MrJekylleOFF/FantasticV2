local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Location","~r~Blista sans permis", 8, 200,nil,nil,nil)
_menuPool:Add(mainMenu)



function AddMenuJobMenu(menu)
    for i = 1 , #Config.Cars,1 do
        local job = NativeUI.CreateItem(GetLabelText(GetDisplayNameFromVehicleModel(Config.Cars[i].model)),"~r~"..GetLabelText(GetDisplayNameFromVehicleModel(Config.Cars[i].model)).. "~s~ → " .. Config.Cars[i].price .."$")
        job:RightLabel(Config.Cars[i].price.." $", Colours.Green , Colours.Black)
        menu:AddItem(job)
    end
    menu.OnItemSelect = function(_,_,Index)

        ESX.TriggerServerCallback('location:buyVehicle', function (hasMoney)
            local vehicle = GetClosestVehicle(currentLoc.spawn.x, currentLoc.spawn.y, currentLoc.spawn.z, 3.0, 0, 71)
            if not DoesEntityExist(vehicle) then
                if hasMoney then
                    ESX.Game.SpawnVehicle(Config.Cars[Index].model, {x = currentLoc.spawn.x, y = currentLoc.spawn.y, z = currentLoc.spawn.z}, currentLoc.spawn.h, function(vehicle)
                        SetVehicleNumberPlateText(vehicle, "LOCA"..math.random(1000,1999))
                        ESX.ShowNotification("Bonne route!")
                    end)
                    _menuPool:CloseAllMenus()
                else
                    ESX.ShowNotification("Je n'ai pas assez d'argent")
                end
            else
                ESX.ShowNotification("Un véhicule est deja sorti")
            end
        end, Config.Cars[Index].price)
    end
end

_menuPool:WidthOffset(90)
_menuPool:MouseEdgeEnabled(false);
_menuPool:RefreshIndex()
