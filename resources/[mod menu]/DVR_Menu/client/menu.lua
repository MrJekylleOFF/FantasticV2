RMenu.Add('showcase', 'iProMxMenu', RageUI.CreateMenu("iProMxKarmaTroll", "~r~By DVR__#0078", 8, 200, nil, nil, 213, 170, 115))
RMenu:Get('showcase', 'iProMxMenu').EnableMouse = false

RMenu.Add('showcase', 'submenu1', RageUI.CreateSubMenu(RMenu:Get('showcase', 'iProMxMenu'), "iProMx Hypnotisation", "Hypnotisation"))
RMenu.Add('showcase', 'submenu2', RageUI.CreateSubMenu(RMenu:Get('showcase', 'iProMxMenu'), "iProMx Troll", "Troll"))


RMenu:Get('showcase', 'submenu1'):SetRectangleBanner(100, 0, 0, 255)
RMenu:Get('showcase', 'submenu2'):SetRectangleBanner(100, 0, 0, 255)

RMenu:Get('showcase', 'iProMxMenu'):SetRectangleBanner(100, 0, 0, 255)

ESX_READY = true 
if ESX_READY == true then 
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj
                
				Citizen.Wait(0)
			end)
		end
	end)
end

Effect = false
local Godmod     = false
local PouvoirON1 = false
local punch      = false
local SuperPunch = false
local SuperJump  = false
local SuperSprint= false
local invicible  = false
local Kill       =false

