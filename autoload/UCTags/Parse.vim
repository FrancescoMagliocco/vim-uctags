" File:         Parse.vim
" Last Change:  06/05/2019
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

  echohl uctagsInfo | echon '  Using Perl GetTagsVim()' | echohl None
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

  echohl uctagsInfo | echon '  Reading tag file' | echohl None
  return map(
        \ filter(readfile(g:uctags_tags_file), "v:val !~# '^!_TAG'"),
        \ "split(v:val, '\t')")
endfunction

function! UCTags#Parse#GetLang(lang)
  let l:lang = UCTags#Utils#GetLang(a:lang)
  echohl uctagsInfo | echon "\rGetting" l:lang 'tags            ' | echohl None
  if !g:uctags_use_perl || !has('perl')
    let l:pat = l:lang ==? 'c' ? '\\(c\\|c++\\)\\>' : l:lang
    return filter(
          \ UCTags#Parse#GetTags(),
          \ "v:val[5] ==? 'language:" . l:lang ==? 'c'
          \   ? '\\(c\\|c++\\)\\>'
          \   : l:lang . "'")
  endif

  echohl uctagsInfo | echon '  Using Perl GetLangVim()' | echohl None
  perl GetLangVim(scalar VIM::Eval('l:lang'))
endfunction
