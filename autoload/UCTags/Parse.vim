" File:         Parse.vim
" Last Change:  06/10/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Parse')
  finish
endif
let g:loaded_UCTags_Parse = 1

function! UCTags#Parse#GetTags()
  if !g:uctags_use_perl || !has('perl') | return s:GetTags() | endif

  if !filereadable(g:uctags_tags_file)
    echoerr 'no tags file'
    finish
  endif

  perl GetTagsVim
endfunction

function! s:GetTags()
  if !filereadable(g:uctags_tags_file)
    echoerr 'no tags file'
    finish
  endif

  if g:uctags_verbose
    echohl warningMsg | echomsg 'Not using Perl!' | echohl None
  endif

  return map(
        \ filter(UCTags#Utils#Readfile(g:uctags_tags_file), "v:val !~# '^!_TAG'"),
        \ "split(v:val, '\t')")
endfunction

function! UCTags#Parse#GetLang(lang)
  let l:lang = UCTags#Utils#GetLang(a:lang)
  if !g:uctags_use_perl || !has('perl')
    let l:pat = l:lang ==? 'c' ? '\\(c\\|c++\\)\\>' : l:lang
    return filter(
          \ UCTags#Parse#GetTags(),
          \ "v:val[5] ==? 'language:" . l:lang ==? 'c'
          \   ? '\\(c\\|c++\\)\\>'
          \   : l:lang . "'")
  endif

  perl GetLangVim(scalar VIM::Eval('l:lang'))
endfunction
