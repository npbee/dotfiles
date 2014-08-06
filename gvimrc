" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c


colorscheme Tomorrow-Night-Eighties
if has("gui_running")
  if has("gui_macvim")
    set guifont=Ubuntu\ Mono:h14
  endif
endif
set linespace=8

