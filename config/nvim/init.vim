" vim: set foldmethod=marker foldlevel=0 nomodeline:

lua require('settings')

" ============================================================================
" PLUGINS {{{
" ============================================================================
silent! if plug#begin(stdpath('data') . '/plugged')

Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'npbee/eighty-five'
Plug 'mattn/efm-langserver'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'mattn/emmet-vim'
Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'
Plug 'folke/trouble.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-colors.nvim'

call plug#end()

" FZF
" ----
 let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('down:80%:hidden', 'ctrl-/'), <bang>0)


" ALE
" -----
let g:ale_linters = {}
let g:ale_linters['javascript'] = []
let g:ale_linters['css'] = ['stylelint']
let g:ale_echo_msg_format = '%linter%: %s [%severity%%/code%]'
let g:ale_fixers = {}
let g:ale_fixers['lua'] = 'lua-format'
let g:ale_fix_on_save = 1

" Trouble
" -------

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>


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

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.documentation = v:true
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.vsnip = v:true

endif

" LSP
" ----
lua require('lsp')

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

" emmet-vim
" ----------
let g:user_emmet_leader_key='<C-E>'



" }}}
" ============================================================================

"" ============================================================================
"" INIT {{{
"" ============================================================================

augroup vimrc
    autocmd!
augroup END

set statusline=%!StatusLine()

" }}}
" ============================================================================

" ============================================================================
" MAPPINGS {{{
" ============================================================================
nnoremap <F12> :call ToggleFixOnSave()<cr>

" Turn off search highlighting
nnoremap <silent> <esc> :noh<cr>

" Fuzzy find files
nnoremap <leader>p :FZF<CR>

" Find various files based on content
" Search
nnoremap <leader>f :Rg<Space>

" Find files based on the word under the cursor
nnoremap <leader>rg :Rg <C-R><C-W> -w<CR>

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
nmap <silent> K <Plug>(ale_hover)
nmap <silent> <leader>e <Plug>(ale_detail)
nnoremap <leader>aj :ALENextWrap<CR>
nnoremap <leader>ak :ALEPreviousWrap<CR>
nnoremap <leader>ax :ALEStopAllLSPs<CR>

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
" Toggle fixing on saving for ales
function! ToggleFixOnSave()
    if g:ale_fix_on_save
        let g:ale_fix_on_save = 0
    else
        let g:ale_fix_on_save = 1
    endif
endfunction


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
