local colors = require('mini.colors')

local function lighten(hex, amount)
  local oklch = colors.convert(hex, 'oklch')
  oklch.l = math.min(100, oklch.l + amount)
  return colors.convert(oklch, 'hex')
end

local function darken(hex, amount)
  local oklch = colors.convert(hex, 'oklch')
  oklch.l = math.max(0, oklch.l - amount)
  return colors.convert(oklch, 'hex')
end

local function mix(hex1, hex2, amount)
  local c1 = colors.convert(hex1, 'rgb')
  local c2 = colors.convert(hex2, 'rgb')
  local t = amount / 100
  return colors.convert({
    r = math.floor(c1.r + (c2.r - c1.r) * t + 0.5),
    g = math.floor(c1.g + (c2.g - c1.g) * t + 0.5),
    b = math.floor(c1.b + (c2.b - c1.b) * t + 0.5),
  }, 'hex')
end

local function desaturate(hex, amount)
  local okhsl = colors.convert(hex, 'okhsl')
  okhsl.s = math.max(0, okhsl.s - amount / 100)
  return colors.convert(okhsl, 'hex')
end

-- print(require('lush').hsl(43, 53, 77))

local is_dark      = vim.o.background == 'dark'
local bg           = is_dark and '#353331' or '#e1e2e3'
local fg           = is_dark and '#E3D2A5' or '#2f2e2d'

local teal         = "#89C0C1"
local green        = "#7DA76B"
local orange       = "#d89a76"
local purple       = "#b98895"
local blue         = "#7e9b8f"
local red          = "#e25c5c"
local yellow       = "#d3b471"

local accent       = blue
local accent_light = lighten(accent, 15)
local text         = fg
local text_dim     = "#CFBC97"
local error        = red
local bg_light     = lighten(bg, 24)

local grey400      = lighten(bg, 20)
local grey500      = lighten(bg, 28)
local grey600      = lighten(bg, 38)
local grey700      = lighten(bg, 8)

vim.g.colors_name  = 'eightyfive'

local hi           = function(group, data) vim.api.nvim_set_hl(0, group, data) end

-- Base -----------------------------------------------------------------------

hi("Normal", { bg = bg, fg = text })
hi("Comment", { fg = grey600, italic = true })
hi("ColorColumn", { bg = grey700 })
hi("CursorLine", { bg = grey700 })
hi("Directory", { fg = accent })
hi("EndOfBuffer", { fg = bg })
hi("ErrorMsg", { fg = red, bold = true })
hi("FloatBorder", { bg = bg, fg = grey400 })
hi("WinSeparator", { bg = bg, fg = grey500 })
hi("Folded", { bg = grey600, fg = text })
hi("FoldColumn", { link = "Normal" })
hi("SignColumn", { bg = bg, fg = lighten(bg, 50) })
hi("IncSearch", { bg = darken(yellow, 15), fg = darken(bg, 10) })
hi("LineNr", { fg = grey400 })
hi("CursorLineNr", { fg = yellow })
hi("MatchParen", { fg = orange, bold = true })
hi("Noise", { fg = grey700 })
hi("MoreMsg", { fg = green, bold = true })
hi("NonText", { link = "Comment" })
hi("NormalFloat", { bg = bg, fg = text_dim })
hi("Pmenu", { bg = grey700 })
hi("PmenuSel", { bg = lighten(grey700, 20), fg = "NONE" })
hi("PmenuSbar", { link = "Normal" })
hi("PmenuThumb", { bg = grey500 })
hi("Question", { link = "Normal" })
hi("Search", { bg = grey500, fg = text })
hi("SpecialKey", { link = "Normal" })
hi("SpellBad", { fg = mix(grey400, red, 70), underdashed = true })
hi("Split", { bg = bg, fg = grey500 })
hi("Title", { link = "Normal" })
hi("Visual", { bg = grey700, fg = text })
hi("WarningMsg", { link = "Normal" })
hi("WildMenu", { link = "Normal" })
hi("Bold", { bold = true })
hi("Conceal", { fg = grey600 })
hi("CurSearch", { bg = yellow, fg = darken(bg, 10) })
hi("FloatTitle", { bg = bg, fg = accent, bold = true })
hi("Italic", { italic = true })
hi("LineNrAbove", { link = "LineNr" })
hi("LineNrBelow", { link = "LineNr" })
hi("MsgArea", { link = "Normal" })
hi("NormalNC", { link = "Normal" })
hi("QuickFixLine", { bold = true })
hi("Substitute", { bg = grey600, fg = text })
hi("VisualNOS", { link = "Visual" })
hi("Whitespace", { fg = grey400 })
hi("WinBar", { link = "StatusLine" })
hi("WinBarNC", { link = "StatusLineNC" })

