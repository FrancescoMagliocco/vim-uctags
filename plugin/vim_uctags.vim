" A Universal-Ctags highlighter
" Last Change:  2019-05-12
" Maintainer:   Francesco Magliocco
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

" XXX Using uctags as prefixes for everything, and even the plugin,
"   kind of bothers me in a way such that what if universal-ctags actually
"   creates a plugin..
let g:loaded_uctags       = 1

let g:uctags_executable   = get(g:, 'uctags_name', 'ctags-universal')

" COMBAK This name doesn't really 'flow'..
let g:uctags_tags_name    = get(g:, 'uctags_tags_name', 'tags')
let g:uctags_max_info     = get(g:, 'uctags_max_info', 1)

let g:uctags_extra_args   = get(g:, 'uctags_extra_args', {})

" universal ctags skip highlight for
" FIXME I don't like this name
" TODO Come up with more elaborate name
let g:uctags_skip_hl_for  = get(
      \ g:,
      \ 'uctags_skip_hl_for',
      \ {
      \   'function': ['vim']
      \ })

" universal ctags kind to highlight group
" The name for this is kind of relevant, but I'm not sure I like it..
let g:uctags_kind_to_hlg  = get(
      \ g:, 'uctags_kind_to_hlg', {
      \   'function'  : 'functionName',
      \   'method'    : 'methods'
      \ })

function! s:ParseArgs(args)
  return extend(extend(a:args, g:uctags_max_info
        \   ? {
        \       '--fields='     : '*',
        \       '--all-kinds='  : '*'
        \     }
        \   : {} ), g:uctags_extra_args)
endfunction

" This will define the default arguments.
let g:uctags_args         = get(
      \ g:,
      \ 'uctags_args',
      \ {
      \   '-R'  : '',
      \   '-f'  : g:uctags_tags_name
      \ })

" Extends g:uctags_args with g:uctags_extra_args so
" g:uctags_args can be used when needing arguments for
" ctags-universal.  See s:ParseArgs() body for aditional details.
let g:uctags_args         = s:ParseArgs(g:uctags_args)

let s:lang_map            =
      \ {
      \   'c#'  : 'cSharp',
      \   'c++' : 'cpp'
      \ }

" highlight group map
let s:hlg_map             =
      \ {
      \   'function'  : 'Func',
      \   'variable'  : 'Var',
      \ }

" universal ctags highlight group map
" FIXME The name for this isn't exactly relevant..
" TODO Come up with more elaborate name.
" This is more of a 'kind to kind but truncated' map.  So maybe rename it as
"   'g:uctags_kind_map', plus it would match the naming convention
"   that was used for 'g:uctags_lang_map'
let g:uctags_hl_group_map = get(g:, 'uctags_hl_group_map', {})

let g:uctags_lang_map     = get(g:, 'uctags_lang_map', {})

" Any key in a:hlg_map that isn't in s:hlg_map will be removed.
" Create a deepcopy() of s:hlg_map, extend said copy with a:hlg_map.
" Remove any non-word character.
"function! s:ParseHlGMap(hlg_map)
""  return map(extend(deepcopy(s:hlg_map), filter(
""        \ a:hlg_map,
""        \ 'has_key(s:hlg_map, v:key)')), "substitute(v:val, '\W', '', 'g')")
""endfunction

" TODO Rename
function! s:ParseHlGMap(hlg_map, map)
  return map(extend(copy(a:map), a:hlg_map), "substitute(v:val, '\W', '', 'g')")
endfunction

" TODO Implement the same, but for g:uctags_ctags_lang_map
let g:uctags_hl_group_map = s:ParseHlGMap(g:uctags_hl_group_map, s:hlg_map)

augroup uctags_aug
  autocmd!
  if filereadable(g:uctags_tags_name)
    autocmd BufWritePost * silent call UCTags#Generate#GenTags()
  endif
augroup END

command! UpdateTags call silent UCTags#Generate#GenTags()
