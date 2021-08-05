resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

server_scripts {
	"util_shared.lua",
	"admin_server.lua",
}

client_scripts {

    "NativeUILua_Reloaded/Wrapper/Utility.lua",

    "NativeUILua_Reloaded/UIElements/UIVisual.lua",
    "NativeUILua_Reloaded/UIElements/UIResRectangle.lua",
    "NativeUILua_Reloaded/UIElements/UIResText.lua",
    "NativeUILua_Reloaded/UIElements/Sprite.lua",

    "NativeUILua_Reloaded/UIMenu/elements/Badge.lua",
    "NativeUILua_Reloaded/UIMenu/elements/Colours.lua",
    "NativeUILua_Reloaded/UIMenu/elements/ColoursPanel.lua",
    "NativeUILua_Reloaded/UIMenu/elements/StringMeasurer.lua",

    "NativeUILua_Reloaded/UIMenu/items/UIMenuItem.lua",
    "NativeUILua_Reloaded/UIMenu/items/UIMenuCheckboxItem.lua",
    "NativeUILua_Reloaded/UIMenu/items/UIMenuListItem.lua",
    "NativeUILua_Reloaded/UIMenu/items/UIMenuSliderItem.lua",
    "NativeUILua_Reloaded/UIMenu/items/UIMenuSliderHeritageItem.lua",
    "NativeUILua_Reloaded/UIMenu/items/UIMenuColouredItem.lua",

    "NativeUILua_Reloaded/UIMenu/items/UIMenuProgressItem.lua",
    "NativeUILua_Reloaded/UIMenu/items/UIMenuSliderProgressItem.lua",

    "NativeUILua_Reloaded/UIMenu/windows/UIMenuHeritageWindow.lua",

    "NativeUILua_Reloaded/UIMenu/panels/UIMenuGridPanel.lua",
    "NativeUILua_Reloaded/UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
    "NativeUILua_Reloaded/UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
    "NativeUILua_Reloaded/UIMenu/panels/UIMenuColourPanel.lua",
    "NativeUILua_Reloaded/UIMenu/panels/UIMenuPercentagePanel.lua",
    "NativeUILua_Reloaded/UIMenu/panels/UIMenuStatisticsPanel.lua",

    "NativeUILua_Reloaded/UIMenu/UIMenu.lua",
    "NativeUILua_Reloaded/UIMenu/MenuPool.lua",

    "NativeUILua_Reloaded/NativeUI.lua"
}

client_scripts {
	--"dependencies/NativeUI.lua",
	--"dependencies/MenuPool.lua",
	"util_shared.lua",
	"admin_client.lua",
	"gui_c.lua",
}
