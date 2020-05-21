" File:         uctags_globals.vim
" Last Change:  05/20/2020
" Maintainer:   FrancescoMagliocco

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_uctags_globals')
  finish
endif
let g:loaded_uctags_globals   = 1
let g:uctags_executable       = get(g:, 'uctags_executable', 'ctags-universal')
let g:uctags_readtags         = get(g:, 'uctags_readtags', 'readtags')

let g:uctags_tags_file        = get(g:, 'uctags_tags_file', 'tags')
let g:uctags_use_readtags     = get(g:, 'uctags_use_readtags', 1)
let g:uctags_max_info         = get(g:, 'uctags_max_info', 0)

let g:uctags_extra_args       = get(g:, 'uctags_extra_args', {})
let g:uctags_syntax_c_enabled = get(g:, 'uctags_syntax_c_enabled', 1)
let g:uctags_use_keyword      = get(g:, 'uctags_use_keyword', 0)
let g:uctags_skip_non_keyword = get(g:, 'uctags_skip_non_keyword', 0)
let g:uctags_use_only_match   = get(g:, 'uctags_use_only_match', 1)
let g:uctags_use_keyword_over_match = get(g:, 'uctags_use_keyword_over_match', 0)

" TODO Change name
let g:uctags_max_lines_header_search = get(g:, 'uctags_max_lines_header_search', 0)

let g:uctags_verbose = get(g:, 'uctags_verbose', 0)
let s:no_perl = "Perl isn't supported!"

" assert_true returns 0 if {actual} is non-zero
let g:uctags_use_perl =
      \ !assert_true(has('perl'), s:no_perl) && get(g:, 'uctags_use_perl', 1)
let g:uctags_max_syn = get(g:, 'uctags_max_syn', 0)

" Package for go also highlights foo in package foo, we could simply still
"   highlight with a pattern.
" From what I have seen so far, name in c++ is operaors rediefined.
" universal ctags skip kind for
let g:uctags_skip_kind_for  = get(g:, 'uctags_skip_hl_for', {
      \   'chapter'       : ['markdown'],
      \   'class'         : ['css'],
      \   'externvar'     : ['c', 'c++'],
      \   'file'          : ['all'],
      \   'function'      : ['vim'],
      \   'header'        : ['c', 'c++'],
      \   'heredoc'       : ['sh'],
      \   'hunk'          : ['diff'],
      \   'id'            : ['css'],
      \   'key'           : ['javaproperties'],
      \   'label'         : ['dosbatch'],
      \   'local'         : ['c#', 'python', 'java'],
      \   'macroparam'    : ['c', 'c++'],
      \   'modifiedfile'  : ['diff'],
      \   'package'       : ['go', 'java'],
      \   'parameter'     : ['c++', 'c', 'python'],
      \   'script'        : ['sh'],
      \   'selector'      : ['css'],
      \   'section'       : ['markdown'],
      \   'subroutine'    : ['perl'],
      \   'subsubsection' : ['markdown'],
      \   'target'        : ['make'],
      \   'var'           : ['vim', 'c', 'c++'],
      \   'variable'      : ['vim', 'c', 'c++']
      \ })

" universal ctags kind to highlight group
" The name for this is kind of relevant, but I'm not sure I like it..
" COMBAK annotation probably needs to be linked to smoethiing else
" COMBAK I have field linked to method as it is kinnd of or acts like a method,
"   except that it is a variable...
" FIXME Implementation needs to be looked at
" XXX Interface is linked to constant, it is kind of accurate
" XXX Take a look at message
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
      \   'enum'            : 'enumName',
      \   'enumerator'      : 'enumValue',
      \   'externvar'       : 'variable',
      \   'field'           : 'field',
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
      \   'property'        : 'property',
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
" TODO WE ONLY WANT TO MATCH THAT OF WHAT IS INSIDE $(), so we can probably
"   disregard some of the FIXMEs
"
" macro for make is already highlightedd by makeIndent, but there is too much
"   that is highlighted by makeIndent
let g:uctags_default_match  =  { 'start' : '/\<',  'end' : '\>/' }
let g:uctags_match_map      = get(g:, 'uctags_match_map', {
      \   'c++'     : { 'member'  : { 'start' : '/\%\(\.\|->\)\<\zs', 'end' : '\>/' }},
      \   'c#'      : { 'method'  : { 'start' : '/\<', 'end' : '\ze\s*\%\((\|<\)/'  },
      \                 'field'   : { 'start' : '/\<', 'end' : '\>\s*\((\)\@!/' },
      \                 'struct'  : { 'start' : '/\<', 'end' : '\>\s*\((\)\@!/' }},
      \   'go'      : { 'member'  : g:uctags_default_match },
      \   'javascript'  : { 'method' : { 'start' : '/\<', 'end' : '\%\(\>\|\ze(\)/'}},
      \   'field'           : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'func'            : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'function'        : { 'start'     : '/\<',  'end' : '\s*\ze(/' },
      \   'member'          : { 'start'     : '/\<',  'end' : '\ze\s*(/' },
      \   'method'          : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'prototype'       : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'rpc'             : { 'start'     : '/\<',  'end' : '\ze(/' },
      \   'target'          : { 'start'     : '+',    'end' : '+' },
      \   'using'           : { 'start'     : '/',    'end' : '\>/' },
      \   'var'             : { 'start'     : '/',    'end' : '\>/' },
      \ })
      "\   'go'      : { 'member'  : { 'start' : '/\<', 'end' : '\>/' }},
      "\   'vim'     : { 'command' : { 'start' : '/\<', 'end' : '\>/' }},
      "\   'alias'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'annotation'      : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'anonmember'      : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'class'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'const'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'enum'            : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'enumerator'      : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'externvar'       : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'define'          : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'id'              : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'implementation'  : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'interface'       : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'label'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'local'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'macro'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'message'         : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'module'          : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'name'            : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'namespace'       : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'option'          : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'package'         : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'packagename'     : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'project'         : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'property'        : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'section'         : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'selector'        : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'service'         : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'struct'          : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'symbol'          : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'table'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'type'            : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'typedef'         : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'union'           : { 'start'     : '/\<',  'end' : '\>/' },
      "\   'variable'        : { 'start'     : '/\<',  'end' : '\>/' },

