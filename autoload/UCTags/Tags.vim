" File:         Tags.vim
" Last Change:  05/20/2020
" Maintainer:   FrancescoMagliocco

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Tags')
  finish
endif
let g:loaded_UCTags_Tags = 1

function! UCTags#Tags#GetTags()
  if !g:uctags_use_perl || !has('perl') | return s:GetTags() | endif
  call UCTags#Utils#HaveTagFile()
  perl GetTagsVim
endfunction

function! s:GetTags()
  call UCTags#Utils#HaveTagFile()
  return map(
        \ filter(UCTags#Utils#Readfile(g:uctags_tags_file), "v:val !~# '^!_TAG'"),
        \ "split(v:val, '\t')")
endfunction

function! s:Readtags(exp)
  return map(split(system(g:uctags_readtags . ' -e -t ' . g:uctags_tags_file . " -Q '" . a:exp . "' -l"), '\n'), "split(v:val, '\t')")
endfunction

function! UCTags#Tags#Readtags(str, ...)
  let l:str = trim(a:str, "'")
  for l:i in range(1, len(a:000))
    let l:str = substitute(l:str, 'a:' . l:i, eval('a:' . l:i), 'g')
  endfor
  return s:Readtags(l:str)
endfunction

function! UCTags#Tags#HeaderGuard(file)
  "let l:ret = s:Readtags('(and (eq? $name "' . substitute(toupper(substitute(a:file, '^lib', '', 'g')), '[/.]', '_', 'g') . '") (eq? $kind "macro"))')
  let l:ret = s:Readtags('(and (suffix? "' . a:file . '" $name) (eq? $kind "macro"))')

  return l:ret
endfunction

function! UCTags#Tags#KindFor(kind, file)
  let l:ret = s:Readtags('(and (eq? $kind "' . a:kind . '") (eq? $input "' . a:file . '"))')
  return l:ret
endfunction

function! UCTags#Tags#KindFor(kind, file, ...)
  let l:ret = s:Readtags('(and (eq? $kind "' . a:kind . '") (eq? $input "' . a:file . '"))')
  return l:ret
endfunction

function! UCTags#Tags#FindFile(file)
  let l:ret = s:Readtags('(and (eq? $kind "file") (or (suffix? $input "/' . a:file . '") (eq? $input "' . a:file . '")))')
  return l:ret
endfunction

function! UCTags#Tags#Kind(kind)

  if !g:uctags_use_perl || !has('perl')
    if g:uctags_use_readtags
      return map(split(system(
            \ g:uctags_readtags . ' -e -t '
            \ . g:uctags_tags_file . ' -Q '
            \ . "'(eq? $kind \"" . a:kind . "\")' -l"), '\n'), "split(v:val, '\t')")
    endif
    return filter(s:GetTags(), "v:val[3] ==? 'kind:" . a:kind . "'")
  endif

  perl GetKindVim(scalar VIM::Eval('a:kind'), scalar VIM::Eval('g:uctags_use_readtags'))
endfunction

function! UCTags#Tags#Namespace(namespace)
  if !g:uctags_use_perl || !has('perl')
    return 

  endif

  echomsg UCTags#Utils#Filter(filter(UCTags#Tags#GetTags(), 'len(v:val) >= 7'), 'v:val[6] =~#', a:namespace . '\>')
endfunction

function! UCTags#Tags#HasFile(...)
  echomsg 'here'
  let l:args = join(a:000, '')
  if !g:uctags_use_perl || !has('perl')
    for l:tag in UCTags#Tags#Kind('file')
      if l:tag[0] =~# l:args
        return l:tag[1]
      endif
    endfor

    return ''
  endif

  perl HasFile(scalar VIM::Eval('l:args'), scalar VIM::Eval('g:uctags_use_readtags'))
endfunction

function! UCTags#Tags#Lang(lang)
  let l:lang = UCTags#Utils#GetLang(a:lang)
  if !g:uctags_use_perl || !has('perl')
    if g:uctags_use_readtags
      return map(split(system(
            \ g:uctags_readtags . ' -e -t '
            \ . g:uctags_tags_file . ' -Q '
            \ . (l:lang ==? 'c'
            \   ? "'(or (eq? $language \"" . l:lang . "\") (eq? $language \"C++\"))' -l"
            \   : "'(eq? $language \"" . l:lang . "\")' -l")), '\n'), "split(v:val, '\t')")
    endif

    return filter(
          \ UCTags#Tags#GetTags(),
          \ "v:val[5] =~? 'language:" . (l:lang ==? 'c'
          \   ? '\%\(c\|c++\)\>'
          \   : l:lang . '\>') . "'")
  endif

  perl GetLangVim(scalar VIM::Eval('l:lang'), scalar VIM::Eval('g:uctags_use_readtags'))
endfunction
