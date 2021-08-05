------------------------------------
------------------------------------
---- DONT TOUCH ANY OF THIS IF YOU DON'T KNOW WHAT YOU ARE DOING
---- THESE ARE **NOT** CONFIG VALUES, USE THE CONVARS IF YOU WANT TO CHANGE SOMETHING
------------------------------------
------------------------------------
-- THIS IS OBSOLETE NOW, PLEASE USE THE WIKI TO ADD ADMINS
admins = {}
-- THIS IS OBSOLETE NOW, PLEASE USE THE WIKI TO ADD ADMINS
permissions = {
	ban = false,
	kick = false,
	spectate = false,
	unban = false,
	teleport = false,
	manageserver = false,
	slap = false,
	freeze = false,
	screenshot = false,
	immune = false,
	anon = false,
	crash = false,
	warning = false,
}
-- Muted Players Table
MutedPlayers = {} 
-- cached players, for offline banning
CachedPlayers = {}
Citizen.CreateThread(function()
	while true do 
		Wait(20000)
		for i, player in pairs(CachedPlayers) do 
			if player.droppedTime and (os.time() > player.droppedTime+600) then
				CachedPlayers[i]=nil
			end
		end
	end
end)

AddEventHandler('playerDropped', function (reason)
	if CachedPlayers[source] then
		CachedPlayers[source].droppedTime = os.time()
	end
end)

AddEventHandler("EasyAdmin:amiadmin", function()
	if not CachedPlayers[source] and not DoesPlayerHavePermission(source,"easyadmin.immune") then
		CachedPlayers[source] = {id = source, name = GetPlayerName(source), identifiers = GetPlayerIdentifiers(source)}
	end
end)

RegisterServerEvent("EasyAdmin:requestCachedPlayers")
AddEventHandler('EasyAdmin:requestCachedPlayers', function(playerId)
	local src = source
	if DoesPlayerHavePermission(source,"easyadmin.ban") then
		TriggerClientEvent("EasyAdmin:fillCachedPlayers", src, CachedPlayers)
		--PrintDebugMessage("Cached Players requested by "..getName(src,true))
	end
end)

