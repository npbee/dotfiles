" Launch Config {{{ "
" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

set encoding=utf8

" Check 1 line for local commands to the buffer
set modelines=1

" Set the amount of commands and search patterns that are remembered
set history=500

" Use JSX syntax on .js files
let g:jsx_ext_required = 0

" }}}


" Colors {{{

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Sets stuff for iTerm
syntax on
set background=dark
let base16colorspace=256
colorscheme base16-vim-master/colors/base16-eighties

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
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" show line numbers
set number
set numberwidth=3

" Give a relative count from the current cursor position
set relativenumber

" Make it obvious where 80 characters is" 
set textwidth=80

" show the cursor position all the time
set ruler

" Automatically wrap at the text width
set wrap

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

" Text bubbling, like Sublime Text
" Move one line up and one line down
nnoremap <silent> <C-Up> :move-2<CR>==
nnoremap <silent> <C-Down> :move+<CR>==

" Move multiple lines up and down
xnoremap <silent> <C-Up> :move-2<CR>gv=gv
xnoremap <silent> <C-Down> :move'>+<CR>gv=gv
"
" }}}

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

" Open a new split window
nnoremap <leader>w <C-w>v<C-w>l

" Easier moving around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle rainbow parenthesis
nnoremap <leader>r :RainbowParenthesesToggle<CR>

" Toggle nerdtree
map <C-m> :NERDTreeToggle<CR>

" Turn of search highlighting
nnoremap <leader><space> :nohlsearch<CR>

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

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" }}}


" Syntastic {{{

" Allow jcsc and jshint checkers for js files
let g:syntastic_javascript_checkers = ['jshint', 'jscs']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_error_symbol = 'S✗'
let g:syntastic_style_warning_symbol = 'S!'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
  autocmd BufRead,BufNewFile  *.jshintrc,*.JSHINTRC,*.jscsrc set filetype=javascript
  autocmd BufRead,BufNewFile *.conf set filetype=nginx

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Trim whitespace on save
  autocmd BufWritePre *.js :%s/\s\+$//e
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


" Bundles {{{

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" }}}


" Local Config {{{

" Reads anything in a .vimrc.local
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" }}}


" Local command to folder on a marker
" vim:foldmethod=marker:foldlevel=0
