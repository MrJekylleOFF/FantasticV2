resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
dependency 'es_extended'
ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua',
}

client_scripts {
	"dependencies/Wrapper/Utility.lua",
	
	"dependencies/UIElements/UIVisual.lua",
	"dependencies/UIElements/UIResRectangle.lua",
	"dependencies/UIElements/UIResText.lua",
	"dependencies/UIElements/Sprite.lua",

	"dependencies/UIMenu/elements/Badge.lua",
	"dependencies/UIMenu/elements/Colours.lua",
	"dependencies/UIMenu/elements/StringMeasurer.lua",
	"dependencies/UIMenu/items/UIMenuItem.lua",
	"dependencies/UIMenu/items/UIMenuCheckboxItem.lua",
	"dependencies/UIMenu/items/UIMenuListItem.lua",
	"dependencies/UIMenu/UIMenu.lua",
	"dependencies/UIMenu/MenuPool.lua",
	"dependencies/UIMenu/items/UIMenuColouredItem.lua",
	"dependencies/NativeUI.lua",
	"dependencies/UIMenu/panels/UIMenuGridPanel.lua",
	"dependencies/UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
	"dependencies/UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
	"dependencies/UIMenu/panels/UIMenuColourPanel.lua",
	"dependencies/UIMenu/panels/UIMenuPercentagePanel.lua",
	"dependencies/UIMenu/panels/UIMenuStatisticsPanel.lua",
	"dependencies/UIMenu/windows/UIMenuHeritageWindow.lua",
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua',
	--'other/pointing.lua',
	--'other/crouch.lua',
}
