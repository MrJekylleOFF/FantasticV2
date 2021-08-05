local TeleportFromTo = {
	["Ambulance"] = {
		positionFrom = { ['x'] = 331.86, ['y'] = -595.51, ['z'] = 43.28, nom = "[~g~E~w~]"},
		positionTo = { ['x'] = 341.65, ['y'] = -591.45, ['z'] = 74.16, nom = ""},
	},
	["Crucial"] = {
		positionFrom = { ['x'] = 273.84, ['y'] = -834.58, ['z'] = 29.26, nom = "~r~E"},
		positionTo = { ['x'] = 273.17, ['y'] = -831.26, ['z'] = 29.44, nom = "~r~E"},
	},
	["jason"] = {
		positionFrom = { ['x'] = 3613.855, ['y'] =  5025.84, ['z'] =  11.347, nom = "~r~E"},
		positionTo = { ['x'] = -1289.854, ['y'] = 448.239, ['z'] =  97.02, nom = "~r~E"},
	},
	["journaliste"] = {
		positionFrom = { ['x'] = -1048.25, ['y'] = -238.28, ['z'] = 44.02, nom = "~r~E"},
		positionTo = { ['x'] = -1046.43, ['y'] = -237.03, ['z'] =  44.02, nom = "~r~E"},
	},
	["journaliste2"] = {
		positionFrom = { ['x'] = -1075.69, ['y'] = -252.28, ['z'] = 44.02, nom = "~r~E"},
		positionTo = { ['x'] = -1072.59, ['y'] = -246.03, ['z'] =  54.02, nom = "~r~E"},
	},
	["journaliste3"] = {
		positionFrom = { ['x'] = -1056.94, ['y'] = -237.28, ['z'] = 44.02, nom = "~r~E"},
		positionTo = { ['x'] = -1058.59, ['y'] = -235.03, ['z'] =  44.02, nom = "~r~E"},
	},
	["police"] = {		
	positionFrom = { ['x'] = 618.44, ['y'] = 17.93, ['z'] = 86.84, nom = "~r~E"},
	positionTo = { ['x'] = 565.59, ['y'] = 4.77, ['z'] =  103.23, nom = "~r~E"},
	},
	["karting"] = {		
		positionFrom = { ['x'] = 102.22, ['y'] = -3088.45, ['z'] = 6.75, nom = "~r~E"},
		positionTo = { ['x'] = -49.32, ['y'] = -3200.45, ['z'] = 16.1, nom = "~r~E"},
		code = true
	},
	["bunker"] = {
		positionFrom = { ['x'] = -263.35, ['y'] = 4729.26, ['z'] = 138.33, nom = "~r~E"},
		positionTo = { ['x'] = 896.18, ['y'] = -3245.93, ['z'] = -98.24, nom = "~r~E"},
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
					if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 1.0)then
						ClearPrints()
						SetTextEntry_2("STRING")
						AddTextComponentString("".. j.positionFrom.nom)
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 38) then
							if not j.code then
								DoScreenFadeOut(800)
								Citizen.Wait(100)
								SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
							--else
							--	SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
								DoScreenFadeIn(800)
							else
									AddTextEntry('FMMC_MPM_NA', 'Entrer le code') --Sets the Text above the typing field in the black square
									DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
									while (UpdateOnscreenKeyboard() == 0) do
										DisableAllControlActions(0);
									   Citizen.Wait(1)
									end
									if (GetOnscreenKeyboardResult()) then
										result = GetOnscreenKeyboardResult()
										if result == "0706" then
											SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
										else
										   ESX.ShowNotification("~r~Code incorrect !")
										end
									end 
							end
						end
					end
				end
			end

			if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 150.0)then
			--	DrawMarker(1, j.positionTo.x, j.positionTo.y, j.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.6, 1.6, 0.1, 0, 0, 255,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 5.0)then
					--Drawing.draw3DText(j.positionTo.x, j.positionTo.y, j.positionTo.z - 1.100, j.positionTo.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 1.0)then
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














