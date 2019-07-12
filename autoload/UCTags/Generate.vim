" Last Change:  07/12/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Generate')
  finish
endif
let g:loaded_UCTags_Generate = 1

function! UCTags#Generate#GenTags()
  if !executable(g:uctags_executable)
    echoerr g:uctags_executable 'could not be found!'
    finish
  endif

  execute '!' . g:uctags_executable
        \ join(values(map(
        \   copy(g:uctags_args), { k, v -> k . "'" . v . "'" })), ' ')
endfunction
