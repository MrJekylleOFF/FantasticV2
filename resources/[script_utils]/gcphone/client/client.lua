--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================
 
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

-- Configuration
local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}
local KeyOpenClose = 244 -- M
local KeyTakeCall = 38 -- E
local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
local USE_RTC = false
local useMouse = false
local ignoreFocus = false
local takePhoto = false
local hasFocus = false

local PhoneInCall = {}
local currentPlaySound = false
local soundDistanceMax = 8.0

function PlayAnim(lib, anim)
  if IsPlayerDead(PlayerId()) then
      return
  end
  
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
      return
  end
  loadAnimDict(lib)

  TaskPlayAnim(GetPlayerPed(-1), lib, anim, 4.0, -1, -1, 50, 0, false, false, false)
  Citizen.Wait(2500)
  ClearPedTasks(GetPlayerPed(-1))
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  ESX.TriggerServerCallback("dqP:getSim", function(result2)
    SimTab = result2
  end)
end)

--====================================================================================
--  Check si le joueurs poséde un téléphone
--  Callback true or false
--====================================================================================
function hasPhone (cb)
  cb(true)
end
--====================================================================================
--  Que faire si le joueurs veut ouvrir sont téléphone n'est qu'il en a pas ?
--====================================================================================
function ShowNoPhoneWarning ()
end

--[[
  Ouverture du téphone lié a un item
  Un solution ESC basé sur la solution donnée par HalCroves
  https://forum.fivem.net/t/tutorial-for-gcphone-with-call-and-job-message-other/177904
--]]
--[[
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShared' function(obj) ESX = obj end)
		Citizen.Wait(0)
  end
end)

function hasPhone (cb)
  if (ESX == nil) then return cb(0) end
  ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
    cb(qtty > 0)
  end, 'phone')
end
function ShowNoPhoneWarning () 
  if (ESX == nil) then return end
  ESX.ShowNotification("Vous n'avez pas de ~r~téléphone~s~")
end
--]]


--====================================================================================
--  
--====================================================================================
_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()

RegisterNetEvent('dqP:syncSim')
AddEventHandler('dqP:syncSim', function()
    ESX.TriggerServerCallback("dqP:getSim", function(result)
        SimTab = result
    end)
end)


function UpMiniMapNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(0, 1)
end


RegisterNetEvent("dqP:shownotif")
AddEventHandler("dqP:shownotif", function(text, color)

    if color == 210 then
        color = 18
    end

    Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end)

function OpenMenu()
_menuPool:CloseAllMenus()
simCardMenu = NativeUI.CreateMenu("iTasim", "Carte SIM", 8, 200,"","",nil,255,0,0,100)
_menuPool:Add(simCardMenu)
_menuPool:WidthOffset(80)
menu = simCardMenu
number = {}
local index565 = nil
result = SimTab
if #result == 0 then

    use = NativeUI.CreateItem("Aucun", "")

    menu:AddItem(use)
end
for i = 1, #result, 1 do
    table.insert(number, {
        number = result[i].number,
        label = result[i].label,
    })
    local c = _menuPool:AddSubMenu(menu, result[i].label, "Numéro de la carte SIM: " .. result[i].number, true, true, false)
    _menuPool:WidthOffset(80)
    use = NativeUI.CreateItem("Activer", "")
    _menuPool:WidthOffset(80)
    ren = NativeUI.CreateItem("Renommer", "")
    _menuPool:WidthOffset(80)
    donner = NativeUI.CreateItem("Donner", "")
    _menuPool:WidthOffset(80)
    jeter = NativeUI.CreateItem("Supprimer", "")
    _menuPool:WidthOffset(80)
    c:AddItem(use)
    c:AddItem(ren)
    c:AddItem(donner)
    c:AddItem(jeter)
    menumbk = menu
    menu.OnItemSelect = function(_, _, Index3)
        index565 = Index3
    end
    c.OnItemSelect = function(menu, _, index)
        if index == 1 then
          ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
            if qtty >= 0 then
                TriggerServerEvent("dqP:SetNumber", number[index565].number)
                    
                else
                    SetNotificationBackgroundColor(6)
                    ESX.ShowNotification("Pas de téléphone ! ")
                end
            end, 'tel')
            _menuPool:CloseAllMenus()
        end
        if index == 2 then
            txt = gettxt2(result[i].label)
            txt = tostring(txt)
            if txt ~= nil then
                if number[index565].number == myPhoneNumber then
                  myPhoneNumber = nil
                end
                TriggerServerEvent("dqP:RenameSim", result[i].id, txt)
                k = menumbk:GetItemAt(i)
                k:UpdateText(txt)
                menu:GoBack()
                result[i].label = txt
            end
        end
        if index == 3 then

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local closestPed = GetPlayerPed(closestPlayer)

            if IsPedSittingInAnyVehicle(closestPed) then
                SetNotificationBackgroundColor(6)
                ESX.ShowNotification('Vous ne pouvez pas donner quelque chose à quelqu\'un dans un véhicule')
                return
            end

            if closestPlayer ~= -1 and closestDistance < 3.0 then
                PlayAnim("mp_common", "givetake1_a")
                TriggerServerEvent('dqP:GiveNumber', GetPlayerServerId(closestPlayer), number[index565].number)

                table.remove( SimTab, i )
                 menumbk:RemoveItemAt(i)
                 menu:GoBack()
            else
                SetNotificationBackgroundColor(6)
                ESX.ShowNotification("Personne à proximité")

            end

        end
        if index == 4 then
            TriggerServerEvent('dqP:Throw', number[index565].number,number[index565])
            table.remove( SimTab, i )
            menumbk:Clear()
            menu:GoBack()
             OpenMenu()
        end
    end