AnonymousAdmins = {}
Citizen.CreateThread(function()
	local strfile = LoadResourceFile(GetCurrentResourceName(), "language/"..GetConvar("ea_LanguageName", "fr")..".json")
	if strfile then
		strings = json.decode(strfile)[1]
	else
		strings = {language=GetConvar("ea_LanguageName", "fr")}
	end
	
	
	moderationNotification = GetConvar("ea_moderationNotification", "false")
	if GetConvar("ea_enableDebugging", "false") == "true" then
		enableDebugging = true
		--PrintDebugMessage("^1Debug Messages Enabled, Anonymous Admins may not be anonymous!")
	else
		enableDebugging = false
	end
	minimumMatchingIdentifiers = GetConvarInt("ea_minIdentifierMatches", 1)
	
	RegisterServerEvent('EasyAdmin:amiadmin')
	AddEventHandler('EasyAdmin:amiadmin', function()
		
		local identifiers = GetPlayerIdentifiers(source)
		for perm,val in pairs(permissions) do
			local thisPerm = DoesPlayerHavePermission(source,"easyadmin."..perm)
			if perm == "screenshot" and not screenshots then
				thisPerm = false
			end
			TriggerClientEvent("EasyAdmin:adminresponse", source, perm,thisPerm)
			PrintDebugMessage("Processed Perm "..perm.." for "..getName(source)..", result: "..tostring(thisPerm))
		end
		
		if DoesPlayerHavePermission(source,"easyadmin.ban") then
			TriggerClientEvent('chat:addSuggestion', source, '/ban', GetLocalisedText("chatsuggestionban"), { {name='player id', help="the player's server id"}, {name='reason', help="your reason."} } )
		end
		if DoesPlayerHavePermission(source,"easyadmin.kick") then
			TriggerClientEvent('chat:addSuggestion', source, '/kick', GetLocalisedText("chatsuggestionkick"), { {name='player id', help="the player's server id"}, {name='reason', help="your reason."}} )
		end
		if DoesPlayerHavePermission(source,"easyadmin.spectate") then
			TriggerClientEvent('chat:addSuggestion', source, '/spectate', GetLocalisedText("chatsuggestionspectate"), { {name='player id', help="the player's server id"} })
		end
		if DoesPlayerHavePermission(source,"easyadmin.unban") then
			TriggerClientEvent('chat:addSuggestion', source, '/unban', GetLocalisedText("chatsuggestionunban"), { {name='identifier', help="the identifier ( such as steamid, ip or license )"} })
		end
		if DoesPlayerHavePermission(source,"easyadmin.teleport") then
			TriggerClientEvent('chat:addSuggestion', source, '/teleport', GetLocalisedText("chatsuggestionteleport"), { {name='player id', help="the player's server id"} })
		end
		if DoesPlayerHavePermission(source,"easyadmin.manageserver") then
			TriggerClientEvent('chat:addSuggestion', source, '/setgametype', GetLocalisedText("chatsuggestiongametype"), { {name='game type', help="the game type"} })
			TriggerClientEvent('chat:addSuggestion', source, '/setmapname', GetLocalisedText("chatsuggestionmapname"), { {name='map name', help="the map name"} })
		end
		
		if DoesPlayerHavePermission(source,"easyadmin.slap") then
			TriggerClientEvent('chat:addSuggestion', source, '/slap', GetLocalisedText("chatsuggestionslap"), { {name='player id', help="the player's server id"},{name='hp', help="the hp to take"} })
		end
		
		if DoesPlayerHavePermission(source,"easyadmin.freeze") then
			TriggerClientEvent('chat:addSuggestion', source, '/freeze', GetLocalisedText("chatsuggestionfreeze"), { {name='player id', help="the player's server id"},{name='toggle', help="either true or false"} })
		end
		
		-- give player the right settings to work with
		TriggerClientEvent("EasyAdmin:SetSetting", source, "button",GetConvarInt("ea_MenuButton", 163) )
		if GetConvar("ea_alwaysShowButtons", "false") == "true" then
			TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", true)
		else
			TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", false)
		end
		
		TriggerClientEvent("EasyAdmin:SetLanguage", source, strings)
		
	end)
	
	RegisterServerEvent("EasyAdmin:kickPlayer")
	AddEventHandler('EasyAdmin:kickPlayer', function(playerId,reason)
		if DoesPlayerHavePermission(source,"easyadmin.kick") and not DoesPlayerHavePermission(playerId,"easyadmin.immune") then
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminkickedplayer"), getName(source), getName(playerId), reason))
			PrintDebugMessage("Kicking Player "..getName(source).." for "..reason)
			DropPlayer(playerId, string.format(GetLocalisedText("kicked"), getName(source), reason) )
		end
	end)
	
	RegisterServerEvent("EasyAdmin:requestSpectate")
	AddEventHandler('EasyAdmin:requestSpectate', function(playerId)
		if DoesPlayerHavePermission(source,"easyadmin.spectate") then
			PrintDebugMessage("Player "..getName(source,true).." Requested Spectate to "..getName(playerId,true))
			TriggerClientEvent("EasyAdmin:requestSpectate", source, playerId)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:SetGameType")
	AddEventHandler('EasyAdmin:SetGameType', function(text)
		if DoesPlayerHavePermission(source,"easyadmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Gametype to "..text)
			SetGameType(text)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:SetMapName")
	AddEventHandler('EasyAdmin:SetMapName', function(text)
		if DoesPlayerHavePermission(source,"easyadmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Map Name to "..text)
			SetMapName(text)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:StartResource")
	AddEventHandler('EasyAdmin:StartResource', function(text)
		if DoesPlayerHavePermission(source,"easyadmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." started Resource "..text)
			StartResource(text)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:StopResource")
	AddEventHandler('EasyAdmin:StopResource', function(text)
		if DoesPlayerHavePermission(source,"easyadmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." stopped Resource "..text)
			StopResource(text)
		end
	end)
	
	AddEventHandler('EasyAdmin:banPlayerServer', function(playerId,reason)
		if playerId ~= nil then
			expires = 10444633200
			local bannedIdentifiers = CachedPlayers[playerId].identifiers
			if expires < os.time() then
				expires = os.time()+expires 
			end
			reason = reason.. string.format(GetLocalisedText("reasonadd"), CachedPlayers[playerId].name, getName(source) )
			local ban = {identifiers = bannedIdentifiers, banner = getName(source, true), reason = reason, expire = expires or 10444633200 }
			updateBlacklist( ban )
			DropPlayer(playerId, string.format("Banni"), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) )
			
		end
	end)

	RegisterServerEvent("EasyAdmin:banPlayer")
	AddEventHandler('EasyAdmin:banPlayer', function(playerId,reason,expires,username)
		if playerId ~= nil then
			if DoesPlayerHavePermission(source,"easyadmin.ban") and CachedPlayers[playerId] and not DoesPlayerHavePermission(playerId,"easyadmin.immune") then
				local bannedIdentifiers = CachedPlayers[playerId].identifiers
				if expires < os.time() then
					expires = os.time()+expires 
				end
				reason = reason.. string.format(GetLocalisedText("reasonadd"), CachedPlayers[playerId].name, getName(source) )
				local ban = {identifiers = bannedIdentifiers, banner = getName(source, true), reason = reason, expire = expires or 10444633200 }
				updateBlacklist( ban )
				PrintDebugMessage("Player "..getName(source,true).." banned player "..CachedPlayers[playerId].name.." for "..reason)
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminbannedplayer"), getName(source), CachedPlayers[playerId].name, reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ))
				DropPlayer(playerId, string.format(GetLocalisedText("banned"), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ) )
			end
		end
	end)

	RegisterServerEvent("EasyAdmin:offlinebanPlayer")
	AddEventHandler('EasyAdmin:offlinebanPlayer', function(playerId,reason,expires)
		if playerId ~= nil then
			if DoesPlayerHavePermission(source,"easyadmin.ban") and not DoesPlayerHavePermission(playerId,"easyadmin.immune") then
				local bannedIdentifiers = CachedPlayers[playerId].identifiers
				if expires < os.time() then
					expires = os.time()+expires 
				end
				reason = reason.. string.format(GetLocalisedText("reasonadd"), CachedPlayers[playerId].name, getName(source) )
				local ban = {identifiers = bannedIdentifiers, banner = getName(source, true), reason = reason, expire = expires or 10444633200 }
				updateBlacklist( ban )
				PrintDebugMessage("Player "..getName(source,true).." offline banned player "..CachedPlayers[playerId].name.." for "..reason)
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminofflinebannedplayer"), getName(source), CachedPlayers[playerId].name, reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ))
			end
		end
	end)
	
	AddEventHandler('banCheater', function(playerId,reason)
		if not reason then reason = "Cheating" end
		if getName(source) ~= "Console" then return end
		local bannedIdentifiers = GetPlayerIdentifiers(playerId)
		reason = reason.. string.format(GetLocalisedText("bancheatingadd"), getName(playerId), getName(source) )
		local ban = {identifiers = bannedIdentifiers, banner = "Anticheat", reason = reason, expire = expires or 10444633200 }
		
		updateBlacklist( ban )
		PrintDebugMessage("Console banned player "..getName(playerId,true).." for "..reason)
		SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminbannedplayer"), 'Console', getName(playerId), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires or 10444633200 ) ))
		DropPlayer(playerId, GetLocalisedText("bancheating"))
	end)
	
	AddEventHandler("EasyAdmin:addBan", function(playerId,reason,expires)
		local bannedIdentifiers = GetPlayerIdentifiers(playerId)
		if expires < os.time() then
			expires = os.time()+expires 
		end
		reason = reason.. string.format(GetLocalisedText("reasonadd"), getName(playerId), "Console" )
		local ban = {identifiers = bannedIdentifiers,  banner = "Unknown", reason = reason, expire = expires or 10444633200 }
		updateBlacklist( ban )
		
		
		PrintDebugMessage("Player "..getName(source,true).." added ban "..reason)
		SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminbannedplayer"), "Console", getName(playerId), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ))
		DropPlayer(playerId, string.format(GetLocalisedText("banned"), reason, os.date('%d/%m/%Y 	%H:%M:%S', expires ) ) )
	end)
	
	RegisterServerEvent("EasyAdmin:updateBanlist")
	AddEventHandler('EasyAdmin:updateBanlist', function(playerId)
		local src = source
		if DoesPlayerHavePermission(source,"easyadmin.kick") then
			updateBlacklist(false,true)
			Citizen.Wait(300)
			TriggerClientEvent("EasyAdmin:fillBanlist", src, blacklist)
			PrintDebugMessage("Banlist Refreshed by "..getName(src,true))
		end
	end)
	
	RegisterServerEvent("EasyAdmin:requestBanlist")
	AddEventHandler('EasyAdmin:requestBanlist', function(playerId)
		local src = source
		if DoesPlayerHavePermission(source,"easyadmin.kick") then
			TriggerClientEvent("EasyAdmin:fillBanlist", src, blacklist)
			PrintDebugMessage("Banlist Requested by "..getName(src,true))
		end
	end)
	
	
	------------------------------ COMMANDS
	
	RegisterCommand("spectate", function(source, args, rawCommand)
		if(source == 0) then
			Citizen.Trace(GetLocalisedText("badidea")) -- Maybe should be it's own string saying something like "only players can do this" or something
		end
		
		PrintDebugMessage("Player "..getName(source,true).." Requested Spectate on "..getName(args[1],true))
		
		if args[1] and tonumber(args[1]) and DoesPlayerHavePermission(source,"easyadmin.spectate") then
			if getName(args[1]) then
				TriggerClientEvent("EasyAdmin:requestSpectate", source, args[1])
			else
				TriggerClientEvent("chat:addMessage", source, { args = { "EasyAdmin", GetLocalisedText("playernotfound") } })
			end
		end
	end, false)
	
	RegisterCommand("unban", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"easyadmin.unban") then
			PrintDebugMessage("Player "..getName(source,true).." Unbanned "..args[1])
			UnbanIdentifier(args[1])
			if (source ~= 0) then
				TriggerClientEvent("chat:addMessage", source, { args = { "EasyAdmin", GetLocalisedText("done") } })
			else
				Citizen.Trace(GetLocalisedText("done"))
			end
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunbannedplayer"), getName(source), args[1])) -- Use the "safe" getName function instead.
		end
	end, false)
	
	RegisterCommand("teleport", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"easyadmin.teleport") then
			PrintDebugMessage("Player Requested Teleport something")
			-- not yet
		end
	end, false)
	
	RegisterCommand("setgametype", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"easyadmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Gametype to "..args[1])
			SetGameType(args[1])
		end
	end, false)
	
	RegisterCommand("setmapname", function(source, args, rawCommand)
		if args[1] and DoesPlayerHavePermission(source,"easyadmin.manageserver") then
			PrintDebugMessage("Player "..getName(source,true).." set Map Name to "..args[1])
			SetMapName(args[1])
		end
	end, false)

	RegisterCommand("slap", function(source, args, rawCommand)
		if args[1] and args[2] and DoesPlayerHavePermission(source,"easyadmin.slap") then
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminslappedplayer"), getName(source), getName(args[1]), args[2]))
			PrintDebugMessage("Player "..getName(source,true).." slapped "..getName(args[1],true).." for "..args[2].." HP")
			TriggerClientEvent("EasyAdmin:SlapPlayer", args[1], args[2])
		end
	end, false)	


	--- Commands for Normal Users

	RegisterCommand("calladmin", function(source, args, rawCommand)
		if GetConvar("ea_enableCallAdminCommand", "false") == "true" then
			local reason = string.gsub(rawCommand, "calladmin ", "")
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("playercalledforadmin"), getName(source), source, reason))
			TriggerClientEvent('chatMessage', source, "^3EasyAdmin^7", {255,255,255}, GetLocalisedText("admincalled"))
		end
	end, false)
	local PlayerReports = {}
	RegisterCommand("report", function(source, args, rawCommand)
		if GetConvar("ea_enableReportCommand", "false") == "true" then
			local source = source
			local id = args[1]
			local valid = false
			local minimumreports = GetConvarInt("ea_defaultMinReports", 3)
			if GetConvar("ea_MinReportModifierEnabled", "true") == "true" then
				if #GetPlayers() > GetConvarInt("ea_MinReportPlayers", 12) then
					minimumreports = math.round(#GetPlayers()/GetConvarInt("ea_MinReportModifier", 4),0)
				end
			end
			if id and not GetPlayerIdentifier(id, 1) then
				for i, player in pairs(GetPlayers()) do
					if string.find(string.lower(GetPlayerName(player)), string.lower(id)) then
						id = player
						valid = true
						break
					end
				end
			else
				valid = true
			end
			
			
			if id and valid then
				local reason = string.gsub(rawCommand, "report " ..args[1].." ", "")
				if not PlayerReports[id] then
					PlayerReports[id] = { }
				end
				local addReport = true
				for i, report in pairs(PlayerReports[id]) do
					if report.source == source or report.sourceName == GetPlayerName(source) then
						addReport = false
					end
				end
				if addReport then
					table.insert(PlayerReports[id], {source = source, sourceName = GetPlayerName(source), reason = reason, time = os.time()})
					SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("playerreportedplayer"), getName(source), source, GetPlayerName(id), id, reason, #PlayerReports[id], minimumreports))
					-- "playerreportedplayer":"```\nUser %s (ID: %a) reported a player!\n%s (%a), Reason: %s\nReport %a/%a\n```",
					TriggerClientEvent('chatMessage', source, "^3EasyAdmin^7", {255,255,255}, GetLocalisedText("successfullyreported"))
					if #PlayerReports[id] >= minimumreports then
						TriggerEvent("EasyAdmin:banPlayer", id, string.format(GetLocalisedText("reportbantext"), minimumreports), os.time()+GetConvarInt("ea_ReportBanTime", 86400))
					end
				else
					TriggerClientEvent('chatMessage', source, "^3EasyAdmin^7", {255,255,255}, GetLocalisedText("alreadyreported"))
				end
			else
				TriggerClientEvent('chatMessage', source, "^3EasyAdmin^7", {255,255,255}, GetLocalisedText("reportedusageerror"))
			end
		end
	end, false)
	
	RegisterServerEvent("EasyAdmin:TeleportPlayerToCoords")
	AddEventHandler('EasyAdmin:TeleportPlayerToCoords', function(playerId,px,py,pz)
		if DoesPlayerHavePermission(source,"easyadmin.teleport") then
			PrintDebugMessage("Player "..getName(source,true).." requsted teleport to "..px..", "..py..", "..pz)
			TriggerClientEvent("EasyAdmin:TeleportRequest", playerId, px,py,pz)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:SlapPlayer")
	AddEventHandler('EasyAdmin:SlapPlayer', function(playerId,slapAmount)
		if DoesPlayerHavePermission(source,"easyadmin.slap") then
			PrintDebugMessage("Player "..getName(source,true).." slapped "..getName(playerId,true).." for "..slapAmount.." HP")
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminslappedplayer"), getName(source), getName(playerId), slapAmount))
			TriggerClientEvent("EasyAdmin:SlapPlayer", playerId, slapAmount)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:FreezePlayer")
	AddEventHandler('EasyAdmin:FreezePlayer', function(playerId,toggle)
		if DoesPlayerHavePermission(source,"easyadmin.freeze") then
			if toggle then
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminfrozeplayer"), getName(source), getName(playerId)))
				PrintDebugMessage("Player "..getName(source,true).." froze "..getName(playerId,true))
			else
				SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunfrozeplayer"), getName(source), getName(playerId)))
				PrintDebugMessage("Player "..getName(source,true).." unfroze "..getName(playerId,true))
			end
			TriggerClientEvent("EasyAdmin:FreezePlayer", playerId, toggle)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:TookScreenshot")
	
	RegisterServerEvent("EasyAdmin:TakeScreenshot")
	AddEventHandler('EasyAdmin:TakeScreenshot', function(playerId)
		if scrinprogress then
			TriggerClientEvent("chat:addMessage", source, { args = { "EasyAdmin", GetLocalisedText("screenshotinprogress") } })
			return
		end
		scrinprogress = true
		local src=source
		local playerId = playerId

		if DoesPlayerHavePermission(source,"easyadmin.screenshot") then
			thistemporaryevent = AddEventHandler("EasyAdmin:TookScreenshot", function(resultURL)
				TriggerClientEvent('chat:addMessage', src, { template = '<img src="{0}" style="max-width: 400px;" />', args = { resultURL } })
				TriggerClientEvent("chat:addMessage", src, { args = { "EasyAdmin", string.format(GetLocalisedText("screenshotlink"), resultURL) } })
				TriggerEvent("Logs:ServerLog", "Capture", resultURL)
				PrintDebugMessage("Screenshot for Player "..getName(playerId,true).." done, "..resultURL.." requsted by"..getName(src,true))
				SendWebhookMessage(moderationNotification, string.format(GetLocalisedText("admintookscreenshot"), getName(src), getName(playerId), resultURL))
				scrinprogress = false
				RemoveEventHandler(thistemporaryevent)
			end)
			
			TriggerClientEvent("EasyAdmin:CaptureScreenshot", playerId)
			local timeoutwait = 0
			repeat
				timeoutwait=timeoutwait+1
				Wait(5000)
				if timeoutwait == 5 then
					RemoveEventHandler(thistemporaryevent)
					scrinprogress = false -- cancel screenshot, seems like it failed
					TriggerClientEvent("chat:addMessage", src, { args = { "EasyAdmin", "Screenshot Failed!" } })
				end
			until not scrinprogress
		end
	end)
	
	RegisterServerEvent("EasyAdmin:unbanPlayer")
	AddEventHandler('EasyAdmin:unbanPlayer', function(banId)
		if DoesPlayerHavePermission(source,"easyadmin.unban") then
			UnbanId(banId)
			PrintDebugMessage("Player "..getName(source,true).." unbanned "..banId)
			SendWebhookMessage(moderationNotification,string.format(GetLocalisedText("adminunbannedplayer"), getName(source), banId))
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
		end
	end)

	RegisterServerEvent("EasyAdmin:crashPlayer")
	AddEventHandler('EasyAdmin:crashPlayer', function(playerId)
		local src = source
		if DoesPlayerHavePermission(src,"easyadmin.crash") then
			TriggerClientEvent("EasyAdmin:crashClient", playerId)
		end
	end)

	RegisterServerEvent("EasyAdmin:warningPlayer")
	AddEventHandler('EasyAdmin:warningPlayer', function(playerId, msg)
		local src = source
		if DoesPlayerHavePermission(src,"easyadmin.warning") then
			TriggerClientEvent("EasyAdmin:WarningClient", playerId, msg)
		end
	end)

	RegisterServerEvent("EasyAdmin:SetAnonymous")
	AddEventHandler('EasyAdmin:SetAnonymous', function(playerId)
		if DoesPlayerHavePermission(source,"easyadmin.anon") then
			if AnonymousAdmins[source] then
				AnonymousAdmins[source] = nil
				PrintDebugMessage("Player "..getName(source,true).." un-anoned himself")
			else
				AnonymousAdmins[source] = true
				PrintDebugMessage("Player "..getName(source,true).." anoned himself")
			end
		end
	end)
	
	function DoesPlayerHavePermission(player, object)
		local haspermission = false
		if (player == 0 or player == "") then
			return true
		end-- Console. It's assumed this will be an admin with access. If not, why the fuck are they giving random people access?
		
		if IsPlayerAceAllowed(player,object) then -- check if the player has access to this permission
			haspermission = true
		else
			haspermission = false
		end
		
		if not haspermission then -- if not, check if they are admin using the legacy method.
			local numIds = GetPlayerIdentifiers(player)
			for i,admin in pairs(admins) do
				for i,theId in pairs(numIds) do
					if admin == theId then
						haspermission = true
					end
				end
			end
		end
		return haspermission
	end
	
	blacklist = {}
	
	function updateAdmins(addItem)
		admins = {}
		local content = LoadResourceFile(GetCurrentResourceName(), "admins.txt")
		if not content then
			return -- instead of re-creating the file, just quit, we dont need to continue anyway.
		end
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^3The following SteamIDs are added to your admins.txt file, this method is **OUTDATED** and **DOES NOT WORK**^7\n")
		Citizen.Trace("Add these admins using ACE:\n")
		for index,value in ipairs(mysplit(content, "\n")) do
			Citizen.Trace(value.."\n")
		end
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
		Citizen.Trace("^1EasyAdmin: WARNING!!!!^7\n")
	end

	RegisterCommand("convertbanlist", function(source, args, rawCommand)
		if GetConvar("ea_custombanlist", "false") == "true" then
			local content = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
			local ob = json.decode(content)
			for i,theBan in ipairs(ob) do
				TriggerEvent("ea_data:addBan", theBan)
				print("processed ban: "..i.."\n")
			end
			content=nil
		else
			print("Custom Banlist is not enabled, converting back to json.")
			TriggerEvent('ea_data:retrieveBanlist', function(banlist)
				blacklist = banlist
				for i,theBan in ipairs(blacklist) do
					if not theBan.identifiers then theBan.identifiers = {} end
					theBan.banid = nil
					if theBan.steam then
						table.insert(theBan.identifiers, theBan.steam)
						theBan.steam=nil
					end
					if theBan.identifier then
						table.insert(theBan.identifiers, theBan.identifier)
						theBan.identifier=nil
					end
					if theBan.discord then
						table.insert(theBan.identifiers, theBan.discord)
						theBan.discord=nil
					end
				end
				SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
			end)
		end
	end, true)
	
	--[[
		Very basic function that turns "source" into a useable player name.
	]]
	function getName(src,anonymousdisabled)
		if (src == 0 or src == "") then
			return "Console"
		else
			if AnonymousAdmins[src] and not anonymousdisabled then
				return GetLocalisedText("anonymous")
			elseif (GetPlayerName(src)) then
				return GetPlayerName(src)
			else
				return "Unknown - " .. src
			end
		end
	end
	
	
	function updateBlacklist(data,remove)
		-- life is pain, if you think this code sucks, SUCK MY DICK and make it better
		if GetConvar("ea_custombanlist", "false") == "true" then 
			
			if data and not remove then
				table.insert(blacklist, data)
				TriggerEvent("ea_data:addBan", data)
				
			elseif data and remove then
					for i,theBan in ipairs(blacklist) do
						for index,identifier in ipairs(theBan.identifiers) do
							if data.identifier == identifier then
								table.remove(blacklist,i)
								PrintDebugMessage("removed ban as per custombanlist remove")
								TriggerEvent("ea_data:removeBan", theBan)
								break
							end
						end
					end
					
			elseif not data then
				TriggerEvent('ea_data:retrieveBanlist', function(banlist)
					blacklist = banlist
					PrintDebugMessage("updated banlist custom banlist")
					for i,theBan in ipairs(blacklist) do
						if theBan.expire < os.time() then
							table.remove(blacklist,i)
							PrintDebugMessage("removing old ban custom banlist")
							TriggerEvent("ea_data:removeBan", theBan)
						end
					end
				end)
			end
			return
		end
		
		local content = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
		if not content then
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode({}), -1)
			content = json.encode({})
		end
		blacklist = json.decode(content)
		
				
		local txtcontent = LoadResourceFile(GetCurrentResourceName(), "banlist.txt") -- compat
		if not txtcontent then txtcontent = "" end
		if string.len(txtcontent) > 5 then
			for index,value in ipairs(mysplit(txtcontent, "\n")) do
				curstring = "" -- make a new string
				for i = 1, #value do -- loop trough every character of "value" to determine if it's part of the identifier or reason
					if string.sub(value,i,i) == ";" then break end -- end the loop if we reached the "reason" part
					curstring = curstring..string.sub(value,i,i) -- add our current letter to our string
				end
				local reason = string.match(value, "^.*%;(.*)" ) or GetLocalisedText("nongiven") -- get the reason from the string or use "none given" if it's nil
				local reason = string.gsub(reason,"\r","")
				table.insert(blacklist, {identifier = curstring, reason = reason, expire = 10444633200 }) -- we need an expire time here, anything will do, lets make it christmas!
			end
			SaveResourceFile(GetCurrentResourceName(), "banlist.txt", "", 0) -- overwrite banlist with emptyness, we dont even need this file, but sadly we cant delete it :(
			SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
		end
		

		PrintDebugMessage("updated banlist")
		if not blacklist then
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
			print("EasyAdmin: ^1Failed^7 to load Banlist!\n")
			print("EasyAdmin: Please check this error soon, ^1Bans *will not* work!^7\n")
			print("^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^4-^5-^6-^8-^9-^1-^2-^3-^3!^1FATAL ERROR^3!^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^1-^9-^8-^6-^5-^4-^3-^2-^7\n")
		end
		
		if blacklist[1] and (blacklist[1].identifier or blacklist[1].steam or blacklist[1].discord) then -- more compat
			Citizen.Trace("Upgrading Banlist...\n")
			for i,ban in ipairs(blacklist) do
				if not ban.identifiers then
					ban.identifiers = {}
				end
				if ban.identifier then
					table.insert(ban.identifiers, ban.identifier)
					ban.identifier = nil
				end
				if ban.steam then
					table.insert(ban.identifiers, ban.steam)
					ban.steam = nil
				end
				if ban.discord and ban.discord ~= "" then
					table.insert(ban.identifiers, ban.discord)
					ban.discord = nil
				end
			end
			Citizen.Trace("Banlist Upgraded! No Further Action is necesarry.\n")
		end

		
		if data and not remove then
			table.insert(blacklist, data)
		elseif not data then
			for i,theBan in ipairs(blacklist) do
				if not theBan.expire then 
					table.remove(blacklist,i)
				elseif not theBan.identifiers[1] then -- make sure 1 identifier is given, otherwise its a broken ban
					table.remove(blacklist,i)
				elseif theBan.expire < os.time() then
					table.remove(blacklist,i)
					PrintDebugMessage("removing old ban no custom banlist")
				elseif theBan.expire == 1924300800 then
					blacklist[i].expire = 10444633200
				end
			end
		end
		if data and remove then
			for i,theBan in ipairs(blacklist) do
				for index,identifier in ipairs(theBan.identifiers) do
					if data.identifier == identifier then
						table.remove(blacklist,i)
						PrintDebugMessage("removing ban as ordered by remove param")
						break
					end
				end
			end
		end
		SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(blacklist, {indent = true}), -1)
	end



	
	function IsIdentifierBanned(theIndentifier)
		local identifierfound = false
		for index,value in ipairs(blacklist) do
			for i,identifier in ipairs(value.identifiers) do
				if theIndentifier == identifier then
					identifierfound = true
				end
			end
		end
		return identifierfound
	end
	
	function BanIdentifier(identifier,reason)
		updateBlacklist( {identifiers = {identifier} , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function BanIdentifiers(identifier,reason)
		updateBlacklist( {identifiers = identifier , banner = "Unknown", reason = reason, expire = 10444633200} )
	end
	
	function UnbanIdentifier(identifier)
		if banid then 
			if blacklist[banid] then 
				table.remove(blacklist,banid)
			end
		elseif identifier then
			for i,ban in ipairs(blacklist) do
				for index,id in ipairs(ban.identifiers) do
					if identifier == id then
						table.remove(blacklist,i)
						PrintDebugMessage("removed ban as per unbanidentifier func")
						return
					end 
				end
			end
		end
	end

	function UnbanId(banId)
		print(blacklist[banId])
		if blacklist[banId] then 
			table.remove(blacklist,banId)
		end
	end
	
	AddEventHandler('playerConnecting', function(playerName, setKickReason)
		local numIds = GetPlayerIdentifiers(source)
		local matchingIdentifiers = 0
		for bi,blacklisted in ipairs(blacklist) do
			for i,theId in ipairs(numIds) do
				for ci,identifier in ipairs(blacklisted.identifiers) do
					if identifier == theId then
						matchingIdentifiers = matchingIdentifiers+1
						PrintDebugMessage("IDENTIFIER MATCH! "..identifier.." Required: "..matchingIdentifiers.."/"..minimumMatchingIdentifiers)
						if matchingIdentifiers >= minimumMatchingIdentifiers then
							setKickReason(string.format( GetLocalisedText("bannedjoin"), blacklist[bi].reason, os.date('%d/%m/%Y 	%H:%M:%S', blacklist[bi].expire )))
							PrintDebugMessage("EasyAdmin: Connection of "..GetPlayerName(source).." Declined, Banned for "..blacklist[bi].reason.." \n")
							CancelEvent()
							return
						end
					end
				end
			end
		end
	end)


	AddEventHandler('chatMessage', function(Source, Name, Msg)
		if MutedPlayers[Source] then
			CancelEvent()
			TriggerClientEvent("chat:addMessage", Source, { args = { "EasyAdmin", GetLocalisedText("playermute") } })
		end
	end)
	
	
	---------------------------------- USEFUL
	
	function SendWebhookMessage(webhook,message)
		if webhook ~= "false" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
	
	function mysplit(inputstr, sep)
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
	
	
	local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
	local curVersion = json.decode(verFile).version
	local updatePath = "/Bluethefurry/EasyAdmin"
	local resourceName = "EasyAdmin ("..GetCurrentResourceName()..")"
	function checkVersion(err,response, headers)
		if err == 200 then
			local data = json.decode(response)
			if curVersion ~= data.version and tonumber(curVersion) < tonumber(data.version) then
				--print("\n--------------------------------------------------------------------------")
				--print("\n"..resourceName.." is outdated.\nCurrent Version: "..data.version.."\nYour Version: "..curVersion.."\nPlease update it from https://github.com"..updatePath.."")
				--print("\nUpdate Changelog:\n"..data.changelog)
				--print("\n--------------------------------------------------------------------------")
			elseif tonumber(curVersion) > tonumber(data.version) then
				--print("Your version of "..resourceName.." seems to be higher than the current version.")
			else
				--print(resourceName.." is up to date!")
			end
		else
			--print("EasyAdmin Version Check failed!")
		end
		local screenshottest = LoadResourceFile("screenshot-basic", "__resource.lua")
		if not screenshottest then
			print("\nEasyAdmin: screenshot-basic is not installed on this Server, screenshots unavailable")
		else
			StartResource("screenshot-basic")
			screenshots = true
		end
		
		
		--SetTimeout(3600000, checkVersionHTTPRequest)
	end
	
	function checkVersionHTTPRequest()
		PerformHttpRequest("https://raw.githubusercontent.com/Bluethefurry/EasyAdmin/master/version.json", checkVersion, "GET")
	end
	
	function loopUpdateBlacklist()
		updateBlacklist()
		SetTimeout(300000, loopUpdateBlacklist)
	end


	
	---------------------------------- END USEFUL
	loopUpdateBlacklist()
	updateAdmins()
	checkVersionHTTPRequest()
end)
