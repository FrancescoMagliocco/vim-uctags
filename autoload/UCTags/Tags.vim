" File:         Tags.vim
" Last Change:  07/23/2019
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

function! UCTags#Tags#Kind(kind)
  if !g:uctags_use_perl || !has('perl')
    return filter(s:GetTags(), "v:val[3] ==? 'kind:" . a:kind . "'")
  endif

  perl GetKindVim(scalar VIM::Eval('a:kind'))
endfunction

function! UCTags#Tags#Namespace(namespace)
  if !g:uctags_use_perl || !has('perl')
    return 

  endif

  echomsg UCTags#Utils#Filter(filter(UCTags#Tags#GetTags(), 'len(v:val) >= 7'), 'v:val[6] =~#', a:namespace . '\>')



endfunction

function! UCTags#Tags#HasFile(...)
  let l:args = join(a:000, '')
  if !g:uctags_use_perl || !has('perl')
    for l:tag in UCTags#Tags#Kind('file')
      if l:tag[0] =~# l:args
        return l:tag[1]
      endif
    endfor

    return ''
  endif

  perl HasFile(scalar VIM::Eval('l:args'))
endfunction

function! UCTags#Tags#Lang(lang)
  let l:lang = UCTags#Utils#GetLang(a:lang)
  if !g:uctags_use_perl || !has('perl')
    return filter(
          \ UCTags#Tags#GetTags(),
          \ "v:val[5] =~? 'language:" . (l:lang ==? 'c'
          \   ? '\%\(c\|c++\)\>'
          \   : l:lang . '\>') . "'")
  endif

  perl GetLangVim(scalar VIM::Eval('l:lang'))
endfunction
