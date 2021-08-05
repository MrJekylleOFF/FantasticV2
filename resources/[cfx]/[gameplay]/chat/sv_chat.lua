RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

--[[AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end

    --print(author .. ': ' .. message)
end)]]

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        --TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- player join messages
--[[AddEventHandler('playerConnecting', function()
    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' joined.')
end)

AddEventHandler('playerDropped', function(reason)
    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left (' .. reason .. ')')
end)]]--

RegisterCommand('say', function(source, args, rawCommand)
    TriggerClientEvent('chatMessage', -1, (source == 0) and 'Console [ ADMIN ] : ' or GetPlayerName(source), { 255, 0, 0 }, rawCommand:sub(5))
end)

-- Variables
cchat = false

-- Events
AddEventHandler('chatMessage', function(source, name, message)
  if message == '/cancelchat' then
    cchat = not cchat
    if cchat then
      TriggerClientEvent('chatMessage', -1, 'Cancel Chat', {255, 255, 255}, name .. 'a annulé le chat pour tout le monde.')
    else
      TriggerClientEvent('chatMessage', -1, 'Cancel Chat', {255, 255, 255}, name .. 'a activé le chat pour tout le monde.')
    end
    CancelEvent()
  else
    if cchat then
      TriggerClientEvent('chatMessage', source, 'Cancel Chat', {255, 255, 255}, name .. 'a annulé la discussion pour tout le monde, votre message a été supprimé')
      CancelEvent()
    end
  end
end)
