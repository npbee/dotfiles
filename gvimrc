" SETS STUFF FOR MACVIM
" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c


if has("gui_running")
  if has("gui_macvim")
    set guifont=Essential\ PragmataPro:h12
  endif
endif

