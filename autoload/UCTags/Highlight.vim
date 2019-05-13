" Last Change:  2019-05-13
" Maintainer:   Francesco Magliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Highlight')
  finish
endif
let g:loaded_UCTags_Highlight = 1

" If any optional arguments are given, do a dry run and output some info
function! UCTags#Highlight#Highlight(kind, ...)
  let l:kind = tolower(a:kind)
  if !has_key(g:uctags_kind_to_hlg, l:kind)
    echoerr 'No support yet for' l:kind
    return
  endif

  " Filter out kinds that aren't a:kind
  " Filter out out languages val, for a:kind key present in
  "   g:uctags_skip_hl_for:
  "     Check if g:uctags_skip_hl_for has key a:kind:
  "       IF key a:kind is present:
  "         Check if val contains tolower(strpart(v:val[5], 9)), i.e language
  "           IF val contains said language:
  "             returned index is NOT < 0; therefore filtered out.
  "           ELSEIF cal does NOT contain said language:
  "             returned index IS < 0; therefore NOT filtered out.
  "       ELSEIF key a:kind is NOT present:
  "         1; therefore NOT filtered out.
  " Sort
  " Removed any duplicates XXX Some languages like C# allow multiple
  "   definitions of methods, given they have different signatures.  This will
  "   essentially remove all except one.
  "
  " COMBAK Another way to do this would be to call a function within the filter
  "   and pass a:kind.  
  " XXX I'm worried that if there is a significant amount of tags that Vim will
  "   halt until all the filtering is done.  TODO I wanted to implement the new
  "   channel and job system.  I'm just not sure if that is possible for
  "   situtations like this.
  let l:skip =
        \ 'has_key(g:uctags_skip_kind_for, l:kind)'
        \ . '? index(g:uctags_skip_kind_for[l:kind],'
        \     . 'tolower(strpart(v:val[5], 9))) < 0'
        \ . ': 1'
  for l:v in uniq(sort(
        \ filter(
        \   filter(
        \     UCTags#Parse#GetTags(), "v:val[3] ==? 'kind:" . l:kind . "'"),
        \   l:skip)))
    let l:lang  = tolower(strpart(l:v[5], 9))
    let l:group = get(g:uctags_lang_map, l:lang, l:lang)
          \ . get(g:uctags_hl_group_map, l:kind, l:kind)
    if a:0
      echomsg l:lang
      continue
    endif

    execute 'syntax match ' . l:group . ' /\<' . l:v[0] . '\ze(/'
    
    " We are not using 'default' as we (or the user if specified) want l:group
    "   linked to g:uctags_kind_to_hlg[l:kind].  Also using 'default' for some
    "   goup-names such as 'vimFunction' result in 'vimFunction' actually being
    "   linked to 'ErrorMsg'
    execute 'hi link' l:group g:uctags_kind_to_hlg[l:kind]
  endfor
endfunction

function! UCTags#Highlight#Methods()
  call UCTags#Highlight#Highlight('method')
endfunction
