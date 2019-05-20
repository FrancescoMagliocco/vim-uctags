" Last Change:  05/19/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Parse')
  finish
endif
let g:loaded_UCTags_Parse = 1

function! UCTags#Parse#GetTags()
  if !filereadable(g:uctags_tags_file)
    echoerr 'no tags file'
    finish
  endif

  return map(
        \ filter(readfile(g:uctags_tags_file), "v:val !~# '^!_TAG'"),
        \ "split(v:val, '\t')")
endfunction

function! UCTags#Parse#GetTagsForLang(lang)
  echomsg filter(
        \ UCTags#Parse#GetTags(), "v:val[5] ==? 'language:" . a:lang . "'")
endfunction

function! UCTags#Parse#GetFunctionTags()
  if !filereadable(g:uctags_tags_file)
    echoerr 'no tags file'
    finish
  endif

  return filter(UCTags#Parse#GetTags(), "v:val[3] ==? 'kind:function'")

endfunction
