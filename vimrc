" vim: set foldmethod=marker foldlevel=0 nomodeline:

" ============================================================================
" PLUGINS {{{
" ============================================================================
silent! if plug#begin('~/.vim/plugged')

" Colors
Plug 'npbee/eighty-five'

" Lang
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'othree/html5.vim', { 'for': ['pug', 'html'] }

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'wokalski/autocomplete-flow'
Plug 'SirVer/ultisnips'

" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'ludovicchabant/vim-gutentags'
Plug 'christoomey/vim-tmux-navigator'

" Utility
Plug 'w0rp/ale'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'

call plug#end()
endif

" vim-test {{{
let test#strategy = "neovim"

" Set the strategies in a .vimrc.local like so
" let g:test#javascript#jest#file_pattern = '-test\.js'
" let g:test#javascript#jest#executable = 'npm run test-watch --prefix ./apps/sf_web'

" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" FZF {{{
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
"}}}

" Ale {{{
let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_fix_on_save = 1
" }}}

" }}}
" ============================================================================


" ============================================================================
" INIT {{{
" ============================================================================

" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Allow for custom indent settings from plugins
filetype plugin indent on

let mapleader = " "

augroup vimrc
    autocmd!
augroup END

set autowrite           " Automatically :write before running commands
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set clipboard=unnamed   " Use OS clipboard
set colorcolumn=80
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set encoding=utf-8
set expandtab           " Tabs are spaces
set foldlevelstart=10
set foldmethod=indent
set history=200         " The amount of commands remembered
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:»·,trail:·
set number              " Show line numbers
set relativenumber
set scrolloff=3
set shiftround
set shiftwidth=4
set showmode
set splitbelow
set statusline=%!StatusLine()
set synmaxcol=200
set textwidth=0
set wildmenu
set wildmode=list:longest,list:full
set writebackup

" Colors {{{
syntax on
set background=dark
set termguicolors
colorscheme eighty-five

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=#fb4934

" Hack to support neovim term colors
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

" }}}
" ============================================================================


" ============================================================================
" MAPPINGS {{{
" ============================================================================
nnoremap <F12> :call ToggleFixOnSave()<cr>

" Turn of search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Do fuzzy finder on Ctrl + P
noremap <C-p> :FZF<CR>

" Search
nnoremap <leader>f :F<Space>

" Map control+S to save
noremap <C-S>          :update<CR>
vnoremap <C-S>         <C-C>:update<CR>
inoremap <C-S>         <C-O>:update<CR>

" Open a new split window vertically
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>e <C-w>s<C-w>l

" Maps '%%' when in command mode to the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Hack to get Control-H working
if has('nvim')
    nmap <BS> <C-W>h
    :tnoremap <Esc> <C-\><C-n>
endif

" Vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" }}}
" ============================================================================


" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrc

    " File Types
    autocmd BufRead,BufNewFile *.md             set filetype=markdown
    autocmd BufRead,BufNewFile *.ejs,*.EJS      set filetype=html
    autocmd BufRead,BufNewFile *.conf           set filetype=nginx
    autocmd BufRead,BufNewFile
        \ *.eslintrc,*.babelrc,*.jshintrc,*.JSHINTRC,*.jscsrc,*.flow
        \ set filetype=javascript

    " Trim whitespace on save
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

    " Close preview after autocomplete
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" }}}
" ============================================================================


" ============================================================================
" FUNCTIONS {{{
" ============================================================================

" Toggle fixing on saving for ales
function! ToggleFixOnSave()
    if g:ale_fix_on_save
        let g:ale_fix_on_save = 0
    else
        let g:ale_fix_on_save = 1
    endif
endfunction

" Strips trailing white space and restores the cursor after.  Avoids having the
" cursor jump to the last replaced whitespace after saving.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

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
    let ls.='%2* %f'
    let ls.='%4* %y %1*'
    let ls.=FileModes()

    let l:fixing = g:ale_fix_on_save

    if l:fixing == 1
        let ls.='%3*'
    endif

    return ls
endfunction

function! RightSide()
    let rs = ''

    " line/col info
    let rs.= "%2* %c • %l/%L "
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

" }}}

" Searching {{{
" Custom searching command.  Basically just allows for passing ag arguments
" directly
" Usage
" :F myThing -tjs
"
" With preview
" :F! myThing -tjs

let g:rg_command = '
  \ rg --column --line-number --no-heading --hidden --follow --color "always"
  \ -g "!{.git,node_modules}/*" '

command! -bang -nargs=* F
  \ call fzf#vim#grep(
  \ g:rg_command.<q-args>,
  \ 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" }}}

" }}}
" ============================================================================


" ============================================================================
" LOCAL VIMRC {{{
" ============================================================================
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" }}}
" ============================================================================
