ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Config.webhookAdmin           = "https://discordapp.com/api/webhooks/613788518073761812/KH2Gp0ONFqC2qXYYvNYhssLbg4VhqGHuhGXyOG_pE3V68hH_8ZdkUOSWeoiW3_2VABs6"
local nameBot = "Bot"
--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/689136985109037185/wfLEtquhQz8ui0qk0Qdc-rxJpo3vfGc0lkDjJfisgpxhe4Oa8ygEHmkwBE2Ux0Tg1D_X"
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds


  

local embeds = {
    {
		--["username"] = "RealityGaming",
        ["title"] = message,
        ["type"] = "rich",
        ["color"] = color,
		--["content"] = "{{message}} {{FeedUrl}}",
        --["footer"]=  {
         --   ["text"]= "ESX-discord_bot_alert",
       --},
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
--mecanbo 

function sendToDiscordVol (name,message,color)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/727553898818306058/e0YE3jpJF2b5hz_y3CBMx33fYZMQXsAbUwKM16Yl8c_1RlpcUHbb9_zreClc9jD4mwrs"
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds


  

local embeds = {
    {
		--["username"] = "RealityGaming",
        ["title"] = message,
        ["type"] = "rich",
        ["color"] = color,
		--["content"] = "{{message}} {{FeedUrl}}",
        --["footer"]=  {
         --   ["text"]= "ESX-discord_bot_alert",
       --},
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordMecano (name,message,color)
  local DiscordWebHook = "https://discordapp.com/api/webhooks/689136985109037185/wfLEtquhQz8ui0qk0Qdc-rxJpo3vfGc0lkDjJfisgpxhe4Oa8ygEHmkwBE2Ux0Tg1D_X"
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
		--["username"] = "RealityGaming",
        ["title"] = message,
        ["type"] = "rich",
        ["color"] = color,
		--["content"] = "{{message}} {{FeedUrl}}",
        --["footer"]=  {
         --   ["text"]= "ESX-discord_bot_alert",
       --},
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
--..getIdentity(author).firstname.." ".. getIdentity(author).lastname ..

-- Send the first notification
sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ".._U('server_start'),Config.bluetweet)

-- Event when a player is writing
AddEventHandler('chatMessage', function(author, color, message)
  if(settings.LogChatServer)then
      local player = ESX.GetPlayerFromId(author)
     sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | "..getIdentity(author).firstname.." ".. getIdentity(author).lastname .." à écrit dans le chat : *"..message.."*", Config.grey)
  end
end)


-- Event when a player is connecting
RegisterServerEvent("esx:playerconnected")
AddEventHandler('esx:playerconnected', function()
  if(settings.LogLoginServer)then
    sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." ".. _('user_connecting'),Config.grey)
  end
end)

-- Event when a player is disconnecting
AddEventHandler('playerDropped', function(reason)
  if(settings.LogLoginServer)then
    sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." ".. _('user_disconnecting') .. " ("..reason..")",Config.grey)
  end
end)

RegisterServerEvent("esx_thief:stealPlayerItem")
AddEventHandler('esx_thief:stealPlayerItem', function(target, itemType, itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local label = xPlayer.getInventoryItem(itemName).label
    sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).firstname.." ".. getIdentity(source).lastname .. " a volé "..amount.." "..label.." à "..getIdentity(target).firstname.." ".. getIdentity(target).lastname,Config.orange)
end)

-- Event when a player is jacking a car
RegisterServerEvent("esx:jackingcar")
AddEventHandler("esx:jackingcar", function(model, plate)
   local xPlayer = ESX.GetPlayerFromId(source)
   --print(plate)
   sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." a volé **"..model.."** immatriculé **"..plate.."**" ,Config.purple)
end)

AddEventHandler("log:TweetAnon", function(author, msg)
   --local xPlayer = ESX.GetPlayerFromId(source)
   --print(plate)
   sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | Tweet Anonyme | ".. author .." a écrit en anonyme : **" .. msg .. "**",Config.bluetweet)

end)

RegisterServerEvent("log:venteVehicule")
AddEventHandler("log:venteVehicule", function(plate, price)
   --local xPlayer = ESX.GetPlayerFromId(source)
   --print(plate)
   sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." a vendu son véhicule **"..plate.."** pour **"..price.."**" ,Config.purple)

end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	--local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
	--local xTarget = ESX.GetPlayerFromId(playerId)
      
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." a donné une facture de  **"..amount.."** à **"..getIdentity(playerId).."**" ,Config.purple)

end)


RegisterServerEvent("esx:iProMxKarmaMenu")
AddEventHandler('esx:iProMxKarmaMenu', function()
      local x_source = source
    local license = PlayerIdentifier('license', x_source)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("Attention ! ! !   Le joueur ", "ATTENTION !!! " .. xPlayer.getName(source) ..  " : "  ..license.. "A trouver le code du DVRKarmaMenu => ( menu pour iProMx )     /!!!\\ ", Config.red)
end)

