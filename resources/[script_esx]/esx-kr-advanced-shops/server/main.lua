ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local number = {}


--GET INVENTORY ITEM
ESX.RegisterServerCallback('esx_kr_shop:getInventory', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local items   = xPlayer.inventory

  cb({items = items})

end)

--Removes item from shop
RegisterServerEvent('esx_kr_shops:RemoveItemFromShop')
AddEventHandler('esx_kr_shops:RemoveItemFromShop', function(number, count, item)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local identifier =  ESX.GetPlayerFromId(src).identifier

        MySQL.Async.fetchAll(
        'SELECT count, item FROM shops_players WHERE item = @item AND ShopNumber = @ShopNumber',
        {
            ['@ShopNumber'] = number,
            ['@item'] = item,
        },
        function(data)

            if count > data[1].count then

                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous ne pouvez pas sortir plus que ce que vous possédez')
                else

                if data[1].count ~= count then

                    MySQL.Async.fetchAll("UPDATE shops_players SET count = @count WHERE item = @item AND ShopNumber = @ShopNumber",
                    {
                        ['@item'] = item,
                        ['@ShopNumber'] = number,
                        ['@count'] = data[1].count - count
                    }, function(result)
                    
                    xPlayer.addInventoryItem(data[1].item, count)
                end)
    
                elseif data[1].count == count then

                    MySQL.Async.fetchAll("DELETE FROM shops_players WHERE item = @name AND ShopNumber = @Number",
                    {
                        ['@Number'] = number,
                        ['@name'] = data[1].item
                    })

                    xPlayer.addInventoryItem(data[1].item, count)
            end
        end
    end)
end)


--Setting selling items.
RegisterServerEvent('esx_kr_shops:setToSell')
AddEventHandler('esx_kr_shops:setToSell', function(id, Item, ItemCount, Price)
  local xPlayer = ESX.GetPlayerFromId(source)
  local GetItem = xPlayer.getInventoryItem(Item)


  MySQL.Async.fetchAll(
    'SELECT label, name FROM items WHERE name = @item',
    {
        ['@item'] = Item,
    },
    function(items)
    
      MySQL.Async.fetchAll(
        'SELECT price, count FROM shops_players WHERE item = @items AND ShopNumber = @ShopNumber',
        {
            ['@items'] = Item,
            ['@ShopNumber'] = id,
        },
        function(data)

        if data[1] == nil then
            imgsrc = 'img/box.png'
            categorie = 'divers'

            for i=1, #Config.Images, 1 do
                if Config.Images[i].item == Item then
                    imgsrc = Config.Images[i].src
                end
            end

            for i=1, #Config.Items, 1 do
                if Config.Items[i].item == Item then
                    categorie = Config.Items[i].categorie
                end
            end

            MySQL.Async.execute('INSERT INTO shops_players (ShopNumber, src, label, count, item, price, categorie) VALUES (@ShopNumber, @src, @label, @count, @item, @price, @categorie)',
            {
                ['@ShopNumber']    = id,
                ['@src']           = imgsrc,
                ['@label']         = items[1].label,
                ['@count']         = ItemCount,
                ['@item']          = items[1].name,
                ['@price']         = Price,
                ['@categorie']     = categorie
            })

            xPlayer.removeInventoryItem(Item, ItemCount)

            elseif data[1].price == Price then
            
                MySQL.Async.fetchAll("UPDATE shops_players SET count = @count WHERE item = @name AND ShopNumber = @ShopNumber",
                {
                    ['@name'] = Item,
                    ['@ShopNumber'] = id,
                    ['@count'] = data[1].count + ItemCount
                }
                )
                xPlayer.removeInventoryItem(Item, ItemCount)


            elseif data ~= nil and data[1].price ~= Price then
                Wait(250)
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous avez déjà un même article dans votre boutique, ~r~ mais pour ' .. data[1].price .. '. vous mettez le prix ' .. Price)
                Wait(250)
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Retirer l\'article et mettre un nouveau prix ou mettre le même prix')
            end
        end)  
    end)
end)

