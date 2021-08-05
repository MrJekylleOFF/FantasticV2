Config = {}

-- Position on Lockdown and Cooldown when the lights turn on
Config.Lockdown = {x = 713.25543212891, y = 164.67964172363, z = 80.754470825195} -- 713.25543212891,164.67964172363,80.754470825195
Config.Cooldown = 3600000 -- 10000 = 10 sec, 20000 = 20sec, 100000 = 100sec, 3600000 = 1 Hour, 86400000 = 24 Hours (If you change this Cooldown time, Remember to change the Cooldown text at Config.LockdownText)

-- 3D Text Message
Config.ActiveText = "[~o~E~w~] pour piraté les lumierres de la ville"
Config.LockdownText = "Le verrouillage est activé \n ~o~Patientez environs ~w~: 1 ~y~heure"

-- Blips
Config.TextComponentString = "Central"
Config.KillBlip = 100000 -- 300000 = 5Min