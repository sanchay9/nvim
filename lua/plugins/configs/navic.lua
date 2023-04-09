local icons = require "plugins.configs.icons".lspkind

require("nvim-navic").setup {
    icons = {
        ["class-name"] = "%#NavicItemKindClass#" .. icons.Class .. "%*" .. " ",
        ["function-name"] = "%#NavicItemKindFunction#" .. icons.Function .. "%*" .. " ",
        ["method-name"] = "%#NavicItemKindMethod#" .. icons.Method .. "%*" .. " ",
        ["container-name"] = "%#NavicItemKindProperty#" .. icons.Object .. "%*" .. " ",
        ["tag-name"] = "%#NavicItemKindKeyword#" .. icons.Tag .. "%*" .. " ",
        ["mapping-name"] = "%#NavicItemKindProperty#" .. icons.Object .. "%*" .. " ",
        ["sequence-name"] = "%NavicItemKindProperty#" .. icons.Array .. "%*" .. " ",
        ["null-name"] = "%NavicItemKindField#" .. icons.Field .. "%*" .. " ",
        ["boolean-name"] = "%NavicItemKindValue#" .. icons.Boolean .. "%*" .. " ",
        ["integer-name"] = "%NavicItemKindValue#" .. icons.Number .. "%*" .. " ",
        ["float-name"] = "%NavicItemKindValue#" .. icons.Number .. "%*" .. " ",
        ["string-name"] = "%NavicItemKindValue#" .. icons.String .. "%*" .. " ",
        ["array-name"] = "%NavicItemKindProperty#" .. icons.Array .. "%*" .. " ",
        ["object-name"] = "%NavicItemKindProperty#" .. icons.Object .. "%*" .. " ",
        ["number-name"] = "%NavicItemKindValue#" .. icons.Number .. "%*" .. " ",
        ["table-name"] = "%NavicItemKindProperty#" .. icons.Table .. "%*" .. " ",
        ["date-name"] = "%NavicItemKindValue#" .. icons.Calendar .. "%*" .. " ",
        ["date-time-name"] = "%NavicItemKindValue#" .. icons.Table .. "%*" .. " ",
        ["inline-table-name"] = "%NavicItemKindProperty#" .. icons.Calendar .. "%*" .. " ",
        ["time-name"] = "%NavicItemKindValue#" .. icons.Watch .. "%*" .. " ",
        ["module-name"] = "%NavicItemKindModule#" .. icons.Module .. "%*" .. " ",
    },
    highlight = false,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true
}