end
menumbk = menu
_menuPool:RefreshIndex()
menumbk:Visible(true)
end



function gettxt2(txtt)
AddTextEntry('txt_phone', "Texte")
DisplayOnscreenKeyboard(1, "txt_phone", "", txtt, "", "", "", 100)
while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
end
if (GetOnscreenKeyboardResult()) then
local result = GetOnscreenKeyboardResult()
if tonumber(result) ~= nil then
  if tonumber(result) >= 1 then
            return tonumber(result)
        else
            end
        else

        return result
     end
  end
end

RegisterCommand("sim",function(source, args) 
  ESX.TriggerServerCallback("dqP:getSim", function(result2)
    SimTab = result2
    OpenMenu()
  end)
  end, false)

  RegisterNetEvent('NB:carteSIM')
  AddEventHandler('NB:carteSIM', function()
	    OpenMenu()
  end)

  RegisterCommand('carte', function()
    OpenMenu()
  end)


Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
_menuPool:ProcessMenus()
    
  if IsControlJustPressed(0, KeyOpenClose) then
      ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
        
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", 1)
      
        if tonumber(myPhoneNumber) ~= nil then
          
          if qtty > 0 then
          TooglePhone()
          TriggerServerEvent("gcPhone:allUpdate")
          k = ESX.GetPlayerData().accounts[1].money
          SendNUIMessage({event = 'updateBankbalance', banking = k})
        else
          SetNotificationBackgroundColor(6)
          UpMiniMapNotification("Pas de téléphone~s~")
        end
      else
        SetNotificationBackgroundColor(6)
        UpMiniMapNotification("Pas de carte sim lié~s~")
      end
      end, 'tel')

    end

    if menuIsOpen == true then
      for _, value in ipairs(KeyToucheCloseEvent) do
        if IsControlJustPressed(1, value.code) then
          MoveFinger(5)
          PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Michael", 1)
          SendNUIMessage({keyUp = value.event})
        end
      end
    end
  end
end)

RegisterNetEvent("gcPhone:forceOpenPhone")
AddEventHandler("gcPhone:forceOpenPhone", function(_myPhoneNumber)
  if menuIsOpen == false then
    TooglePhone()
  end
end)

--====================================================================================
--  Active ou Deactive une application (appName => config.json)
--====================================================================================
RegisterNetEvent('gcPhone:setEnableApp')
AddEventHandler('gcPhone:setEnableApp', function(appName, enable)
  SendNUIMessage({event = 'setEnableApp', appName = appName, enable = enable })
end)

--====================================================================================
--  Gestion des appels fixe
--====================================================================================
function startFixeCall (fixeNumber)
  local number = ''
  AddTextEntry('num_phone', "Numéro :")
  DisplayOnscreenKeyboard(1, "num_phone", "", "", "", "", "", 10)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    number =  GetOnscreenKeyboardResult()
  end
  if number ~= '' then
    TriggerEvent('gcphone:autoCall', number, {
      useNumber = fixeNumber
    })
    PhonePlayCall(true)
  end
end

function TakeAppel (infoCall)
  TriggerEvent('gcphone:autoAcceptCall', infoCall)
end

