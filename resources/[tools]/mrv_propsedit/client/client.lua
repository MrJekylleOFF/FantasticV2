-- MRV#0001

-- Utils
local props = {}
local currentObject = nil
local currentObjectIsAttached = false
local sensibilityMultiplier = 1
local saveX, saveY, save
local currentPropX, currentPropY, currentPropZ

local function showNotification(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(true, true)
end

local function addProp(propObject, propName)
    table.insert(props, {object = propObject, name = propName})
end

local function removeProp(propObject)
    for i = 1, #props do
        if (props[i] == propObject) then
            table.remove(props, i)
        end
    end
end

RegisterNetEvent("mrv_propsedit:addProp")
AddEventHandler("mrv_propsedit:addProp", addProp)

RegisterNetEvent("mrv_propsedit:removeProp")
AddEventHandler("mrv_propsedit:removeProp", removeProp)

local index, newRotation = {rotation = 1, x = 1, y = 1, z = 1, sensibility = 1}, nil

local function getClObject()
    local object = nil

    for k, v in pairs(props) do
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        local closestObject = GetClosestObjectOfType(x, y, z, 5.0, v.name, false, 0, 0)

        if (closestObject ~= 0) then
            object = closestObject

            break
        end
    end

    return object
end

local function generateTableWithNumbers(numbers)
    local theTable = {}

    for i = 1, numbers do
        table.insert(theTable, i)
    end

    return theTable
end

local function drawMarker(x, y, z)
    DrawMarker(22, x, y, z, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, true, false, 0, false, nil, nil, false)
end

local function attachObjectToVehicle(object, vehicle, boneIndex)
    local x, y, z = 
    (saveX) or 0.0, 
    (saveY) or 0.0, 
    (saveZ) or 0.5

    AttachEntityToEntity(object, vehicle, boneIndex, x, y, z, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
end

RegisterNetEvent("mrv_propsedit:cl_open")
AddEventHandler("mrv_propsedit:cl_open", function()
    RageUI.Visible(RMenu:Get("propsEdit", "main"), not RageUI.Visible(RMenu:Get("propsEdit", "main")))
end)

-- Menu
RMenu.Add("propsEdit", "main", RageUI.CreateMenu("propsEdit", "~b~ACTIONS DISPONIBLES", 5, 150))

RMenu:Get("propsEdit", "main").Closed = function()
    currentObject = nil
end

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('propsEdit', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Button("Réinitialiser la position de spawn", nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    saveX, saveY, saveZ = nil, nil, nil
                end
            end)

            RageUI.Button("Attacher l'objet dans le coffre du véhicule", nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    if DoesEntityExist(currentObject) then
                        local plyVehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                        
                        if (DoesEntityExist(plyVehicle)) then
                            local boneIndex = GetEntityBoneIndexByName(plyVehicle, "chassis")
                            
                            attachObjectToVehicle(currentObject, plyVehicle, boneIndex)

                            currentPropX, currentPropY, currentPropZ = table.unpack(GetEntityCoords(currentObject))

                            print(currentPropX, currentPropY, currentPropZ)

                            currentObjectIsAttached = true

                            showNotification("Objet attaché dans le coffre ~g~avec succès.")
                        else
                            showNotification("~r~Aucun véhicule~s~ trouvé.")
                        end
                    end
                end
            end)

            RageUI.Button("Détacher l'objet du coffre", nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    if DoesEntityExist(currentObject) then
                        local ply = PlayerPedId()
                        local plyVehicle = GetVehiclePedIsIn(ply, true)
                        local x, y, z = table.unpack(GetEntityCoords(plyVehicle))
                        
                        if (DoesEntityExist(plyVehicle)) then
                            DetachEntity(currentObject, false, true)
                            SetEntityCoords(currentObject, x + 5, y, z - 0.5, false, false, false, true)

                            currentObjectIsAttached = false

                            showNotification("Objet détaché du le coffre ~g~avec succès.")
                        else
                            showNotification("~r~Aucun véhicule~s~ trouvé.")
                        end
                    end
                end
            end)

            RageUI.Slider("X", index.x, 100, nil, false, { }, true, function(Hovered, Active, Selected, Index)
                if (index.x ~= Index) then
                    if DoesEntityExist(currentObject) then
                        local x, y, z = table.unpack(GetEntityCoords(currentObject))
                        local newX
                        local plyVehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                        local boneIndex = GetEntityBoneIndexByName(plyVehicle, "chassis")
                        
                        DetachEntity(currentObject, 0, false)

                        if (index.x < Index) then
                            newX = (x - ((index.x / 150) / (1 * sensibilityMultiplier)))
                        elseif (index.x > Index) then
                            newX = (x + ((index.x / 150) / (1 * sensibilityMultiplier)))
                        end

                        SetEntityCoordsNoOffset(currentObject, newX, y, z, false, false, false)
                        --SetEntityCoords(currentObject, newX, y, z, false, false, false, true)

                        saveX = (currentPropX ~= nil) and (newX - currentPropX) or nil
                    end
                end

                index.x = Index
            end)

            RageUI.Slider("Y", index.y, 100, nil, false, { }, true, function(Hovered, Active, Selected, Index)
                if (index.y ~= Index) then
                    if DoesEntityExist(currentObject) then
                        local x, y, z = table.unpack(GetEntityCoords(currentObject))
                        local newY
                        local plyVehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                        local boneIndex = GetEntityBoneIndexByName(plyVehicle, "chassis")

                        DetachEntity(currentObject, 0, false)

                        if (index.y < Index) then
                            newY = (y - ((index.y / 150) / 10))
                        elseif (index.y > Index) then
                            newY = (y + ((index.y / 150) / 10))
                        end

                        SetEntityCoordsNoOffset(currentObject, x, newY, z, false, false, false)
                        --SetEntityCoords(currentObject, x, newY, z, false, false, false, true)

                        saveY = (currentPropY ~= nil) and (newY - currentPropY) or nil
                    end
                end

                index.y = Index
            end)

            RageUI.Slider("Z", index.z, 100, nil, false, { }, true, function(Hovered, Active, Selected, Index)
                if (index.z ~= Index) then
                    if DoesEntityExist(currentObject) then
                        local x, y, z = table.unpack(GetEntityCoords(currentObject))
                        local newZ
                        local plyVehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                        local boneIndex = GetEntityBoneIndexByName(plyVehicle, "chassis")

                        DetachEntity(currentObject, 0, false)

                        if (index.z < Index) then
                            newZ = (z - ((index.z / 150) / 5))
                        elseif (index.z > Index) then
                            newZ = (z + ((index.z / 150) / 5))
                        end

                        SetEntityCoordsNoOffset(currentObject, x, y, newZ, false, false, false)
                        --SetEntityCoords(currentObject, x, y, newZ, false, false, false, true)

                        saveZ = (currentPropZ ~= nil) and (newZ - currentPropZ) or nil
                    end
                end

                index.z = Index
            end)

            RageUI.Slider("Rotation", index.rotation, 60, nil, false, { }, true, function(Hovered, Active, Selected, Index)
                if (index.rotation ~= Index) then
                    if DoesEntityExist(currentObject) then
                        newRotation = ((index.rotation * 50) / 10)

                        SetEntityHeading(currentObject, newRotation)
                    end
                end

                index.rotation = Index
            end)

            RageUI.List("Sensibilité", generateTableWithNumbers(10), index.sensibility, nil, { }, true, function(Hovered, Active, Selected, Index)
                index.sensibility = Index
            end)

            RageUI.Button("Ramener l'objet à moi", nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    if DoesEntityExist(currentObject) then
                        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

                        SetEntityCoords(currentObject, (x + 1), (y + 1), (z - 0.5), false, false, false, true)
                    end
                end
            end)

            RageUI.Button("Sauvegarder les objets du véhicule (SOON)", nil, {}, true, function(Hovered, Active, Selected, Index)
            end)
        end, function()
        end)
    end
end, 1)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if (currentObject ~= nil and DoesEntityExist(currentObject) and RageUI.Visible(RMenu:Get("propsEdit", "main"))) then
            local x, y, z = table.unpack(GetEntityCoords(currentObject))

            drawMarker(x, y, (z + 1.5))
        end

        if IsControlJustPressed(0, 11) then
            if (#props == 0) then
                showNotification("Vous n'avez spawn ~r~aucun objet.")
            else
                local closestObj = getClObject()

                if (closestObj == nil) then
                    showNotification("Aucun objet ~b~à proximité.")
                else
                    currentObject = closestObj
                        
                    TriggerServerEvent("mrv_propsedit:sv_open")
                end
            end
        end
    end
end)