let g:uctags_pre_args       = get(g:, 'uctags_pre_args', {
      \   '-R'                      : '',
      \   '-f'                      : g:uctags_tags_file,
      \   '--extras='               :
      \     '*-{subword}{qualified}{fileScope}{anonymous}',
      \   '--fields='               : '*-{roles}{file}',
      \   '--kinds-all='            : '*',
      \ })

" XXX Disabling Target for Make because most targets are already highlighted.
"   There are some tags generated with uctags that suggest some parts of
"   targets aren't highlgihted however.
" When executed, the order is not guarenteed as this is a dictionnary
" This will define the default arguments.
" COMBAK DTD does seem to have some interesting stuff that should be
"   highlighted
" COMBAK PHP needs to be looked at; disabled for now
" COMBAK We are actually going to have to take a look at a lot of the langugaes
"   we have disabled
let g:uctags_args           = get(g:, 'uctags_args', {
      \   '--kinds-c++='            : '-{variable}',
      \   '--kinds-c='              : '-{variable}',
      \   '--kinds-css='            : '-{id}{selector}{class}',
      \   '--kinds-html='           : '-{heading1}{heading2}{heading3}',
      \   '--kinds-json='           : '-{number}{object}{array}',
      \   '--kinds-maven2='         : '-{artifactId}',
      \   '--kinds-python='         : '-{unknown}{parameter}',
      \   '--kinds-make='           : '-{target}',
      \   '--languages='            : '-markdown,json,restructuredtext,ant,xslt,javaproperties,diff,dtd,html,php,windres,dbusintrospect,yaml,maven2,man,plistxml,sml,perl,sh,svg,sql'
      \ })

let s:lang_map              =
      \ {
      \   'c#'  : 'cs',
      \   'c++' : 'cpp'
      \ }

" highlight group map
let s:hlg_map               =
      \ {
      \   'c#'              : { 'class' : 'ClassType' },
      \   'alias'           : 'Alias',
      \   'annotation'      : 'Annotation',
      \   'anonmember'      : 'AnonMember',
      \   'class'           : 'Class',
      \   'const'           : 'Const',
      \   'enum'            : 'Enum',
      \   'enumerator'      : 'Enumerator',
      \   'externvar'       : 'ExternVar',
      \   'define'          : 'Define',
      \   'event'           : 'Event',
      \   'field'           : 'Field',
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

function! GetGroup(lang, kind)
  let l:hlg = get(s:hlg_map, a:lang, s:hlg_map)
  let l:hlg = has_key(l:hlg, a:kind) ? l:hlg[a:kind] : get(s:hlg_map, a:kind, a:kind)
  return get(g:uctags_lang_map, a:lang, a:lang) . l:hlg
endfunction

" universal ctags highlight group map
" FIXME The name for this isn't exactly relevant..
" TODO Come up with more elaborate name.
" This is more of a 'kind to kind but truncated' map.  So maybe rename it as
"   'g:uctags_kind_map', plus it would match the naming convention
"   that was used for 'g:uctags_lang_map'
let g:uctags_hl_group_map   = get(g:, 'uctags_hl_group_map', {})

let g:uctags_lang_map       = get(g:, 'uctags_lang_map', {})

function! s:ParseMap(expr1, expr2)
  return map(extend(filter(copy(a:expr1), 'type(v:val) == v:t_string'), a:expr2), "substitute(v:val, '\W', '', 'g')")
endfunction

let g:uctags_hl_group_map   = s:ParseMap(s:hlg_map, g:uctags_hl_group_map)
let g:uctags_lang_map       = s:ParseMap(s:lang_map, g:uctags_lang_map)
