-- Ceci est un exemple basique utilisant ESX.
-- C'est seulement une demo, à vous de modifier à votre convenance.

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function getPlayerByName(playername)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i]) 
        if (xPlayer.lastName() ~= nil and xPlayer.firstName() ~= nil) and (string.lower(xPlayer.lastName()) .. ' ' .. string.lower(xPlayer.firstName())) == string.lower(playername) then
            return xPlayer   
        end
    end
    return nil
end

AddEventHandler('onPlayerVote', function (playername, ip, date)
    playername = string.lower(playername)

    local xPlayer = getPlayerByName(playername)
    if xPlayer then
        xPlayer.addMoney(50)
        xPlayer.addInventoryItem('coffre', 1)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Merci pour le vote : ~n~~g~50$ et un coffre et un cadeau !")
        TriggerClientEvent('esx:showNotification', -1, "~g~Quelqu'un a voté pour le serveur a reçu 50$ et un coffre et un cadeau !")
    else
        TriggerClientEvent('esx:showNotification', -1, "~r~Quelqu'un a voté pour le serveur a reçu  50$ et un coffre et un cadeau !")
    end
    
    
    
    MySQL.Async.fetchAll('SELECT * FROM top_votes WHERE name = @name', {['@name'] = playername}, function(gotInfo)
		if gotInfo[1] ~= nil then
		    MySQL.Async.execute(
                'UPDATE top_votes SET votes = votes + 1 WHERE `name` = @name',
                {
                    ['@name']   = playername,
                }
            )
		else
            MySQL.Async.execute(
                'INSERT INTO top_votes (name, votes) VALUES (@name, 1)',
                {
                    ['@name']   = playername,
                }
            )
		end
	end)
end)


function Salaire()
	TriggerEvent('onPlayerVote', 'Thom512' )
end
--SetTimeout(5000, Salaire)
--Salaire()
