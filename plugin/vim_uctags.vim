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
let g:loaded_uctags         = 1

let g:uctags_executable     = get(g:, 'uctags_executable', 'ctags-universal')

let g:uctags_tags_file      = get(g:, 'uctags_tags_file', 'tags')
let g:uctags_max_info       = get(g:, 'uctags_max_info', 1)

let g:uctags_extra_args     = get(g:, 'uctags_extra_args', {})
let g:uctags_syntax_c_enabled = get(g:, 'uctags_syntax_c_enabled', 1)

" From what I have seen so far, name in c++ is operaors rediefined.
" universal ctags skip kind for
let g:uctags_skip_kind_for  = get(g:, 'uctags_skip_hl_for', {
      \   'chapter'       : ['markdown'],
      \   'class'         : ['c++'],
      \   'function'      : ['vim', 'c++', 'c'],
      \   'header'        : ['c', 'c++'],
      \   'heredoc'       : ['sh'],
      \   'hunk'          : ['diff'],
      \   'key'           : ['javaproperties'],
      \   'label'         : ['dosbatch'],
      \   'modifiedfile'  : ['diff'],
      \   'parameter'     : ['c++', 'c', 'python'],
      \   'prototype'     : ['c++'],
      \   'script'        : ['sh'],
      \   'section'       : ['markdown'],
      \   'subroutine'    : ['perl'],
      \   'subsubsection' : ['markdown'],
      \   'variable'      : ['vim']
      \ })

" I'M NOT SURE IF I WANT TO DISABLE THE FIELD FILE OR NOT
" universal ctags kind to highlight group
" The name for this is kind of relevant, but I'm not sure I like it..
" COMBAK annotation probably needs to be linked to smoethiing else
" COMBAK Enum needs to be linked to something else.  I don't think ther is
"   currently a group made for it, same for enumerator
" COMBAK I have field linked to method as it is kinnd of or acts like a method,
"   except that it is a variable...
" FIXME Implementation needs to be looked at
" XXX Interface is linked to constant, it is kind of accurate
" XXX Take a look at message
" XXX Package
" XXX Property
" XXX Service
" XXX Symbol
" XXX Table
let g:uctags_kind_to_hlg      = get(g:, 'uctags_kind_to_hlg', {
      \   'alias'           : 'namespace',
      \   'annotation'      : 'notation',
      \   'class'           : 'class',
      \   'const'           : 'constant',
      \   'command'         : 'command',
      \   'enum'            : 'class',
      \   'enumerator'      : 'cTagsDefinedName',
      \   'externvar'       : 'variable',
      \   'field'           : 'method',
      \   'func'            : 'functionName',
      \   'function'        : 'functionName',
      \   'implementation'  : 'errorMsg',
      \   'interface'       : 'constant',
      \   'local'           : 'variable',
      \   'macro'           : 'cTagsDefinedName',
      \   'message'         : 'class',
      \   'method'          : 'method',
      \   'module'          : 'statement',
      \   'name'            : 'class',
      \   'namespace'       : 'namespace',
      \   'option'          : 'option',
      \   'package'         : 'namespace',
      \   'packagename'     : 'namespace',
      \   'project'         : 'title',
      \   'property'        : 'errorMsg',
      \   'rpc'             : 'functionName',
      \   'service'         : 'class',
      \   'struct'          : 'structure',
      \   'symbol'          : 'identifier',
      \   'table'           : 'title',
      \   'target'          : 'special',
      \   'type'            : 'type',
      \   'typedef'         : 'type',
      \   'union'           : 'type',
      \   'using'           : 'using',
      \   'var'             : 'variable',
      \   'variable'        : 'variable'
      \ })

