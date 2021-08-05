resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
dependencies {
	'es_extended'
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
	"dependencies/UIMenu/windows/UIMenuHeritageWindow.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}
