resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Menu Default'

version '1.0.4'

client_scripts {
    "Wrapper/Utility.lua",

    "UIElements/UIVisual.lua",
    "UIElements/UIResRectangle.lua",
    "UIElements/UIResText.lua",
    "UIElements/Sprite.lua",
}

client_scripts {
    "UIMenu/elements/Badge.lua",
    "UIMenu/elements/Colours.lua",
    "UIMenu/elements/ColoursPanel.lua",
    "UIMenu/elements/StringMeasurer.lua",

    "UIMenu/items/UIMenuItem.lua",
    "UIMenu/items/UIMenuCheckboxItem.lua",
    "UIMenu/items/UIMenuListItem.lua",
    "UIMenu/items/UIMenuSliderItem.lua",
    "UIMenu/items/UIMenuSliderHeritageItem.lua",
    "UIMenu/items/UIMenuColouredItem.lua",

    "UIMenu/items/UIMenuProgressItem.lua",
    "UIMenu/items/UIMenuSliderProgressItem.lua",

    "UIMenu/windows/UIMenuHeritageWindow.lua",

    "UIMenu/panels/UIMenuGridPanel.lua",
    "UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
    "UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
    "UIMenu/panels/UIMenuColourPanel.lua",
    "UIMenu/panels/UIMenuPercentagePanel.lua",
    "UIMenu/panels/UIMenuStatisticsPanel.lua",

    "UIMenu/UIMenu.lua",
    "UIMenu/MenuPool.lua",
}

client_scripts {
	'@es_extended/client/wrapper.lua',
	'client/main.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/app.css',
	'html/js/mustache.min.js',
	'html/js/app.js',
	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf'
}

dependencies {
	'es_extended'
}
