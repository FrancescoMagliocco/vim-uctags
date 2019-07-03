" File:         Log.vim
" Last Change:  07/02/2019
" Maintainer:   FrancescoMagliocco

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Log')
  finish
endif
let g:loaded_UCTags_Log = 1

function! UCTags#Log#Error(...)
  if !a:0 | return | endif
  echohl uctagsErr | echomsg join(a:000) | echohl None
endfunction

function! UCTags#Log#Info(...)
  if !a:0 | return | endif
  echohl uctagsInfo | echomsg join(a:000) | echohl None
endfunction

function! UCTags#Log#Warn(...)
  if !a:0 | return | endif
  echohl uctagsWarn | echomsg join(a:000) | echohl None
endfunction
