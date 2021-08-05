grade1 = false
grade2 = false
grade3 = false
grade4 = false
grade5 = false

hgrade = nil

Vehicule1 = false
Vehicule2 = false
Vehicule3 = false
Vehicule4 = false
Vehicule5 = false


_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()

mainGangMenu = NativeUI.CreateMenu('GangsBuilder', 'Actions', nil, nil, nil, nil, nil, 180, 0, 0)
_menuPool:Add(mainGangMenu)

local addGangMenu = _menuPool:AddSubMenu(mainGangMenu, 'Créer un gang', '', true, true)

Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
	['NENTER'] = 201, ['N4'] = 108, ['N5'] = 60, ['N6'] = 107, ['N+'] = 96, ['N-'] = 97, ['N7'] = 117, ['N8'] = 61, ['N9'] = 118
}

function DrawGangMenu()
	local GangData = {
		Weapons = gangsKit.Weapons[1],
	}
	
	local tt = NativeUI.CreateItem('========== INFORMATION DE LA FACTION ==========', '')
	addGangMenu.SubMenu:AddItem(tt)

	local nameItem = NativeUI.CreateItem('Nom de la faction', '')
	addGangMenu.SubMenu:AddItem(nameItem)

	local labelItem = NativeUI.CreateItem('Label de la faction', '')
	addGangMenu.SubMenu:AddItem(labelItem)

	local t = NativeUI.CreateItem('==================== GRADES =====================', '')
	addGangMenu.SubMenu:AddItem(t)

	local grade1Item = NativeUI.CreateItem('Grade 1 (Obligé)', '')
	addGangMenu.SubMenu:AddItem(grade1Item)

	local grade2Item = NativeUI.CreateItem('Grade 2 (Obligé)', '')
	addGangMenu.SubMenu:AddItem(grade2Item)

	local grade3Item = NativeUI.CreateItem('Grade 3 (Pas obligé)', '')
	addGangMenu.SubMenu:AddItem(grade3Item)

	local grade4Item = NativeUI.CreateItem('Grade 4 (Pas obligé)', '')
	addGangMenu.SubMenu:AddItem(grade4Item)

	local grade5Item = NativeUI.CreateItem('Grade 5 (Pas obligé)', '')
	addGangMenu.SubMenu:AddItem(grade5Item)

	local tI = NativeUI.CreateItem('=================== VEHICULES ====================', '')
	addGangMenu.SubMenu:AddItem(tI)

	local veh1Item = NativeUI.CreateItem('Véhicule 1 (Obligé)', '')
	addGangMenu.SubMenu:AddItem(veh1Item)

	local veh2Item = NativeUI.CreateItem('Véhicule 2 (Pas obligé)', '')
	addGangMenu.SubMenu:AddItem(veh2Item)

	local veh3Item = NativeUI.CreateItem('Véhicule 3 (Pas obligé)', '')
	addGangMenu.SubMenu:AddItem(veh3Item)

	local veh4Item = NativeUI.CreateItem('Véhicule 4 (Pas obligé)', '')
	addGangMenu.SubMenu:AddItem(veh4Item)

	local veh5Item = NativeUI.CreateItem('Véhicule 5 (Pas obligé)', '')
	addGangMenu.SubMenu:AddItem(veh5Item)

	local vehColor = NativeUI.CreateItem('Couleur primaire du véhicule (RGB)', '')
	addGangMenu.SubMenu:AddItem(vehColor)

	local vehColor2 = NativeUI.CreateItem('Couleur secondaire du véhicule (RGB)', '')
	addGangMenu.SubMenu:AddItem(vehColor2)

	local to = NativeUI.CreateItem('============ ARMES VENDEURS ARMES ============', '')
	addGangMenu.SubMenu:AddItem(to)

	local weaponsItem = NativeUI.CreateListItem('Armes a vendre', {'Aucune armes', 'Stock d\'armes 1'}, 1, '')
	addGangMenu.SubMenu:AddItem(weaponsItem)

	local toO = NativeUI.CreateItem('============== POINT DE LA FACTION ==============', '')
	addGangMenu.SubMenu:AddItem(toO)

	local cloakroomItem = NativeUI.CreateListItem('Vestiaire', {'Position Actuelle', 'Position Custom'}, 1, '')
	addGangMenu.SubMenu:AddItem(cloakroomItem)

	local vehSpawnerItem = NativeUI.CreateListItem('Menu Sortie Véhicule', {'Position Actuelle', 'Position Custom'}, 1, '')
	addGangMenu.SubMenu:AddItem(vehSpawnerItem)

	local vehSpawnPointItem = NativeUI.CreateListItem('Sortie Véhicule', {'Position Actuelle', 'Position Custom'}, 1, '')
	addGangMenu.SubMenu:AddItem(vehSpawnPointItem)

	local vehSpawnHeadingItem = NativeUI.CreateListItem('Rotation du Véhicule', {'Rotation Actuelle', 'Rotation Custom'}, 1, '')
	addGangMenu.SubMenu:AddItem(vehSpawnHeadingItem)

	local vehDeleterItem = NativeUI.CreateListItem('Rangement Véhicule', {'Position Actuelle', 'Position Custom'}, 1, '')
	addGangMenu.SubMenu:AddItem(vehDeleterItem)

	local bossActionsItem = NativeUI.CreateListItem('Gestion Gang', {'Position Actuelle', 'Position Custom'}, 1, '')
	addGangMenu.SubMenu:AddItem(bossActionsItem)

	local toOO = NativeUI.CreateItem('==============  VALIDER LA FACTION  ==============', '')
	addGangMenu.SubMenu:AddItem(toOO)

	local confirmItem = NativeUI.CreateColouredItem('Valider la faction', '', Colours.Green, Colours.GreenLight)
	addGangMenu.SubMenu:AddItem(confirmItem)

	addGangMenu.SubMenu.OnItemSelect = function(_, item, index)
		if item == nameItem then
			local result = KeyboardInput2('GANG_NAME', 'Nom :', GangData.Name or '', 30)
			if result ~= nil then
				GangData.Name = result
				item:RightLabel(result)
			end
		end

		if item == labelItem then
			local result = tostring(KeyboardInput('GANG_LABEL', 'Label :', GangData.Label or '', 30))
			if result ~= nil then
				GangData.Label = result
				item:RightLabel(result)
			end
		end

		if item == grade1Item then
				name  = KeyboardInput2('GRADE1_NAME', 'Name :', '', 10)
				label = KeyboardInput('GRADE1_LABEL', 'Label :', '', 10)

				if label ~= nil and name ~= nil then
					GangData.Grade1 = {name = name, label = label}
					ShowNotification('Grade 1 ajouté avec succés.')
					item:RightLabel(name .. ' / ' .. label)
					grade1 = true
				end
		end

		if item == grade2Item then
			if grade1 then
				name  = KeyboardInput2('GRADE2_NAME', 'Name :', '', 10)
				label = KeyboardInput('GRADE2_LABEL', 'Label :', '', 10)

				if label ~= nil and name ~= nil then
					GangData.Grade2 = {name = name, label = label}
					ShowNotification('Grade 2 ajouté avec succés.')
					item:RightLabel(name .. ' / ' .. label)
					grade2 = true
				end
			else
				ShowNotification('~r~Vous devez faire le grade 1 en premier !')
			end
		end

		if item == grade3Item then
			if grade1 and grade2 then
				name  = KeyboardInput2('GRADE3_NAME', 'Name :', '', 10)
				label = KeyboardInput('GRADE3_LABEL', 'Label :', '', 10)

				if label ~= nil and name ~= nil then
					GangData.Grade3 = {name = name, label = label}
					ShowNotification('Grade 3 ajouté avec succés.')
					item:RightLabel(name .. ' / ' .. label)
					grade3 = true
				end
			else
				ShowNotification('~r~Vous devez faire le grade 1 et 2 en premier !')
			end
		end

		if item == grade4Item then
			if grade1 and grade2 and grade3 then
				name  = KeyboardInput2('GRADE4_NAME', 'Name :', '', 10)
				label = KeyboardInput('GRADE4_LABEL', 'Label :', '', 10)

				if label ~= nil and name ~= nil then
					GangData.Grade4 = {name = name, label = label}
					ShowNotification('Grade 4 ajouté avec succés.')
					item:RightLabel(name .. ' / ' .. label)
					grade4 = true
				end
			else
				ShowNotification('~r~Vous devez faire le grade 1, 2 et 3 en premier !')
			end
		end

		if item == grade5Item then
			if grade1 and grade2 and grade3 and grade4 then
				name  = KeyboardInput2('GRADE5_NAME', 'Name :', '', 10)
				label = KeyboardInput('GRADE5_LABEL', 'Label :', '', 10)

				if label ~= nil and name ~= nil then
					GangData.Grade5 = {name = name, label = label}
					ShowNotification('Grade 5 ajouté avec succés.')
					item:RightLabel(name .. ' / ' .. label)
					grade5 = true
				end
			else
				ShowNotification('~r~Vous devez faire le grade 1, 2, 3 et 4 en premier !')
			end
		end

		if item == veh1Item then
			name  = KeyboardInput2('VEH1_NAME', 'Model :', '', 10)
			label = KeyboardInput('VEH1_LABEL', 'Label :', '', 10)

			if label ~= nil and name ~= nil then
				local model = (type(name) == 'number' and name or GetHashKey(name))

				if IsModelInCdimage(model) then
					if (Vehicule1 and GangData.Vehicule1.name == name) or (Vehicule2 and GangData.Vehicule2.name == name) or (Vehicule3 and GangData.Vehicule3.name == name) or (Vehicule4 and GangData.Vehicule4.name == name) or (Vehicule5 and GangData.Vehicule5.name == name) then
						ShowNotification("Ce model est deja relier a un véhicule")
					else
						GangData.Vehicule1 = {name=name, label = label}
						item:RightLabel(name)
						ShowNotification('Véhicule 1 ajouté avec succés.')
						Vehicule1 = true
					end
				else
					ShowNotification('~r~Ce véhicule n\'existe pas !')
				end
			end
		end

		if item == veh2Item then
			name  = KeyboardInput2('VEH2_NAME', 'Model :', '', 10)
			label = KeyboardInput('VEH2_LABEL', 'Label :', '', 10)

			if Vehicule1 then
				if label ~= nil and name ~= nil then
					local model = (type(name) == 'number' and name or GetHashKey(name))

					if IsModelInCdimage(model) then
						if (Vehicule1 and GangData.Vehicule1.name == name) or (Vehicule2 and GangData.Vehicule2.name == name) or (Vehicule3 and GangData.Vehicule3.name == name) or (Vehicule4 and GangData.Vehicule4.name == name) or (Vehicule5 and GangData.Vehicule5.name == name) then
							ShowNotification("Ce model est deja relier a un véhicule")
						else
							GangData.Vehicule2 = {name=name, label = label}
							item:RightLabel(name)
							ShowNotification('Véhicule 2 ajouté avec succés.')
							Vehicule2 = true
						end
					else
						ShowNotification('~r~Ce véhicule n\'existe pas !')
					end
				end
			else
				ShowNotification("~r~Vous devez choisir le véhicule 1 en premier ! ")
			end
		end

		if item == veh3Item then
			name  = KeyboardInput2('VEH3_NAME', 'Model :', '', 10)
			label = KeyboardInput('VEH3_LABEL', 'Label :', '', 10)

			if Vehicule1 and Vehicule2 then
				if label ~= nil and name ~= nil then
					local model = (type(name) == 'number' and name or GetHashKey(name))

					if IsModelInCdimage(model) then
						print(GangData.Vehicule2.name .. ' | ' .. model)
						if (Vehicule1 and GangData.Vehicule1.name == name) or (Vehicule2 and GangData.Vehicule2.name == name) or (Vehicule3 and GangData.Vehicule3.name == name) or (Vehicule4 and GangData.Vehicule4.name == name) or (Vehicule5 and GangData.Vehicule5.name == name) then
							ShowNotification("Ce model est deja relier a un véhicule")
						else
							GangData.Vehicule3 = {name=name, label = label}
							item:RightLabel(name)
							ShowNotification('Véhicule 3 ajouté avec succés.')
							Vehicule3 = true
						end
					else
						ShowNotification('~r~Ce véhicule n\'existe pas !')
					end
				end
			else
				ShowNotification("~r~Vous devez choisir le véhicule 1 et 2 en premier ! ")
			end
		end

		if item == veh4Item then
			name  = KeyboardInput2('VEH4_NAME', 'Model :', '', 10)
			label = KeyboardInput('VEH4_LABEL', 'Label :', '', 10)

			if Vehicule1 and Vehicule2 and Vehicule3 then
				if label ~= nil and name ~= nil then
					local model = (type(name) == 'number' and name or GetHashKey(name))

					if IsModelInCdimage(model) then
						if (Vehicule1 and GangData.Vehicule1.name == name) or (Vehicule2 and GangData.Vehicule2.name == name) or (Vehicule3 and GangData.Vehicule3.name == name) or (Vehicule4 and GangData.Vehicule4.name == name) or (Vehicule5 and GangData.Vehicule5.name == name) then
							ShowNotification("Ce model est deja relier a un véhicule")
						else
							GangData.Vehicule4 = {name=name, label = label}
							item:RightLabel(name)
							ShowNotification('Véhicule 4 ajouté avec succés.')
							Vehicule4 = true
						end
					else
						ShowNotification('~r~Ce véhicule n\'existe pas !')
					end
				else
					ShowNotification("~r~Vous devez choisir le véhicule 1,2 et 3 en premier ! ")
				end
			end
		end

		if item == veh5Item then
			name  = KeyboardInput2('VEH5_NAME', 'Model :', '', 10)
			label = KeyboardInput('VEH5_LABEL', 'Label :', '', 10)

			if Vehicule1 and Vehicule2 and Vehicule3 and Vehicule4 then
				if label ~= nil and name ~= nil then
					local model = (type(name) == 'number' and name or GetHashKey(name))

					if IsModelInCdimage(model) then
						if (Vehicule1 and GangData.Vehicule1.name == name) or (Vehicule2 and GangData.Vehicule2.name == name) or (Vehicule3 and GangData.Vehicule3.name == name) or (Vehicule4 and GangData.Vehicule4.name == name) or (Vehicule5 and GangData.Vehicule5.name == name) then
							ShowNotification("Ce model est deja relier a un véhicule")
						else	
							GangData.Vehicule5 = {name=name, label = label}
							item:RightLabel(name)
							ShowNotification('Véhicule 5 ajouté avec succés.')
							Vehicule5 = true
						end
					else
						ShowNotification('~r~Ce véhicule n\'existe pas !')
					end
				end
			else
				ShowNotification("~r~Vous devez choisir le véhicule 1,2,3 et 4 en premier ! ")
			end
		end

		if item == vehColor then
			r  = KeyboardInput2('R_NAME', 'R :', '', 10)
			g = KeyboardInput('G_LABEL', 'G :', '', 10)
			b = KeyboardInput('B_LABEL', 'B :', '', 10)
					GangData.VehiculeColor = {r = r, g=g, b=b}
					item:RightLabel(r .. ', ' .. g .. ', ' .. b)
					ShowNotification('Couleur primaire ajouté avec succés.')
		end

		if item == vehColor2 then
			r  = KeyboardInput2('R_NAME', 'R :', '', 10)
			g = KeyboardInput('G_LABEL', 'G :', '', 10)
			b = KeyboardInput('B_LABEL', 'B :', '', 10)
					GangData.VehiculeColor2 = {r = r, g=g, b=b}
					item:RightLabel(r .. ', ' .. g .. ', ' .. b)
					ShowNotification('Couleur secondaire ajouté avec succés.')
		end

		if item == vehSpawnHeading then
			local result = tonumber(KeyboardInput('GANG_VEH_SPAWN_HEADING', 'Rotation du Véhicule (degrés) :', GangData.VehSpawnHeading or '', 30))
			if result ~= nil then
				GangData.VehSpawnHeading = result
				item:RightLabel(result)
			end
		end

		if item == confirmItem then
			if GangData.Name == nil then
				ShowNotification('Aucun nom !')
				return
			end

			if GangData.Label == nil then
				ShowNotification('Aucun label !')
				return
			end

			if GangData.Weapons == nil then
				ShowNotification('Aucun kit d\'armes !')
				return
			end

			if GangData.Cloakroom == nil then
				ShowNotification('Aucun vestiaire !')
				return
			end

			if GangData.VehSpawner == nil then
				ShowNotification('Aucun point pour spawn véhicule !')
				return
			end

			if GangData.VehSpawnPoint == nil then
				ShowNotification('Aucun emplacement de spawn véhicule !')
				return
			end

			if GangData.VehSpawnHeading == nil then
				ShowNotification('Aucune rotation du véhicule !')
				return
			end

			if GangData.VehDeleter == nil then
				ShowNotification('Aucun point de suppression véhicule !')
				return
			end

			if GangData.BossActions == nil then
				ShowNotification('Aucun point de gestion gang !')
				return
			end

			if GangData.Grade1 == nil and GangData.Grade2 == nil then
				ShowNotification('Vous devez créer le grade 1 et 2 minimum !')
				return
			end

			if GangData.Vehicule1 == nil then
				ShowNotification('Vous devez mettre au moin 1 vehicule !')
				return
			end

			if GangData.VehiculeColor == nil then
				ShowNotification('Vous devez mettre choisir une couleur primaire !')
				return
			end

			if GangData.VehiculeColor2 == nil then
				ShowNotification('Vous devez mettre choisir une couleur secondaire !')
				return
			end

			if not grade5 and not grade4 and not grade3 then
				GangData.Grade2.name = "boss"
			elseif not grade5 and not grade4 then
				GangData.Grade3.name = "boss"
			elseif not grade5 then
				GangData.Grade4.name = "boss"
			else
				GangData.Grade5.name = "boss"
			end


			TriggerServerEvent('gb:addGang', GangData)
			grade1 = false
			grade2 = false
			grade3 = false
			grade4 = false
			grade5 = false

			Vehicule1 = false
			Vehicule2 = false
			Vehicule3 = false
			Vehicule4 = false
			Vehicule5 = false
			ShowNotification('Faction créé ! (Disponible au prochain reboot)')
		end
	end

	addGangMenu.SubMenu.OnListChange = function(_, item, index)
		if item == weaponsItem then
			GangData.Weapons = gangsKit.Weapons[index]
		end
	end

	addGangMenu.SubMenu.OnListSelect = function(_, item, index)
		if item == cloakroomItem then
			if index == 1 then
				local plyCoords = VectorToArray(GetEntityCoords(PlayerPedId(), false))
				plyCoords.z = plyCoords.z - 1.05
				GangData.Cloakroom = plyCoords
				ShowNotification('Coordonnées ajouté.')
			else
				x = tonumber(KeyboardInput('COORDS_X', 'X Value :', '', 30))
				y = tonumber(KeyboardInput('COORDS_Y', 'Y Value :', '', 30))
				z = tonumber(KeyboardInput('COORDS_Z', 'Z Value :', '', 30))
				if x ~= nil and y ~= nil and z ~= nil then
					GangData.Cloakroom = {x = x, y = y, z = z}
					ShowNotification('Coordonnées ajouté.')
				end
			end
		end
		if item == vehSpawnerItem then
			if index == 1 then
				local plyCoords = VectorToArray(GetEntityCoords(PlayerPedId(), false))
				plyCoords.z = plyCoords.z - 1.05
				GangData.VehSpawner = plyCoords
				ShowNotification('Coordonnées ajouté.')
			else
				x = tonumber(KeyboardInput('COORDS_X', 'X Value :', '', 30))
				y = tonumber(KeyboardInput('COORDS_Y', 'Y Value :', '', 30))
				z = tonumber(KeyboardInput('COORDS_Z', 'Z Value :', '', 30))

				if x ~= nil and y ~= nil and z ~= nil then
					GangData.VehSpawner = {x = x, y = y, z = z}
					ShowNotification('Coordonnées ajouté.')
				end
			end
		end

		if item == vehSpawnPointItem then
			if index == 1 then
				local plyCoords = VectorToArray(GetEntityCoords(PlayerPedId(), false))
				plyCoords.z = plyCoords.z - 1.05
				GangData.VehSpawnPoint = plyCoords
				ShowNotification('Coordonnées ajouté.')
			else
				x = tonumber(KeyboardInput('COORDS_X', 'X Value :', '', 30))
				y = tonumber(KeyboardInput('COORDS_Y', 'Y Value :', '', 30))
				z = tonumber(KeyboardInput('COORDS_Z', 'Z Value :', '', 30))

				if x ~= nil and y ~= nil and z ~= nil then
					GangData.VehSpawnPoint = {x = x, y = y, z = z}
					ShowNotification('Coordonnées ajouté.')
				end
			end
		end

		if item == vehSpawnHeadingItem then
			if index == 1 then
				GangData.VehSpawnHeading = GetEntityHeading(PlayerPedId(), true)
				ShowNotification('Rotation ajouté.')
			else
				degree = tonumber(KeyboardInput('ROTATION_DEGREE', 'Degree Value :', '', 30))

				if degree ~= nil then
					GangData.VehSpawnHeading = degree
					ShowNotification('Rotation ajouté.')
				end
			end
		end

		if item == vehDeleterItem then
			if index == 1 then
				local plyCoords = VectorToArray(GetEntityCoords(PlayerPedId(), false))
				plyCoords.z = plyCoords.z - 1.05
				GangData.VehDeleter = plyCoords
				ShowNotification('Coordonnées ajouté.')
			else
				x = tonumber(KeyboardInput('COORDS_X', 'X Value :', '', 30))
				y = tonumber(KeyboardInput('COORDS_Y', 'Y Value :', '', 30))
				z = tonumber(KeyboardInput('COORDS_Z', 'Z Value :', '', 30))

				if x ~= nil and y ~= nil and z ~= nil then
					GangData.VehDeleter = {x = x, y = y, z = z}
					ShowNotification('Coordonnées ajouté.')
				end
			end
		end

		if item == bossActionsItem then
			if index == 1 then
				local plyCoords = VectorToArray(GetEntityCoords(PlayerPedId(), false))
				plyCoords.z = plyCoords.z - 1.05
				GangData.BossActions = plyCoords
				ShowNotification('Coordonnées ajouté.')
			else
				x = tonumber(KeyboardInput('COORDS_X', 'X Value :', '', 30))
				y = tonumber(KeyboardInput('COORDS_Y', 'Y Value :', '', 30))
				z = tonumber(KeyboardInput('COORDS_Z', 'Z Value :', '', 30))

				if x ~= nil and y ~= nil and z ~= nil then
					GangData.BossActions = {x = x, y = y, z = z}
					ShowNotification('Coordonnées ajouté.')
				end
			end
		end
	end

	addGangMenu.SubMenu.OnMenuClosed = function()
		_menuPool:RefreshIndex()
	end

	_menuPool:RefreshIndex()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		_menuPool:ProcessMenus()
		_menuPool:MouseControlsEnabled(false)
		_menuPool:MouseEdgeEnabled(false)
		_menuPool:ControlDisablingEnabled(false)
	end
end)

DrawGangMenu()

RegisterNetEvent('gb:OpenMenu')
AddEventHandler('gb:OpenMenu', function()
	mainGangMenu:Visible(true)
end)

RegisterCommand("gangsbuilder", function(source)
	ESX.TriggerServerCallback('jek:getUsergroup', function(plyGroup)
		if plyGroup ~= nil and (plyGroup == 'admin' or plyGroup == 'superadmin' or plyGroup == 'owner' or plyGroup == '_dev') then
			TriggerEvent('gb:OpenMenu', source)
		else
			ESX.ShowNotification("Vous devez être ~r~Admin ~w~pour ouvrir le ~g~GangsBuilder.")
		end
	end)
end,false)