-- BUYING PRODUCT
RegisterServerEvent('esx_kr_shops:Buy')
AddEventHandler('esx_kr_shops:Buy', function(id, Item, ItemCount)
  local src = source
  local identifier = ESX.GetPlayerFromId(src).identifier
  local xPlayer = ESX.GetPlayerFromId(src)

        local ItemCount = tonumber(ItemCount)
        MySQL.Async.fetchAll(
        'SELECT * FROM shops_players WHERE ShopNumber = @Number AND item = @item',
        {
            ['@Number'] = id,
            ['@item'] = Item,
        }, function(result)

    
        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE ShopNumber = @Number',
        {
            ['@Number'] = id,
        }, function(result2)

            if xPlayer.getMoney() < ItemCount * result[1].price then
                TriggerClientEvent('esx:showNotification', src, '~r~Vous n\'avez pas assez d\'argent.')
            elseif ItemCount <= 0 then
                TriggerClientEvent('esx:showNotification', src, '~r~quantité invalide.')
            else
                xPlayer.removeMoney(ItemCount * result[1].price)
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Tu as acheté ' .. ItemCount .. 'x ' .. Item .. ' pour $' .. ItemCount * result[1].price)
                xPlayer.addInventoryItem(result[1].item, ItemCount)

                MySQL.Async.execute("UPDATE owned_shops SET money = @money WHERE ShopNumber = @Number",
                {
                    ['@money']      = result2[1].money + (result[1].price * ItemCount),
                    ['@Number']     = id,
                })
    

                if result[1].count ~= ItemCount then
                    MySQL.Async.execute("UPDATE shops_players SET count = @count WHERE item = @name AND ShopNumber = @Number",
                    {
                        ['@name'] = Item,
                        ['@Number'] = id,
                        ['@count'] = result[1].count - ItemCount
                    })
                elseif result[1].count == ItemCount then
                    MySQL.Async.fetchAll("DELETE FROM shops_players WHERE item = @name AND ShopNumber = @Number",
                    {
                        ['@Number'] = id,
                        ['@name'] = result[1].item
                    })
                end
            end
        end)
    end)
end)

--CALLBACKS
ESX.RegisterServerCallback('esx_kr_shop:getShopList', function(source, cb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local identifier = ESX.GetPlayerFromId(_source).identifier

        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE identifier = @identifier',
        {
            ['@identifier'] = '0',
        }, function(result)

      cb(result)
    end)
end)


