" Last Change:  2019-05-07
" Maintainer:   Francesco Magliocco
" License:      GNU General Public License v3.0

if (exists('g:universal_ctags_enabled') && !g:universal_ctags_enabled)
      \ || !exists('g:loaded_universal_ctags')
      \ || exists('g:loaded_UCTags_Highlight')
  finish
endif
let g:loaded_UCTags_Highlight = 1

function! UCTags#Highlight#Functions()
  for l:v in UCTags#Parse#GetFunctionTags()
    let l:lang = strpart(l:v[5], 9)
    let l:group = tolower(l:lang) . g:universal_ctags_hl_group_map['function']
    let l:match = '/\<' . l:v[0] . '\ze(/'
    let l:cmd = 'syntax match ' . l:group . ' ' . l:match
    echomsg l:cmd
    execute l:cmd
    execute 'hi def link' l:group 'functionName'
  endfor

endfunction
