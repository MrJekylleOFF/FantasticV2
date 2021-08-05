--====================================================================================
-- #Author: Jonathan D @Gannon
-- #Version 2.0
--====================================================================================

math.randomseed(os.time()) 

--- Pour les numero du style XXX-XXXX
function getPhoneRandomNumber()
    local numBase0 = math.random(100,999)
    local numBase1 = math.random(0,9999)
    local num = string.format("%03d-%04d", numBase0, numBase1 )
	return num
end

--- Exemple pour les numero du style 06XXXXXXXX
-- function getPhoneRandomNumber()
--     return '0' .. math.random(600000000,699999999)
-- end


--[[
  Ouverture du téphone lié a un item
  Un solution ESC basé sur la solution donnée par HalCroves
  https://forum.fivem.net/t/tutorial-for-gcphone-with-call-and-job-message-other/177904
--]]

local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
    ESX.RegisterServerCallback('gcphone:getItemAmount', function(source, cb, item)
        --print('gcphone:getItemAmount call item : ' .. item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)
        
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
    end)
end)

ESX.RegisterServerCallback('gcphone:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count
    cb(qtty)
end)

RegisterServerEvent("dqP:RenameSim")
AddEventHandler("dqP:RenameSim", function(id, txt, _)
  MySQL.Async.execute(
    'UPDATE user_sim SET label = @label WHERE id=@id',
    {
      ['@id'] = id,
      ['@label'] = txt

    }
  )

 -- TriggerClientEvent("esx:showNotification",source,"Vous avez bien renommé votre ".."sim".." en "..txt)

end)

