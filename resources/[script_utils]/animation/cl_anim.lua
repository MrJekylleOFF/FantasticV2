  
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()
ESX                           = nil
animBind = NativeUI.CreateMenu("Animations", "", 8, 200,nil,nil,nil)
_menuPool:Add(animBind)
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

function ShowAboveRadarMessage(message, back)
	if back then Citizen.InvokeNative(0x92F0DA1E27DB96DC, back) end
	SetNotificationTextEntry("")
	AddTextComponentString(message)
	if string.len(message) > 99 and AddLongString then AddLongString(message) end
	return DrawNotification(0, 1)
end


pavAnimName = {}
pavAnim = {}
local barberShops = nil
function OpenBindMenu()
	_menuPool:CloseAllMenus()
    for k , v in pairs(Config.Anims) do
        for i=1,#v,1 do
            table.insert( pavAnim, v[i].name )
            table.insert( pavAnimName,v[i])
        end
    end
	menu = animBind
    pavInd = { "Pav 7", "Pav 8", "Pav 9" }
    pavName = { "pav7", "pav8", "pav9" }

    local selectedBindAnim = nil
    local selectedAnim
    local selectedDict = nil

    pref = menu
    local selectedmood = nil
    local selecteddemarhce = nil

    bind = NativeUI.CreateListItem("Touches : ", pavInd, 0, "Choisissez une animation a mettre sur une touche !")
    animq = NativeUI.CreateListItem("Animations : ", pavAnim, 0, "")
    pref:AddItem(bind)
    pref:AddItem(animq)


    p = NativeUI.CreateItem("Annuler l\'animation","")
    menu:AddItem(p)
    pref.OnItemSelect = function(_,_,index)
        if index == 1 then
            local ped = GetPlayerPed(-1);
            if ped then
                ClearPedTasks(ped);
            end
            SetEnableHandcuffs(ped, false)
        end
    end
    pref.OnListSelect = function(_, item, index)
        --(index)
        if item == bind then
            if selectedBindAnim ~= nil then
                TriggerEvent("annim:shownotif", "Touches d\'animations : " .. selectedBindAnim .. "~n~sur la touche " .. pavInd[index], 26)
                TriggerServerEvent("annim:saveBind", selectedAnim, pavName[index])
            else
                TriggerEvent("annim:shownotif", "Aucune animation selectionne !", 6)
            end
        end
        if item == animq then
            TriggerEvent("annim:shownotif", "Animation Choisi : " .. pavAnim[index], 26)
            ESX.ShowNotification("~b~~h~Vous devez enregistrer les 3 touches de votre pavé num ~n~ ~g~~h~[7]       [8]      [9] ~n~~b~pour pouvoir les faire par la suite")
            selectedBindAnim = pavAnim[index]
            selectedAnim = pavAnimName[index]

            print(pavAnimName[index])
        end
    end

    for  k , v in pairs(Config.Anims) do
        tpl = _menuPool:AddSubMenu(menu, k,"",true,true)
        for i = 1 ,#v,1 do
            p = NativeUI.CreateItem(v[i].name,"")
            tpl:AddItem(p)
        end
        tpl.OnItemSelect = function(_, _, index)
            if type(v[index].func) == "function" then v[index].func(GetPlayerPed(-1)) return end
            if v[index].anim then
                doAnim(v[index].anim, nil, v[index].func)
            elseif v[index].anims then
                local firstAnim = v[index].anims.enter[#v[index].anims.enter]
                local selected = v[index].anims.exit and IsEntityPlayingAnim(ped, firstAnim.anim[1], firstAnim.anim[2], 3) and v[index].anims.exit or v[index].anims.enter
                TaskSynchronizedTasks(GetPlayerPed(-1), selected)
            elseif v[index].animD then 
                print(v[index].animD[1], v[index].animD[2])
                startAttitude(v[index].animD[1], v[index].animD[2])    
            end
        end
        _menuPool:RefreshIndex()
    end
    _menuPool:WidthOffset(120)
	_menuPool:RefreshIndex()

end
function TaskSynchronizedTasks(ped, animData, clearTasks)
	for _,v in pairs(animData) do
		if not HasAnimDictLoaded(v.anim[1]) then
			RequestAnimDict(v.anim[1])
			while not HasAnimDictLoaded(v.anim[1]) do Citizen.Wait(0) end
		end
	end

	local _, sequence = OpenSequenceTask(0)
	for _,v in pairs(animData) do
		TaskPlayAnim(0, v.anim[1], v.anim[2], 2.0, -2.0, math.floor(v.time or -1), v.flag or 48, 0, 0, 0, 0)
	end

	CloseSequenceTask(sequence)
	if clearTasks then ClearPedTasks(ped) end
	TaskPerformSequence(ped, sequence)
	ClearSequenceTask(sequence)

	for _,v in pairs(animData) do
		RemoveAnimDict(v.anim[1])
	end

	return sequence
end

function canDoIt()
	return true
end
function doAnim(animName, time, flag, ped, customPos)
	if type(animName) ~= "table" then animName = {animName} end
	ped, flag = ped or GetPlayerPed(-1), flag and tonumber(flag) or false

	if not animName or not animName[1] or string.len(animName[1]) < 1 then return end
    print(IsEntityPlayingAnim(ped, animName[1], animName[2], 3))
	if IsEntityPlayingAnim(ped, animName[1], animName[2], 3) or IsPedActiveInScenario(ped) then ClearPedTasks(ped) print("o") return end

	Citizen.CreateThread(function()
		forceAnim(animName, flag, { ped = ped, time = time, pos = customPos })
	end)
end

function forceAnim(animName, flag, args)
	flag, args = flag and tonumber(flag) or false, args or {}
	local ped, time, clearTasks, animPos, animRot, animTime = args.ped or GetPlayerPed(-1), args.time, args.clearTasks, args.pos, args.ang

	if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then return end

	if not clearTasks then ClearPedTasks(ped) end

	if not animName[2] and femaleFix[animName[1]] and GetEntityModel(ped) == -1667301416 then
		animName = femaleFix[animName[1]]
	end

	if animName[2] and not HasAnimDictLoaded(animName[1]) then
		if not DoesAnimDictExist(animName[1]) then return end
		RequestAnimDict(animName[1])
		while not HasAnimDictLoaded(animName[1]) do
			Citizen.Wait(10)
		end
	end

	if not animName[2] then
		ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
		TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
	else
		if not animPos then
			TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 0, 0, 0, 0, 0)
		else
			TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, flag or 44, animTime or -1, 0, 0)
		end
	end

	if time and type(time) == "number" then
		Citizen.Wait(time)
		ClearPedTasks(ped)
	end

	if not args.dict then RemoveAnimDict(animName[1]) end
