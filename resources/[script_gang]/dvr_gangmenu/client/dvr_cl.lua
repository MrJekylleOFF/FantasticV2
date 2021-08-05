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


local GUI                       = {}
GUI.Time                        = 0

ESX = nil
local PlayerData = {}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

-- BLIPS GANG
local blipsfammilies = {
  {title="", colour=2, id=84, x = -93.48, y = -1550.57, z = 32.64}, -- fammilies
}

local fammilies = true
Citizen.CreateThread(function()
  Citizen.Wait(0)
  if fammilies then
      for k,v in pairs(blipsfammilies) do
          zoneblipfammilies = AddBlipForRadius(v.x,v.y,v.z, 1000.0)
          SetBlipSprite(zoneblipfammilies,1)
          SetBlipColour(zoneblipfammilies,69)
          SetBlipAlpha(zoneblipfammilies,150)         
      end
      fammilies = false
  end
end)

--- ballas
local blipsballas = {
  {title="", colour=2, id=84, x = 50.75, y = -1862.42, z = 35.29}, -- ballas
}
local ballas = true
Citizen.CreateThread(function()
  Citizen.Wait(0)
  if ballas then 
      for k,v in pairs(blipsballas) do
          zoneblipballas = AddBlipForRadius(v.x,v.y,v.z, 1000.0)
          SetBlipSprite(zoneblipballas,1)
          SetBlipColour(zoneblipballas,83)
          SetBlipAlpha(zoneblipballas,150) 
      end
      ballas = false
  end
end)

--- vagos
local blipsvagos = {
  {title="", colour=2, id=84, x = 300.15, y = -2010.01, z = 24.64}  -- vagos
}
local vagos = true
Citizen.CreateThread(function()
  Citizen.Wait(0)
  if vagos then 
      for k,v in pairs(blipsvagos) do
          zoneblipvagos = AddBlipForRadius(v.x,v.y,v.z, 920.0)
          SetBlipSprite(zoneblipvagos,1)
          SetBlipColour(zoneblipvagos,60)
          SetBlipAlpha(zoneblipvagos,150) 
      end
      vagos = false
  end
end)

--- aztecas
local blipAztecas = {
  {title="", colour=54, id=84, x = 1308.76, y = -1755.64, z = 57.14}  -- aztecas
}
local Aztecas = true
Citizen.CreateThread(function()
  Citizen.Wait(0)
  if Aztecas then 
      for k,v in pairs(blipAztecas) do
          zoneblipAztecas = AddBlipForRadius(v.x,v.y,v.z, 920.0)
          SetBlipSprite(zoneblipAztecas, 1)
          SetBlipColour(zoneblipAztecas, 54)
          SetBlipAlpha(zoneblipAztecas, 150) 
      end
      Aztecas = false
  end
end)


--- white
local blipWhite = {
  {title="", colour=54, id=84, x = -609.45, y = 193.85, z = 71.02}  -- white
}
local White = true
Citizen.CreateThread(function()
  Citizen.Wait(0)
  if White then 
      for k,v in pairs(blipWhite) do
          zoneblipWhite = AddBlipForRadius(v.x,v.y,v.z, 500.0)
          SetBlipSprite(zoneblipWhite, 1)
          SetBlipColour(zoneblipWhite, 0)
          SetBlipAlpha(zoneblipWhite, 150) 
      end
      White = false
  end
end)