RegisterServerEvent('dqP:SetNumber')
AddEventHandler('dqP:SetNumber', function(numb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
 -- local identifier = GetPlayerIdentifiers(_source)[2]
  
  
  phoneNumber = numb
	TriggerClientEvent("gcPhone:myPhoneNumber",_source,numb)
  TriggerClientEvent("dqP:UpdateNumber",_source,numb)
  
  MySQL.Async.execute(
      'UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
      {
          ['@identifier']   = xPlayer.identifier,
          ['@phone_number'] = phoneNumber
      }
  )
	TriggerClientEvent("dqP:shownotif",_source,"Numéro utilisé : " .. tostring(phoneNumber),26)  
	

	
end)
ESX.RegisterServerCallback('dqP:getSim', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    
  
    MySQL.Async.fetchAll(
      'SELECT * FROM user_sim WHERE identifier = @identifier',
      {
          ['@identifier'] = xPlayer.identifier
      },
      function(result)
  
        cb(result)
      --  --(json.encode(result))
  
    end )
  
  end)
RegisterServerEvent('dqP:Throw')
AddEventHandler('dqP:Throw', function(number,data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

			
				MySQL.Async.execute(
					'UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
					{
						['@identifier']   = xPlayer.identifier,
						['@phone_number'] = nil
			
					}
				)
				TriggerClientEvent("gcPhone:myPhoneNumber",_source,nil)
				TriggerClientEvent("dqP:UpdateNumber",_source,nil)
			
			MySQL.Async.execute(
				'DELETE FROM user_sim where identifier = @job AND number = @name ',
				{
					['@job']   = xPlayer.identifier,
					['@count'] = "c",
					['@name'] = number
		
				}
            )
			TriggerClientEvent('esx:showNotification', source, '~r~-1 SIM '.. number)

		
	
end)

ESX.RegisterUsableItem('sim', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('sim', 1)
	phoneNumber = GenerateUniquePhoneNumber()


	MySQL.Async.execute(
		'INSERT INTO user_sim (identifier,number,label) VALUES(@identifier,@phone_number,@label)',
		{
			['@identifier']   = xPlayer.identifier,
			['@phone_number'] = phoneNumber,
			['@label'] = "SIM "..phoneNumber,

		}
	)
	TriggerClientEvent("dqP:shownotif",_source,"Nouvelle carte SIM : " .. phoneNumber ,26)  	
	TriggerClientEvent("dqP:syncSim",source)
	


end)


function GenerateUniquePhoneNumber()
    local running = true
    local phone = nil
    while running do
        local rand = '555' .. math.random(1111,9999)
      --  --('Recherche ... : ' .. rand)
        local count = MySQL.Sync.fetchScalar("SELECT COUNT(number) FROM user_sim WHERE number = @phone_number", { ['@phone_number'] = rand })
        if count < 1 then
            phone = rand
            running = false
        end
    end
  --  --('Numero Choisi  : ' .. phone)
    return phone
end

    
RegisterServerEvent('dqP:useSim')
AddEventHandler('dqP:useSim', function(number)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent("gcPhone:myPhoneNumber",_source,number)
	TriggerClientEvent("dqP:UpdateNumber",_source,number)
	
	MySQL.Async.execute(
		'UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
		{
			['@identifier']   = xPlayer.identifier,
			['@phone_number'] = number

		}
	)

end)

RegisterServerEvent('dqP:GiveNumber')
AddEventHandler('dqP:GiveNumber', function(target,number)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayer2 = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT * FROM `users` WHERE `identifier` = @identifier',
		{
			['@identifier'] = xPlayer.identifier,
			
		},
		function(result)

			if result[1].phone_number == number then
				TriggerClientEvent("gcPhone:myPhoneNumber",_source,nil)
				TriggerClientEvent("dqP:UpdateNumber",_source,nil)
				MySQL.Async.execute(
					'UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
					{
						['@identifier']   = xPlayer.identifier,
						['@phone_number'] = ""
			
					}
				)
			end
			MySQL.Async.execute(
				'DELETE FROM user_sim where identifier = @job AND number = @name ',
				{
					['@job']   = xPlayer.identifier,
					['@count'] = "c",
					['@name'] = number
		
				}
			)
			MySQL.Async.execute('INSERT INTO user_sim (identifier, number,label) VALUES (@name, @count,@job)',
			{
			  ['@name']   = xPlayer2.identifier,
			  
			  ['@count'] = number,
			  ['@job'] = "SIM ".. number
			},
			function (_)
			  
			end)
			TriggerClientEvent('esx:showNotification', _source, '~r~-1 SIM '.. number)
			TriggerClientEvent('esx:showNotification', target, '~g~+1 SIM '.. number)
			TriggerClientEvent("dqP:syncSim",_source)
			TriggerClientEvent("dqP:syncSim",target)
	end)
end)



--====================================================================================
--  Utils
--====================================================================================
function getSourceFromIdentifier(identifier, cb)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if (xPlayer.identifier ~= nil and xPlayer.identifier == identifier) or (xPlayer.identifier == identifier) then
    cb(xPlayer.source)
    return
    end
    end
    cb(nil)
    end

function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end
function getIdentifierByPhoneNumber(phone_number) 
    local result = MySQL.Sync.fetchAll("SELECT users.identifier FROM users WHERE users.phone_number = @phone_number", {
        ['@phone_number'] = phone_number
    })
    if result[1] ~= nil then
        return result[1].identifier
    end
    return nil
end


function getPlayerID(source)
    local identifiers

for k,v in ipairs(GetPlayerIdentifiers(source)) do
    if string.match(v, 'license:') then
        identifiers = string.sub(v, 9)
        break
    end
end
--local player = getIdentifiant(identifiers)
return identifiers
end


function getOrGeneratePhoneNumber (sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", { 
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end


function getOrGeneratePhoneNumber (sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", { 
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end
--====================================================================================
--  Contacts
--====================================================================================
function getContacts(identifier)
    local result = MySQL.Sync.fetchAll("SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    return result
end
function addContact(source, identifier, number, display)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = identifier,
        ['@number'] = number,
        ['@display'] = display,
    },function()
        notifyContactChange(sourcePlayer, identifier)
    end)
end
function updateContact(source, identifier, id, number, display)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", { 
        ['@number'] = number,
        ['@display'] = display,
        ['@id'] = id,
    },function()
        notifyContactChange(sourcePlayer, identifier)
    end)
