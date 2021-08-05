local TeleportFromTo = {
["test"] = {
    positionFrom = { ['x'] = -3033.49, ['y'] = -1.22 , ['z'] = 1.35, nom = "~r~E"},
    positionTo = { ['x'] = 514.184, ['y'] = 4843.361, ['z'] = -62.589, nom = "~r~E"},
    },
["test2"] = {
    positionFrom = { ['x'] = -1618.50, ['y'] = -2999.41, ['z'] = -78.14, nom = "~r~E"},
    positionTo = { ['x'] = 3540.62, ['y'] = 3675.96, ['z'] = 28.12, nom = "~r~E"},
    },
["test3"] = {
    positionFrom = { ['x'] = -1618.43, ['y'] = -3007.42, ['z'] = -75.20, nom = "~r~E"},
    positionTo = { ['x'] = -1507.61, ['y'] = -3016.79, ['z'] = -79.24, nom = "~r~E"},
    },
["test4"] = {
    positionFrom = { ['x'] = -1521.36, ['y'] = -2978.67, ['z'] = -80.40, nom = "~r~E"},
    positionTo = { ['x'] = -1507.72, ['y'] = -3024.63, ['z'] = -79.24, nom = "~r~E"},
    }
}

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing


function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function Drawing.drawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end

function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
end
local code = 'LEGACY'
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k, j in pairs(TeleportFromTo) do

			--msginf(k .. " " .. tostring(j.positionFrom.x), 15000)
			if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 150.0)then
			--	DrawMarker(1, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1, 0, 0, 0, 0, 0, 0, 1.6, 1.6, 0.1, 0, 0, 255,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 3.0)then
					--Drawing.draw3DText(j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1.100, j.positionFrom.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 3.0)then
						ClearPrints()
						SetTextEntry_2("STRING")
						AddTextComponentString("".. j.positionFrom.nom)
						DrawSubtitleTimed(2000, 1)
                        if IsControlJustPressed(1, 38) then
                            AddTextEntry('FMMC_MPM_NA', "")
                            DisplayOnscreenKeyboard(false, "FMMC_MPM_NA", "Code d'accès ", "", "", "", "", 7)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0);
                                Wait(0);
                            end
                            if (GetOnscreenKeyboardResult()) then
                                text = GetOnscreenKeyboardResult()
                            end
                            local text = GetOnscreenKeyboardResult()
                            if text == code then 
                                if text ~= nil and text ~= "" then
                                    DoScreenFadeOut(800)
                                    Citizen.Wait(100)
                                    SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
                                end
                            else
                                ESX.ShowNotification("~r~ Code incorect")
                            end

						--else
						--	SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
							DoScreenFadeIn(800)
						end
					end
				end
			end

			if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 150.0)then
			--	DrawMarker(1, j.positionTo.x, j.positionTo.y, j.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.6, 1.6, 0.1, 0, 0, 255,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 5.0)then
					--Drawing.draw3DText(j.positionTo.x, j.positionTo.y, j.positionTo.z - 1.100, j.positionTo.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 3.0)then
						ClearPrints()
						SetTextEntry_2("STRING")
						AddTextComponentString("".. j.positionTo.nom)
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(800)
							Citizen.Wait(100)
							SetEntityCoords(GetPlayerPed(-1), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
						--else
						--	SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
							DoScreenFadeIn(800)
						end
					end
				end
			end
		end
	end
end)


-----

local TeleportFromTo = {
    ["test1"] = {
        positionFrom = { ['x'] = -658.66, ['y'] = 886.85, ['z'] = 229.25, nom = "~r~E"},
        positionTo = { ['x'] = -682.56, ['y'] = 592.59, ['z'] = 145.38, nom = "~r~E"},
    }
    }
    
    Drawing = setmetatable({}, Drawing)
    Drawing.__index = Drawing
    
    
    function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    
        local scale = (1/dist)*20
        local fov = (1/GetGameplayCamFov())*100
        local scale = scale*fov
    
        SetTextScale(scaleX*scale, scaleY*scale)
        SetTextFont(fontId)
        SetTextProportional(1)
        SetTextColour(r, g, b, a)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(textInput)
        SetDrawOrigin(x,y,z+2, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
    
    function Drawing.drawMissionText(m_text, showtime)
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(m_text)
        DrawSubtitleTimed(showtime, 1)
    end
    
    function msginf(msg, duree)
        duree = duree or 500
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(msg)
        DrawSubtitleTimed(duree, 1)
    end
    local code = 'A1819'
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2)
            local pos = GetEntityCoords(GetPlayerPed(-1), true)
    
            for k, j in pairs(TeleportFromTo) do
    
                --msginf(k .. " " .. tostring(j.positionFrom.x), 15000)
                if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 150.0)then
                --	DrawMarker(1, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1, 0, 0, 0, 0, 0, 0, 1.6, 1.6, 0.1, 0, 0, 255,255, 0, 0, 0,0)
                    if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 3.0)then
                        --Drawing.draw3DText(j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1.100, j.positionFrom.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
                        if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 3.0)then
                            ClearPrints()
                            SetTextEntry_2("STRING")
                            AddTextComponentString("".. j.positionFrom.nom)
                            DrawSubtitleTimed(2000, 1)
                            if IsControlJustPressed(1, 38) then
                                AddTextEntry('FMMC_MPM_NA', "")
                                DisplayOnscreenKeyboard(false, "FMMC_MPM_NA", "Code d'accès ", "", "", "", "", 7)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0);
                                    Wait(0);
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    text = GetOnscreenKeyboardResult()
                                end
                                local text = GetOnscreenKeyboardResult()
                                if text == code then 
                                    if text ~= nil and text ~= "" then
                                        DoScreenFadeOut(800)
                                        Citizen.Wait(100)
                                        SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
                                    end
                                else
                                    ESX.ShowNotification("~r~ Code incorect")
                                end
    
                            --else
                            --	SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
                                DoScreenFadeIn(800)
                            end
                        end
                    end
                end
    
                if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 150.0)then
                --	DrawMarker(1, j.positionTo.x, j.positionTo.y, j.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.6, 1.6, 0.1, 0, 0, 255,255, 0, 0, 0,0)
                    if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 5.0)then
                        --Drawing.draw3DText(j.positionTo.x, j.positionTo.y, j.positionTo.z - 1.100, j.positionTo.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
                        if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 3.0)then
                            ClearPrints()
                            SetTextEntry_2("STRING")
                            AddTextComponentString("".. j.positionTo.nom)
                            DrawSubtitleTimed(2000, 1)
                            if IsControlJustPressed(1, 38) then
                                DoScreenFadeOut(800)
                                Citizen.Wait(100)
                                SetEntityCoords(GetPlayerPed(-1), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
                            --else
                            --	SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
                                DoScreenFadeIn(800)
                            end
                        end
                    end
                end
            end
        end
    end)





