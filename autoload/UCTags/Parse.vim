" File:         Parse.vim
" Last Change:  07/23/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Parse')
  finish
endif
let g:loaded_UCTags_Parse = 1
