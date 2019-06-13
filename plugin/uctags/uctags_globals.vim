" File:         uctags_globals.vim
" Last Change:  06/13/2019
" Maintainer:   FrancescoMagliocco

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_uctags_globals')
  finish
endif
let g:loaded_uctags_globals   = 1
let g:uctags_executable       = get(g:, 'uctags_executable', 'ctags-universal')

let g:uctags_tags_file        = get(g:, 'uctags_tags_file', 'tags')
let g:uctags_max_info         = get(g:, 'uctags_max_info', 0)

let g:uctags_extra_args       = get(g:, 'uctags_extra_args', {})
let g:uctags_syntax_c_enabled = get(g:, 'uctags_syntax_c_enabled', 1)
let g:uctags_use_keyword      = get(g:, 'uctags_use_keyword', 1)
let g:uctags_skip_non_keyword = get(g:, 'uctags_skip_non_keyword', 0)
let g:uctags_use_only_match   = get(g:, 'uctags_use_only_match', 0)

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
      \   'externvar'     : ['c', 'c++'],
      \   'file'          : ['all'],
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
" For target we are using + as the delimiter because in the name of some
"   targets, there is / present.
" TODO WE ONLY WANT TO MATCH THAT OF WHAT IS INSIDE $(), so we can probably
"   disregard some of the FIXMEs
"
" macro for make is already highlightedd by makeIndent, but there is too much
"   that is highlighted by makeIndent
let g:uctags_default_match  =  { 'start' : '/\<',  'end' : '\>/' }
let g:uctags_match_map      = get(g:, 'uctags_match_map', {
      \   'c++'     : { 'member'  : { 'start' : '/\%\(\.\|->\)\<\zs', 'end' : '\>/' }},
      \   'c#'      : { 'method'  : { 'start' : '/\<', 'end' : '\ze\s*\%\((\|<\)/'  }},
      \   'go'      : { 'member'  : g:uctags_default_match },
      \   'javascript'  : { 'method' : { 'start' : '/\<', 'end' : '\%\(\>\|\ze(\)/'}},
      \   'python'  : { 'class'   : { 'start' : '/\<', 'end' : '\ze(/' }},
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
      \   '--fields='               : '*-{roles}{file}',
      \   '--kinds-all='            : '*',
      \   '--kinds-c++='            : '-{header}',
      \   '--kinds-c='              : '-{header}',
      \   '--kinds-cpreprocessor='  : '-{header}',
      \   '--kinds-html='           : '-{heading1}',
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

function! s:ParseMap(expr1, expr2)
  return map(extend(copy(a:expr1), a:expr2), "substitute(v:val, '\W', '', 'g')")
endfunction

let g:uctags_hl_group_map   = s:ParseMap(s:hlg_map, g:uctags_hl_group_map)
let g:uctags_lang_map       = s:ParseMap(s:lang_map, g:uctags_lang_map)
