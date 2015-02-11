" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c


colorscheme base16-tomorrow
if has("gui_running")
  if has("gui_macvim")
    set guifont=Essential\ PragmataPro:h12
  endif
endif
set linespace=8