" FIXME target will match $(TARGET), eventally I want to only match just TARGET
"   inside $() and have $() be highlighted as different.  BUT  $() may already
"   be overriden to be highlighted on their own by the syntax file for Make and
"   others that may be of correspondance.
" FIXME Some targets have % in the target, I'm not sure if that has to be
"   escaped or not.
" FIXME Some targets have . present.  We need to escape that.
" For target we are using + as the delimiter because in the name of some
"   targets, there is / present.
" TODO WE ONLY WANT TO MATCH THAT OF WHAT IS INSIDE $(), so we can probably
"   disregard some of the FIXMEs
"
" macro for make is already highlightedd by makeIndent, but there is too much
"   that is highlighted by makeIndent
let g:uctags_match_map      = get(g:, 'uctags_match_map', {
      \   'c++'     : { 'member'  : { 'start' : '/\<', 'end' : '\>/' }},
      \   'go'      : { 'member'  : { 'start' : '/\<', 'end' : '\>/' }},
      \   'python'  : { 'class'   : { 'start' : '/\<', 'end' : '\ze(/' }},
      \   'vim'     : { 'command' : { 'start' : '/\<', 'end' : '\>/' }},
      \   'alias'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'annotation'      : { 'start'     : '/\<',  'end' : '\>/' },
      \   'class'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'const'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'enum'            : { 'start'     : '/\<',  'end' : '\>/' },
      \   'enumerator'      : { 'start'     : '/\<',  'end' : '\>/' },
      \   'externvar'       : { 'start'     : '/\<',  'end' : '\>/' },
      \   'field'           : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'func'            : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'function'        : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'implementation'  : { 'start'     : '/\<',  'end' : '\>/' },
      \   'interface'       : { 'start'     : '/\<',  'end' : '\>/' },
      \   'local'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'macro'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'member'          : { 'start'     : '/\<',  'end' : '\ze\s*(/' },
      \   'message'         : { 'start'     : '/\<',  'end' : '\>/' },
      \   'method'          : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'module'          : { 'start'     : '/\<',  'end' : '\>/' },
      \   'name'            : { 'start'     : '/\<',  'end' : '\>/' },
      \   'namespace'       : { 'start'     : '/\<',  'end' : '\>/' },
      \   'option'          : { 'start'     : '/\<',  'end' : '\>/' },
      \   'package'         : { 'start'     : '/\<',  'end' : '\>/' },
      \   'packagename'     : { 'start'     : '/\<',  'end' : '\>/' },
      \   'project'         : { 'start'     : '/\<',  'end' : '\>/' },
      \   'property'        : { 'start'     : '/\<',  'end' : '\>/' },
      \   'rpc'             : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'service'         : { 'start'     : '/\<',  'end' : '\>/' },
      \   'struct'          : { 'start'     : '/\<',  'end' : '\>/' },
      \   'symbol'          : { 'start'     : '/\<',  'end' : '\>/' },
      \   'table'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'target'          : { 'start'     : '+',    'end' : '+' },
      \   'type'            : { 'start'     : '/\<',  'end' : '\>/' },
      \   'typedef'         : { 'start'     : '/\<',  'end' : '\>/' },
      \   'union'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'using'           : { 'start'     : '/',    'end' : '\>/' },
      \   'var'             : { 'start'     : '/',    'end' : '\>/' },
      \   'variable'        : { 'start'     : '/\<',  'end' : '\>/' },
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
let g:uctags_args           = get(g:, 'uctags_args', {
      \   '-R'  : '',
      \   '-f'  : g:uctags_tags_file
      \ })

" Extends g:uctags_args with g:uctags_extra_args so
" g:uctags_args can be used when needing arguments for
" ctags-universal.  See s:ParseArgs() body for aditional details.
let g:uctags_args           = s:ParseArgs(g:uctags_args)

let s:lang_map              =
      \ {
      \   'c#'  : 'cSharp',
      \   'c++' : 'cpp'
      \ }

" highlight group map
let s:hlg_map               =
      \ {
      \   'alias'           : 'Alias',
      \   'annotation'      : 'Annotation',
      \   'class'           : 'Class',
      \   'const'           : 'Const',
      \   'enum'            : 'Enum',
      \   'enumerator'      : 'Enumerator',
      \   'externvar'       : 'ExternVar',
      \   'field'           : 'field',
      \   'func'            : 'Func',
      \   'function'        : 'Func',
      \   'implementation'  : 'Impl',
      \   'interface'       : 'Interface',
      \   'local'           : 'Local',
      \   'macro'           : 'Macro',
      \   'member'          : 'Member',
      \   'message'         : 'Msg',
      \   'method'          : 'Method',
      \   'module'          : 'Module',
      \   'name'            : 'Name',
      \   'namespace'       : 'Namespace',
      \   'option'          : 'Option',
      \   'package'         : 'Pkg',
      \   'packagename'     : 'PkgName',
      \   'parameter'       : 'Param',
      \   'project'         : 'Project',
      \   'property'        : 'Property',
      \   'rpc'             : 'rpc',
      \   'service'         : 'Service',
      \   'struct'          : 'Struct',
      \   'symbol'          : 'Sym',
      \   'table'           : 'Table',
      \   'target'          : 'Target',
      \   'type'            : 'Type',
      \   'typedef'         : 'TypeDef',
      \   'union'           : 'Union',
      \   'using'           : 'Using',
      \   'var'             : 'Var',
      \   'variable'        : 'Var',
      \ }

" universal ctags highlight group map
" FIXME The name for this isn't exactly relevant..
" TODO Come up with more elaborate name.
" This is more of a 'kind to kind but truncated' map.  So maybe rename it as
"   'g:uctags_kind_map', plus it would match the naming convention
"   that was used for 'g:uctags_lang_map'
let g:uctags_hl_group_map   = get(g:, 'uctags_hl_group_map', {})

let g:uctags_lang_map       = get(g:, 'uctags_lang_map', {})

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
let g:uctags_hl_group_map   = s:ParseHlGMap(g:uctags_hl_group_map, s:hlg_map)
let g:uctags_lang_map       = s:ParseHlGMap(g:uctags_lang_map, s:lang_map)

augroup uctags_aug
  autocmd!
  if filereadable(g:uctags_tags_file)
    autocmd BufWritePost * silent call UCTags#Generate#GenTags()
  endif
augroup END

command! -bar UpdateTags silent call UCTags#Generate#GenTags() | redraw!