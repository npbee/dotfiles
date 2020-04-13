" vim: set foldmethod=marker foldlevel=0 nomodeline:

" ============================================================================
" PLUGINS {{{
" ============================================================================
silent! if plug#begin('~/.vim/plugged')

" Colors
Plug 'npbee/eighty-five'

" Lang
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'othree/html5.vim', { 'for': ['pug', 'html'] }
Plug 'niftylettuce/vim-jinja', { 'for': 'jinja' }
Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }

" Editing
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'Shougo/neosnippet.vim'
Plug 'wellle/targets.vim'


" Browsing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'ludovicchabant/vim-gutentags'

" Utility
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'

call plug#end()
endif

" }}}

" {{{ dirvish

" Sort directories at the top
let g:dirvish_mode = ':sort ,^.*[\/],'

" }}}

" {{{ neosnippet
let g:neosnippet#snippets_directory='~/.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {
            \ '_': 1,
            \}

let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['javascriptreact'] = 'javascript'

" }}}

" vim-test {{{
let test#strategy = "neoterm"


" Set the strategies in a .vimrc.local like so
let g:test#javascript#jest#file_pattern = '-test\.js'
let g:test#javascript#jest#executable = 'npm run test-watch --prefix ./apps/sf_web'

" }}}

" neoterm {{{
let g:neoterm_default_mod = "vertical"

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

let g:fzf_layout = { 'down': '70%' }
"}}}

" Coc {{{
let g:coc_global_extensions = [ 'coc-eslint', 'coc-json',
        \ 'coc-prettier', 'coc-emmet', 'coc-neosnippet'
       \]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" }}}

"" }}}
"" ============================================================================


"" ============================================================================
"" INIT {{{
"" ============================================================================

" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Allow for custom indent settings from plugins
filetype plugin indent on

let mapleader = " "

augroup vimrc
    autocmd!
augroup END

"" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"" Give more space for displaying messages.
set cmdheight=2

set clipboard=unnamed   " Use OS clipboard
set colorcolumn=80
set completeopt=menuone,menu,longest
set conceallevel=0
set display+=lastline
set encoding=utf-8
set expandtab           " Tabs are spaces
set foldlevelstart=10
set foldmethod=indent

" CoC - TextEdit might fail if hidden is not set.
set hidden

set history=200         " The amount of commands remembered
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:»·,trail:·
set scrolloff=3

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set shiftround
set shiftwidth=2

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set showmode
set splitbelow
set statusline=%!StatusLine()
set synmaxcol=200
set textwidth=0

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

set wildmenu
set wildmode=list:longest,list:full

" Colors {{{
syntax on
set background=dark
set termguicolors
colorscheme eighty-five

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
nnoremap <F10> :call SynStack()<cr>

" Turn off search highlighting
nnoremap <silent> <leader><cr> :noh<cr>


" FZF
" Fuzzy find files
nnoremap <leader>p :FZF<CR>

" Find various files based on content
" Search
nnoremap <leader>f :FF<Space>

" Find files based on the word under the cursor
nnoremap <leader>rg :F <C-R><C-W><CR>

" Find files based on the selected text in visual mode
xnoremap <silent> <leader>rg       y:F <C-R>"<CR>

" Fuzzy find at a specific path
nnoremap <leader>? :FZF<space>

" Fuzzy find buffers
nnoremap <leader>b :Buffers<CR>



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

" Close terminal window and kill the process
nmap <silent> <leader>tx :Tclose!<CR>


" Cycle through buffers with tab
nnoremap <tab> :bnext<cr>
nnoremap <S-tab> :bprev<cr>
nnoremap <leader>q :bdelete<CR>

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

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Move lines
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv

" Manually run prettier
nnoremap gp :silent %!prettier --stdin-filepath %<CR>

" Stupid way to run prettier on text files and treat as markdown. There's
" probably a better way to do this.
nnoremap gpmd :silent %!prettier --stdin-filepath dummy.md<CR>

" Cycles through a list
function! WrapCommand(direction, prefix)
  if a:direction == "up"
    try
      execute a:prefix . "previous"
    catch /^Vim\%((\a\+)\)\=:E553/
      execute a:prefix . "last"
    endtry
  elseif a:direction == "down"
    try
      execute a:prefix . "next"
    catch /^Vim\%((\a\+)\)\=:E553/
      execute a:prefix . "first"
    catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
    endtry
  endif
endfunction

" Command + l cycles down through the location list
nnoremap <silent> ]l :call WrapCommand("up", "l")<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR><Paste>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>

" }}}
" ============================================================================


"" ============================================================================
"" AUTOCMD {{{
"" ============================================================================

augroup vimrc

    " File Types
    autocmd BufRead,BufNewFile *.md             set filetype=markdown
    autocmd BufRead,BufNewFile *.mdx             set filetype=markdown.mdx
    autocmd BufRead,BufNewFile *.ejs,*.EJS      set filetype=html
    autocmd BufRead,BufNewFile *.conf           set filetype=nginx
    autocmd BufRead,BufNewFile
        \ *.eslintrc,*.babelrc,*.jshintrc,*.JSHINTRC,*.jscsrc,*.flow
        \ set filetype=javascript
    autocmd BufRead,BufNewFile *Jenkins* set syntax=groovy

    " JSON5
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " Trim whitespace on save
    autocmd BufWinLeave * call clearmatches()

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

    " autocmd FileType html,css,javascript.jsx EmmetInstall

    autocmd Filetype gitcommit setlocal textwidth=72
    autocmd FileType vimwiki set syntax=markdown

    " Close preview after autocomplete
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

     " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" }}}
" ============================================================================


" ============================================================================
" FUNCTIONS {{{
" ============================================================================

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

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" Statusline {{{

function! StatusLine()
 let statusl =  '%2* %f %*|%*'                         " File path
 let statusl .= '%4* %y %*|%*'                         " File type

  let statusl .= '%2* %m'                               " Modified indicator
  let statusl .= '%='                                   " Start right side
  let statusl .= '%2* %c %*|%*'                         " Column number
  let statusl .= '%2* %l/%L %*|%*'                      " Current Line number / total lines
  let statusl .= "%*%3* %{coc#status()}%{get(b:, 'coc_current_function','')}%*"

   return statusl
endfunction

"" }}}

"" Searching {{{
"" Custom searching command.  Basically just allows for passing rg arguments
"" directly
"" Usage
"" :F myThing -tjs
""
"" With preview
"" :F! myThing -tjs

"let g:rg_command = 'rg --column --line-number --no-heading --color=always --smart-case '

"command! -bang -nargs=* F
"  \ call fzf#vim#grep(
"  \ g:rg_command.shellescape(<q-args>),
"  \ 1,
"  \   <bang>0 ? fzf#vim#with_preview('up:75%')
"  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"  \   <bang>0)

"" Probably a better way to do this, but this allows a full rg search with options
"command! -bang -nargs=* FF
"  \ call fzf#vim#grep(
"  \ g:rg_command.<q-args>,
"  \ 1,
"  \   <bang>0 ? fzf#vim#with_preview('up:75%')
"  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"  \   <bang>0)

"" }}}

"" }}}
"" ============================================================================


"" ============================================================================
"" LOCAL VIMRC {{{
"" ============================================================================
"if filereadable(glob("~/.vimrc.local"))
"    source ~/.vimrc.local
"endif
" }}}
" ============================================================================
