resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	"NativeUILua/Wrapper/Utility.lua",

	"NativeUILua/UIElements/UIVisual.lua",
	"NativeUILua/UIElements/UIResRectangle.lua",
	"NativeUILua/UIElements/UIResText.lua",
	"NativeUILua/UIElements/Sprite.lua",
	
	"NativeUILua/UIMenu/elements/Badge.lua",
	"NativeUILua/UIMenu/elements/Colours.lua",
	"NativeUILua/UIMenu/elements/ColoursPanel.lua",
	"NativeUILua/UIMenu/elements/StringMeasurer.lua",

	"NativeUILua/UIMenu/items/UIMenuItem.lua",
	"NativeUILua/UIMenu/items/UIMenuCheckboxItem.lua",
	"NativeUILua/UIMenu/items/UIMenuListItem.lua",
	"NativeUILua/UIMenu/items/UIMenuSliderItem.lua",
	"NativeUILua/UIMenu/items/UIMenuSliderHeritageItem.lua",
	"NativeUILua/UIMenu/items/UIMenuColouredItem.lua",

	"NativeUILua/UIMenu/UIMenu.lua",
	"NativeUILua/UIMenu/MenuPool.lua",
	
	"NativeUILua/NativeUI.lua",
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'client/builder.lua',
	'client/menu.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/builder.lua',
	'server/main.lua'
}