end
function deleteContact(source, identifier, id)
    local sourcePlayer = tonumber(source)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    notifyContactChange(sourcePlayer, identifier)
end
function deleteAllContact(identifier)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
        ['@identifier'] = identifier
    })
end
function notifyContactChange(source, identifier)
    local sourcePlayer = tonumber(source)
    local identifier = identifier
    if sourcePlayer ~= nil then 
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
    end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addContact(sourcePlayer, identifier, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    updateContact(sourcePlayer, identifier, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteContact(sourcePlayer, identifier, id)
end)

--====================================================================================
--  Messages
--====================================================================================
function getMessages(identifier)
    local result = MySQL.Sync.fetchAll("SELECT phone_messages.* FROM phone_messages LEFT JOIN users ON users.identifier = @identifier WHERE phone_messages.receiver = users.phone_number", {
         ['@identifier'] = identifier
    })
    return result
    --return MySQLQueryTimeStamp("SELECT phone_messages.* FROM phone_messages LEFT JOIN users ON users.identifier = @identifier WHERE phone_messages.receiver = users.phone_number", {['@identifier'] = identifier})
end

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage', function(transmitter, receiver, message, owner, cb)
    cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

function _internalAddMessage(transmitter, receiver, message, owner)
    local Query = "INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner);"
    local Query2 = 'SELECT * from phone_messages WHERE `id` = @id;'
	local Parameters = {
        ['@transmitter'] = transmitter,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@isRead'] = owner,
        ['@owner'] = owner
    }
    local id = MySQL.Sync.insert(Query, Parameters)
    return MySQL.Sync.fetchAll(Query2, {
        ['@id'] = id
    })[1]
end

function addMessage(source, identifier, phone_number, message)
    local sourcePlayer = tonumber(source)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getNumberPhone(identifier)
    if otherIdentifier ~= nil then 
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
        getSourceFromIdentifier(otherIdentifier, function (osou)
            if tonumber(osou) ~= nil then 
                -- TriggerClientEvent("gcPhone:allMessage", osou, getMessages(otherIdentifier))
                TriggerClientEvent("gcPhone:receiveMessage", tonumber(osou), tomess)
            end
        end) 
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
end

function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", { 
        ['@receiver'] = mePhoneNumber,
        ['@transmitter'] = num
    })
end

function deleteMessage(msgId)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number})
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
        ['@mePhoneNumber'] = mePhoneNumber
    })
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addMessage(sourcePlayer, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessageFromPhoneNumber(sourcePlayer,identifier, number)
    -- TriggerClientEvent("gcphone:allMessage", sourcePlayer, getMessages(identifier))
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local identifier = getPlayerID(source)
    setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
    deleteAllContact(identifier)
    appelsDeleteAllHistorique(identifier)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, {})
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, {})
    TriggerClientEvent("appelsDeleteAllHistorique", sourcePlayer, {})
end)

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall (num)
    local result = MySQL.Sync.fetchAll("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120", {
        ['@num'] = num
    })
    return result
end

function sendHistoriqueCall (src, num) 
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels (appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.transmitter_num,
            ['@num'] = appelInfo.receiver_num,
            ['@incoming'] = 1,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
        end)
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "###-####"
        end
        MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.receiver_num,
            ['@num'] = num,
            ['@incoming'] = 0,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            if appelInfo.receiver_src ~= nil then
                notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
            end
        end)
    end
end

function notifyNewAppelsHisto (src, num) 
    sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    sendHistoriqueCall(sourcePlayer, num)
end)

