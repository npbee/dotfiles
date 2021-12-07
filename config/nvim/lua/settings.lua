local options = {
    backup = false,
    background = "dark",
    clipboard = 'unnamed',
    colorcolumn = '80',
    completeopt = "menu,menuone,noselect",
    conceallevel = 0, -- Always show syntax 
    expandtab = true,
    exrc = true,
    foldlevelstart = 99,
    foldmethod = "indent",
    history = 200,
    hlsearch = true,
    incsearch = true,
    laststatus = 2, -- Always show status line
    lazyredraw = true,
    list = true,
    listchars = "tab:»·,trail:·",
    pumwidth = 80,
    scrolloff = 3,
    secure = true,
    showmode = true,
    signcolumn = "yes", -- Always show sign column to avoid layout shift
    splitbelow = true,
    synmaxcol = 200,
    syntax = "on",
    termguicolors = true,
    updatetime = 100,
    wildmenu = true,
    wildmode = "list:longest,list:full"
}

local globals = {
    mapleader = ' ',
    filetype = 'plugin indent on',

    -- Term colors for fzf
    -- dark0 + gray
    terminal_color_0 = "#282828",
    terminal_color_8 = "#928374",

    -- red
    terminal_color_1 = "#cc241d",
    terminal_color_9 = "#fb4934",

    -- green
    terminal_color_2 = "#98971a",
    terminal_color_10 = "#b8bb26",

    -- neutral_yellow + bright_yellow
    terminal_color_3 = "#d79921",
    terminal_color_11 = "#fabd2f",

    -- neutral_blue + bright_blue
    terminal_color_4 = "#458588",
    terminal_color_12 = "#83a598",

    -- neutral_purple + bright_purple
    terminal_color_5 = "#b16286",
    terminal_color_13 = "#d3869b",

    -- neutral_aqua + faded_aqua
    terminal_color_6 = "#689d6a",
    terminal_color_14 = "#8ec07c",

    -- light4 + light1
    terminal_color_7 = "#a89984",
    terminal_color_15 = "#ebdbb2"
}

for k, v in pairs(options) do vim.opt[k] = v end

for k, v in pairs(globals) do vim.g[k] = v end

vim.cmd('colorscheme eighty-five')
