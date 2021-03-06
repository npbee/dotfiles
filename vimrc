" vim: set foldmethod=marker foldlevel=0 nomodeline:

" ============================================================================
" PLUGINS {{{
" ============================================================================
silent! if plug#begin('~/.vim/plugged')

" Colors
Plug 'npbee/eighty-five'
Plug 'cocopon/colorswatch.vim'
Plug 'cocopon/inspecthi.vim'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'

" Lang
" Plug 'yuezk/vim-js'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
" Plug 'jparise/vim-graphql', { 'for': 'graphql' }
" Plug 'othree/html5.vim', { 'for': ['pug', 'html'] }
" Plug 'niftylettuce/vim-jinja', { 'for': 'jinja' }
" Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }
" Plug 'neoclide/jsonc.vim'
" Plug 'keith/swift.vim', { 'for': 'swift' }
" Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact']  }
Plug 'sheerun/vim-polyglot'


" Editing
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'wellle/targets.vim'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript.jsx'] }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'dense-analysis/ale'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'


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

" {{{ emmet
let g:user_emmet_leader_key='<C-E>'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'javascriptreact' : {
\      'extends' : 'jsx',
\  },
\  'typescriptreact' : {
\      'extends' : 'jsx',
\  },
\}

" }}}

" {{{ vsnip
" Expand
imap <expr> <C-k>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-k>'
smap <expr> <C-k>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-k>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
smap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
smap        S   <Plug>(vsnip-cut-text)

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript', 'javascript']
let g:vsnip_filetypes.typescript = ['typescript', 'javascript']

" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" Ale {{{
let g:ale_fixers =
\ { 'javascript': ['prettier'],
 \  'javascriptreact': ['prettier'],
 \  'typescript': ['prettier'],
 \  'typescriptreact': ['prettier'],
 \  'scss': ['prettier'],
 \  'markdown': ['prettier'],
 \  'markdown.mdx': ['prettier'],
 \  'graphql': ['prettier'],
 \  'json': ['prettier'],
 \  'css': ['prettier'],
 \  'yaml': ['prettier'],
 \  'vimwiki': ['prettier'],
 \  'elixir': ['mix_format'],
 \  'svelte': ['prettier'],
 \  'html': ['prettier'] }

let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_save = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_linter_aliases = {
\   'svelte': ['javascript'],
\   'typescriptreact': ['javascript']
\}
let g:ale_linters = {
\   'svelte': ['eslint'],
\   'javascript': ['eslint']
\}

" }}}

" {{{ dirvish

" Sort directories at the top
let g:dirvish_mode = ':sort ,^.*[\/],'

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

set clipboard=unnamed   " Use OS clipboard
set colorcolumn=80
set completeopt=menuone,menu,longest,preview,popup
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
set pumwidth=80
set scrolloff=3

" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

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

if has('nvim') 
  colorscheme eighty-five
else
  colorscheme iceberg
endif

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
nnoremap <F12> :call ToggleFixOnSave()<cr>

" Turn off search highlighting
nnoremap <silent> <esc> :noh<cr>

nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gr <Plug>(ale_find_references)
nmap <silent> gl <Plug>(ale_hover)
nmap <silent> an :ALENext<CR>
nnoremap gj :ALENextWrap<CR>
nnoremap gk :ALEPreviousWrap<CR>
nnoremap g1 :ALEFirst<CR>
nnoremap g0 :ALEStopAllLSPs<CR>



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
nmap <silent> <Home> <Plug>(ale_previous_wrap) 
nmap <silent> <End> <Plug>(ale_next_wrap)

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

    " tsconfig.json is actually jsonc, help TypeScript set the correct filetype
    autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc



    " JSON5
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " Trim whitespace on save
    autocmd BufWinLeave * call clearmatches()

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

    autocmd FileType html,css,javascript.jsx EmmetInstall

    autocmd Filetype gitcommit setlocal textwidth=72
    autocmd FileType vimwiki set syntax=markdown

    " Close preview after autocomplete
    " Silent suppresses the error
    autocmd! CompleteDone * if pumvisible() == 0 |silent! pclose | endif

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

" Toggle fixing on saving for ales
function! ToggleFixOnSave()
    if g:ale_fix_on_save
        let g:ale_fix_on_save = 0
    else
        let g:ale_fix_on_save = 1
    endif
endfunction

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
  let statusl .= "%*%#Error#%{AleStatus('error')}%*" 

   return statusl
endfunction

"" }}}

" Searching {{{
" Custom searching command.  Basically just allows for passing rg arguments
" directly
" Usage
" :F myThing -tjs
"
" With preview
" :F! myThing -tjs

let g:rg_command = 'rg --column --line-number --no-heading --color=always --smart-case '

command! -bang -nargs=* F
  \ call fzf#vim#grep(
  \ g:rg_command.shellescape(<q-args>),
  \ 1,
  \   <bang>0 ? fzf#vim#with_preview('up:75%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Probably a better way to do this, but this allows a full rg search with options
command! -bang -nargs=* FF
  \ call fzf#vim#grep(
  \ g:rg_command.<q-args>,
  \ 1,
  \   <bang>0 ? fzf#vim#with_preview('up:75%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" }}}

"" }}}
"" ============================================================================


"" ============================================================================
"" LOCAL VIMRC {{{
"" ============================================================================
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" }}}
" ============================================================================
