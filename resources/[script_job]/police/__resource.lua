resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Police Job'

version '1.3.0'

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
    'UITimerBar/UITimerBarPool.lua',

    'UITimerBar/items/UITimerBarItem.lua',
    'UITimerBar/items/UITimerBarProgressItem.lua',
    'UITimerBar/items/UITimerBarProgressWithIconItem.lua',

}

client_scripts {
    'UIProgressBar/UIProgressBarPool.lua',
    'UIProgressBar/items/UIProgressBarItem.lua',
}

client_scripts {
    "NativeUI.lua",
}

client_scripts {
    ".test/Native-Danger.lua"
}

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
	'client/main.lua',
}

dependencies {
	'es_extended'
}