ESX.RegisterServerCallback('esx_kr_shop:getOwnedBlips', function(source, cb)

        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE NOT identifier = @identifier',
        {
            ['@identifier'] = '0',
        }, function(results)
        cb(results)
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop:getAllShipments', function(source, cb, id)
  local identifier = ESX.GetPlayerFromId(source).identifier

        MySQL.Async.fetchAll(
        'SELECT * FROM shipments WHERE id = @id AND identifier = @identifier',
        {
            ['@id'] = id,
            ['@identifier'] = identifier,
        }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop:getTime', function(source, cb)
    cb(os.time())
end)

ESX.RegisterServerCallback('esx_kr_shop:getOwnedShop', function(source, cb, id)
local src = source
local identifier = ESX.GetPlayerFromId(src).identifier

        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber AND identifier = @identifier',
        {
            ['@ShopNumber'] = id,
            ['@identifier'] = identifier,
        }, function(result)

        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop:getShopInfo', function(source, cb, id)
local src = source

        MySQL.Async.fetchAll(
        'SELECT ShopName, ShopLogo FROM owned_shops WHERE ShopNumber = @ShopNumber',
        {
            ['@ShopNumber'] = id,
        }, function(result)
        print(result[1].ShopLogo)
        cb(result[1])
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop:getShopItems', function(source, cb, number)
  local identifier = ESX.GetPlayerFromId(source).identifier
  
        MySQL.Async.fetchAll('SELECT * FROM shops_players WHERE ShopNumber = @ShopNumber',
        {
            ['@ShopNumber'] = number
        }, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('esx_kr_shops:GetAllItems')
AddEventHandler('esx_kr_shops:GetAllItems', function(id)
    local _source = source
    local identifier = ESX.GetPlayerFromId(_source).identifier
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll(
    'SELECT * FROM shipments WHERE id = @id AND identifier = @identifier',
    {
        ['@id'] = id,
        ['@identifier'] = identifier
    }, function(result)

        for i=1, #result, 1 do
            xPlayer.addInventoryItem(result[i].item, result[i].count)
            MySQL.Async.fetchAll('DELETE FROM shipments WHERE id = @id AND identifier = @identifier',{['@id'] = id,['@identifier'] = identifier,})
        end
    end)
end)


RegisterServerEvent('esx_kr_shops-robbery:UpdateCanRob')
AddEventHandler('esx_kr_shops-robbery:UpdateCanRob', function(id)
    MySQL.Async.fetchAll("UPDATE owned_shops SET LastRobbery = @LastRobbery WHERE ShopNumber = @ShopNumber",{['@ShopNumber'] = id,['@LastRobbery']    = os.time(),})
end)

RegisterServerEvent('esx_kr_shop:MakeShipment')
AddEventHandler('esx_kr_shop:MakeShipment', function(id, item, price, count, label)
  local _source = source
  local identifier = ESX.GetPlayerFromId(_source).identifier

    MySQL.Async.fetchAll('SELECT money FROM owned_shops WHERE ShopNumber = @ShopNumber AND identifier = @identifier',{['@ShopNumber'] = id,['@identifier'] = identifier,}, function(result)

        if result[1].money >= price * count then

            MySQL.Async.execute('INSERT INTO shipments (id, label, identifier, item, price, count, time) VALUES (@id, @label, @identifier, @item, @price, @count, @time)',{['@id']       = id,['@label']      = label,['@identifier'] = identifier,['@item']       = item,['@price']      = price,['@count']      = count,['@time']       = os.time()})
            MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE ShopNumber = @ShopNumber",{['@ShopNumber'] = id,['@money']    = result[1].money - price * count,})  
            TriggerClientEvent('esx:showNotification', _source, '~g~Vous avez commandé' .. count .. ' pieces ' .. label .. ' pour $' .. price * count)
        else
            TriggerClientEvent('esx:showNotification', _source, '~r~Vous n’avez pas assez d’argent dans votre boutique.')
        end
    end)
end)

RegisterServerEvent('esx_kr_shops:BuyShop')
AddEventHandler('esx_kr_shops:BuyShop', function(name, price, number, hasbought)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local identifier = ESX.GetPlayerFromId(source).identifier

    MySQL.Async.fetchAll(
    'SELECT identifier FROM owned_shops WHERE ShopNumber = @ShopNumber',
    {
      ['@ShopNumber'] = number,
    }, function(result)

    if result[1].identifier == '0' then

        if xPlayer.getMoney() >= price then
            MySQL.Async.fetchAll("UPDATE owned_shops SET identifier = @identifier, ShopName = @ShopName WHERE ShopNumber = @ShopNumber",{['@identifier']  = identifier,['@ShopNumber']     = number,['@ShopName']     = name},function(result)
            xPlayer.removeMoney(price)
        end)
            TriggerClientEvent('esx_kr_shops:removeBlip', -1)
            TriggerClientEvent('esx_kr_shops:setBlip', -1)
            TriggerClientEvent('esx:showNotification', _source, '~gVous avez acheté un magasin pour $' ..  price)
        else    
            TriggerClientEvent('esx:showNotification', _source, '~r~ Vous ne pouvez pas vous permettre ce magasin')
        end

    else
        TriggerClientEvent('esx:showNotification', _source, '~r~ Vous ne pouvez pas vous permettre ce magasin')
        end
    end)
end)


--BOSS MENU STUFF
RegisterServerEvent('esx_kr_shops:addMoney')
AddEventHandler('esx_kr_shops:addMoney', function(amount, number)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local identifier = ESX.GetPlayerFromId(source).identifier

    MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @Number',
        {
          ['@identifier'] = identifier,
          ['@Number'] = number,
        },
        function(result)
          
        if os.time() - result[1].LastRobbery <= 900 then
            time = os.time() - result[1].LastRobbery
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~L\'argent de votre boutique a été bloqué à cause d\'un vol, veuillez patienter ' .. math.floor((900 - time) / 60) .. ' minutes')
            return
        end

        if xPlayer.getMoney() >= amount then

            MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE identifier = @identifier AND ShopNumber = @Number",
            {
                ['@money']      = result[1].money + amount,
                ['@Number']     = number,
                ['@identifier'] = identifier
            })
            xPlayer.removeMoney(amount)
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Vous mettez en $' .. amount .. 'dans votre magasin')
        else
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous ne pouvez pas en mettre plus que ce que vous possédez')
        end
    end)
end)

RegisterServerEvent('esx_kr_shops:takeOutMoney')
AddEventHandler('esx_kr_shops:takeOutMoney', function(amount, number)
local src = source
local identifier = ESX.GetPlayerFromId(src).identifier
local xPlayer = ESX.GetPlayerFromId(src)


  MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @Number',
    {
      ['@identifier'] = identifier,
      ['@Number'] = number,
    },

    function(result)

    if os.time() - result[1].LastRobbery <= 900 then
        time = os.time() - result[1].LastRobbery
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~L\'argent de votre boutique a été bloqué à cause d\'un vol, veuillez patienter ' .. math.floor((900 - time) / 60) .. ' minutes')
        return
    end
      
        if result[1].money >= amount then
            MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE identifier = @identifier AND ShopNumber = @Number",
            {
                ['@money']      = result[1].money - amount,
                ['@Number']     = number,
                ['@identifier'] = identifier
            })
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Vous avez sorti $' .. amount .. ' de votre magasin')
            xPlayer.addMoney(amount)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous ne pouvez pas en mettre plus que ce que vous possédez')
        end
        
    end)
end)


