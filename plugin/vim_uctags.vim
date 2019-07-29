" A Universal-Ctags highlighter
" File:         vim_uctags.vim
" Last Change:  07/29/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

" We check if enabled first because if not enabled, it doesn't matter what
" version of Vim is running.
if exists('g:loaded_uctags') && g:loaded_uctags
  finish
endif


if v:version < 801
  echohl errorMsg
  echomsg 'Vim needs to be atleast version 8.1 to use this plugin'
  echohl None
endif

if exists('g:uctags_enabled') && !g:uctags_enabled
  echohl moreMsg | echomsg 'vim-uctags is not enabled' | echohl None
  finish
endif

hi uctagsInfo guifg=#F8F800 guibg=NONE    cterm=none
hi def link uctagsWarn warningMsg
hi def link uctagsErr  errorMsg

" XXX Using uctags as prefixes for everything, and even the plugin,
"   kind of bothers me in a way such that what if universal-ctags actually
"   creates a plugin..
let g:loaded_uctags         = 1
runtime plugin/uctags/uctags_globals.vim
runtime plugin/uctags/uctags_perl.vim

augroup uctags_aug
  autocmd!
  if filereadable(g:uctags_tags_file)
    " COMBAK For some reason all of a sudden we need to redraw...  Why?  Maybe
    "   because my laptop isn't plugged in?..
    autocmd BufWritePost * silent call UCTags#Generate#GenTags() | redraw!
  endif
augroup END

command! -bar UpdateTags silent call UCTags#Generate#GenTags() | redraw!
"command! -bar DeleteAllSyn silent execute "!find . -name '*.syn' -delete" | redraw!
command! DeleteAllSyn silent call system("find . -name '*.syn' -delete")
command! CreateSynFiles call UCTags#Highlight#CreateSynFiles(UCTags#Tags#Lang(&ft))
command! UpdateSynFile call UCTags#Highlight#UpdateSynFile(expand('%'))
