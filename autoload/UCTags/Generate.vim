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
      \   '--extras='   : '-{subword}',
      \   '--fields='   : '+Kzl',
      \   '--kinds-all=': '+{file}',
      \   '--kinds-c='  : '+{header}',
      \   '--kinds-c++=': '+{header}',
      \   '--kinddef-c\#=': 'U,using,using namespace'
      \ }

let s:post_critical_args =
      \ {
      \   '--regex-c\#=': '/^\s*using\s+([a-zA-Z0-9.]+)+;/\1/U/'
      \ }

" This would probably be ideal if we used optional arguemnts, that way we could
"   specify which args we wanted to parse.
function! s:ParseArgs(args)
  let l:ret = {}

  " I don't like using for loops, but I think this is the only way this can be
  "   done.
  "
  " When a:args and g:uctags_extra_args have the same key, but the case doesn't
  "   match, both keys are still unique and therefore the value in
  "   g:uctags_extra_args wont override the value in a:args that has the
  "   identical key.  To fix this, we convert each key in a:args and
  "   g:uctags_extra_args to lowercase.
  "
  " I'm hoping that items(a:args) + items(g:uctags_extra_args) will ensure
  "   g:uctags_extra_args has still the higher precedence so identical keys will
  "   be overrided.
  for [l:k, l:v] in items(a:args) + items(g:uctags_extra_args)
    let l:ret[tolower(l:k)] = l:v
  endfor

  return l:ret
endfunction

function! s:DictToStr(dict)
  return join(values(map(copy(a:dict), { k, v -> k . "'" . v . "'" })))
endfunction

function! UCTags#Generate#GenTags()
  if !executable(g:uctags_executable)
    echoerr g:uctags_executable 'could not be found!'
    finish
  endif

  execute '!' . g:uctags_executable
        \ s:DictToStr(g:uctags_pre_args)
        \ s:DictToStr(s:ParseArgs(g:uctags_args))
        \ s:DictToStr(s:critical_args)
        \ s:DictToStr(s:post_critical_args)
endfunction
