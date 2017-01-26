" Launch Config {{{ "
" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

if !has('nvim')
    set encoding=utf-8
endif

" Check 1 line for local commands to the buffer
set modelines=1

" Set the amount of commands and search patterns that are remembered
set history=500

" Use this for local config options like local snippets
set runtimepath+=~/.vim.local/

" }}}


" Plugins {{{

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Colors
Plug 'morhetz/gruvbox'
Plug 'npbee/eighty-five'

" Syntax
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'benekastah/neomake'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'Valloric/ListToggle'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-eunuch'
Plug 'ludovicchabant/vim-gutentags'

" Editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'kassio/neoterm'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'

call plug#end()

" FZF {{{

" Custom searching command.  Basically just allows for passing ag arguments
" directly
" Usage
" :Ag myThing --js
"
" With preview
" :Ag! myThing --js
command! -bang -nargs=* AgRaw
  \ call fzf#vim#grep(
  \ 'ag --nogroup --column --color '.<q-args>,
  \ 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" }}}

" Easy Align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}

" {{{ vim-javascript

let g:javascript_plugin_flow = 1

" }}}


" Dirvish {{{
nnoremap - :Dirvish %<CR>
" }}}


" Vim JSX {{{

" Use JSX syntax on .js files
" let g:jsx_ext_required=0

" }}}


" NeoMake {{{

" Define makers in the vimrc.local file like so:
" let g:neomake_javascript_enabled_makers=['...']
" let g:neomake_jsx_enabled_makers=['...']

" Run neomake after every save
autocmd! BufWritePost * Neomake

" }}}


" Ultisnips {{{

let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

let g:UltiSnipsSnippetsDir="~/.dotfiles/vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=['UltiSnips', '~/.vim.local/UltiSnips']

" }}}


" Neoterm {{{
if has('nvim')
    let g:neoterm_position = 'horizontal'
    let command = g:neoterm_npm_lib_cmd . ' ' . expand('%:p')

    " run set test lib
    nnoremap <silent> ,rf :call neoterm#do(command)<cr>

    " Useful maps
    " hide/close terminal
    nnoremap <silent> ,th :call neoterm#close()<cr>
    " open terminal
    nnoremap <silent> ,to :call neoterm#open()<cr>
    " clear terminal
    nnoremap <silent> ,tl :call neoterm#clear()<cr>
    " kills the current job (send a <c-c>)
    nnoremap <silent> ,tc :call neoterm#kill()<cr>

endif
" }}}


" Deoplete {{{

let g:deoplete#enable_at_startup = 1
if !exists('g:test#javascript#mocha#file_pattern')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" }}}

" FZF {{{

" Do fuzzy finder on Ctrl + P
noremap <C-p> :FZF<CR>
" }}}

" Divish {{{
augroup my_dirvish_events
    autocmd!

    " Map d to sort directories at the top
    autocmd FileType dirvish nnoremap <buffer> t :sort r /[^\/]$/<CR>
augroup END
" }}}

" Elm {{{
let g:elm_setup_keybindings = 0
" }}}

" }}}


" Omnifuncs {{{

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" }}}


" Colors {{{

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Sets stuff for iTerm
syntax on
set background=dark
set termguicolors
colorscheme eighty-five

let g:gruvbox_contrast_dark="soft"
let g:gruvbox_italic=1

" Hack for gruvbox to support neovim term colors
" https://github.com/morhetz/gruvbox/pull/93
if has('nvim')
  " dark0 + gray
  let g:terminal_color_0 = "#282828"
  let g:terminal_color_8 = "#928374"

  " neurtral_red + bright_red
  let g:terminal_color_1 = "#cc241d"
  let g:terminal_color_9 = "#fb4934"

  " neutral_green + bright_green
  let g:terminal_color_2 = "#98971a"
  let g:terminal_color_10 = "#b8bb26"

  " neutral_yellow + bright_yellow
  let g:terminal_color_3 = "#d79921"
  let g:terminal_color_11 = "#fabd2f"

  " neutral_blue + bright_blue
  let g:terminal_color_4 = "#458588"
  let g:terminal_color_12 = "#83a598"

  " neutral_purple + bright_purple
  let g:terminal_color_5 = "#b16286"
  let g:terminal_color_13 = "#d3869b"

  " neutral_aqua + faded_aqua
  let g:terminal_color_6 = "#689d6a"
  let g:terminal_color_14 = "#8ec07c"

  " light4 + light1
  let g:terminal_color_7 = "#a89984"
  let g:terminal_color_15 = "#ebdbb2"
endif

" }}}


" Spaces & Tabs {{{

" 4 space tab
set tabstop=4
set softtabstop=4

" Tabs are spaces
set expandtab

" }}}


" UI Settings {{{

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=#fb4934
match ExtraWhitespace /\s\+$/

" show line numbers
set number
set numberwidth=3

" Give a relative count from the current cursor position
set relativenumber

" Make it obvious where 80 characters is"
set textwidth=80

" Do not autowrap
set fo-=t

" show the cursor position all the time
set ruler

" Show the command in the bottom bar
set showcmd

" This gives some buffer above a line when going to a line
set scrolloff=3

" Highlight the current line"
set cursorline

" Allow for custom indent settings from plugins
filetype plugin indent on

