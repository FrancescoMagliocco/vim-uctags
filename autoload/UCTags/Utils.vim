" File:         Utils.vim
" Last Change:  07/19/2019
" Maintainer:   FrancescoMagliocco

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Utils')
  finish
endif
let g:loaded_UCTags_Utils = 1

let s:lang_map =
      \ [
      \   ['asm', 'nasm', 'fasm', 'masm'],
      \   ['c++', 'cplusplus', 'cpp', 'cc'],
      \   ['c#', 'csharp', 'cs'],
      \   ['javascript', 'jscript', 'js']
      \ ]

function! UCTags#Utils#HaveTagFile(...)
  if !filereadable(a:0 ? a:1 : g:uctags_tags_file)
    echoerr 'No Tags file!'
    finish
  endif

  return 1
endfunction

function! UCTags#Utils#Writefile(lines, file)
  if !g:uctags_use_perl || !has('perl')
    call writefile(a:lines, a:file)
  else
    " scalar context needs to be specified or success will be included
    perl Writefile(scalar VIM::Eval('a:file'), scalar VIM::Eval('a:lines'))
  endif
endfunction

function! UCTags#Utils#GetLang(lang)
  for l:v in s:lang_map
    if count(l:v, a:lang)
      return l:v[0]
      break
    endif
  endfor

  return a:lang
endfunction

function! UCTags#Utils#ToDict(list)
  let l:ret = {}
  for l:i in a:list
    let l:ret[l:i] = ''
  endfor

  return l:ret
endfunction

" COMBAK We need to get the namespace for files we are trying to update the syn
"   file for, and get all tags for that namespace.  This is for cSharp as even
"   code located in a different file, if it has the same namespace, it is valid
"   and accessible in any file that uses that scoped namespace.
function! UCTags#Utils#GetNamespace(file)
    let l:ret = UCTags#Utils#FilterFile(a:file, 'v:val =~#', '^\s*namespace\s*\(\S*\)')
    echomsg map(l:ret, 'split(v:val)[-1]')

endfunction

" Just like UCTags#UtilsFilter(), but expr1 is instead a file.
" lhs is the 'left hand side' of expr2 for filter including the comparison
"   operator.
" rhs is the 'right hand side' of expr2 after the comparison operator.
"
" The reason why we have these separate is because when using Perl, v:val has
"   no meaning, but if using Vim, it does.
" If an optional argument is given, it will be the amount of lines to read from
"   a:file
"
" Example:
"   UCTags#Utils#FilterFile(expand('%'), 'v:val =~#', '^\d', 69)
"   This would be the equivilent to
"     filter(readfile(expand('%'), '', 69), "v:val =~# '^\d'")
function! UCTags#Utils#FilterFile(file, lhs, rhs, ...)
  if !filereadable(a:file) | return [] | endif
  if !g:uctags_use_perl || !has('perl')
    return UCTags#Utils#Filter(
          \ function('UCTags#Utils#Readfile', [a:file] + a:000)(), a:lhs, a:rhs)
  endif

  " FIXME Doens't support range for readfile on Perl side yet
  perl FilterVim(
        \ scalar VIM::Eval('a:rhs'), Readfile(scalar VIM::Eval('a:file')))
endfunction

" XXX Document this because it is confusing
function! UCTags#Utils#Filter(arg1, lhs, rhs)
  if !g:uctags_use_perl || !has('perl')
    return filter(a:arg1, a:lhs . "'" . a:rhs . "'")
  endif

  perl FilterVim(scalar VIM::Eval('a:rhs'), VIM::Eval('a:arg1')))
endfunction

" XXX Document this because it is confusing
function! UCTags#Utils#Readfile(file, ...)
  if !g:uctags_use_perl || !has('perl') || !filereadable(a:file)
    execute 'silent! return readfile(a:file' . (a:0 && a:1 ? ", '', a:1)" : ')')
  endif

  execute "perl ReadfileVim(scalar VIM::Eval('a:file')"
        \ . (a:0 && a:1 ? ", scalar VIM::Eval('a:1'))" : ')')
endfunction