end

function startAttitude(lib, anim)
    ESX.Streaming.RequestAnimSet(lib, function()
        SetPedMovementClipset(PlayerPedId(), anim, true)
    end)
end
	
-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		_menuPool:ProcessMenus()
        --if IsControlPressed(0,  Keys['F10']) then
        --  animBind:Visible(true)
        --end
		if IsControlJustReleased(0, Keys['X']) and IsInputDisabled(0) and not isDead then
			ClearPedTasks(PlayerPedId())
		end
	end
end)

OpenBindMenu()

RegisterNetEvent("annim:shownotif")
AddEventHandler("annim:shownotif", function(text, color)
    if color == 210 then
        color = 18
    end
    Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end)




local Pad7 = {}
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlPressed(0, 117) and GetLastInputMethod(0) then
            Wait(200)
            if GetLastInputMethod(0) then
                if Pad7[1] ~= nil then
                    if type(Pad7[2].func) == "function" then Pad7[2].func(GetPlayerPed(-1)) return end
                    if Pad7[1].anim then
                        doAnim(Pad7[1].anim, nil, Pad7[1].func)
                    else
                        local firstAnim = Pad7[1].anims.enter[#Pad7[1].anims.enter]
                        local selected = Pad7[1].anims.exit and IsEntityPlayingAnim(ped, firstAnim.anim[1], firstAnim.anim[2], 3) and Pad7[1].anims.exit or Pad7[1].anims.enter
                        TaskSynchronizedTasks(GetPlayerPed(-1), selected)
                    end
                    Wait(500)
                end
            end
        end
        if IsControlJustReleased(0, 111) and GetLastInputMethod(0) then
            Wait(200)
            if GetLastInputMethod(0) then
                if Pad7[2] ~= nil then
                    if type(Pad7[2].func) == "function" then Pad7[2].func(GetPlayerPed(-1)) return end
                    if Pad7[2].anim then
                        doAnim(Pad7[2].anim, nil, Pad7[2].func)
                    else
                        local firstAnim = Pad7[2].anims.enter[#Pad7[2].anims.enter]
                        local selected = Pad7[2].anims.exit and IsEntityPlayingAnim(ped, firstAnim.anim[1], firstAnim.anim[2], 3) and Pad7[2].anims.exit or Pad7[2].anims.enter
                        TaskSynchronizedTasks(GetPlayerPed(-1), selected)
                    end
                end
            end
            Wait(500)
        end
        if IsControlPressed(0, 118) and GetLastInputMethod(0) then
            Wait(200)
            if GetLastInputMethod(0) then
                if Pad7[3] ~= nil then
                    if type(Pad7[3].func) == "function" then Pad7[3].func(GetPlayerPed(-1)) return end
                    if Pad7[3].anim then
                        doAnim(Pad7[3].anim, nil, Pad7[3].func)
                    elseif Pad7[3].anims then
                        local firstAnim = Pad7[3].anims.enter[#Pad7[3].anims.enter]
                        local selected = Pad7[3].anims.exit and IsEntityPlayingAnim(ped, firstAnim.anim[1], firstAnim.anim[2], 3) and Pad7[3].anims.exit or Pad7[1].anims.enter
                        TaskSynchronizedTasks(GetPlayerPed(-1), selected)
                    end
                    Wait(500)
                end
            end
        end
    end
end)
function tableHasValue(tbl, value, k)
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end
function PlayAnimSaved(anim, dict)
    local ad = anim
    player = GetPlayerPed(-1)
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        loadAnimDict(ad)
        if (IsEntityPlayingAnim(player, ad, dict, 3)) then
            ClearPedSecondaryTask(PlayerPedId())
        else
            TaskPlayAnim(player, ad, dict, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        end
    end
end
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end
 femaleFix = {
	["WORLD_HUMAN_BUM_WASH"] = {"amb@world_human_bum_wash@male@high@idle_a", "idle_a"},
	["WORLD_HUMAN_SIT_UPS"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a"},
	["WORLD_HUMAN_PUSH_UPS"] = {"amb@world_human_push_ups@male@base", "base"},
	["WORLD_HUMAN_BUM_FREEWAY"] = {"amb@world_human_bum_freeway@male@base", "base"},
	["WORLD_HUMAN_CLIPBOARD"] = {"amb@world_human_clipboard@male@base", "base"},
	["WORLD_HUMAN_VEHICLE_MECHANIC"] = {"amb@world_human_vehicle_mechanic@male@base", "base"},
}
RegisterNetEvent('annim:ready')
AddEventHandler('annim:ready', function()
    ESX.TriggerServerCallback("annim:getsettings", function(result)

        if result[1] ~= nil then
            Pad7 = {}
            pav7 = json.decode(result[1].pav7)
            pav8 = json.decode(result[1].pav8)
            pav9 = json.decode(result[1].pav9)
            table.insert(Pad7, { anim = pav7.anim, dict = pav7.dict })
            table.insert(Pad7, { anim = pav8.anim, dict = pav8.dict })
            table.insert(Pad7, { anim = pav9.anim, dict = pav9.dict })


            TriggerEvent("annim:shownotif", "Touche enregistrée", 26)
        end
    end)
end)



AddEventHandler("playerSpawned", function(_)
    while ESX == nil do
        Wait(1)
    end
    ESX.TriggerServerCallback("annim:getsettings", function(result)

        if result[1] ~= nil then
            Pad7 = {}
            pav7 = json.decode(result[1].pav7)
            pav8 = json.decode(result[1].pav8)
            pav9 = json.decode(result[1].pav9)
            table.insert(Pad7, { anim = pav7.anim, dict = pav7.dict })
            table.insert(Pad7, { anim = pav8.anim, dict = pav8.dict })
            table.insert(Pad7, { anim = pav9.anim, dict = pav9.dict })
            TriggerEvent("annim:shownotif", "Touche enregistrée", 26)
        end
    end)

end)




RegisterCommand("openanim",function(source, args)
	animBind:Visible(true)
end, false)
