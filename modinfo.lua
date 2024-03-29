istest = false
name = " Omni Info Panel" .. (istest and " test" or "")
version = "1.15"
description = "Version:" .. version .. "\n Omnipotent information panel!"
author = "dyc"
forumthread = ""
api_version = 6
priority = -1
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true
dst_compatible = true
all_clients_require_mod = false
client_only_mod = true
server_only_mod = false
icon_atlas = "preview.xml"
icon = "preview.tex"
configuration_options = {
    {
        name = "hovertext",
        label = "Hover Text",
        hover = "Show the vanilla hover text when the mouse hovers on objects? (It is suggested to turn it off.)",
        options = {
            { description = "ON",  lkey = "on",  data = true,  hover = "" },
            { description = "OFF", lkey = "off", data = false, hover = "" },
        },
        default = true,
    },
    {
        name = "infopanelpos",
        label = "Info Panel Position",
        hover = "Follow object? Or use fixed position?",
        options = {
            { description = "Auto",          lkey = "auto",         data = "auto",   hover = "Set position to bottom left if controller is attached, otherwise follow object." },
            { description = "Follow Object", lkey = "followobject", data = "follow", hover = "" },
            { description = "Top Left",      lkey = "topleft",      data = "tl",     hover = "" },
            { description = "Bottom Left",   lkey = "bottomleft",   data = "bl",     hover = "" },
            { description = "Bottom Right",  lkey = "bottomright",  data = "br",     hover = "" },
            { description = "Top Right",     lkey = "topright",     data = "tr",     hover = "" },
        },
        default = "auto",
    },
    {
        name = "infopanelfs",
        label = "Info Panel Font",
        options = {
            { description = "Very Small", lkey = "verysmall", data = 18, hover = "18" },
            { description = "Small",      lkey = "small",     data = 22, hover = "22" },
            { description = "Normal",     lkey = "normal",    data = 25, hover = "25" },
            { description = "Large",      lkey = "large",     data = 29, hover = "29" },
            { description = "Very Large", lkey = "verylarge", data = 35, hover = "35" },
        },
        default = 25,
    },
    {
        name = "infopanelopacity",
        label = "Info Panel Opacity",
        options = {
            { description = "20%",  data = 0.2, hover = "" },
            { description = "40%",  data = 0.4, hover = "" },
            { description = "60%",  data = 0.6, hover = "" },
            { description = "80%",  data = 0.8, hover = "" },
            { description = "100%", data = 1.0, hover = "" },
        },
        default = 1.0,
    },
    {
        name = "prefab",
        label = "Show Prefab",
        hover = "Show prefab name in info panel?",
        options = {
            { description = "ON",  lkey = "on",  data = true,  hover = "" },
            { description = "OFF", lkey = "off", data = false, hover = "" },
        },
        default = false,
    },
    {
        name = "tags",
        label = "Show Tags",
        hover = "Show object's tags in info panel?",
        options = {
            { description = "ON",  lkey = "on",  data = true,  hover = "" },
            { description = "OFF", lkey = "off", data = false, hover = "" },
        },
        default = false,
    },
    {
        name = "recipe",
        label = "Show Recipes",
        hover = "Show object's ingredient info?",
        options = {
            { description = "ON",  lkey = "on",  data = true,  hover = "" },
            { description = "OFF", lkey = "off", data = false, hover = "" },
        },
        default = true,
    },
    {
        name = "content",
        label = "Panel Content",
        hover = "How detailed should the content in the panel be?",
        options = {
            { description = "Detailed", lkey = "detailed", data = "detailed", hover = "Show as detailed as possible!" },
            { description = "Concise",  lkey = "concise",  data = "concise",  hover = "Show several most useful ones only. (e.g. health, weapon, food)" },
        },
        default = "detailed",
    },
    {
        name = "notifications",
        label = "Warnings",
        hover = "Show warning banners? (e.g. volcano eruption)",
        options = {
            { description = "ON",  lkey = "on",  data = true,  hover = "" },
            { description = "OFF", lkey = "off", data = false, hover = "" },
        },
        default = true,
    },
    {
        name = "language",
        label = "Language",
        hover = "",
        options = {
            { description = "Auto", lkey = "auto", data = "auto", hover = "" },
            { description = "English", lkey = "english", data = "en", hover = "" },
            { description = "简体中文", lkey = "chinesesimplified", data = "chs", hover = "" },
        },
        default = "auto",
    },
}