-- Statusline -----------------------------------------------------------------

hi("StatusLine", { link = "Normal" })
hi("StatusLineNC", { bg = bg, fg = green })
hi("StatuslineAccent", { bg = blue, fg = bg, bold = true })
hi("StatuslineInsertAccent", { bg = green, fg = bg, bold = true })
hi("StatuslineVisualAccent", { bg = purple, fg = bg, bold = true })
hi("StatuslineReplaceAccent", { bg = yellow, fg = bg, bold = true })
hi("StatuslineCmdLineAccent", { bg = teal, fg = bg, bold = true })
hi("StatuslineTerminalAccent", { bg = orange, fg = bg, bold = true })

-- Tabline --------------------------------------------------------------------

hi("TabLine", { link = "Normal" })
hi("TabLineFill", { link = "Normal" })
hi("TabLineSel", { fg = accent })

-- Diff -----------------------------------------------------------------------

hi("DiffAdd", { fg = green })
hi("DiffChange", { fg = purple })
hi("DiffDelete", { fg = red })
hi("DiffText", { fg = red, reverse = true })
hi("diffAdded", { link = "DiffAdd" })
hi("diffChanged", { link = "DiffChange" })
hi("diffRemoved", { link = "DiffDelete" })
hi("diffFile", { fg = yellow })
hi("diffLine", { fg = blue })
hi("Added", { link = "DiffAdd" })
hi("Changed", { link = "DiffChange" })
hi("Removed", { link = "DiffDelete" })

-- Git commit ------------------------------------------------------------------

hi("gitcommitBranch", { fg = orange, bold = true })
hi("gitcommitComment", { link = "Comment" })
hi("gitcommitDiscarded", { link = "Comment" })
hi("gitcommitDiscardedFile", { fg = yellow, bold = true })
hi("gitcommitDiscardedType", { fg = accent })
hi("gitcommitHeader", { link = "Title" })
hi("gitcommitOverflow", { fg = red })
hi("gitcommitSelected", { link = "Comment" })
hi("gitcommitSelectedFile", { fg = green, bold = true })
hi("gitcommitSelectedType", { link = "gitcommitDiscardedType" })
hi("gitcommitSummary", { fg = green })
hi("gitcommitUnmergedFile", { link = "gitcommitDiscardedFile" })
hi("gitcommitUnmergedType", { link = "gitcommitDiscardedType" })
hi("gitcommitUntracked", { link = "Comment" })
hi("gitcommitUntrackedFile", { fg = teal })

-- User -----------------------------------------------------------------------

hi("User1", { fg = red })
hi("User2", { fg = accent })
hi("User3", { fg = green })
hi("User4", { fg = purple })
hi("User5", { fg = yellow })
hi("User6", { fg = orange })

-- Syntax ---------------------------------------------------------------------

hi("Boolean", { link = "Normal" })
hi("Character", { link = "String" })
hi("Constant", { link = "Normal" })
hi("Define", { link = "StorageClass" })
hi("Exception", { fg = orange })
hi("Float", { link = "Normal" })
hi("String", { fg = yellow })
hi("Identifier", { link = "Normal" })
hi("Include", { link = "StorageClass" })
hi("Keyword", { link = "StorageClass" })
hi("Label", { link = "Normal" })
hi("Macro", { link = "StorageClass" })
hi("Number", { link = "Normal" })
hi("Operator", { link = "Normal" })
hi("Function", { fg = text })
hi("Statement", { link = "Normal" })
hi("Conditional", { fg = orange })
hi("Repeat", { fg = accent })
hi("PreProc", { link = "Normal" })
hi("Structure", { link = "Normal" })
hi("Type", { link = "Normal" })
hi("Typedef", { link = "Normal" })
hi("StorageClass", { fg = accent })
hi("Special", { link = "Normal" })
hi("SpecialChar", { link = "Normal" })
hi("Delimiter", { link = "Normal" })
hi("Underlined", { fg = accent, underline = true })
hi("Error", { fg = error })
hi("Todo", { fg = yellow, bold = true })

