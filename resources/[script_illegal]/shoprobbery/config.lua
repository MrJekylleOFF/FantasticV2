Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'sv' -- 'en', 'sv' or 'custom'

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(1134.02, -983.34, 45.42-0.98), heading = 277.6, money = {3000, 5000}, cops = 3, blip = false, name = '', cooldown = {hour = 2, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1392.63, 3606.41, 34.98-0.98), heading = 203.18, money = {3000, 5000}, cops = 3, blip = false, name = '', cooldown = {hour = 2, minute = 30, second = 0}, robbed = false},
    {coords = vector3(372.22, 326.68, 102.57-0.98), heading = 258.03, money = {3000, 5000}, cops = 3, blip = false, name = '', cooldown = {hour = 2, minute = 30, second = 0}, robbed = false},
	{coords = vector3(24.38, -1346.91, 28.5-0.98), heading = 267.53, money = {3000, 5000}, cops = 3, blip = false, name = '', cooldown = {hour = 2, minute = 30, second = 0}, robbed = false},
	{coords = vector3(-1221.71, -908.53, 12.33-0.98), heading = 33.95, money = {3000, 5000}, cops = 3, blip = false, name = '', cooldown = {hour = 2, minute = 30, second = 0}, robbed = false},

}

Translation = {
    ['sv'] = {
        ['shopkeeper'] = 'Apu',
        ['robbed'] = 'Je viens de me faire voler et je n\'ai plus d\'argent!',
        ['cashrecieved'] = 'Vous avez obtenu: ',
        ['currency'] = '$ ',
        ['scared'] = 'Effrayé: ',
        ['no_cops'] = 'Il n\'y a pas assez de policiers en ligne!',
        ['cop_msg'] = 'Nous avons envoyé une photo du voleur depuis les caméras de surveillance!',
        ['set_waypoint'] = 'Mettre le point GPS en magasin',
        ['hide_box'] = 'Fermer cette boîte',
        ['robbery'] = 'Vol de magasin en attente',
        ['walked_too_far'] = 'Vous êtes allé trop loin!'
    }
}