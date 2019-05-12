" Last Change:  2019-05-12
" Maintainer:   Francesco Magliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Generate')
  finish
endif
let g:loaded_UCTags_Generate = 1

function! UCTags#Generate#GenTags()
  execute '!' . g:uctags_executable
        \ join(values(map(
        \   copy(g:uctags_args), { k, v -> k . "'" . v . "'" })), ' ')
endfunction