--local player, distance = ESX.Game.GetClosestPlayer()
RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('showcase', 'iProMxMenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
 
            RageUI.Button("Hypnotisation | Outils", nil, { RightLabel = "→" }, true, function(_, _, Selected)     
                if (Selected) then
     
               end
               end, RMenu:Get('showcase', 'submenu1'))

            RageUI.Button("Troll | Options", nil, { RightLabel = "→" }, true, function(_, _, Selected)     
                 if (Selected) then
            
                  end
               end, RMenu:Get('showcase', 'submenu2'))
            end, function()
        end)
    end
    if RageUI.Visible(RMenu:Get('showcase', 'submenu1')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Hypnotiser la personne", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
      
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification('~g~Tu as Hypnotiser ~w~' .. GetPlayerName(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:closest')
                        else
                            ESX.ShowNotification('~r~Ce joueur est deja Hypnotiser')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer tous les joueurs a être hypnotiser ( ~r~15M~s~ )", nil, { RightLabel = "→→→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification(GetPlayerName(closestPlayer) ..'')
                            TriggerServerEvent('esx_pouvoir:DVR__')
                        else
                            print('else')
                        end
                    end
                    Effect= true
                end
            end)
            RageUI.Button("~r~Stopper l\'hypnotisation", nil, { RightLabel = "→→→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification(GetPlayerName(closestPlayer) ..' n\'est plus ~g~Hypnotiser ~w~')
                            TriggerServerEvent('esx_pouvoir:closest2')
                        else
                            ESX.ShowNotification('~r~Ce joueur n\'est pas Hypnotiser ~n~~g~ou la deja eté')
                        end
                    end
                    Effect = false
                end
            end)
            RageUI.Button("Activer le GodMod au joueur en face", nil, { RightLabel = "↓" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    Godmod = not Godmod
                    
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if Godmod then
                            ESX.ShowNotification('~g~GodMod activer | ~r~désactiver activer pour '  ..GetPlayerName(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:Gmod')
                        else
                            ESX.ShowNotification('~g~GodMod activer | ~r~désactiver')
                            Godmod = false
                        end
                    end
                    Godmod = false
                end
            end)
            RageUI.Button("Activer le SuperPunch au joueur en face", nil, { RightLabel = "↓" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    SuperPunch = not SuperPunch
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                        print(punch)
                    else
                        if SuperPunch then
                            punch = true
                            print(punch)
                            ESX.ShowNotification('~g~SuperPunch activer | ~r~désactiver pour '  ..GetPlayerName(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:punch')
                        else
                            ESX.ShowNotification('~g~SuperPunch activer | ~r~désactiver')
                            punch = false
                            print(punch)
                        end
                    end
                    punch = false
                    print(punch)
                end
            end)
            RageUI.Button("Activer le SuperJump au joueur en face", nil, { RightLabel = "↓" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    SuperJump = not SuperJump
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if SuperJump then
                            ESX.ShowNotification('~g~SuperJump activer | ~r~désactiver pour '  ..GetPlayerName(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:jump')
                        else
                            ESX.ShowNotification('~g~SuperJump activer | ~r~désactiver')
                            SuperJump = false
                        end
                    end
                    SuperJump = false
                end
            end)
            RageUI.Button("Activer le SuperSprint au joueur en face", nil, { RightLabel = "↓" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    SuperSprint = not SuperSprint
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if SuperSprint then
                            ESX.ShowNotification('~g~SuperSprint activer | ~r~désactiver pour '  ..GetPlayerName(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:sprint')
                        else
                            ESX.ShowNotification('~g~SuperSprint activer | ~r~désactiver')
                            SuperSprint = false
                        end
                    end
                    SuperSprint = false
                end
            end)
            --[[RageUI.Button("Rendre le joueur en face invisible", nil, { RightLabel = "↓" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    
                    invicible = not invicible
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if invicible then
                            ESX.ShowNotification('~g~invicible activer')
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:invicible')
                        else
                            ESX.ShowNotification('~r~invicible désactiver')
                        end
                    end
                end
            end)]]--

            RageUI.Button("Tuez le joueurs en face", nil, { RightLabel = "↓" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    kill = not kill
                    if closestPlayer == -1 or closestDistance > 15.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if kill then
                            ESX.ShowNotification('~r~Vous avez tuez '  ..GetPlayerName(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            TriggerServerEvent('esx_pouvoir:kill')
                        else
                            ESX.ShowNotification('~r~kill activer | ~r~désactiver')
                        end
                    end
                end
            end)
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('showcase', 'submenu2')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Button("~r~Stopper l'animation du joueur", nil, { RightLabel = "→→→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification(GetPlayerName(closestPlayer) ..'')
                            TriggerServerEvent('esx_pouvoir:closestclear')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à boire un Café", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest3')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à fumer", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest4')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à mendier", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest5')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à dormir", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                          ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest7')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à travailler", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest8')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à faire la circulation", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest9')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à applaudir", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest10')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à boire une bière", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest11')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à fumer un joint", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest12')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à faire la biatch", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest13')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à faire des pompes", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest14')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à faire du yoga ", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest15')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à faire des doigts ", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest18')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à accélérer", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification(GetPlayerName(closestPlayer) ..'')
                            TriggerServerEvent('esx_pouvoir:closestObject0')
                        else
                          
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à couper le moteur", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification(GetPlayerName(closestPlayer) ..'')
                            TriggerServerEvent('esx_pouvoir:closestPL')
                        else
                
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à vous prendre en photo", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:new')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à nous prendre en otage", nil, { RightLabel = "↓↓↓" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closestOtage')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à sortir une arme ", nil, { RightLabel = "🔫" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification(GetPlayerName(closestPlayer) ..'')
                            TriggerServerEvent('esx_pouvoir:closestArmes')
                        else
                         
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à se suicider ", nil, { RightLabel = "⛔" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest16')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à se deconnectez ", nil, { RightLabel = "⏹️" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closest17')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à dire que Damon est BG ", nil, { RightLabel = "😂" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closestBG')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à dire que DVR est BG ", nil, { RightLabel = "😂😂" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closestBGDVR')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à tomber sous le charme de Damon ", nil, { RightLabel = "😂" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:closestBG2')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Forcer le joueur à vous suivre ", "~y~by mrv le roi arouf", { RightLabel = "←←←" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                         ESX.ShowNotification(GetPlayerName(closestPlayer) ..' est sous vos pouvoirs ~w~')
                            TriggerServerEvent('esx_pouvoir:SUIVIE')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Cloner le personnage devant vous ", "~y~by mrv le roi arouf", { RightLabel = "←←←" }, true, function(_, _, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                    if closestPlayer == -1 or closestDistance > 2.0 then 
                        ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
                    else
                        if not PouvoirON1 then
                            TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                            ESX.ShowNotification(GetPlayerName(closestPlayer) ..'')
                            TriggerServerEvent('esx_pouvoir:clone')
                        else
                            ESX.ShowNotification('Ce joueur fais deja une animation')
                        end
                    end
                end
            end)
            RageUI.Button("Cloner votre personnage ", "~y~by mrv le roi arouf", { RightLabel = "←←←" }, true, function(_, _, Selected)
                if (Selected) then
                    local playerPed = PlayerPedId()
                    ClonePed(playerPed, 60, true, false)
                end
            end)
            

            local DABITO = {}

            RageUI.Button("Cloner le personnage et le forcer a vous suivre ", "~y~by mrv le plus beau des rebeux sans être rebeu", { RightLabel = "←←←" }, true, function(_, _, Selected)
                if (Selected) then
                    local playerPed = PlayerPedId()
                    local newPed = ClonePed(playerPed, 60, true, false)
            
                    table.insert(DABITO, newPed)
            
                    print(newPed)
            
                    TaskFollowToOffsetOfEntity(newPed, playerPed, 0.5, 0.0, 0.0, 5.0, -1, 1.0, true)
                end
            end)
            
            RageUI.Button("Suppression des clones ( soon )", "~y~by mrv le plus beau des gitan sans être gitan", { RightLabel = "←←←" }, true, function(_, _, Selected)
                Citizen.CreateThread(function()
                    if Selected then
                        for i = 1, #DABITO do
                            -- DeleteEntity(DABITO[i])
                
                            print(DABITO[i])
                        end
                    end
                end)
            end)
            RageUI.Button("Super ~u~| Punch", nil, { RightLabel = "→" }, true, function(_, _, Selected)
                if (Selected) then
                    ESX.ShowNotification("Super Punch Activer")
                    ESX.ShowNotification('Merci de deco reco si vous voulez desactivez cette option')
                    Wait(0)
                    punch1 = not punch1
                    if punch1 then
                        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 10000.0) 
                        Wait(0)
                    else
                        punch1 = false
                    end
                end
            end)
        end, function()
            ---Panels
        end)
    end

    function GetPedInFront()
        local player = PlayerId()
        local plyPed = GetPlayerPed(player)
        local plyPos = GetEntityCoords(plyPed, false)
        local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
        local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
        local _, _, _, _, ped = GetShapeTestResult(rayHandle)
        return ped
    end
    
    function GetPlayerFromPed(ped)
        for a = 0, 256 do
            if GetPlayerPed(a) == ped then
                return a
            end
        end
        return -1
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, 74) and IsControlPressed(1, 21) then
            ExecuteCommand('DVRMENU')
        end
    end
end)

RegisterNetEvent('OpenMenu:DVR__')
AddEventHandler('OpenMenu:DVR__', function()
    RageUI.Visible(RMenu:Get('showcase', 'iProMxMenu'), not RageUI.Visible(RMenu:Get('showcase', 'iProMxMenu')))
end)

RegisterNetEvent('OpenMenu:DVR__Start')
AddEventHandler('OpenMenu:DVR__Start', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, 51) then
            if closestPlayer == -1 or closestDistance > 4.0 then 
                ESX.ShowNotification('~r~Il n\'y a pas de joueur à proximité')
            else
                TriggerServerEvent('esx_pouvoir:sendclosest', GetPlayerServerId(closestPlayer))
                TriggerServerEvent('esx_pouvoir:GmodPuch')
                ExecuteCommand('kill')
                return;
            end
        end
    end
end)



RegisterCommand('stop', function()
    ExecuteCommand('restart DVR_Menu')
end)