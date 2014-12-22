" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Leader
let mapleader = ","

" Automatically :write before running commands
set autowrite

" Backspace deletes like most programs in insert mode
set backspace=2

set colorcolumn=+1

" Highlight the current line" 
set cursorline

set expandtab
set encoding=utf8
set history=500

" do incremental searching
set incsearch

" Always display the status line
set laststatus=2

" Display extra whitespace
set list listchars=tab:»·,trail:·

set nobackup
set noswapfile
set nowritebackup
set number
set numberwidth=5

" Give a relative count from the current cursor position
set relativenumber

" show the cursor position all the time
set ruler

" This gives some buffer above a line when goin going to a line
set scrolloff=3

set shiftround
set shiftwidth=4

" display incomplete commands
set showcmd

set splitbelow
set splitright
set tabstop=4

" Make it obvious where 80 characters is" 
set textwidth=80

set wildmode=list:longest,list:full
set wrap

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

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
  autocmd BufRead,BufNewFile  *.jshintrc,*.JSHINTRC set filetype=javascript

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Open a new split window
nnoremap <leader>w <C-w>v<C-w>l

" Easier moving around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle rainbow parenthesis
nnoremap <leader>r :RainbowParenthesesToggle<CR>

" toggle out of insert mode
:imap ii  <Esc>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
