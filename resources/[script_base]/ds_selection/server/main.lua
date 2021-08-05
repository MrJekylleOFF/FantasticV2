ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("ds_core:createsign")
AddEventHandler("ds_core:createsign", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if result[1] then
        if xPlayer ~= nil then
            TriggerClientEvent("ds_core:createsign", _source, (result[1].firstname .. " " .. result[1].lastname), xPlayer.job.label, ("Cash: " .. result[1].money .. "$"))
        end
    end
end)    

RegisterServerEvent("ds_core:select")
AddEventHandler("ds_core:select", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM characters WHERE identifier=@username", {['@username'] = player})
    if xPlayer ~= nil then
        if result[1] then   
            TriggerClientEvent("ds_core:animation", _source, true)
        else
        end
    end
end)    

RegisterServerEvent("ds_core:lastpos")
AddEventHandler("ds_core:lastpos", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if (result) then
        if xPlayer ~= nil then
            TriggerClientEvent("ds_core:lastpos", _source, json.decode(result[1].position))
        end
    end
end)