RegisterServerEvent('dqP:MakeServiceCall')
AddEventHandler('dqP:MakeServiceCall', function(_source,job,source1)

    
    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        --print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    --print(json.encode(extraData))
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end
    --print('CALL WITH NUMBER ' .. srcPhone)
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }
    

    if is_valid == true then
        getSourceFromIdentifier(destPlayer, function (srcTo)
            if srcTo ~= nill then
                AppelsEnCours[indexCall].receiver_src = srcTo
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false)
            else
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end)
    else
        TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
    end
end)



RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)
    if FixePhone[phone_number] ~= nil then
        onCallFixePhone(source, phone_number, rtcOffer, extraData)
        return
    end
    
    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    --print(json.encode(extraData))
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end
    --print('CALL WITH NUMBER ' .. srcPhone)
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }
    

    if is_valid == true then
        getSourceFromIdentifier(destPlayer, function (srcTo)
            if srcTo ~= nill then
                AppelsEnCours[indexCall].receiver_src = srcTo
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false)
            else
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end)
    else
        TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
    end

end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall',source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function (callId, candidates)
    --print('send cadidate', callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local source = source
        local to = AppelsEnCours[callId].transmitter_src
        if source == to then 
            to = AppelsEnCours[callId].receiver_src
        end
        --print('TO', to)
        TriggerClientEvent('gcPhone:candidates', to, candidates)
    end
end)


RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
            saveAppels(AppelsEnCours[id])
        end
    end
end)




RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function (infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then 
            saveAppels(AppelsEnCours[id])
        end
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function (numero)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {
        ['@owner'] = srcPhone,
        ['@num'] = numero
    })
end)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner", {
        ['@owner'] = srcPhone
    })
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function ()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    appelsDeleteAllHistorique(srcIdentifier)
end)


--====================================================================================
--  OnLoad
--====================================================================================
AddEventHandler('esx:playerLoaded',function(source)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getOrGeneratePhoneNumber(sourcePlayer, identifier, function (myPhoneNumber)
        TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, myPhoneNumber)
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
        TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
    end)
end)

-- Just For reload
RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    local num = getNumberPhone(identifier)
    --TriggerClientEvent('dqP:UpdateNumber', _source,phoneNumber)
    TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, num)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
    TriggerClientEvent('gcPhone:getBourse', sourcePlayer, getBourse())
    sendHistoriqueCall(sourcePlayer, num)
end)


AddEventHandler('onMySQLReady', function ()
    MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
end)

--====================================================================================
--  App bourse
--====================================================================================
function getBourse()
    --  Format
    --  Array 
    --    Object
    --      -- libelle type String    | Nom
    --      -- price type number      | Prix actuelle
    --      -- difference type number | Evolution 
    -- 
    local result = MySQL.Sync.fetchAll("SELECT * FROM `bourse` ORDER BY price DESC",{})
    --[[local result = {
        {
            lille = 'Pierre',
            price = 12.2,
            difference =  -12.1
        },
        {
            libelle = 'Orange',
            price = 6.2,
            difference = 3.1
        },
        {
            libelle = 'Laine',
            price = 6.0,
            difference = 3.1
        },
        {
            libelle = 'Cuir',
            price = 8.0,
            difference = 3.1
        },
        {
            libelle = 'Diamant',
            price = 80.0,
            difference = -3.1
        },
        {
            libelle = 'Poulets',
            price = 10.0,
            difference = -3.1
        },
        {
            libelle = 'Saucisse',
            price = 4.0,
            difference = -3.1
        },
        {
            libelle = 'Pomme',
            price = 12,
            difference = 1.1
        }
    }]]
    return result
end

--====================================================================================
--  App ... WIP
--====================================================================================


-- SendNUIMessage('ongcPhoneRTC_receive_offer')
-- SendNUIMessage('ongcPhoneRTC_receive_answer')

-- RegisterNUICallback('gcPhoneRTC_send_offer', function (data)


-- end)


-- RegisterNUICallback('gcPhoneRTC_send_answer', function (data)


-- end)



function onCallFixePhone (source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }
    
    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end



function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    
    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil
    
end