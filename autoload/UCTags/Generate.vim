" Last Change:  2019-05-07
" Maintainer:   Francesco Magliocco
" License:      GNU General Public License v3.0

if (exists('g:universal_ctags_enabled') && !g:universal_ctags_enabled)
      \ || !exists('g:loaded_universal_ctags')
      \ || exists('g:loaded_UCTags_Generate')
  finish
endif
let g:loaded_UCTags_Generate = 1

function! UCTags#Generate#GenTags()
  execute '!' . g:universal_ctags_executable
        \ join(values(map(
        \   copy(g:universal_ctags_args), { k, v -> k . "'" . v . "'"})), ' ')
endfunction
