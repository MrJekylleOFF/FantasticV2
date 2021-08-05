ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetGangData()
	local data = LoadResourceFile('GangsBuilder', 'data/gangData.json')
	return data and json.decode(data) or {}
end

RegisterServerEvent('gb:addGang')
AddEventHandler('gb:addGang', function(data)

    if data.Grade3 ~= nil then
        MySQL.Async.execute([[
        INSERT INTO `job2_grades` (`job2_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
        (@gangName, 2, @Grade3Name, @Grade3Label, 0, '{}', '{}')
;
        ]], {
            ['@gangName'] = data.Name,
            ['@Grade3Name'] = data.Grade3.name,
            ['@Grade3Label'] = data.Grade3.label,
        })
    end

    if data.Grade4 ~= nil then
        MySQL.Async.execute([[
        INSERT INTO `job2_grades` (`job2_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
        (@gangName, 3, @Grade4Name, @Grade4Label, 0, '{}', '{}')
;
        ]], {
            ['@gangName'] = data.Name,
            ['@Grade4Name'] = data.Grade4.name,
            ['@Grade4Label'] = data.Grade4.label,
        })
    end

    if data.Grade5 ~= nil then
        MySQL.Async.execute([[
        INSERT INTO `job2_grades` (`job2_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
        (@gangName, 4, @Grade5Name, @Grade5Label, 0, '{}', '{}')
;
        ]], {
            ['@gangName'] = data.Name,
            ['@Grade5Name'] = data.Grade5.name,
            ['@Grade5Label'] = data.Grade5.label,
        })
    end


    MySQL.Async.execute([[
    INSERT INTO `jobs2` (`name`, `label`) VALUES (@gangName, @gangLabel);
    INSERT INTO `addon_account` (name, label, shared) VALUES (@gangSociety, @gangLabel, 1);
    INSERT INTO `datastore` (name, label, shared) VALUES (@gangSociety, @gangLabel, 1);
    INSERT INTO `job2_grades` (`job2_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
    (@gangName, 0, @Grade1Name, @Grade1Label, 0, '{}', '{}'),
    (@gangName, 1, @Grade2Name, @Grade2Label, 0, '{}', '{}')
;
    ]], {
		['@gangName'] = data.Name,
        ['@gangLabel'] = data.Label,
        ['@Grade1Name'] = data.Grade1.name,
        ['@Grade2Name'] = data.Grade2.name,
        ['@Grade1Label'] = data.Grade1.label,
        ['@Grade2Label'] = data.Grade2.label,
        ['@gangSociety'] = 'society_' .. data.Name
	}, function(rowsChanged)
        local GangData = GetGangData()
        table.insert(GangData, data)
    
        SaveResourceFile('GangsBuilder', 'data/gangData.json', json.encode(GangData))
        TriggerClientEvent('gb:SyncGangs', -1, GangData)
	end)
end)

RegisterServerEvent('gb:editGang')
AddEventHandler('gb:editGang', function(i, data)
    local GangData = GetGangData()
    GangData[i] = data

    SaveResourceFile('GangsBuilder', 'data/gangData.json', json.encode(GangData))
    TriggerClientEvent('gb:SyncGangs', -1, GangData)
end)

RegisterServerEvent('gb:deleteGang')
AddEventHandler('gb:deleteGang', function(i)
    local GangData = GetGangData()
    table.remove(GangData, i)

    SaveResourceFile('GangsBuilder', 'data/gangData.json', json.encode(GangData))
    TriggerClientEvent('gb:SyncGangs', -1, GangData)
end)

RegisterServerEvent('gb:requestSync')
AddEventHandler('gb:requestSync', function()
    TriggerClientEvent('gb:SyncGangs', source, GetGangData())
end)