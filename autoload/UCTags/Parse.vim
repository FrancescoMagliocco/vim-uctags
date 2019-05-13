" Last Change:  2019-05-12
" Maintainer:   Francesco Magliocco
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
"  for l:val in l:tags
"    let l:lang = strpart(l:val[5], 9)
"    let l:kind = strpart(l:val[3], 5)
"    let l:cmd = 'syntax match ' . l:lang . l:kind . ' ' . l:val[2]
"    let l:cmd = substitute(l:cmd, '\*', '\\\*', 'g')
"    echomsg l:cmd
"    let l:cmd = strpart(l:cmd, 0, strlen(l:cmd) - 2)
"    echomsg l:cmd
"    execute l:cmd
"  endfor
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
