local STYLE = 'minimal' -- fancy | minimal | monochrome
return {
  run = function()
    local mode = require("staline.modules.mode")
    local filename = require("staline.modules.filename")
    local branch = require("staline.modules.branch")
    local diff = require("staline.modules.diff")
    local folder = require("staline.modules.folder")
    local position = require("staline.modules.position")
    local diagnostics = require("staline.modules.diagnostics")
    local lsp = require("staline.modules.lsp")
    return table.concat {
      mode(STYLE),
      filename(),
      branch(),
      diff(STYLE),
      "%=",
      diagnostics(STYLE),
      folder(STYLE),
      lsp(STYLE) or "",
      position(STYLE),
    };
  end,
}

-- fbg("StalineFolderIcon", black, color1)
-- fbg("StalineFolderIconMono", contrast, fg = colors.color7 },
-- fbg("StalineFolderSep") = { bg = colors.black, fg = colors.color1 },
-- fbg("StalineFolderText") = { bg = colors.color8, fg = colors.color15 },
-- fbg("StalineFolderTextMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineFilename") = { bg = colors.background, fg = colors.color7 },
-- fbg("StalineFilenameSep") = { fg = colors.color8, bg = colors.black },
-- fbg("StalineLogo") = { bg = colors.black, fg = colors.color12 },
-- fbg("StalineProgress") = { bg = colors.color8, fg = colors.color15 },
-- fbg("StalineProgressMono") = { bg = colors.contrast, fg = colors.color7 },
-- fbg("StalineProgressSep") = { bg = colors.color8, fg = colors.color10 },
-- fbg("StalineProgressIcon") = { bg = colors.color10, fg = colors.color8 },
-- fbg("StalineProgressIconMono") = { bg = colors.color7, fg = colors.color8 },
-- fbg("StalineBranch") = { bg = colors.background, fg = colors.comment },
-- fbg("StalineModeSepTwo") = { bg = colors.background, fg = colors.color8 },
-- fbg("StalineNormalMode") = { bg = colors.color12, fg = colors.black },
-- fbg("StalineVisualMode") = { bg = colors.color11, fg = colors.black },
-- fbg("StalineCommandMode") = { bg = colors.color9, fg = colors.black },
-- fbg("StalineInsertMode") = { bg = colors.color10, fg = colors.black },
-- fbg("StalineTerminalMode") = { bg = colors.color13, fg = colors.black },
-- fbg("StalineNTerminalMode") = { bg = colors.color13, fg = colors.black },
-- fbg("StalineConfirmMode") = { bg = colors.color6, fg = colors.black },
-- fbg("StalineNormalModeSep") = { fg = colors.color12, bg = colors.color8 },
-- fbg("StalineVisualModeSep") = { fg = colors.color11, bg = colors.color8 },
-- fbg("StalineCommandModeSep") = { fg = colors.color9, bg = colors.color8 },
-- fbg("StalineInsertModeSep") = { fg = colors.color10, bg = colors.color8 },
-- fbg("StalineTerminalModeSep") = { fg = colors.color13, bg = colors.color8 },
-- fbg("StalineNTerminalModeSep") = { fg = colors.color13, bg = colors.color8 },
-- fbg("StalineConfirmModeSep") = { fg = colors.color6, bg = colors.color8 },
-- fbg("StalineEmptySpace") = { bg = colors.background, fg = colors.color15 },
-- fbg("StalineLspError") = { bg = colors.black, fg = colors.color9 },
-- fbg("StalineLspInfo") = { bg = colors.black, fg = colors.color12 },
-- fbg("StalineLspHints") = { bg = colors.black, fg = colors.color6 },
-- fbg("StalineLspWarning") = { bg = colors.black, fg = colors.color11 },
-- fbg("StalineLspErrorIcon") = { bg = colors.black, fg = colors.color9 },
-- fbg("StalineLspInfoIcon") = { bg = colors.black, fg = colors.color12 },
-- fbg("StalineLspHintsIcon") = { bg = colors.black, fg = colors.color6 },
-- fbg("StalineLspWarningIcon") = { bg = colors.black, fg = colors.color11 },
-- fbg("StalineLspName") = { bg = colors.color8, fg = colors.foreground },
-- fbg("StalineLspNameMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspIcon") = { bg = colors.color13, fg = colors.black },
-- fbg("StalineLspIconMono") = { bg = colors.contrast, fg = colors.color7 },
-- fbg("StalineDiffAdd") = { bg = colors.background, fg = colors.color10 },
-- fbg("StalineDiffChange") = { bg = colors.background, fg = colors.color11 },
-- fbg("StalineDiffRemove") = { bg = colors.background, fg = colors.color9 },
-- fbg("StalineDiffAddMono") = { bg = colors.background, fg = colors.color7 },
-- fbg("StalineDiffChangeMono") = { bg = colors.background, fg = colors.color7 },
-- fbg("StalineDiffRemoveMono") = { bg = colors.background, fg = colors.color7 },
-- fbg("StalineLspErrorMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspInfoMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspHintsMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspWarningMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspErrorIconMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspInfoIconMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspHintsIconMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineLspWarningIconMono") = { bg = colors.black, fg = colors.color7 },
-- fbg("StalineMonoMode") = { bg = colors.contrast, fg = colors.color7 },