RegisterNetEvent("gcPhone:notifyFixePhoneChange")
AddEventHandler("gcPhone:notifyFixePhoneChange", function(_PhoneInCall)
  PhoneInCall = _PhoneInCall
end)

RegisterNetEvent("dqP:UpdateNumber")
AddEventHandler("dqP:UpdateNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)


RegisterNetEvent("dqP:UpdateNumber")
AddEventHandler("dqP:UpdateNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

--[[
  Affiche les imformations quant le joueurs est proche d'un fixe
--]]
function showFixePhoneHelper (coords)
  for number, data in pairs(FixePhone) do
    local dist = GetDistanceBetweenCoords(
      data.coords.x, data.coords.y, data.coords.z,
      coords.x, coords.y, coords.z, 1)
    if dist <= 2.0 then
      SetTextComponentFormat("STRING")
      AddTextComponentString("~g~" .. data.name .. ' ~o~' .. number .. '~n~~INPUT_PICKUP~~w~ Utiliser')
      DisplayHelpTextFromStringLabel(0, 0, 0, -1)
      if IsControlJustPressed(1, KeyTakeCall) then
        startFixeCall(number)
      end
      break
    end
  end
end
 

Citizen.CreateThread(function ()
  local mod = 0
  while true do 
    local playerPed   = PlayerPedId()
    local coords      = GetEntityCoords(playerPed)
    local inRangeToActivePhone = false
    local inRangedist = 0
    for i, _ in pairs(PhoneInCall) do 
        local dist = GetDistanceBetweenCoords(
          PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
          coords.x, coords.y, coords.z, 1)
        if (dist <= soundDistanceMax) then
          DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
              0,0,0, 0,0,0, 0.1,0.1,0.1, 0,255,0,255, 0,0,0,0,0,0,0)
          inRangeToActivePhone = true
          inRangedist = dist
          if (dist <= 1.5) then 
            SetTextComponentFormat("STRING")
            SetNotificationBackgroundColor(6)
            AddTextComponentString("~INPUT_PICKUP~ Décrocher")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(1, KeyTakeCall) then
              PhonePlayCall(true)
              TakeAppel(PhoneInCall[i])
              PhoneInCall = {}
              StopSoundJS('ring2.ogg')
            end
          end
          break
        end
    end
    if inRangeToActivePhone == false then
      showFixePhoneHelper(coords)
    end
    if inRangeToActivePhone == true and currentPlaySound == false then
      PlaySoundJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
      currentPlaySound = true
    elseif inRangeToActivePhone == true then
      mod = mod + 1
      if (mod == 15) then
        mod = 0
        SetSoundVolumeJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
      end
    elseif inRangeToActivePhone == false and currentPlaySound == true then
      currentPlaySound = false
      StopSoundJS('ring2.ogg')
    end
    Citizen.Wait(0)
  end
end)


function PlaySoundJS (sound, volume)
  SendNUIMessage({ event = 'playSound', sound = sound, volume = volume })
end

function SetSoundVolumeJS (sound, volume)
  SendNUIMessage({ event = 'setSoundVolume', sound = sound, volume = volume})
end

function StopSoundJS (sound)
  SendNUIMessage({ event = 'stopSound', sound = sound})
end


RegisterNetEvent("gcPhone:forceOpenPhone")
AddEventHandler("gcPhone:forceOpenPhone", function(_myPhoneNumber)
  if menuIsOpen == false then
    TooglePhone()
  end
end)
 
--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent("gcPhone:myPhoneNumber")
AddEventHandler("gcPhone:myPhoneNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent("gcPhone:contactList")
AddEventHandler("gcPhone:contactList", function(_contacts)
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)

RegisterNetEvent("gcPhone:allMessage")
AddEventHandler("gcPhone:allMessage", function(allmessages)
  SendNUIMessage({event = 'updateMessages', messages = allmessages})
  messages = allmessages
end)

RegisterNetEvent("gcPhone:getBourse")
AddEventHandler("gcPhone:getBourse", function(bourse)
  SendNUIMessage({event = 'updateBourse', bourse = bourse})
end)


RegisterNetEvent("gcPhone:receiveMessage")
AddEventHandler("gcPhone:receiveMessage", function(message)

  SendNUIMessage({event = 'newMessage', message = message})
  table.insert(messages, message)
  if message.owner == 0 then
    local text = message.transmitter
    if ShowNumberNotification == true then
      ESX.ShowNotification('Vous avez reçu un sms')
      for _,contact in pairs(contacts) do
        if contact.number == message.transmitter then
          ESX.ShowNotification('~w~Contact: ~b~' ..contact.display)
          break
        end
      end
    end

    --- sonnerie sms
    local time1 = 180
    local time2 = 50
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    Citizen.Wait(time2)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    Citizen.Wait(time1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    Citizen.Wait(time2)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    Citizen.Wait(time2)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
    PlaySoundFrontend(-1, "Pull_Out", "Phone_SoundSet_Michael", 1)
  end
end)

--====================================================================================
--  Function client | Contacts
--====================================================================================
function addContact(display, num) 
    TriggerServerEvent('gcPhone:addContact', display, num)
end

function deleteContact(num) 
    TriggerServerEvent('gcPhone:deleteContact', num)
end
--====================================================================================
--  Function client | Messages
--====================================================================================
function sendMessage(num, message)
  TriggerServerEvent('gcPhone:sendMessage', num, message)
end

function deleteMessage(msgId)
  TriggerServerEvent('gcPhone:deleteMessage', msgId)
  for k, v in ipairs(messages) do 
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('gcPhone:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('gcPhone:deleteAllMessage')
end

function setReadMessageNumber(num)
  TriggerServerEvent('gcPhone:setReadMessageNumber', num)
  for k, v in ipairs(messages) do 
    if v.transmitter == num then
      v.isRead = 1
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('gcPhone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gcPhone:requestAllContact')
end



--====================================================================================
--  Function client | Appels
--====================================================================================
local aminCall = false
local inCall = false

RegisterNetEvent("gcPhone:waitingCall")
AddEventHandler("gcPhone:waitingCall", function(infoCall, initiator)
  SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator})
  if initiator == true then
    PhonePlayCall()
    if menuIsOpen == false then
      TooglePhone()
    end
  end
end)

RegisterNetEvent("gcPhone:acceptCall")
AddEventHandler("gcPhone:acceptCall", function(infoCall, initiator)
  if inCall == false and USE_RTC == false then
    inCall = true
    exports["mumble-voip"]:SetCallChannel(infoCall.id + 1)
    --NetworkSetVoiceChannel(infoCall.id + 1)
    --NetworkSetTalkerProximity(0.0)
  end
  if menuIsOpen == false then 
    TooglePhone()
  end
  PhonePlayCall()
  SendNUIMessage({event = 'acceptCall', infoCall = infoCall, initiator = initiator})
end)

RegisterNetEvent("gcPhone:rejectCall")
AddEventHandler("gcPhone:rejectCall", function(infoCall)
  if inCall == true then
    inCall = false
    exports["mumble-voip"]:SetCallChannel(0)
    --Citizen.InvokeNative(0xE036A705F989E049)
    --NetworkSetTalkerProximity(2.5)
  end
  PhonePlayText()
  SendNUIMessage({event = 'rejectCall', infoCall = infoCall})
end)


RegisterNetEvent("gcPhone:historiqueCall")
AddEventHandler("gcPhone:historiqueCall", function(historique)
  SendNUIMessage({event = 'historiqueCall', historique = historique})
end)


function startCall (phone_number, rtcOffer, extraData)
  TriggerServerEvent('gcPhone:startCall', phone_number, rtcOffer, extraData)
end

function acceptCall (infoCall, rtcAnswer)
  TriggerServerEvent('gcPhone:acceptCall', infoCall, rtcAnswer)
end

function rejectCall(infoCall)
  TriggerServerEvent('gcPhone:rejectCall', infoCall)
end

function ignoreCall(infoCall)
  TriggerServerEvent('gcPhone:ignoreCall', infoCall)
end

function requestHistoriqueCall() 
  TriggerServerEvent('gcPhone:getHistoriqueCall')
end

function appelsDeleteHistorique (num)
  TriggerServerEvent('gcPhone:appelsDeleteHistorique', num)
end

function appelsDeleteAllHistorique ()
  TriggerServerEvent('gcPhone:appelsDeleteAllHistorique')
end
  

--====================================================================================
--  Event NUI - Appels
--====================================================================================

RegisterNUICallback('startCall', function (data, cb)
  startCall(data.numero, data.rtcOffer, data.extraData)
  cb()
end)

RegisterNUICallback('acceptCall', function (data, cb)
  acceptCall(data.infoCall, data.rtcAnswer)
  cb()
end)
RegisterNUICallback('rejectCall', function (data, cb)
  rejectCall(data.infoCall)
  cb()
end)

RegisterNUICallback('ignoreCall', function (data, cb)
  ignoreCall(data.infoCall)
  cb()
end)

RegisterNUICallback('notififyUseRTC', function (use, cb)
  USE_RTC = use
  if USE_RTC == true and inCall == true then
    inCall = false
    Citizen.InvokeNative(0xE036A705F989E049)
    NetworkSetTalkerProximity(2.5)
  end
  cb()
end)


RegisterNUICallback('onCandidates', function (data, cb)
  TriggerServerEvent('gcPhone:candidates', data.id, data.candidates)
  cb()
end)

RegisterNetEvent("gcPhone:candidates")
AddEventHandler("gcPhone:candidates", function(candidates)
  SendNUIMessage({event = 'candidatesAvailable', candidates = candidates})
end)



RegisterNetEvent('gcphone:autoCall')
AddEventHandler('gcphone:autoCall', function(number, extraData)
  if number ~= nil then
    SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData})
  end
end)