RegisterServerEvent("esx:effectmenu")
AddEventHandler('esx:effectmenu', function()
      local x_source = source
    local license = PlayerIdentifier('license', x_source)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("Attention ! ! !   Le joueur ", "ATTENTION !!! " .. xPlayer.getName(source) ..  " : "  ..license.. "A trouver le code du Effect's Menu     /!!!\\ ", Config.red)
end)

-- Event when a player is killing an other one
RegisterServerEvent('esx:killerlog')
AddEventHandler('esx:killerlog', function(t,killer, kilerT) -- t : 0 = NPC, 1 = player
  local xPlayer = ESX.GetPlayerFromId(source)
  if(t == 1) then
     local xPlayer = ESX.GetPlayerFromId(source)
     local xPlayerKiller = ESX.GetPlayerFromId(killer)

     if(xPlayerKiller.name ~= nil and xPlayer.name ~= nil)then

       if(kilerT.killerinveh) then
         local model = kilerT.killervehname

            sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." ".._('user_kill').." "..getIdentity(killer).." ".._('with').." "..model, Config.red)

       else
            sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." ".._('user_kill').." "..getIdentity(killer), Config.red)

       end
    end
  else
     sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." ".. _('user_kill_environnement'),Config.red)
  end

end)

RegisterServerEvent('esx:removeInventoryItem1')
AddEventHandler("esx:removeInventoryItem1", function(type, item, quantity)
   if(settings.LogItemTransfer)then
    sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." à jeté ".. quantity .. " ".. item ,Config.yellow)
   end

end)

RegisterServerEvent("esx:giveInventoryItem1")
AddEventHandler("esx:giveInventoryItem1", function(target, type_item, item, quantity, valid)
    if true then
      local label = ""
        local xPlayer = ESX.GetPlayerFromId(source)
      if(type_item == "item_standard") then
          label = xPlayer.getInventoryItem(item).label
      else
        label = item
      end
       if(settings.LogItemTransfer) and quantity ~= 0 then
        sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." à donné ".. quantity .. " ".. label.. " à ".. getIdentity(target),Config.yellow)
       end
    else
        sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." possible tentative de triche" ,Config.yellow)
    end
end)

RegisterServerEvent("Logs:custom")
AddEventHandler("Logs:custom", function(message)
	--TriggerServerEvent('Logs:custom', "message")
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." "..message,Config.orange)
end)

RegisterServerEvent("Logs:customAdmin")
AddEventHandler("Logs:customAdmin", function(Source, message, target)
	--TriggerServerEvent('Logs:customAdmin', "message")
    print(os.date("%d/%m/%y %X").." | ID:**"..Source.."** | "..getIdentity(source).." "..message ..getIdentity(target).firstname.." ".. getIdentity(target).lastname)
	sendToDiscordAdmin("Admin-Bot", os.date("%d/%m/%y %X").." | ID:**"..Source.."** | "..getIdentity(source).." "..message ..getIdentity(target).firstname.." ".. getIdentity(target).lastname,Config.orange)
end)


RegisterServerEvent("esx:enterblacklistedcar")
AddEventHandler("esx:enterblacklistedcar", function(model)
   sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." @Fantastic  est entré dans ( Attention )".. model ,Config.red)
end)

RegisterServerEvent('eden_drugs:createweed')
AddEventHandler('eden_drugs:createweed', function(x, y, z,id)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." à planté de la weed en X="..math.floor(x).." Y="..math.floor(y).." Z="..math.floor(z),Config.purple)
end)

RegisterServerEvent('mod:giveMoney')
AddEventHandler('mod:giveMoney', function(amount)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." s'est give de l'argent: **"..amount.."$**" ,Config.purple)
end)

RegisterServerEvent('mod:giveSale')
AddEventHandler('mod:giveSale', function(amount)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." s'est give de l'argent sale: **"..amount.."$**" ,Config.purple)
end)

RegisterServerEvent('mod:giveBank')
AddEventHandler('mod:giveBank', function(amount)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." s'est give de l'argent en banque: **"..amount.."$**" ,Config.purple)
end)


RegisterServerEvent('lr_carthief:recupCar')
AddEventHandler('lr_carthief:recupCar', function(px,py,pz,plate)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." à forcé un garage, plaque: **"..plate.."**" ,Config.purple)
end)

RegisterServerEvent('lr_carthief:VehSold')
AddEventHandler('lr_carthief:VehSold', function(owned, price, plate)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." à vendu un véhicule joueur pour **"..price.."** Dollars, immatriculé **".. plate.."**" ,Config.purple)
end)
RegisterServerEvent('esx_holdup:rob')
AddEventHandler('esx_holdup:rob', function(robb)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." braque une supérette" ,Config.purple)
end)

RegisterServerEvent('esx_society:withdrawMoneyLOG')
AddEventHandler('esx_society:withdrawMoneyLOG', function(society, amount)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." retire **"..amount.."** $ de la société **"..society.."**" ,Config.orange)
end)

RegisterServerEvent('esx_society:depositMoneyLOG')
AddEventHandler('esx_society:depositMoneyLOG', function(society, amount)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." dépose **"..amount.."** $ dans la société **"..society.."**" ,Config.orange)
end)