let s:kinds =
      \ {
      \   'ada'                 : ['entryspec', 'taskspec', 'protectspec',
      \     'packspec', 'subprogspec', 'separate', 'typespec', 'subspec',
      \     'varspec', 'autovar', 'label', 'component', 'entry', 'formal',
      \     'identifier', 'task', 'literal', 'constant', 'protected', 'package',
      \     'subprogram', 'type', 'subtype', 'variable', 'exception', 'anon'],
      \   'ansibleplaybook'     : ['play'],
      \   'ant'                 : ['property', 'antfile', 'project', 'target'],
      \   'asciidoc'            : ['subsection', 'l4subsection', 'anchor',
      \     'chapter', 'section', 'subsubsection', 'l5subsection'],
      \   'asm'                 : ['define', 'label', 'macro', 'section',
      \     'type', 'class', 'constant', 'function', 'subroutine', 'variable'],
      \   'autoit'              : ['script', 'func', 'global', 'local',
      \     'region'],
      \   'autoconf'            : ['condition', 'definition', 'optenable',
      \     'macro', 'package', 'subst', 'template', 'optwith'],
      \   'automake'            : ['data', 'library', 'man', 'program',
      \     'script', 'ltlibrary', 'condition', 'directory'],
      \   'awk'                 : ['function'],
      \   'beta'                : ['fragment', 'pattern', 'slot', 'virtual'],
      \   'basic'               : ['constant', 'function', 'enum', 'label',
      \     'type', 'variable'],
      \   'c'                   : ['label', 'macro', 'enumerator', 'function',
      \     'enum', 'header', 'local', 'member', 'prototype', 'struct',
      \     'typedef', 'union', 'variable', 'externvar', 'parameter'],
      \   'c#'                  : ['event', 'class', 'macro', 'enumerator',
      \     'field', 'enum', 'interface', 'local', 'method', 'namespace',
      \     'property', 'struct', 'typedef'],
      \   'c++'                 : ['alias', 'label', 'name', 'using', 'class',
      \     'macro', 'enumerator', 'function', 'enum', 'header', 'local',
      \     'member', 'namespace', 'prototype', 'struct', 'typedef', 'union',
      \     'variable', 'externvar', 'parameter'],
      \   'cmake'               : ['option', 'function', 'macro', 'project',
      \     'regex', 'target', 'variable'],
      \   'cpreprocessor'       : ['macro', 'header'],
      \   'css'                 : ['class', 'id', 'selector'],
      \   'cuda'                : ['label', 'macro', 'enumerator', 'function',
      \     'enum', 'header', 'local', 'member', 'prototype', 'struct',
      \     'typedef', 'union', 'variable', 'externvar', 'parameter'],
      \   'clojure'             : ['function', 'namespace'],
      \   'cobol'               : ['division', 'program', 'sourcefile', 'data',
      \     'fd', 'group', 'paragraph', 'section'],
      \   'ctags'               : ['kind', 'langdef'],
      \   'd'                   : ['module', 'template', 'version', 'mixin',
      \     'alias', 'class', 'enumerator', 'function', 'enum', 'interface',
      \     'local', 'member', 'namespace', 'prototype', 'struct', 'union',
      \     'variable', 'externvar'],
      \   'dbusintrospect'      : ['interface', 'method', 'property', 'signal'],
      \   'dtd'                 : ['entity', 'attribute', 'element', 'notation',
      \     'parameterentity', 'label', 'phandler', 'regex'],
      \   'diff'                : ['deletedfile', 'hunk', 'modifiedfile',
      \     'newfile'],
      \   'dosbatch'            : ['label', 'variable'],
      \   'eiffel'              : ['class', 'feature', 'local'],
      \   'elm'                 : ['alias', 'constructor', 'function', 'module',
      \     'namespace', 'port', 'type'],
      \   'erlang'              : ['macro', 'function', 'module', 'record',
      \     'type'],
      \   'falcon'              : ['class', 'function', 'namespace', 'member',
      \     'variable'],
      \   'flex'                : ['class', 'function', 'method', 'property',
      \     'variable', 'mxtag'],
      \   'fortran'             : ['enum', 'local', 'method', 'enumerator',
      \     'prototype', 'submodule', 'blockdata', 'common', 'entry',
      \     'function', 'interface', 'component', 'label', 'module', 'namelist',
      \     'program', 'subroutine', 'type', 'variable'],
      \   'fypp'                : ['macro'],
      \   'gdbinit'             : ['document', 'definition', 'localvariable',
      \     'toplevelvariable'],
      \   'glade'               : ['class', 'handler', 'id'],
      \   'go'                  : ['anonmember', 'packagename', 'const', 'func',
      \     'interface', 'member', 'package', 'struct', 'type', 'unknown',
      \     'var'],
      \   'html'                : ['anchor', 'heading1', 'heading2',
      \     'heading3'],
      \   'itcl'                : ['common', 'class', 'method', 'procedure',
      \     'variable'],
      \   'iniconf'             : ['key', 'section'],
      \   'json'                : ['array', 'boolean', 'number', 'object',
      \     'string', 'null'],
      \   'java'                : ['annotation', 'class', 'enumconstant',
      \     'field', 'enum', 'interface', 'local', 'method', 'package'],
      \   'javaproperties'      : ['key'],
      \   'javascript'          : ['constant', 'class', 'function', 'generator',
      \     'method', 'property', 'variable'],
      \   'ldscript'            : ['section', 'inputsection', 'symbol',
      \     'version'],
      \   'lisp'                : ['function'],
      \   'lua'                 : ['function'],
      \   'm4'                  : ['macrofile', 'macro'],
      \   'make'                : ['makefile', 'macro', 'target'],
      \   'man'                 : ['section', 'title'],
      \   'markdown'            : ['subsection', 'l4subsection', 'chapter',
      \     'regex', 'section', 'subsubsection', 'l5subsection'],
      \   'matlab'              : ['class', 'function', 'variable'],
      \   'maven2'              : ['artifactid', 'groupid', 'property',
      \     'repositoryid'],
      \   'myrddin'             : ['constant', 'function', 'pkg', 'trait',
      \     'type', 'var'],
      \   'ocaml'               : ['constructor', 'module', 'class',
      \     'exception', 'function', 'method', 'val', 'recordfield', 'type',
      \     'var'],
      \   'objectivec'          : ['field', 'implementation', 'macro',
      \     'protocol', 'class', 'enum', 'function', 'interface', 'method',
      \     'property', 'struct', 'typedef', 'var'],
      \   'oldc'                : ['label', 'class', 'macro', 'enumerator',
      \     'function', 'enum', 'header', 'local', 'member', 'namespace',
      \     'prototype', 'struct', 'typedef', 'union', 'variable', 'externvar'],
      \   'oldc++'              : ['label', 'class', 'macro', 'enumerator',
      \     'function', 'enum', 'header', 'local', 'member', 'namespace',
      \     'prototype', 'struct', 'typedef', 'union', 'variable', 'externvar'],
      \   'php'                 : ['alias', 'class', 'define', 'function',
      \     'interface', 'local', 'namespace', 'trait', 'variable'],
      \   'pascal'              : ['function', 'procedure', 'username'],
      \   'perl'                : ['constant', 'subroutinedeclaration',
      \     'format', 'label', 'package', 'subroutine'],
      \   'perl6'               : ['submethod', 'class', 'grammar', 'method',
      \     'module', 'package', 'role', 'subroutine', 'token', 'rule'],
      \   'plistxml'            : ['key'],
      \   'pod'                 : ['subsection', 'chapter', 'section',
      \     'subsubsection'],
      \   'protobuf'            : ['enumerator', 'field', 'enum', 'message',
      \     'package', 'rpc', 'service'],
      \   'puppetmanifest'      : ['class', 'definition', 'node', 'resource',
      \     'variable'],
      \   'python'              : ['namespace', 'class', 'function', 'module',
      \     'local', 'member', 'variable', 'unknown', 'parameter'],
      \   'pythonloggingconfig' : ['loggersection', 'qualname'],
      \   'qemuhx'              : ['infoitem', 'qmp'],
      \   'qtmoc'               : ['signal', 'property', 'slot'],
      \   'r'                   : ['function', 'globalvar', 'library', 'source',
      \     'functionvar'],
      \   'rexx'                : ['subroutine'],
      \   'rspec'               : ['context', 'describe'],
      \   'restructuredtext'    : ['subsection', 'target', 'chapter', 'section',
      \     'subsubsection'],
      \   'relaxng'             : ['attribute', 'element', 'namedpattern'],
      \   'robot'               : ['keyword', 'testcase', 'variable'],
      \   'rpmspec'             : ['global', 'macro', 'package', 'tag'],
      \   'ruby'                : ['singletonmethod', 'class', 'method',
      \     'module'],
      \   'rust'                : ['macro', 'method', 'implementation',
      \     'enumerator', 'function', 'enum', 'interface', 'field', 'module',
      \     'struct', 'typedef', 'variable'],
      \   'slang'               : ['function', 'namespace'],
      \   'sml'                 : ['functor', 'exception', 'function',
      \     'structure', 'signature', 'type', 'value'],
      \   'sql'                 : ['domain', 'field', 'label', 'package',
      \     'service', 'trigger', 'publication', 'view', 'cursor', 'prototype',
      \     'event', 'function', 'index', 'local', 'synonym', 'procedure',
      \     'record', 'subtype', 'table', 'variable', 'mltable', 'mlconn',
      \     'mlprop'],
      \   'svg'                 : ['id'],
      \   'scheme'              : ['function', 'set'],
      \   'sh'                  : ['alias', 'function', 'heredoc', 'script'],
      \   'systemverilog'       : ['assert', 'class', 'enum', 'interface',
      \     'package', 'modport', 'program', 'prototype', 'property', 'struct',
      \     'typedef', 'covergroup', 'block', 'constant', 'event', 'function',
      \     'module', 'net', 'port', 'register', 'task'],
      \   'systemdunit'         : ['unit'],
      \   'ttcn'                : ['testcase', 'group', 'module', 'modulepar',
      \     'timer', 'altstep', 'const', 'template', 'enum', 'function',
      \     'member', 'port', 'signature', 'type', 'var'],
      \   'tcl'                 : ['namespace', 'procedure'],
      \   'tcloo'               : ['class', 'method'],
      \   'tex'                 : ['subparagraph', 'paragraph', 'subsubsection',
      \     'chapter', 'include', 'label', 'part', 'section', 'subsection'],
      \   'vhdl'                : ['component', 'package', 'subtype',
      \     'constant', 'prototype', 'entity', 'function', 'local', 'procedure',
      \     'record', 'type'],
      \   'vera'                : ['prototype', 'typedef', 'class', 'macro',
      \     'enumerator', 'function', 'enum', 'header', 'interface', 'local',
      \     'member', 'program', 'signal', 'task', 'variable', 'externvar'],
      \   'verilog'             : ['block', 'constant', 'event', 'function',
      \     'module', 'net', 'port', 'register', 'task'],
      \   'vim'                 : ['augroup', 'command', 'function', 'map',
      \     'filename', 'variable'],
      \   'windres'             : ['accelerators', 'bitmap', 'cursor', 'dialog',
      \     'font', 'icon', 'menu', 'version'],
      \   'xslt'                : ['matchedtemplate', 'namedtemplate',
      \     'parameter', 'stylesheet', 'variable'],
      \   'yacc'                : ['label'],
      \   'yaml'                : ['anchor'],
      \   'yumrepo'             : ['repoid'],
      \   'zephir'              : ['alias', 'class', 'define', 'function',
      \     'interface', 'local', 'namespace', 'trait', 'variable']
      \ }

function! UCTags#Utils#HiLink(lang)
  let l:lang = UCTags#Utils#GetLang(a:lang)
  for l:v in s:kinds[l:lang]

    let l:has_key = has_key(g:uctags_match_map, l:lang)
          \ && has_key(g:uctags_match_map[l:lang], l:v)

    if !l:has_key && !has_key(g:uctags_match_map, l:v)
      continue
    endif

    execute 'hi! link' GetGroup(l:lang, l:v) get(g:uctags_kind_to_hlg, l:v, 'errorMsg')
  endfor
endfunction
