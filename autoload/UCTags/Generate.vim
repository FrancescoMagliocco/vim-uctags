" Last Change:  08/08/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Generate')
  finish
endif
let g:loaded_UCTags_Generate = 1

let s:critical_args =
      \ {
      \   '--fields='   : '+Kzl',
      \   '--kinds-all=': '+{file}',
      \   '--kinds-c='  : '+{header}',
      \   '--kinds-c++=': '+{header}'
      \ }

function! s:ParseArgs(args)
  return extend(a:args, g:uctags_extra_args)
endfunction

function! s:DictToStr(dict)
  return join(values(map(copy(a:dict), { k, v -> k . "'" . v . "'" })))
endfunction

function! UCTags#Generate#GenTags()
  if !executable(g:uctags_executable)
    echoerr g:uctags_executable 'could not be found!'
    finish
  endif

  call s:ParseArgs(g:uctags_args)
  execute '!' . g:uctags_executable
        \ s:DictToStr(g:uctags_pre_args)
        \ s:DictToStr(g:uctags_args)
        \ s:DictToStr(s:critical_args)
endfunction
