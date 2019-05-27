" A Universal-Ctags highlighter
" Last Change:  05/27/2019
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

" XXX Using uctags as prefixes for everything, and even the plugin,
"   kind of bothers me in a way such that what if universal-ctags actually
"   creates a plugin..
let g:loaded_uctags         = 1

let g:uctags_executable     = get(g:, 'uctags_executable', 'ctags-universal')

let g:uctags_tags_file      = get(g:, 'uctags_tags_file', 'tags')
let g:uctags_max_info       = get(g:, 'uctags_max_info', 0)

let g:uctags_extra_args     = get(g:, 'uctags_extra_args', {})
let g:uctags_syntax_c_enabled = get(g:, 'uctags_syntax_c_enabled', 1)

" TODO Change name
let g:uctags_max_lines_header_search = get(g:, 'uctags_max_lines_header_search', 0)

let g:uctags_verbose = get(g:, 'uctags_verbose', 0)
let g:uctags_max_syn = get(g:, 'uctags_max_syn', 0)

" Package for go also highlights foo in package foo, we could simply still
"   highlight with a pattern.
" From what I have seen so far, name in c++ is operaors rediefined.
" universal ctags skip kind for
let g:uctags_skip_kind_for  = get(g:, 'uctags_skip_hl_for', {
      \   'chapter'       : ['markdown'],
      \   'externvar'     : ['c', 'c++'],
      \   'function'      : ['vim'],
      \   'header'        : ['c', 'c++'],
      \   'heredoc'       : ['sh'],
      \   'hunk'          : ['diff'],
      \   'key'           : ['javaproperties'],
      \   'label'         : ['dosbatch'],
      \   'modifiedfile'  : ['diff'],
      \   'package'       : ['go'],
      \   'parameter'     : ['c++', 'c', 'python'],
      \   'script'        : ['sh'],
      \   'section'       : ['markdown'],
      \   'subroutine'    : ['perl'],
      \   'subsubsection' : ['markdown'],
      \   'var'           : ['vim', 'c', 'c++'],
      \   'variable'      : ['vim', 'c', 'c++']
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
" XXX section is also used for asm
let g:uctags_kind_to_hlg      = get(g:, 'uctags_kind_to_hlg', {
      \   'alias'           : 'namespace',
      \   'annotation'      : 'notation',
      \   'anonmember'      : 'type',
      \   'class'           : 'class',
      \   'const'           : 'constant',
      \   'command'         : 'command',
      \   'define'          : 'cTagsDefinedName',
      \   'enum'            : 'class',
      \   'enumerator'      : 'cTagsDefinedName',
      \   'externvar'       : 'variable',
      \   'field'           : 'method',
      \   'func'            : 'functionName',
      \   'function'        : 'functionName',
      \   'id'              : 'identifier',
      \   'implementation'  : 'errorMsg',
      \   'interface'       : 'constant',
      \   'label'           : 'label',
      \   'local'           : 'variable',
      \   'macro'           : 'cTagsDefinedName',
      \   'member'          : 'member',
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
      \   'prototype'       : 'functionName',
      \   'rpc'             : 'functionName',
      \   'section'         : 'identifier',
      \   'selector'        : 'identifier',
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
      \   'c++'     : { 'member'  : { 'start' : '/\%\(\.\|->\)\<\zs', 'end' : '\>/' }},
      \   'go'      : { 'member'  : { 'start' : '/\<', 'end' : '\>/' }},
      \   'javascript'  : { 'method' : { 'start' : '/\<', 'end' : '\%\(\>\|\ze(\)/'}},
      \   'python'  : { 'class'   : { 'start' : '/\<', 'end' : '\ze(/' }},
      \   'vim'     : { 'command' : { 'start' : '/\<', 'end' : '\>/' }},
      \   'alias'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'annotation'      : { 'start'     : '/\<',  'end' : '\>/' },
      \   'anonmember'      : { 'start'     : '/\<',  'end' : '\>/' },
      \   'class'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'const'           : { 'start'     : '/\<',  'end' : '\>/' },
      \   'enum'            : { 'start'     : '/\<',  'end' : '\>/' },
      \   'enumerator'      : { 'start'     : '/\<',  'end' : '\>/' },
      \   'externvar'       : { 'start'     : '/\<',  'end' : '\>/' },
      \   'define'          : { 'start'     : '/\<',  'end' : '\>/' },
      \   'field'           : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'func'            : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'function'        : { 'start'     : '/\<',  'end' : '\s*\ze(/' },
      \   'id'              : { 'start'     : '/\<',  'end' : '\>/' },
      \   'implementation'  : { 'start'     : '/\<',  'end' : '\>/' },
      \   'interface'       : { 'start'     : '/\<',  'end' : '\>/' },
      \   'label'           : { 'start'     : '/\<',  'end' : '\>/' },
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
      \   'prototype'       : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'rpc'             : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'section'         : { 'start'     : '/\<',  'end' : '\>/' },
      \   'selector'        : { 'start'     : '/\<',  'end' : '\>/' },
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
      \   '-R'                      : '',
      \   '-f'                      : g:uctags_tags_file,
      \   '--extras='               :
      \     '*-{subword}{qualified}{fileScope}{anonymous}',
      \   '--fields='               : '*-{roles}{scope}{file}',
      \   '--kinds-all='            : '*',
      \   '--kinds-c++='            : '-{header}',
      \   '--kinds-c='              : '-{header}',
      \   '--kinds-cpreprocessor='  : '-{header}',
      \   '--kinds-html='           : '-{heading1`}',
      \   '--kinds-json='           : '-{number}{object}{array}',
      \   '--kinds-maven2='         : '-{artifactId}',
      \   '--languages='            : '-markdown,json'
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
      \   'anonmember'      : 'AnonMember',
      \   'class'           : 'Class',
      \   'const'           : 'Const',
      \   'enum'            : 'Enum',
      \   'enumerator'      : 'Enumerator',
      \   'externvar'       : 'ExternVar',
      \   'define'          : 'Define',
      \   'field'           : 'field',
      \   'func'            : 'Func',
      \   'function'        : 'Func',
      \   'id'              : 'Id',
      \   'implementation'  : 'Impl',
      \   'interface'       : 'Interface',
      \   'label'           : 'Label',
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
      \   'prototype'       : 'Proto',
      \   'rpc'             : 'rpc',
      \   'section'         : 'Section',
      \   'selector'        : 'Selector',
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

function! s:ParseMap(expr1, expr2)
  return map(extend(copy(a:expr1), a:expr2), "substitute(v:val, '\W', '', 'g')")
endfunction

let g:uctags_hl_group_map   = s:ParseMap(s:hlg_map, g:uctags_hl_group_map)
let g:uctags_lang_map       = s:ParseMap(s:lang_map, g:uctags_lang_map)

augroup uctags_aug
  autocmd!
  if filereadable(g:uctags_tags_file)
    " COMBAK For some reason all of a sudden we need to redraw...  Why?  Maybe
    "   because my laptop isn't plugged in?..
    autocmd BufWritePost * silent call UCTags#Generate#GenTags() | redraw!
  endif
augroup END

command! -bar UpdateTags silent call UCTags#Generate#GenTags() | redraw!
command! ReadTags call UCTags#Highlight#ReadTags(expand('%'))
command! -bar DeleteAllSyn silent execute '!find . -name *.syn -delete' | redraw!
command! UpdateSyn call UCTags#Highlight#UpdateSyn(UCTags#Highlight#Lang(&ft))