RegisterNetEvent('gcphone:autoCallNumber')
AddEventHandler('gcphone:autoCallNumber', function(data)
  TriggerEvent('gcphone:autoCall', data.number)
end)

RegisterNetEvent('gcphone:autoAcceptCall')
AddEventHandler('gcphone:autoAcceptCall', function(infoCall)
  SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall})
end)



--====================================================================================
--  Gestion des evenements NUI
--==================================================================================== 
RegisterNUICallback('log', function(data, cb)
  print(data)
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)
RegisterNUICallback('blur', function(data, cb)
  cb()
end)
RegisterNUICallback('reponseText', function(data, cb)
  local limit = data.limit or 255
  local text = data.text or ''
  AddTextEntry('msg_phone', "Message :")
  DisplayOnscreenKeyboard(1, "msg_phone", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)
--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  cb(json.encode(messages))
end)
RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(PlayerPedId())
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gcPhone:sendMessage', data.phoneNumber, data.message)
end)
RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)
RegisterNUICallback('deleteMessageNumber', function (data, cb)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)
RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)
--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb) 
  TriggerServerEvent('gcPhone:addContact', data.display, data.phoneNumber)
end)
RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('gcPhone:updateContact', data.id, data.display, data.phoneNumber)
end)
RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('gcPhone:deleteContact', data.id)
end)
RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)
RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)

