" Last Change:  05/17/2019
" Maintainer:   FrancescoMagliocco
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
        \     . 'tolower(v:val[5][9:])) < 0'
        \ . ': 1'

  " I HAVE REMOVED UNIQ to use filescope
  for l:v in (sort(
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
    
    let l:has_key = has_key(g:uctags_match_map, l:lang)

    " If neither g:uctags_match_map[l:lang] or g:uctags_match_map has key
    "   l:kind, there isn't a pattern to match l:kind for l:lang.
    if !l:has_key && !has_key(g:uctags_match_map, l:kind)
      continue
    endif

    " Using l:match =
    "     \ get(g:uctags_match_map[l:lang], l:kind, g:uctags_match_map[l:kind)
    "   Throws an error if l:kind is not present in g:uctags_match_map even if
    "   l:kind is present in g:uctags_match_map[l:kind]
    let l:match = get(
          \ l:has_key ? g:uctags_match_map[l:lang] : g:uctags_match_map, l:kind)

    let l:lines = []
    if filereadable(l:lang . '.syn')
      let l:lines = readfile(l:lang . '.syn')
    endif


    let l:syn = 'syntax match ' . l:group . ' ' . l:match.start . substitute(l:v[0], '\(\.\|\$\|\\\|\~\|\$\|\^\)', '\\\1', 'g') . l:match.end
    let l:link = 'hi link' . ' ' . l:group . ' ' . g:uctags_kind_to_hlg[l:kind]
    if index(l:lines, l:syn) < 0
      call add(l:lines, l:syn)
      if index(l:lines, l:link)
        call add(l:lines, l:link)
      endif

      call writefile(l:lines, l:lang . '.syn')
    endif
    continue
  endfor
endfunction

function! UCTags#Highlight#High(tags, ...)

  let l:skip =
        \ 'has_key(g:uctags_skip_kind_for, tolower(v:val[3][5:]))'
        \ . '? index(g:uctags_skip_kind_for[tolower(v:val[3][5:])],'
        \     . 'tolower(v:val[5][9:])) < 0'
        \ . ': 1'
""  let l:tlang = ''
  let l:file = expand('%:t') . '.syn'
  " The reason why we are using silent! is bcause if l:file doesn';t exists, an
  "   empty list is returned which is okay.
  silent! let l:lines = readfile(l:file)
  for l:v in uniq(sort(
        \ filter(
        \   filter(
        \     filter(a:tags, "v:val[1] =~? expand('%:t')  . '$'"),
        \     'has_key(g:uctags_kind_to_hlg, tolower(v:val[3][5:]))'), l:skip)))
    let l:kind = tolower(l:v[3][5:])
    let l:lang  = tolower(l:v[5][9:])
    let l:group = get(g:uctags_lang_map, l:lang, l:lang)
          \ . get(g:uctags_hl_group_map, l:kind, l:kind)
    if a:0
      echomsg l:lang
      echomsg l:kind
      echomsg l:group
      continue
    endif
    
    let l:has_key = has_key(g:uctags_match_map, l:lang)
          \ && has_key(g:uctags_match_map[l:lang], l:kind)

    if !l:has_key && !has_key(g:uctags_match_map, l:kind)
      continue
    endif

    let l:match = get(
          \ l:has_key ? g:uctags_match_map[l:lang] : g:uctags_match_map, l:kind)

    let l:syn = 'syntax match ' . l:group . ' ' . l:match.start . substitute(
          \ l:v[0],
          \ '\(\.\|\$\|\\\|\~\|\$\|\^\|/\|\ \|\[\|\]\)',
          \ '\\\1',
          \ 'g') . l:match.end
    let l:link = 'hi link' . ' ' . l:group . ' ' . g:uctags_kind_to_hlg[l:kind]
      call add(l:lines, l:syn)
    execute 'hi link' l:group g:uctags_kind_to_hlg[l:kind]
  endfor

  call writefile(uniq(sort(l:lines)), l:file)
endfunction

function! UCTags#Highlight#Lang(lang)
  return filter(UCTags#Parse#GetTags(), "v:val[5] ==? 'language:" . a:lang . "'")
endfunction

function! UCTags#Highlight#Methods()
  call UCTags#Highlight#Highlight('method')
endfunction
