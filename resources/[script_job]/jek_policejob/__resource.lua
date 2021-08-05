resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Police Job'

version '1.2.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
    "NativeUI/Wrapper/Utility.lua",

    "NativeUI/UIElements/UIVisual.lua",
    "NativeUI/UIElements/UIResRectangle.lua",
    "NativeUI/UIElements/UIResText.lua",
	"NativeUI/UIElements/Sprite.lua",

	"NativeUI/UIMenu/elements/Badge.lua",
    "NativeUI/UIMenu/elements/Colours.lua",
    "NativeUI/UIMenu/elements/ColoursPanel.lua",
    "NativeUI/UIMenu/elements/StringMeasurer.lua",
	
	"NativeUI/UIMenu/items/UIMenuItem.lua",
    "NativeUI/UIMenu/items/UIMenuCheckboxItem.lua",
	"NativeUI/UIMenu/items/UIMenuListItem.lua",
	"NativeUI/UIMenu/items/UIMenuColouredItem.lua",
	
    "NativeUI/UIMenu/panels/UIMenuColourPanel.lua",
	"NativeUI/UIMenu/panels/UIMenuStatisticsPanel.lua",
	
	"NativeUI/UIMenu/UIMenu.lua",
	"NativeUI/UIMenu/MenuPool.lua",
	
	"NativeUI/NativeUI.lua",
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'config.lua',
	'client/armurie.lua',
	'client/menu.lua',
	'client/MenuVeh.lua',
	'client/npc.lua',
	'client/pilote.lua',
	'client/utils.lua',
	'client/zone.lua',
	'client/main.lua',
	'client/renfortPNJ.lua',
	'client/interactNPC.lua',
	'client/radar.lua'
}

dependencies {
	'es_extended',
	'esx_factures'
}