-- Add security for event (leuit#0100)
RegisterNUICallback('callEvent', function(data, cb)
  local eventName = data.eventName or ''
  if string.match(eventName, 'gcphone') then
    if data.data ~= nil then 
      TriggerEvent(data.eventName, data.data)
    else
      TriggerEvent(data.eventName)
    end
  else
    print('Event not allowed')
  end
  cb()
end)
RegisterNUICallback('useMouse', function(um, cb)
  useMouse = um
end)
RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('gcPhone:deleteALL')
  cb()
end)



function TooglePhone() 
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then 
    PhonePlayIn()
  else
    PhonePlayOut()
  end
end
RegisterNUICallback('faketakePhoto', function(data, cb)
  menuIsOpen = false
  SendNUIMessage({show = false})
  cb()
  TriggerEvent('camera:open')
end)

RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  SendNUIMessage({show = false})
  PhonePlayOut()
  cb()
end)




----------------------------------
---------- GESTION APPEL ---------
----------------------------------
RegisterNUICallback('appelsDeleteHistorique', function (data, cb)
  appelsDeleteHistorique(data.numero)
  cb()
end)
RegisterNUICallback('appelsDeleteAllHistorique', function (data, cb)
  appelsDeleteAllHistorique(data.infoCall)
  cb()
end)


----------------------------------
---------- GESTION VIA WEBRTC ----
----------------------------------
AddEventHandler('onClientResourceStart', function(res)
  DoScreenFadeIn(300)
  if res == "gcphone" then
      TriggerServerEvent('gcPhone:allUpdate')
  end
end)


RegisterNUICallback('setIgnoreFocus', function (data, cb)
  ignoreFocus = data.ignoreFocus
  cb()
end)



RegisterNUICallback('takePhoto', function(data, cb)
	CreateMobilePhone(1)
  CellCamActivate(true, true)
  takePhoto = true
  Citizen.Wait(0)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takePhoto do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takePhoto = false
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload(data.url, data.field, function(data)
        local resp = json.decode(data)
        DestroyMobilePhone()
        CellCamActivate(false, false)
        --cb(json.encode({ url = resp.files[1].url }))   
      end)
      takePhoto = false
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)