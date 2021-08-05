fx_version 'adamant'
game 'gta5'

author 'Morow'
description 'Clothes shop with item of clothing'

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",

    "RageUI/components/*.lua",

    "RageUI/menu/elements/*.lua",

    "RageUI/menu/items/*.lua",

    "RageUI/menu/panels/*.lua",

    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",

    "client/menu.lua",
    "client/position.lua"

}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "server/server.lua",

}