RegisterServerEvent('esx_ambulancejob:revive1')
AddEventHandler('esx_ambulancejob:revive1', function(target)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." à réanimé " ..getIdentity(target).firstname.." ".. getIdentity(target).lastname,Config.red)
end)

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price)
  sendToDiscordMecano("Comptable", os.date("%d/%m/%y %X").." | "..getIdentity(source).." a modifié un véhicule pour **"..price.."** $" ,Config.orange)
end)

RegisterServerEvent('esx_vehiclelock:changeowner')
AddEventHandler('esx_vehiclelock:changeowner', function(target, plate)
	sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." à donné le véhicule immatriculé **"..plate.."** à " ..getIdentity(target).firstname.." ".. getIdentity(target).lastname,Config.red)
end)

RegisterServerEvent('pawnshop:sellItem')
AddEventHandler('pawnshop:sellItem', function(count, item, value)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
	local label = xPlayer.getInventoryItem(item).label
  sendToDiscord(nameBot, os.date("%d/%m/%y %X").." | ID:**"..source.."** | "..getIdentity(source).." a vendu ".. count.." ".. label .." au préteur sur gage pour ".. count * value.." $",Config.orange)
end)


RegisterServerEvent('connexion:license')
AddEventHandler('connexion:license', function(count, item, value)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent("esx:playerJoined", xPlayer.name)
  sendToDiscord(nameBot, os.date("%d/%m/%y %X").. "License : " ..license.. "Name :" ..name.. "c'est connecter")
end)


AddEventHandler("Logs:ServerLog", function(title,msg)
  sendToDiscordVol(title, msg, Config.orange)
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Add event when a player pick an item
-- TriggerEvent("esx:pickitemalert",xPlayer.name,item.label,total) -> ESX_extended
RegisterServerEvent("esx:pickitemalert")
AddEventHandler("esx:pickitemalert", function(name,itemname,amount)
   if(settings.LogItemPickup)then
    sendToDiscord(_U('server_item_pick'),name.." ".._('user_pick').." : "..itemname.." x"..amount,Config.white)
   end

end)


-- Add event when a player is washing money
--  TriggerEvent("esx:washingmoneyalert",xPlayer.name,amount) -> ESX_society
RegisterServerEvent("esx:washingmoneyalert")
AddEventHandler("esx:washingmoneyalert", function(name,amount)
  sendToDiscord(_U('server_washingmoney'),name.." ".._('user_washingmoney').." ".. amount .." dollars",Config.orange)

end)

function PlayerIdentifier(type, id)
  local identifiers = {}
  local numIdentifiers = GetNumPlayerIdentifiers(id)

  for a = 0, numIdentifiers do
      table.insert(identifiers, GetPlayerIdentifier(id, a))
  end

  for b = 1, #identifiers do
      if string.find(identifiers[b], type, 1) then
          return identifiers[b]
      end
  end
  return false
end

RegisterServerEvent("esx:playerconnected")
AddEventHandler('esx:playerconnected', function()
	  local x_source = source
    local license = PlayerIdentifier('license', x_source)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("Le joueur ", " " .. xPlayer.getName(source) ..  " : "  ..license.. "  Vien d'arriver en ville  ", Config.bluetweet)
    print(license,"=>",xPlayer.getName(source))
end)

RegisterServerEvent("esx:tom")
AddEventHandler('esx:tom', function()
	  local x_source = source
    local license = PlayerIdentifier('license', x_source)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("Le joueur ", " " .. xPlayer.getName(source) ..  " : "  ..license.. "  Vien de faire la commande [ /tom ]  (a trouver le code) ", Config.red)
end)

RegisterServerEvent("esx:tomFailed")
AddEventHandler('esx:tomFailed', function()
	  local x_source = source
    local license = PlayerIdentifier('license', x_source)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("Le joueur ", " " .. xPlayer.getName(source) ..  " : "  ..license.. "  Vien de faire la commande [ /tom ]  (n'as pas trouver le code) ", Config.orange)
end)
-- Source = toi
-- GetName = nom du joueur

-- Event when a player is writing a tweet
AddEventHandler('chatMessage', function(source, name, message)
    if(settings.LogTweetServer)then
        if message:sub(1, 1) == "/" then
          sm = stringsplit(message, " ");
           if sm[1] == "/tweet" then
            local identity = getIdentity(source)
            local nameName = "".. identity.firstname .. " " .. identity.lastname .. "",
               CancelEvent()
               sendToDiscord(nameName,string.sub(message,7),Config.bluetweet)
               --sendToDiscordTweet(_U('server_twitter'), "" .. identity.firstname .. " " .. identity.lastname .." # " .. string.sub(message,7),Config.red)
           end
        end
    end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function getIdentity(source)
  
    --print("DISCORD "..tostring(source))

    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
	
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
      ['@identifier'] = identifier
    })
  if result[1] ~= nil then
    local identity = result[1]
	
    return identity['firstname'] .." ".. identity['lastname']
  else
    return "***** *****"
  end
end