" Allow for the popup window thing to appear when using tab completion
set wildmenu
set wildmode=list:longest,list:full

" Only redraw when needed
set lazyredraw

" Highlight matching delimiters
set showmatch

" This makes vim slow......
let loaded_matchparen = 1

" Highlight 1 column after the max width
set colorcolumn=+1

" Always display the status line
set laststatus=2

" Display extra whitespace
set list listchars=tab:»·,trail:·

" When opening a new vertical split, open it below the current buffer
set splitbelow

" When opening a new horizontal split, open it to the right of the current
" buffer
set splitright

" }}}


" Searching {{{

" Search as characters entered
set incsearch

" Highlight matches
set hlsearch

" }}}


" Folder {{{

" enable folding
set foldenable

" Open most folds by default
set foldlevelstart=10

" Limit nested folding
set foldnestmax=10

" Set space to unfold
nnoremap <space> za

" Fold based on indent
set foldmethod=indent

" }}}


" Movement {{{

" Move lines visually (don't skip lines that are wrapped into two lines)
nnoremap j gj
nnoremap k gk

" Highlight last inserted text
nnoremap gV `[v`]

" Switch between tabs
"Press Ctrl-Tab to switch between open tabs (like browser tabs) to
" the right side. Ctrl-Shift-Tab goes the other way.
noremap <C-Tab> :tabnext<CR>
noremap <C-S-Tab> :tabprev<CR>

" Switch to specific tab numbers with Command-number
noremap <D-1> :tabn 1<CR>
noremap <D-2> :tabn 2<CR>
noremap <D-3> :tabn 3<CR>
noremap <D-4> :tabn 4<CR>
noremap <D-5> :tabn 5<CR>
noremap <D-6> :tabn 6<CR>
noremap <D-7> :tabn 7<CR>
noremap <D-8> :tabn 8<CR>
noremap <D-9> :tabn 9<CR>
" Command-0 goes to the last tab
noremap <D-0> :tablast<CR>

" }}}

" Scroll a buffer while keeping the cursor fixed
nnoremap <C-M-j> 3j3<C-e>
nnoremap <C-M-k> 3k3<C-y>


" Leader Shortcuts {{{

" Leader
let mapleader = ","

" toggle out of insert mode
:imap ii  <Esc>

" open ag.vim
nnoremap <leader>a :AgRaw

" Open a new split window vertically
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>e <C-w>s<C-w>l

" Easier moving around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Turn of search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" }}}


" Autogroups {{{

" These group autocommands together so that they don't happen more than once
" when the vimrc is reread

augroup vimrcEx
  autocmd!

  " Return to last edit position when opening files (You want this!) "
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile  *.ejs,*.EJS set filetype=html
  autocmd BufRead,BufNewFile
    \ *.eslintrc,*.babelrc,*.jshintrc,*.JSHINTRC,*.jscsrc,*.flow
    \ set filetype=javascript
  autocmd BufRead,BufNewFile *.conf set filetype=nginx

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Trim whitespace on save
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END

" }}}


" Saving {{{

" Automatically :write before running commands
set autowrite

" Map control+S to save
noremap <C-S>          :update<CR>
vnoremap <C-S>         <C-C>:update<CR>
inoremap <C-S>         <C-O>:update<CR>

" Change the directory where VIM does backups and swapfiles
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" }}}


" Editing {{{

" Backspace deletes like most programs in insert mode
set backspace=2

" Set the autoindenting to four and round all to that number
set shiftwidth=4
set shiftround

" Don't add a new line
set fileformats+=dos

" }}}


" Remaps {{{
if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
endif
" }}}


" Statusline {{{

function! FileModes()
    let fm = '%2*'

    if &modified
        let fm.= ' +'
    endif

    if &paste
        let fm.= ' P'
    endif

    let fm.= '%1*'

    return fm
endfunction

function! LeftSide()
    let ls = ''
    let ls.='%2* %f '
    let ls.='%4* %y %1*'
    let ls.=FileModes()

    return ls
endfunction

function! RightSide()
    let rs = ''


    " if exists ("neomake#statusline#LoclistStatus")
        let errors = neomake#statusline#LoclistStatus()
        if errors =~ 'E'
            let rs .= "%2*"
            let rs .= errors
        else
            let rs .= "%1*"
            let rs .= errors
        endif
        let rs .= "%2*"
        let rs .= " "
    " endif

    " line/col info
    let rs.= "%2* col %c lines %l/%L "

    if exists('*fugitive#head')
        let head = fugitive#head()

        " Set non-ascii font to 'octicons' from 'fonts' folder in iCloud
        if !empty(head)
            let rs .= '%3*' . ' ' . head . ' '
        endif
    endif

    return rs
endfunction

function! StatusLine()
    let statusl = LeftSide()
    let statusl.= '%='
    let statusl.= RightSide()

    return statusl
endfunction

set showmode
set statusline=%!StatusLine()

" }}}


" {{{ Utilities

" Show syntax highlighting groups for word under cursor
nmap <F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Strips trailing white space and restores the cursor after.  Avoids having the
" cursor jump to the last replaced whitespace after saving.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" }}}


" Local Config {{{

" Reads anything in a .vimrc.local
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" }}}

" Local command to folder on a marker
" vim:foldmethod=marker:foldlevel=0