-- LSP / Diagnostics ----------------------------------------------------------

hi("LspReferenceText", { fg = lighten(bg, 50), bold = true })
hi("LspReferenceRead", { fg = lighten(bg, 50), bold = true })
hi("LspReferenceWrite", { fg = lighten(bg, 50), bold = true })
hi("LspSignatureActiveParameter", { link = "LspReferenceText" })
hi("LspCodeLens", { link = "Comment" })
hi("LspCodeLensSeparator", { link = "Comment" })
hi("DiagnosticError", { link = "Error" })
hi("DiagnosticWarn", { fg = yellow })
hi("DiagnosticInfo", { fg = accent })
hi("DiagnosticHint", { fg = text_dim })
hi("DiagnosticOk", { fg = green })
hi("DiagnosticUnderlineError", { sp = red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = yellow, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = accent, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = text_dim, undercurl = true })
hi("DiagnosticUnderlineOk", { sp = green, undercurl = true })
hi("DiagnosticFloatingError", { fg = red })
hi("DiagnosticFloatingWarn", { fg = yellow })
hi("DiagnosticFloatingInfo", { fg = accent })
hi("DiagnosticFloatingHint", { fg = text_dim })
hi("DiagnosticFloatingOk", { fg = green })
hi("DiagnosticVirtualTextError", { link = "DiagnosticError" })
hi("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
hi("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
hi("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
hi("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })
hi("DiagnosticSignError", { link = "DiagnosticError" })
hi("DiagnosticSignWarn", { link = "DiagnosticWarn" })
hi("DiagnosticSignInfo", { link = "DiagnosticInfo" })
hi("DiagnosticSignHint", { link = "DiagnosticHint" })
hi("DiagnosticSignOk", { link = "DiagnosticOk" })
hi("DiagnosticDeprecated", { sp = red, strikethrough = true })
hi("DiagnosticUnnecessary", { link = "Comment" })

-- JS / TS --------------------------------------------------------------------

hi("jsStorageClass", { link = "StorageClass" })
hi("jsReturn", { fg = orange })
hi("typescriptImport", { link = "StorageClass" })
hi("typescriptExport", { link = "StorageClass" })
hi("typescriptVariable", { link = "StorageClass" })
hi("typescriptFuncKeyword", { link = "StorageClass" })
hi("typescriptBOMWindowMethod", { fg = purple })
hi("jsxComponentName", { fg = text_dim })
hi("jsxAttrib", { fg = accent_light })

-- CSS ------------------------------------------------------------------------

hi("cssFunctionName", { fg = purple })
hi("cssDefinition", { fg = purple })
hi("cssAttrRegion", { link = "cssDefinition" })
hi("cssUnitDecorators", { fg = desaturate(darken(text, 10), 10) })

-- Elixir ---------------------------------------------------------------------

hi("elixirModuleDefine", { fg = accent })
hi("elixirMacroDefine", { link = "elixirModuleDefine" })
hi("elixirDefine", { link = "elixirModuleDefine" })

-- Lua ------------------------------------------------------------------------

hi("luaLocal", { link = "StorageClass" })
hi("luaRepeat", { link = "StorageClass" })

-- Markdown -------------------------------------------------------------------

hi("markdownH1", { fg = accent })
hi("markdownH2", { fg = accent })
hi("markdownH3", { fg = accent })
hi("markdownH4", { fg = accent })
hi("markdownH5", { fg = accent })
hi("markdownH6", { fg = accent })
hi("markdownHeading", { fg = accent })
hi("htmlH1", { fg = accent })
hi("htmlH2", { fg = accent })
hi("htmlH3", { fg = accent })
hi("htmlH4", { fg = accent })
hi("htmlH5", { fg = accent })
hi("htmlH6", { fg = accent })

-- HTML -----------------------------------------------------------------------

hi("htmlArg", { fg = accent_light })
hi("htmlTagName", { fg = text_dim })

-- SQL ------------------------------------------------------------------------

hi("sqlStatement", { fg = accent })
hi("sqlKeyword", { fg = accent })
hi("sqlType", { fg = orange })

-- Python ---------------------------------------------------------------------

hi("pythonImport", { link = "StorageClass" })
hi("pythonStatement", { link = "StorageClass" })

-- Packer ---------------------------------------------------------------------

hi("packerStatusSuccess", { fg = green, bold = true })
hi("packerOutput", { bold = true })
hi("packerHash", { fg = accent })

-- nvim-cmp -------------------------------------------------------------------

hi("CmpItemAbbrMatch", { fg = blue, bold = true })
hi("CmpItemKindDefault", { fg = text_dim })
hi("CmpItemKindKeyword", { fg = text_dim })
hi("CmpItemKindVariable", { fg = text_dim })
hi("CmpItemKindFunction", { fg = purple })
hi("CmpItemKindMethod", { fg = text_dim })
hi("CmpItemKindModule", { fg = purple })
hi("CmpItemKindSnippet", { fg = green })

-- Telescope ------------------------------------------------------------------

hi("TelescopeBorder", { fg = grey400 })

-- Treesitter -----------------------------------------------------------------

hi("TSConditional", { fg = orange })
hi("@conditional", { fg = orange })
hi("TSInclude", { fg = accent })
hi("@include", { fg = accent })
hi("TSKeyword", { link = "StorageClass" })
hi("@keyword", { link = "StorageClass" })
hi("TSKeywordFunction", { link = "StorageClass" })
hi("@keyword.function", { link = "StorageClass" })
hi("TSKeywordReturn", { fg = orange })
hi("@keyword.return", { fg = orange })
-- hi("TSPunctDelimiter", { link = "Normal" })
hi("@punctuation.delimiter", { link = "Normal" })
hi("TSType", { fg = text_dim })
hi("@type", { fg = text_dim })
hi("TSTypeBuiltin", { link = "TSType" })
hi("@type.builtin", { link = "TSType" })
hi("TSVariableBuiltin", { fg = text_dim })
hi("@variable.builtin", { fg = text_dim })
hi("@variable", { link = "Normal" })
hi("@operator", { link = "Normal" })
hi("TSTag", { fg = text_dim })
hi("@tag", { fg = text_dim })
hi("TSTagAttribute", { fg = accent_light })
hi("@tag.attribute", { fg = accent_light })

-- Additional treesitter groups ------------------------------------------------

hi("@comment", { link = "Comment" })
hi("@punctuation", { link = "Normal" })
hi("@constant", { link = "Normal" })
hi("@constant.builtin", { link = "Normal" })
hi("@constant.macro", { link = "StorageClass" })
hi("@define", { link = "StorageClass" })
hi("@macro", { link = "StorageClass" })
hi("@string", { link = "String" })
hi("@string.escape", { fg = orange })
hi("@string.special", { fg = orange })
hi("@character", { link = "String" })
hi("@character.special", { fg = orange })
hi("@number", { link = "Normal" })
hi("@boolean", { link = "Normal" })
hi("@float", { link = "Normal" })
hi("@function", { link = "Function" })
hi("@function.builtin", { link = "Function" })
hi("@function.call", { link = "Function" })
hi("@function.macro", { link = "Function" })
hi("@parameter", { fg = text_dim })
hi("@method", { link = "Function" })
hi("@method.call", { link = "Function" })
hi("@field", { link = "Normal" })
hi("@property", { link = "Normal" })
hi("@constructor", { link = "Normal" })
hi("@label", { link = "Normal" })
hi("@exception", { fg = orange })
hi("@namespace", { fg = text_dim })
hi("@storageclass", { link = "StorageClass" })
hi("@structure", { link = "Normal" })
hi("@preproc", { link = "Normal" })
hi("@debug", { fg = teal })
hi("@symbol", { link = "Normal" })
hi("@none", {})

-- Legacy @text.* groups
hi("@text.literal", { link = "String" })
hi("@text.reference", { link = "Normal" })
hi("@text.title", { link = "Title" })
hi("@text.uri", { fg = accent, underline = true })
hi("@text.todo", { link = "Todo" })
hi("@text.note", { link = "MoreMsg" })
hi("@text.warning", { link = "WarningMsg" })
hi("@text.danger", { link = "ErrorMsg" })
hi("@text.strong", { bold = true })
hi("@text.emphasis", { italic = true })
hi("@text.strike", { strikethrough = true })
hi("@text.underline", { underline = true })

-- Semantic tokens
hi("@lsp.type.class", { link = "@type" })
hi("@lsp.type.decorator", { link = "Function" })
hi("@lsp.type.enum", { link = "@type" })
hi("@lsp.type.enumMember", { link = "Normal" })
hi("@lsp.type.function", { link = "Function" })
hi("@lsp.type.interface", { link = "@type" })
hi("@lsp.type.macro", { link = "StorageClass" })
hi("@lsp.type.method", { link = "Function" })
hi("@lsp.type.namespace", { fg = text_dim })
hi("@lsp.type.parameter", { fg = text_dim })
hi("@lsp.type.property", { link = "Normal" })
hi("@lsp.type.struct", { link = "Normal" })
hi("@lsp.type.type", { link = "@type" })
hi("@lsp.type.typeParameter", { link = "@type" })
hi("@lsp.type.variable", { link = "Normal" })
hi("@lsp.mod.deprecated", { fg = red })

-- nvim-0.10+ groups
if vim.fn.has('nvim-0.10') == 1 then
  hi("@variable.parameter", { link = "@parameter" })
  hi("@variable.member", { link = "Normal" })
  hi("@module", { fg = text_dim })
  hi("@module.builtin", { fg = text_dim })
  hi("@string.documentation", { link = "String" })
  hi("@string.regexp", { fg = orange })
  hi("@string.special.symbol", { link = "Normal" })
  hi("@string.special.path", { link = "Directory" })
  hi("@string.special.url", { fg = accent, underline = true })
  hi("@number.float", { link = "Normal" })
  hi("@type.qualifier", { link = "StorageClass" })
  hi("@attribute", { link = "StorageClass" })
  hi("@function.method", { link = "Function" })
  hi("@function.method.call", { link = "Function" })
  hi("@keyword.coroutine", { link = "StorageClass" })
  hi("@keyword.operator", { link = "Normal" })
  hi("@keyword.import", { link = "StorageClass" })
  hi("@keyword.storage", { link = "StorageClass" })
  hi("@keyword.repeat", { link = "StorageClass" })
  hi("@keyword.debug", { fg = teal })
  hi("@keyword.exception", { fg = orange })
  hi("@keyword.conditional", { fg = orange })
  hi("@keyword.conditional.ternary", { fg = orange })
  hi("@keyword.directive", { link = "StorageClass" })
  hi("@keyword.directive.define", { link = "StorageClass" })
  hi("@punctuation.bracket", { link = "Normal" })
  hi("@punctuation.special", { link = "Normal" })
  hi("@comment.documentation", { link = "Comment" })
  hi("@comment.error", { fg = red })
  hi("@comment.warning", { fg = yellow })
  hi("@comment.todo", { fg = yellow, bold = true })
  hi("@comment.note", { fg = teal })
  hi("@markup.strong", { bold = true })
  hi("@markup.italic", { italic = true })
  hi("@markup.strikethrough", { strikethrough = true })
  hi("@markup.underline", { underline = true })
  hi("@markup.heading", { fg = accent })
  hi("@markup.heading.1", { fg = orange })
  hi("@markup.heading.2", { fg = yellow })
  hi("@markup.heading.3", { fg = green })
  hi("@markup.heading.4", { fg = teal })
  hi("@markup.heading.5", { fg = accent })
  hi("@markup.heading.6", { fg = purple })
  hi("@markup.quote", { link = "Comment" })
  hi("@markup.math", { fg = yellow })
  hi("@markup.link", { fg = accent })
  hi("@markup.link.label", { link = "@markup.link" })
  hi("@markup.link.url", { fg = text, underline = true })
  hi("@markup.raw", { fg = text_dim })
  hi("@markup.raw.block", { link = "@markup.raw" })
  hi("@markup.list", { link = "Normal" })
  hi("@markup.list.checked", { fg = green })
  hi("@markup.list.unchecked", { fg = yellow })
  hi("@diff.plus", { link = "DiffAdd" })
  hi("@diff.minus", { link = "DiffDelete" })
  hi("@diff.delta", { link = "DiffChange" })
  hi("@tag.delimiter", { link = "Normal" })
end

-- Snippets --------------------------------------------------------------------

hi("SnippetTabstop", { bg = grey700 })
hi("SnippetTabstopActive", { bg = bg_light })
