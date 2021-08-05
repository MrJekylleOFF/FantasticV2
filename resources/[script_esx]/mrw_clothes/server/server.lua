-- Author : Morow 
-- GitHub : https://github.com/Morow73
-- No Edit, No Sell !!!!!!! 

--- Utils ---

local loadPlyClothe, player = {}, {}
local saveClothe = true
local price = 20
ESX_READY = true 

---
--- Event ---
if ESX_READY == true then 
  ESX = nil 
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   
  saveClothe = false

  ESX.RegisterServerCallback('mrw_clothes:getPlayerSkin', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
      ['@identifier'] = xPlayer.identifier
    }, function(users)
      local users = users[1]
      local skin = nil

      if users.skin ~= nil then
        cl = json.decode(users.skin)
      end

      cb(cl)
    end)
  end)

  ESX.RegisterServerCallback('mrw_clothes:buyClothes', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
      xPlayer.removeMoney(price)
      TriggerClientEvent('esx:showNotification', source, "Vous avez payé : "..price.." $.")
      cb(true)
    else
      cb(false)
    end
  end)
end

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

RegisterNetEvent('mrw_clothes:saveClothe')
AddEventHandler('mrw_clothes:saveClothe', function(name, clothe)
  local x_source = source
  local license = PlayerIdentifier('license', x_source)

  --[[if ESX_READY == true then
    local xPlayer = ESX.GetPlayerFromId(x_source)
    --if xPlayer.getMoney() >= price then 
     -- xPlayer.removeMoney(price)
      saveClothe = true 
      TriggerClientEvent('mrw_clothes:Notification', x_source, "Vous avez payé : "..price.." $.")
   -- else 
      saveClothe = false
      TriggerClientEvent('mrw_clothes:Notification', x_source, "Vous n'avez pas assez ~r~d'argent~w~ !")
    --end  
  else 
    saveClothe = true   
  end]]
  
  --if saveClothe then 
    MySQL.Async.execute("INSERT INTO player_clothe (identifier, name, clothe) VALUES (@identifier, @name, @clothe)",
      {
        ['@identifier'] = license,
        ['@name'] = name,
        ['@clothe'] = json.encode(clothe)
      },
      function(result)
        player[x_source].AddClothe(name, clothe)
        TriggerClientEvent('mrw_clothes:Notification', x_source, 'Votre tenue à été ~g~sauvegarder~w~ !')
      end
    )
 -- end  
end)

RegisterNetEvent('mrw_clothes:loadClothe')
AddEventHandler('mrw_clothes:loadClothe', function()
  local x_source = source
  local license = PlayerIdentifier('license', x_source)

  MySQL.Async.fetchAll("SELECT name, clothe FROM player_clothe WHERE identifier = @identifier ", 
    { 
      ['@identifier'] = license
    }, 
    function(result)

      loadPlyClothe = {}

      for i=1,#result ,1 do
        local name = result[i].name
        local clothe = json.decode(result[i].clothe)
        table.insert(loadPlyClothe,{name = name, clothe = clothe})
      end
      player[x_source] = CreateClothingTable(x_source, loadPlyClothe)
      player[x_source].GetClothe(false) 
    end
  )      
end)

RegisterNetEvent('mrw_clothes:giveClothe')
AddEventHandler('mrw_clothes:giveClothe', function(name, closestPlayer)
  local x_source = source
  local license = PlayerIdentifier('license', x_source)
  local licenseOwner = PlayerIdentifier('license', closestPlayer)

  MySQL.Async.fetchAll("UPDATE player_clothe SET identifier = @owner WHERE identifier = @identifier AND name = @name", 
    {
      ['@identifier'] = license, 
      ['@owner'] = licenseOwner,
      ['@name'] = name
    },
    function(result)
      local ownerClothe = player[x_source].GetClothe(true)
      for k,v in pairs(ownerClothe) do
        if name == v.name then 
          player[x_source].DeleteClothe(name)
          player[closestPlayer].AddClothe(name, v.clothe)

          TriggerClientEvent('mrw_clothes:Notification', x_source, "Vous avez donné une tenue !")
          TriggerClientEvent('mrw_clothes:Notification', closestPlayer, "Une tenue vous à été donné !")
        end 
      end   
    end
  )
end)

RegisterNetEvent('mrw_clothes:dropClothe')
AddEventHandler('mrw_clothes:dropClothe', function(name)
  local x_source = source
  local license = PlayerIdentifier('license', x_source)
  
  MySQL.Async.execute("DELETE FROM player_clothe WHERE identifier = @identifier AND name = @name",
    {
      ['@identifier'] = license,
      ['@name'] = name
    },
    function(result)
      player[x_source].DeleteClothe(name)
      TriggerClientEvent('mrw_clothes:Notification', x_source, "Vous avez jeté une tenue !")
    end
  )
end)

---
--- Table ---

function CreateClothingTable(source, clothing)
  local self = {}
  
  self.source = source

  self.GetClothe = clothing

  local player = {}

  player.GetClothe = function(cb)
    if cb == true then 
      return self.GetClothe
    else 
      print(#self.GetClothe, self.source)
      TriggerClientEvent('mrw_clothes:loadPlayerClothe', self.source, self.GetClothe)
    end 
  end

  player.AddClothe = function(name, clothe)
    table.insert(self.GetClothe, {name = name, clothe = clothe})
    self.GetClothe = self.GetClothe
    TriggerClientEvent('mrw_clothes:refreshClothe', self.source, self.GetClothe)
  end

  player.DeleteClothe = function(name)
    for k,v in pairs(self.GetClothe) do
      if name == v.name then 
        table.remove(self.GetClothe, k)
        self.GetClothe = self.GetClothe
      end
    end 
    TriggerClientEvent('mrw_clothes:refreshClothe', self.source, self.GetClothe)
  end

  return player
end

---


