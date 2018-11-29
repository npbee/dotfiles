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
Plug 'tpope/vim-git'
Plug 'leafgarland/typescript-vim', { 'for': ['ts'] }

" Editing
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


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
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

call plug#end()
endif


" {{{ dirvish

" Sort directories at the top
let g:dirvish_mode = ':sort ,^.*[\/],'

" }}}

" {{{ neosnippet
let g:neosnippet#snippets_directory='~/.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {
            \ '_': 1,
            \}
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" }}}

" vim-test {{{
let test#strategy = "neoterm"


" Set the strategies in a .vimrc.local like so
" let g:test#javascript#jest#file_pattern = '-test\.js'
" let g:test#javascript#jest#executable = 'npm run test-watch --prefix ./apps/sf_web'

" }}}

" neoterm {{{
let g:neoterm_default_mod = "vertical"

" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" Completion {{{
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
let g:ale_fixers = {'javascript': ['prettier'], 'scss': ['prettier'], 'markdown': ['prettier'], 'graphql': ['prettier'], 'json': ['prettier'], 'css': ['prettier'], 'yaml': ['prettier'], 'vimwiki': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_lint_on_text_changed='never'
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'

" }}}

" Vimwiki {{{
let g:vimwiki_list = [{ 'path': '~/Dropbox/wiki', 'ext': '.md', 'syntax': 'markdown' }]
let g:vimwiki_global_ext=0
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
set completeopt=menuone,menu,longest
set conceallevel=0
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set display+=lastline
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
" set number              " Show line numbers
" set relativenumber
set scrolloff=3
set shiftround
set shiftwidth=2
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
nnoremap <F3> :set invnumber<cr>
nnoremap <F10> :call SynStack()<cr>
nnoremap <F12> :call ToggleFixOnSave()<cr>

" Turn of search highlighting
nnoremap <CR> :nohlsearch<CR>

" Fuzzy find files
nnoremap <leader>p :FZF<CR>

" Fuzzy find at a specific path
nnoremap <leader>? :FZF<space>

" Fuzzy find buffers
nnoremap <leader>b :Buffers<CR>


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

" neoterm

" Toggle terminal window
nmap <silent> <leader>tt :Ttoggle<CR>

" CLose terminal window and kill the process
nmap <silent> <leader>tx :Tclose!<CR>


" Cycle through buffers with tab
nnoremap <tab> :bnext<cr>
nnoremap <S-tab> :bprev<cr>
nnoremap <C-X> :bdelete<CR>

" in visual mode, use tab for indenting
xnoremap <tab> >gv
xnoremap <s-tab> <gv

nnoremap <F10> :call SynStack()<CR>

" Easily swap between files
nnoremap <leader><leader> <c-^>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <leader>n :call RenameFile()<cr>

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

    autocmd Filetype gitcommit setlocal textwidth=72
    autocmd FileType vimwiki set syntax=markdown

    " Close preview after autocomplete
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

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

" Show syntax highlight under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" Statusline {{{
function! AleStatus(type) abort
  let l:count = ale#statusline#Count(bufnr(''))
    let l:errors = l:count.error + l:count.style_error
  let l:warnings = l:count.warning + l:count.style_warning

  if a:type ==? 'error' && l:errors
    return '  ' . printf(' %d E ', l:errors)
  endif

  if a:type ==? 'warning' && l:warnings
    let l:space = l:errors ? ' ': ''
    return printf('%s %d W ', l:space, l:warnings)
  endif

  return ''
endfunction

function! StatusLine()
  let l:fixing = g:ale_fix_on_save

  let statusl =  '%2* %f %*|%*'                         " File path
  let statusl .= '%4* %y %*|%*'                         " File type

  if l:fixing == 1
    let statusl .=' %3*  %*|%*'                        " Prettier indicator
  endif

  let statusl .= '%2* %m'                               " Modified indicator
  let statusl .= '%='                                   " Start right side
  let statusl .= '%2* %c %*|%*'                         " Column number
  let statusl .= '%2* %l/%L %*|%*'                      " Current Line number / total lines
  let statusl .= "%*%#Error#%{AleStatus('error')}%*"    " Errors count

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