RegisterServerEvent('esx_kr_shops:changeName')
AddEventHandler('esx_kr_shops:changeName', function(number, name)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)
      MySQL.Async.fetchAll("UPDATE owned_shops SET ShopName = @Name WHERE identifier = @identifier AND ShopNumber = @Number",
      {
        ['@Number'] = number,
        ['@Name']     = name,
        ['@identifier'] = identifier
      })
      TriggerClientEvent('esx_kr_shops:removeBlip', -1)
      TriggerClientEvent('esx_kr_shops:setBlip', -1)
end)

RegisterServerEvent('esx_kr_shops:SellShop')
AddEventHandler('esx_kr_shops:SellShop', function(number)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE identifier = @identifier AND ShopNumber = @ShopNumber',
    {
      ['@identifier'] = identifier,
      ['@ShopNumber'] = number,
    },
    function(result)
      MySQL.Async.fetchAll(
        'SELECT * FROM shops_players WHERE ShopNumber = @ShopNumber',
        {
          ['@ShopNumber'] = number,
        },
        function(result2)

      if result[1].money == 0 and result2[1] == nil then
        MySQL.Async.fetchAll("UPDATE owned_shops SET identifier = @identifiers, ShopName = @ShopName WHERE identifier = @identifier AND ShopNumber = @Number",
        {
            ['@identifiers'] = '0',
            ['@identifier'] = identifier,
            ['@ShopName']    = '0',
            ['@Number'] = number,
        })
            xPlayer.addMoney(result[1].ShopValue / 2)
            TriggerClientEvent('esx_kr_shops:removeBlip', -1)
            TriggerClientEvent('esx_kr_shops:setBlip', -1)
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Vous avez vendu votre boutique')
            else
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous ne pouvez pas vendre votre boutique avec des objets ou de l\'argent à l\'intérieur')
            end
        end)
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop:getUnBoughtShops', function(source, cb)
  local identifier = ESX.GetPlayerFromId(source).identifier
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE identifier = @identifier',
    {
      ['@identifier'] = '0',
    },
    function(result)

        cb(result)
    end)
end)

ESX.RegisterServerCallback('esx_kr_shop-robbery:getOnlinePolices', function(source, cb)
  local _source  = source
  local xPlayers = ESX.GetPlayers()
  local cops = 0

    for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
        cops = cops + 1
        end
    end
    Wait(25)
    cb(cops)
end)

ESX.RegisterServerCallback('esx_kr_shop-robbery:getUpdates', function(source, cb, id)

    MySQL.Async.fetchAll(
    'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber',
    {
     ['@ShopNumber'] = id,
    },
     function(result)

        if result[1].LastRobbery == 0 then
            id = id
            MySQL.Async.fetchAll("UPDATE owned_shops SET LastRobbery = @LastRobbery WHERE ShopNumber = @ShopNumber",
            {
            ['@ShopNumber'] = id,
            ['@LastRobbery']   = os.time(),
            })
        else
            if os.time() - result[1].LastRobbery >= Config.TimeBetweenRobberies then
                cb({cb = true, time = os.time() - result[1].LastRobbery, name = result[1].ShopName})
            else
                cb({cb = nil, time = os.time() - result[1].LastRobbery})
            end
        end
    end)
end)


RegisterServerEvent('esx_kr_shops-robbery:GetReward')
AddEventHandler('esx_kr_shops-robbery:GetReward', function(id)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)


        MySQL.Async.fetchAll(
        'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber',
        {
            ['@ShopNumber'] = id,
        }, function(result)

        id = id
        
        MySQL.Async.fetchAll("UPDATE owned_shops SET money = @money WHERE ShopNumber = @ShopNumber",
        {
            ['@ShopNumber'] = id,
            ['@money']     = result[1].money - (result[1].money / Config.CutOnRobbery),
        })
        id = id

        print( 'add money ' .. (result[1].money / Config.CutOnRobbery) )

        xPlayer.addMoney( (result[1].money / Config.CutOnRobbery) )
    end)
end)

RegisterServerEvent('esx_kr_shops-robbery:NotifyOwner')
AddEventHandler('esx_kr_shops-robbery:NotifyOwner', function(msg, id)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)

    for i=1, #ESX.GetPlayers(), 1 do
        local identifier = ESX.GetPlayerFromId(ESX.GetPlayers()[i])
  
            MySQL.Async.fetchAll(
            'SELECT * FROM owned_shops WHERE ShopNumber = @ShopNumber',
            {
                ['@ShopNumber'] = id,
            }, function(result)

            if result[1].identifier == identifier.identifier then
                TriggerClientEvent('esx:showNotification', identifier.source, msg)
            end

        end)
    end
end)
