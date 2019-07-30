" File:         Utils.vim
" Last Change:  07/29/2019
" Maintainer:   FrancescoMagliocco

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Utils')
  finish
endif
let g:loaded_UCTags_Utils = 1

let s:lang_maps =
      \ [
      \   ['Ada', 'ada'],
      \   ['AnsiblePlaybook', 'ansibleplaybook'],
      \   ['Ant', 'ant'],
      \   ['Asciidoc', 'asciidoc'],
      \   ['Asm', 'asm', 'nasm', 'fasm', 'masm'],
      \   ['Asp', 'asp'],
      \   ['AutoIt', 'autoit'],
      \   ['Autoconf', 'autoconf'],
      \   ['Automake', 'automake'],
      \   ['Awk', 'awk'],
      \   ['BETA', 'beta'],
      \   ['Basic', 'basic'],
      \   ['C#', 'c#', 'csharp', 'cs'],
      \   ['C', 'c'],
      \   ['C++', 'c++', 'cplusplus', 'cpp', 'cc'],
      \   ['CMake', 'cmake'],
      \   ['CPreProcessor', 'cpreprocessor'],
      \   ['CSS', 'css'],
      \   ['CUDA', 'cuda'],
      \   ['Clojure', 'clojure'],
      \   ['Cobol', 'cobol'],
      \   ['Ctags', 'ctags'],
      \   ['D', 'd'],
      \   ['DBusIntrospect', 'dbusintrospect'],
      \   ['DTD', 'dtd'],
      \   ['DTS', 'dts'],
      \   ['Diff', 'diff'],
      \   ['DosBatch', 'dosbatch'],
      \   ['Eiffel', 'eiffel'],
      \   ['Elm', 'elm'],
      \   ['Erlang', 'erlang'],
      \   ['Falcon', 'falcon'],
      \   ['Flex', 'flex'],
      \   ['Fortran', 'fortran'],
      \   ['Fypp', 'fypp'],
      \   ['Gdbinit', 'gdbinit'],
      \   ['Glade', 'glade'],
      \   ['Go', 'go'],
      \   ['HTML', 'html'],
      \   ['ITcl', 'itcl'],
      \   ['Iniconf', 'iniconf'],
      \   ['JSON', 'json'],
      \   ['Java', 'java'],
      \   ['JavaProperties', 'javaproperties'],
      \   ['JavaScript', 'javascript', 'jscript', 'js'],
      \   ['LdScript', 'ldscript'],
      \   ['Lisp', 'lisp'],
      \   ['Lua', 'lua'],
      \   ['M4', 'm4'],
      \   ['Make', 'make'],
      \   ['Man', 'man'],
      \   ['Markdown', 'markdown'],
      \   ['MatLab', 'matlab'],
      \   ['Maven2', 'maven2'],
      \   ['Myrddin', 'myrddin'],
      \   ['OCaml', 'ocaml'],
      \   ['ObjectiveC', 'objectivec'],
      \   ['OldC', 'oldc'],
      \   ['OldC++', 'oldc++', 'oldcplusplus'],
      \   ['PHP', 'php'],
      \   ['Pascal', 'pascal'],
      \   ['Passwd', 'passwd'],
      \   ['Perl', 'perl'],
      \   ['Perl6', 'perl6'],
      \   ['PlistXML', 'plistxml'],
      \   ['Pod', 'pod'],
      \   ['Protobuf', 'protobuf'],
      \   ['PuppetManifest', 'puppetmanifest'],
      \   ['Python', 'python'],
      \   ['PythonLoggingConfig', 'pythonloggingconfig'],
      \   ['QemuHX', 'qemuhx'],
      \   ['QtMoc', 'qtmoc'],
      \   ['R', 'r'],
      \   ['REXX', 'rexx'],
      \   ['RSpec', 'rspec'],
      \   ['ReStructuredText', 'restructuredtext'],
      \   ['RelaxNG', 'relaxng'],
      \   ['Robot', 'robot'],
      \   ['RpmSpec', 'rpmspec'],
      \   ['Ruby', 'ruby'],
      \   ['Rust', 'rust'],
      \   ['SLang', 'slang'],
      \   ['SML', 'sml'],
      \   ['SQL', 'sql'],
      \   ['SVG', 'svg'],
      \   ['Scheme', 'scheme'],
      \   ['Sh', 'sh'],
      \   ['SystemVerilog', 'systemverilog'],
      \   ['SystemdUnit', 'systemdunit'],
      \   ['TTCN', 'ttcn'],
      \   ['Tcl', 'tcl'],
      \   ['TclOO', 'tcloo'],
      \   ['Tex', 'tex'],
      \   ['VHDL', 'vhdl'],
      \   ['Vera', 'vera'],
      \   ['Verilog', 'verilog'],
      \   ['Vim', 'vim'],
      \   ['WindRes', 'windres'],
      \   ['XSLT', 'xslt'],
      \   ['YACC', 'yacc'],
      \   ['Yaml', 'yaml'],
      \   ['YumRepo', 'yumrepo'],
      \   ['Zephir', 'zephir'],
      \ ]

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
  for l:v in s:lang_maps
    if count(l:v, a:lang)
      return l:v[0]
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
      \   'Ada'                 : ['entryspec', 'taskspec', 'protectspec',
      \     'packspec', 'subprogspec', 'separate', 'typespec', 'subspec',
      \     'varspec', 'autovar', 'label', 'component', 'entry', 'formal',
      \     'identifier', 'task', 'literal', 'constant', 'protected', 'package',
      \     'subprogram', 'type', 'subtype', 'variable', 'exception', 'anon'],
      \   'AnsiblePlaybook'     : ['play'],
      \   'Ant'                 : ['property', 'antfile', 'project', 'target'],
      \   'Asciidoc'            : ['subsection', 'l4subsection', 'anchor',
      \     'chapter', 'section', 'subsubsection', 'l5subsection'],
      \   'Asm'                 : ['define', 'label', 'macro', 'section',
      \     'type', 'class', 'constant', 'function', 'subroutine', 'variable'],
      \   'AutoIt'              : ['script', 'func', 'global', 'local',
      \     'region'],
      \   'Autoconf'            : ['condition', 'definition', 'optenable',
      \     'macro', 'package', 'subst', 'template', 'optwith'],
      \   'Automake'            : ['data', 'library', 'man', 'program',
      \     'script', 'ltlibrary', 'condition', 'directory'],
      \   'Awk'                 : ['function'],
      \   'BETA'                : ['fragment', 'pattern', 'slot', 'virtual'],
      \   'Basic'               : ['constant', 'function', 'enum', 'label',
      \     'type', 'variable'],
      \   'C'                   : ['label', 'macro', 'enumerator', 'function',
      \     'enum', 'header', 'local', 'member', 'prototype', 'struct',
      \     'typedef', 'union', 'variable', 'externvar', 'parameter'],
      \   'C#'                  : ['event', 'class', 'macro', 'enumerator',
      \     'field', 'enum', 'interface', 'local', 'method', 'namespace',
      \     'property', 'struct', 'typedef'],
      \   'C++'                 : ['alias', 'label', 'name', 'using', 'class',
      \     'macro', 'enumerator', 'function', 'enum', 'header', 'local',
      \     'member', 'namespace', 'prototype', 'struct', 'typedef', 'union',
      \     'variable', 'externvar', 'parameter'],
      \   'CMake'               : ['option', 'function', 'macro', 'project',
      \     'regex', 'target', 'variable'],
      \   'CPreProcessor'       : ['macro', 'header'],
      \   'CSS'                 : ['class', 'id', 'selector'],
      \   'CUDA'                : ['label', 'macro', 'enumerator', 'function',
      \     'enum', 'header', 'local', 'member', 'prototype', 'struct',
      \     'typedef', 'union', 'variable', 'externvar', 'parameter'],
      \   'Clojure'             : ['function', 'namespace'],
      \   'Cobol'               : ['division', 'program', 'sourcefile', 'data',
      \     'fd', 'group', 'paragraph', 'section'],
      \   'Ctags'               : ['kind', 'langdef'],
      \   'D'                   : ['module', 'template', 'version', 'mixin',
      \     'alias', 'class', 'enumerator', 'function', 'enum', 'interface',
      \     'local', 'member', 'namespace', 'prototype', 'struct', 'union',
      \     'variable', 'externvar'],
      \   'DBusIntrospect'      : ['interface', 'method', 'property', 'signal'],
      \   'DTD'                 : ['entity', 'attribute', 'element', 'notation',
      \     'parameterentity', 'label', 'phandler', 'regex'],
      \   'Diff'                : ['deletedfile', 'hunk', 'modifiedfile',
      \     'newfile'],
      \   'DosBatch'            : ['label', 'variable'],
      \   'Eiffel'              : ['class', 'feature', 'local'],
      \   'Elm'                 : ['alias', 'constructor', 'function', 'module',
      \     'namespace', 'port', 'type'],
      \   'Erlang'              : ['macro', 'function', 'module', 'record',
      \     'type'],
      \   'Falcon'              : ['class', 'function', 'namespace', 'member',
      \     'variable'],
      \   'Flex'                : ['class', 'function', 'method', 'property',
      \     'variable', 'mxtag'],
      \   'Fortran'             : ['enum', 'local', 'method', 'enumerator',
      \     'prototype', 'submodule', 'blockdata', 'common', 'entry',
      \     'function', 'interface', 'component', 'label', 'module', 'namelist',
      \     'program', 'subroutine', 'type', 'variable'],
      \   'Fypp'                : ['macro'],
      \   'Gdbinit'             : ['document', 'definition', 'localvariable',
      \     'toplevelvariable'],
      \   'Glade'               : ['class', 'handler', 'id'],
      \   'Go'                  : ['anonmember', 'packagename', 'const', 'func',
      \     'interface', 'member', 'package', 'struct', 'type', 'unknown',
      \     'var'],
      \   'HTML'                : ['anchor', 'heading1', 'heading2',
      \     'heading3'],
      \   'ITcl'                : ['common', 'class', 'method', 'procedure',
      \     'variable'],
      \   'Iniconf'             : ['key', 'section'],
      \   'JSON'                : ['array', 'boolean', 'number', 'object',
      \     'string', 'null'],
      \   'Java'                : ['annotation', 'class', 'enumconstant',
      \     'field', 'enum', 'interface', 'local', 'method', 'package'],
      \   'JavaproPerties'      : ['key'],
      \   'JavaScript'          : ['constant', 'class', 'function', 'generator',
      \     'method', 'property', 'variable'],
      \   'LdScript'            : ['section', 'inputsection', 'symbol',
      \     'version'],
      \   'Lisp'                : ['function'],
      \   'Lua'                 : ['function'],
      \   'M4'                  : ['macrofile', 'macro'],
      \   'Make'                : ['makefile', 'macro', 'target'],
      \   'Man'                 : ['section', 'title'],
      \   'Markdown'            : ['subsection', 'l4subsection', 'chapter',
      \     'regex', 'section', 'subsubsection', 'l5subsection'],
      \   'MatLab'              : ['class', 'function', 'variable'],
      \   'Maven2'              : ['artifactid', 'groupid', 'property',
      \     'repositoryid'],
      \   'Myrddin'             : ['constant', 'function', 'pkg', 'trait',
      \     'type', 'var'],
      \   'OCaml'               : ['constructor', 'module', 'class',
      \     'exception', 'function', 'method', 'val', 'recordfield', 'type',
      \     'var'],
      \   'ObjectiveC'          : ['field', 'implementation', 'macro',
      \     'protocol', 'class', 'enum', 'function', 'interface', 'method',
      \     'property', 'struct', 'typedef', 'var'],
      \   'OldC'                : ['label', 'class', 'macro', 'enumerator',
      \     'function', 'enum', 'header', 'local', 'member', 'namespace',
      \     'prototype', 'struct', 'typedef', 'union', 'variable', 'externvar'],
      \   'OldC++'              : ['label', 'class', 'macro', 'enumerator',
      \     'function', 'enum', 'header', 'local', 'member', 'namespace',
      \     'prototype', 'struct', 'typedef', 'union', 'variable', 'externvar'],
      \   'PHP'                 : ['alias', 'class', 'define', 'function',
      \     'interface', 'local', 'namespace', 'trait', 'variable'],
      \   'Pascal'              : ['function', 'procedure', 'username'],
      \   'Perl'                : ['constant', 'subroutinedeclaration',
      \     'format', 'label', 'package', 'subroutine'],
      \   'Perl6'               : ['submethod', 'class', 'grammar', 'method',
      \     'module', 'package', 'role', 'subroutine', 'token', 'rule'],
      \   'Plistxml'            : ['key'],
      \   'Pod'                 : ['subsection', 'chapter', 'section',
      \     'subsubsection'],
      \   'Protobuf'            : ['enumerator', 'field', 'enum', 'message',
      \     'package', 'rpc', 'service'],
      \   'PuppetManifest'      : ['class', 'definition', 'node', 'resource',
      \     'variable'],
      \   'Python'              : ['namespace', 'class', 'function', 'module',
      \     'local', 'member', 'variable', 'unknown', 'parameter'],
      \   'PythonLoggingConfig' : ['loggersection', 'qualname'],
      \   'QemuHX'              : ['infoitem', 'qmp'],
      \   'QtMoc'               : ['signal', 'property', 'slot'],
      \   'R'                   : ['function', 'globalvar', 'library', 'source',
      \     'functionvar'],
      \   'REXX'                : ['subroutine'],
      \   'RSpec'               : ['context', 'describe'],
      \   'ReStructuredText'    : ['subsection', 'target', 'chapter', 'section',
      \     'subsubsection'],
      \   'Relaxng'             : ['attribute', 'element', 'namedpattern'],
      \   'Robot'               : ['keyword', 'testcase', 'variable'],
      \   'RpmSpec'             : ['global', 'macro', 'package', 'tag'],
      \   'Ruby'                : ['singletonmethod', 'class', 'method',
      \     'module'],
      \   'Rust'                : ['macro', 'method', 'implementation',
      \     'enumerator', 'function', 'enum', 'interface', 'field', 'module',
      \     'struct', 'typedef', 'variable'],
      \   'SLang'               : ['function', 'namespace'],
      \   'SML'                 : ['functor', 'exception', 'function',
      \     'structure', 'signature', 'type', 'value'],
      \   'SQL'                 : ['domain', 'field', 'label', 'package',
      \     'service', 'trigger', 'publication', 'view', 'cursor', 'prototype',
      \     'event', 'function', 'index', 'local', 'synonym', 'procedure',
      \     'record', 'subtype', 'table', 'variable', 'mltable', 'mlconn',
      \     'mlprop'],
      \   'SVG'                 : ['id'],
      \   'Scheme'              : ['function', 'set'],
      \   'Sh'                  : ['alias', 'function', 'heredoc', 'script'],
      \   'SystemVerilog'       : ['assert', 'class', 'enum', 'interface',
      \     'package', 'modport', 'program', 'prototype', 'property', 'struct',
      \     'typedef', 'covergroup', 'block', 'constant', 'event', 'function',
      \     'module', 'net', 'port', 'register', 'task'],
      \   'SystemdUnit'         : ['unit'],
      \   'TTCN'                : ['testcase', 'group', 'module', 'modulepar',
      \     'timer', 'altstep', 'const', 'template', 'enum', 'function',
      \     'member', 'port', 'signature', 'type', 'var'],
      \   'Tcl'                 : ['namespace', 'procedure'],
      \   'TclOO'               : ['class', 'method'],
      \   'Tex'                 : ['subparagraph', 'paragraph', 'subsubsection',
      \     'chapter', 'include', 'label', 'part', 'section', 'subsection'],
      \   'VHDL'                : ['component', 'package', 'subtype',
      \     'constant', 'prototype', 'entity', 'function', 'local', 'procedure',
      \     'record', 'type'],
      \   'Vera'                : ['prototype', 'typedef', 'class', 'macro',
      \     'enumerator', 'function', 'enum', 'header', 'interface', 'local',
      \     'member', 'program', 'signal', 'task', 'variable', 'externvar'],
      \   'Verilog'             : ['block', 'constant', 'event', 'function',
      \     'module', 'net', 'port', 'register', 'task'],
      \   'Vim'                 : ['augroup', 'command', 'function', 'map',
      \     'filename', 'variable'],
      \   'WindRes'             : ['accelerators', 'bitmap', 'cursor', 'dialog',
      \     'font', 'icon', 'menu', 'version'],
      \   'XSLT'                : ['matchedtemplate', 'namedtemplate',
      \     'parameter', 'stylesheet', 'variable'],
      \   'YACC'                : ['label'],
      \   'Yaml'                : ['anchor'],
      \   'YumRepo'             : ['repoid'],
      \   'Zephir'              : ['alias', 'class', 'define', 'function',
      \     'interface', 'local', 'namespace', 'trait', 'variable']
      \ }

function! UCTags#Utils#HiLink(lang)
  let l:lang = UCTags#Utils#GetLang(a:lang)
  for l:v in s:kinds[l:lang]
    let l:lang = tolower(l:lang)

    let l:has_key = has_key(g:uctags_match_map, l:lang)
          \ && has_key(g:uctags_match_map[l:lang], l:v)

    if !l:has_key && !has_key(g:uctags_match_map, l:v)
      continue
    endif

    execute 'hi! link' GetGroup(l:lang, l:v) get(g:uctags_kind_to_hlg, l:v, 'errorMsg')
  endfor
endfunction
