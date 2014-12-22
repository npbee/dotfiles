# Use Vim settings, rather then Vi settings. This setting must be as early as
# possible, as it has side effects.
set nocompatible

# Leader
let mapleader = " "

set autowrite     # Automatically :write before running commands
set backspace=4   # Backspace deletes like most programs in insert mode
set colorcolumn=+1
set cursorline    # Highlight the current line
set expandtab
set history=50
set incsearch     # do incremental searching
set laststatus=2  # Always display the status line
set list listchars=tab:»·,trail:·  # Display extra whitespace
set nobackup
# http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noswapfile
set nowritebackup
set number
set numberwidth=5
set relativenumber  # Give a relative count from the current cursor position
set ruler         # show the cursor position all the time
set scrolloff=3   # This gives some buffer above a line when goin going to a line
set shiftround
set shiftwidth=4
set showcmd       # display incomplete commands
set splitbelow
set splitright
set tabstop=4
set textwidth=80  # Make it obvious where 80 characters is
set wildmode=list:longest,list:full
set wrap

# Switch syntax highlighting on, when the terminal has colors
# Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  # When editing a file, always jump to the last known cursor position.
  # Don't do it for commit messages, when the position is invalid, or when
  # inside an event handler (happens when dropping a file on gvim).
  # autocmd BufReadPost *
  #   \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  #   \   exe "normal g`\"" |
  #   \ endif

  # Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile  *.ejs,*.EJS set filetype=html
  autocmd BufRead,BufNewFile  *.jshintrc,*.JSHINTRC set filetype=javascript

  # Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  # Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  # Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

# Open a new split window
nnoremap <leader>w <C-w>v<C-w>l

# Easier moving around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l