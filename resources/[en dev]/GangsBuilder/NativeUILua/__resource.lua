resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'NativeUILua-Reloaded'
description 'NativeUILua-Reloaded is UI library for FiveM designed specifically for making interface based on GTA:Online style. (Base source: https://github.com/FrazzIe/NativeUILua ) | (Base NativeUI : https://github.com/Guad/NativeUI) '


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