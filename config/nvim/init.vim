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

" Syntax
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'benekastah/neomake'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'rking/ag.vim'
Plug 'Valloric/ListToggle'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-eunuch'

" Editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'kassio/neoterm'
Plug 'tpope/vim-fugitive'

call plug#end()

" Dirvish {{{
nnoremap - :Dirvish %<CR>
" }}}


" Vim JSX {{{

" Use JSX syntax on .js files
" let g:jsx_ext_required = 0

" }}}


" CtrlP {{{

" Sets ctrlp to match files top to bottom
let g:ctrlp_match_window = 'bottom,order:ttb'

" Ignore setting the working directory
"let g:ctrlp_working_path_mode = 0

" Use ag for ctrlp
" Ignore does not work here, we have to use .agignore
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Use regex for ctrlp
let g:ctrlp_regexp = 1

let g:ctrlp_abbrev = {
    \ 'gmode': 't',
    \ 'abbrevs': [
        \ {
        \ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
        \ 'expanded': '.*',
        \ 'mode': 'pfrz',
        \ }
    \]
\}
" }}}


" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
" }}}


" YouCompleteMe {{{

" Don't let YouCompleteMe use tab, interferes with Ultisnips
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

" }}}


" NeoMake {{{
let g:neomake_javascript_linter_maker = {
    \ 'exe': 'eslint_d',
    \ 'args': ['-f', 'compact', '--parser', 'babel-eslint', '--cache'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \}

let g:neomake_javascript_enabled_makers = ['linter']

" Run neomake after every save
autocmd! BufWritePost * Neomake

" }}}


" Ultisnips {{{

let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

let g:UltiSnipsSnippetsDir="~/.dotfiles/vim/UltiSnips"

" }}}


" Neoterm {{{
if has('nvim')
    let g:neoterm_position = 'horizontal'

    " run set test lib
    nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
    nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
    nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
    nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

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


" Sneak {{{

" }}}


" Deoplete {{{

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" }}}


" Elm {{{
let g:elm_format_autosave = 1
" }}}
"
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

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1

  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" }}}


" Colors {{{

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Sets stuff for iTerm
syntax on
set background=dark
colorscheme gruvbox

let g:gruvbox_contrast_dark="hard"

highlight User1 ctermfg=110 ctermbg=236 guifg=#83a598 guibg=#282828
highlight User2 ctermfg=203 ctermbg=236 guibg=#282828 guifg=#fb4934
highlight User3 ctermfg=213 ctermbg=236 guibg=#282828 guifg=#d3869b
highlight User4 ctermfg=175 ctermbg=236 guibg=#282828 guifg=#fe8019
highlight User5 ctermfg=142 ctermbg=236 guibg=#282828 guifg=#b8bb26

highlight StatusLine ctermbg=white ctermfg=236 guifg=#282828 guibg=#fdf4c1
highlight StatusLineNC ctermbg=white ctermfg=236 guifg=#282828 guibg=#504945
highlight VertSplit ctermfg=white ctermbg=236 gui=bold,reverse guifg=#282828 guibg=#504945

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

set guifont=Ubuntu\ Mono\ derivative\ Powerline:h11
" }}}


" Searching {{{

" Search as characters entered
set incsearch

" Highlight matches
set hlsearch

" Do fuzzy finder on Ctrl + P
noremap <C-p> :FZF<CR>

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

" Text bubbling, like Sublime Text
" Move one line up and one line down
nnoremap <silent> <C-Up> :move-2<CR>==
nnoremap <silent> <C-Down> :move+<CR>==

" Move multiple lines up and down
xnoremap <silent> <C-Up> :move-2<CR>gv=gv
xnoremap <silent> <C-Down> :move'>+<CR>gv=gv
"
" }}}


" Leader Shortcuts {{{

" Leader
let mapleader = ","

" toggle out of insert mode
:imap ii  <Esc>

" Save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag

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

" Elm Specific
au FileType elm nmap <leader>b <Plug>(elm-make)
au FileType elm nmap <leader>m <Plug>(elm-make-main)
" au FileType elm nmap <leader>t <Plug>(elm-test)
au FileType elm nmap <leader>r <Plug>(elm-repl)
au FileType elm nmap <leader>e <Plug>(elm-error-detail)
au FileType elm nmap <leader>d <Plug>(elm-show-docs)

" }}}

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

" Tmux {{{
let g:tmuxline_preset = {
            \ 'a': '#S',
            \ 'win': '#I #W',
            \ 'cwin': '#I #W',
            \ 'z': '#H',
            \ 'options': {
            \'status-justify': 'left'}
            \}
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
  autocmd BufRead,BufNewFile *.eslintrc,*.babelrc,*.jshintrc,*.JSHINTRC,*.jscsrc set filetype=javascript
  autocmd BufRead,BufNewFile *.conf set filetype=nginx

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Trim whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e
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
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

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
    let ls.='%1* %f '
    let ls.='%3* %y %1*'
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
        let rs .= "%1*"
        let rs .= " "
    " endif

    " line/col info
    let rs.= "%1* col %c lines %l/%L "

    if exists('*fugitive#head')
        let head = fugitive#head()

        if !empty(head)
            let rs .= '%3*' . ' ' . head . ' '
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


" Local Config {{{

" Reads anything in a .vimrc.local
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" }}}

" Local command to folder on a marker
" vim:foldmethod=marker:foldlevel=0