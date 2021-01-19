" vim: set foldmethod=marker foldlevel=0 nomodeline:

" ============================================================================
" PLUGINS {{{
" ============================================================================
silent! if plug#begin(stdpath('data') . '/plugged')

Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'npbee/eighty-five'
Plug 'lukas-reineke/format.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'ludovicchabant/vim-gutentags'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'

call plug#end()

" ALE
" -----
let g:ale_linters = {}
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 'never'
let g:ale_lint_on_enter = 'never'
let g:ale_lint_delay = 200
let g:ale_echo_msg_format = '%linter%: %s [%severity%%/code%]'

let g:ale_fixers = {}
let g:ale_fix_on_save = 1

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

" Completion
" ----------
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
    \ 'priority': 10, 
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'blocklist': [],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

endif

" Dirvish
" -------

" Sort directories at the top
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-test
" --------
let test#strategy = "neoterm"

" neoterm
" --------
let g:neoterm_default_mod = "vertical"

" vsnip
" ------
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript', 'javascript']
let g:vsnip_filetypes.typescript = ['typescript', 'javascript']

" }}}
" ============================================================================

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

" Load project-specific configs
set exrc
set secure

set clipboard=unnamed   " Use OS clipboard
set colorcolumn=80
set completeopt=menuone,menu,longest,preview,noinsert,noselect
set conceallevel=0
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
set pumwidth=80
set scrolloff=3

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
set statusline=%!StatusLine()

set showmode
set splitbelow
" set statusline=%!StatusLine()
set synmaxcol=200
set textwidth=0

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

set wildmenu
set wildmode=list:longest,list:full
set wildcharm=<tab>

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
" ============================================================================

" ============================================================================
" MAPPINGS {{{
" ============================================================================

" Turn off search highlighting
nnoremap <silent> <esc> :noh<cr>

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

" in visual mode, use tab for indenting
xnoremap <tab> >gv
xnoremap <s-tab> <gv

" Cycle through buffers with tab
nnoremap <tab> :bnext<cr>
nnoremap <S-tab> :bprev<cr>
nnoremap <leader>q :bdelete<CR>

" Easily swap between files
nnoremap <leader><leader> <c-^>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ALE
" -----
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gr <Plug>(ale_find_references)
nmap <silent> gl <Plug>(ale_hover)
nmap <silent> an :ALENext<CR>
nnoremap gj :ALENextWrap<CR>
nnoremap gk :ALEPreviousWrap<CR>
nnoremap g1 :ALEFirst<CR>
nnoremap g0 :ALEStopAllLSPs<CR>

" Completion
" ----------

" Use <Tab> to cycle completions
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" vim-test
" --------
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" neoterm
" --------
" Toggle terminal window
nmap <silent> <leader>tt :Ttoggle<CR>

" Close terminal window and kill the process
nmap <silent> <leader>tx :Tclose!<CR>

" vsnip
" ------

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


" }}}
" ============================================================================

"" ============================================================================
"" AUTOCMD {{{
"" ============================================================================
augroup vimrc
    autocmd!
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    " File Types
    autocmd BufRead,BufNewFile *.md             set filetype=markdown
    autocmd BufRead,BufNewFile *.mdx            set filetype=markdown.mdx
    autocmd BufRead,BufNewFile *.ejs,*.EJS      set filetype=html
    autocmd BufRead,BufNewFile *.conf           set filetype=nginx
    autocmd BufRead,BufNewFile
        \ *.eslintrc,*.babelrc,*.jshintrc,*.JSHINTRC,*.jscsrc,*.flow
        \ set filetype=javascript
    autocmd BufRead,BufNewFile *Jenkins*        set syntax=groovy

    " JSON5
    autocmd FileType json syntax match Comment +\/\/.\+$+

    autocmd Filetype gitcommit setlocal textwidth=72

augroup END

" }}}
" ============================================================================

" ============================================================================
" FUNCTIONS {{{
" ============================================================================

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
" ============================================================================

" ============================================================================
" FUNCTIONS {{{
" ============================================================================
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

" }}}
" ============================================================================


"" ============================================================================
"" LOCAL VIMRC {{{
"" ============================================================================
if filereadable(glob("~/.config/nvim/init.local.vim"))
    source ~/.config/nvim/init.local.vim
endif
" }}}
" ============================================================================
