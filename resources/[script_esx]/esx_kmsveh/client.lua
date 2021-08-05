ESX = nil
local kmsTotal
local kmsNow = 0 
local posVeh

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    
	while true do Wait(0)
        local playerPed = GetPlayerPed(-1)
		if GetIsVehicleEngineRunning(GetVehiclePedIsIn(playerPed, false)) then
            local veh = GetVehiclePedIsIn(playerPed, false)
            local plate = GetVehicleNumberPlateText(veh)
            
            ESX.TriggerServerCallback('esx_kmveh:getVehicle', function (kms)
                kmsTotal = kms
                TriggerEvent('esx_kmveh:HUD', GroupDigit(math.floor(kmsTotal/1000)).." km")
            end, plate)
            
            while kmsTotal == nil do Wait(0) end
            
            local isInCar = true
            while isInCar do
                Wait(0) 
                local currVeh = GetVehiclePedIsIn(playerPed, false)
                if not posVeh then
                    posVeh = GetEntityCoords(currVeh)
                end
                
                currPos = GetEntityCoords(currVeh)
                local dist = Vdist(posVeh.x, posVeh.y, posVeh.z, currPos.x, currPos.y, currPos.z)
                posVeh = GetEntityCoords(currVeh)
                kmsNow = kmsNow + dist
                
                if IsControlJustPressed(1, 20) and GetLastInputMethod(0) then  --W
                    kmDummy = kmsTotal + kmsNow
                    TriggerEvent('esx_kmveh:HUD', GroupDigit(math.floor(kmDummy/1000)).." km")
                end
            

                if not GetIsVehicleEngineRunning(currVeh) then
                    isInCar = false
                    kmsTotal = kmsTotal + math.floor(kmsNow)
                    kmsNow = 0 
                    posVeh = nil
                    TriggerServerEvent('esx_kmveh:setKms', plate, kmsTotal)
                end
            end    
        end
	end
end)

function GroupDigit(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' .. " "):reverse())..right
end

function text(x,y,scale,text)
    SetTextFont(2)
    SetTextProportional(0)
    SetTextWrap(0.0, 0.745)
    SetTextRightJustify(true) 
    SetTextScale(scale, scale)
    SetTextColour(255,255,255,255)
    SetTextDropShadow(20,255,0,0,255)
    --SetTextEdge(2, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(tostring(text))
    DrawText(x, y)
end

AddEventHandler('esx_kmveh:HUD', function(txt)
    local endTimer = GetGameTimer() + 4000
    while GetGameTimer() < endTimer  do
        text(0.0,0.908,0.5, txt)
        Wait(0)
    end
end)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if kmstotal > 350000 then
            SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
        end
    end
end)]]--


RegisterNetEvent('esx_kmveh:setKmsAdmin')
AddEventHandler('esx_kmveh:setKmsAdmin', function(kms)
    kmsTotal = math.floor(kms*1000)
    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    if plate ~= nil then
        ESX.ShowNotification("Kilométrage défini sur: ~y~"..kms.." ~s~km")
        TriggerServerEvent('esx_kmveh:setKms', plate, kmsTotal)
    else
        ESX.ShowNotification("Veillez a être dans un véhicule")
    end
end)