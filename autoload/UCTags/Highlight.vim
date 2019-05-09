" Last Change:  2019-05-08
" Maintainer:   Francesco Magliocco
" License:      GNU General Public License v3.0

if (exists('g:universal_ctags_enabled') && !g:universal_ctags_enabled)
      \ || !exists('g:loaded_universal_ctags')
      \ || exists('g:loaded_UCTags_Highlight')
  finish
endif
let g:loaded_UCTags_Highlight = 1

function! UCTags#Highlight#Highlight(kind)
  for l:v in uniq(sort(filter(
        \ UCTags#Parse#GetTags(), "v:val[3] ==? 'kind:" . a:kind . "'")))
    let l:lang  = tolower(strpart(l:v[5], 9))
    let l:group = get(g:universal_ctags_lang_map, l:lang, l:lang)
          \ . get(g:universal_ctags_hl_group_map, a:kind, a:kind)
    execute 'syntax matach ' . l:group . ' /\<' . l:v[0] . '\ze(/'
    execute 'hi def link' l:group 'functionName'
  endfor
endfunction

function! UCTags#Highlight#Methods()
  call UCTags#Highlight#Highlight('method')
endfunction
