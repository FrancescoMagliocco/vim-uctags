" File:         Highlight.vim
" Last Change:  07/31/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Highlight')
  finish
endif
let g:loaded_UCTags_Highlight = 1

let g:uctags_enable_go = get(g:, 'uctags_enable_go', 0)

function! s:UpdateSyn(syn_file)
    echomsg a:syn_file
  if !g:uctags_use_perl || !has('perl')
    let l:buf_syn_file = expand('%') . '.syn'
    " Read the syn file for the current active buffer.
    " If no syn file exists, l:buf_syn is [].
    " If syn file exists, filters out all Vim comments.
    silent! let l:buf_syn =
          \ filter(readfile(l:buf_syn_file), "v:val !~# '^\\s*\\\"'")
    " Reads and iterates through a:syn_file.
    for l:t in readfile(a:syn_file)
      " Syntax of l:t:
      "   syn match {group-name} {pattern}
      "     Example: syn match csClassType /\<FileManager\>/
      " Split l:t on whitespace.
      " Retrives the last item in l:t; the pattern.
      " Escapes all backslashes in pattern.
      " Truncates the first and last character; forwardslashes of pattern.
      " Checks the current buffer for the modified pattern, and store the
      "   results of the match.
      let l:no_match = empty(filter(getline(2, line('$')),
            \ "v:val =~# escape(split(l:t, ' ')[-1], '\')[1:-2]"))

      " If l:buf_syn has l:t, we check the previously stored results, then
      "   continue.
      if count(l:buf_syn, l:t)

        " Before we continue, if the result is there was no match, we remove
        "   l:t from l:buf_syn, then continue.
        if l:no_match | call filter(l:buf_syn, 'v:val !=# l:t') | endif
        continue
      endif

      " If the previously stored results is there was no match, we continue.
      if l:no_match | continue | endif

      " Current buffer has match, add l:t to l:buf_syn.
      call add(l:buf_syn, l:t)
    endfor

    " Write l:buf_syn to the syn file for the current buffer.
    call writefile(l:buf_syn, l:buf_syn_file)
  else
    perl UpdateSyn(scalar VIM::Eval('a:syn_file'))
  endif
endfunction

function! s:SearchPython(src_file)
    let l:dir =
          \ substitute(
          \   substitute(a:src_file, '^\s*from\s\+\(\S\+\)\+.*', '\1', 'g'),
          \   '\.', '/', 'g')
    if isdirectory(l:dir)
      if filereadable(l:dir . '.py') | echomsg 'Readable' l:dir . '.py' | endif
      let l:ret =
            \ filter(
            \   map(
            \     split(
            \       substitute(
            \         a:src_file,
            \         '^\s*from\s\+[a-zA-Z0-9._]\+\s\+import\s\+\(.\+\)\+$',
            \         '\1',
            \         'g'
            \       ), ',\s*'),
            \     "[0, l:dir . '/' . split(v:val)[0] . '.py']"
            \   ), 'filereadable(v:val[1])')
      if filereadable(l:dir . '/__main__.py')
        let l:ret = [[0, l:dir . '/__main__.py']] + l:ret
      endif

      if filereadable(l:dir . '/__init__.py')
        let l:ret = [[0, l:dir . '/__init__.py']] + l:ret
      endif

      return l:ret
    elseif filereadable(l:dir . '.py')
      return [[0, l:dir . '.py']]
    endif
endfunction

function! s:SearchJava(src_file)
  "echomsg a:src_file
  "let l:ret = uniq(sort(map(filter(UCTags#Tags#Kind('package'), 'v:val[0] ==# a:src_file[:-2]'), 'v:val[1]')))
  let l:ret = filter(UCTags#Tags#Kind('package'), 'v:val[0] ==# a:src_file[:-2]')
  let l:split = split(a:src_file[:-2], '\.')
  call uniq(sort(extend(l:ret, filter(filter(UCTags#Tags#Kind('package'), "v:val[0] ==# join(l:split[:-2], '.')"), "v:val[0] ==# '" . l:split[-1] . ".java'"))))
  echomsg l:ret
  return l:ret

endfunction

" TODO Rename
" TODO Document this
" For cs, gets all tags of kind 'namespace'
let s:search =
      \ {
      \   'cpp' : 'let l:ret = filter(filter(UCTags#Tags#GetTags(), '
      \     . "'v:val[1] =~# a:1'), \"v:val[0] ==# split(a:2, '/')[-1]\")",
      \   'c'   : 'let l:ret = filter(filter(UCTags#Tags#GetTags(), '
      \     . "'v:val[1] =~# a:1'), \"v:val[0] ==# split(a:2, '/')[-1]\")",
      \   'cs'  : "let l:ret = filter(UCTags#Tags#Kind('namespace'), "
      \     . "\"v:val[0] ==# '\" . a:2[:-2 + (a:2[-1:] !=# ';')] . \"'\")",
      \   'python' : 'let l:ret = s:SearchPython(a:2)',
      \   'java'  : 'let l:ret = s:SearchJava(a:2)'
      \ }

"let s:search =
"      \ {
"      \   'cpp' : "let l:ret = filter(UCTags#Tags#Kind('header'), "
"      \     . "'v:val[1] ==# a:2')",
"      \   'c'   : "let l:ret = filter(UCTags#Tags#Kind('header'), "
"      \     . "'v:val[1] =~# a:1')",
"      \   'cs'  : "let l:ret = filter(UCTags#Tags#Kind('namespace'), "
"      \     . "\"v:val[0] ==# '\" . a:2[:-2 + (a:2[-1:] !=# ';')] . \"'\")",
"      \   'python' : 'let l:ret = s:SearchPython(a:2)',
"      \   'java'  : 'let l:ret = s:SearchJava(a:2)'
"      \ }
" TODO Needs to be renamed
"
function! s:UpdateSynFilter(...)
  " TODO Use Log namespace
  " Just incase less than 2 argments are given
  if a:0 < 2 | echoer 'Need 2 arguments!' | endif
  if !g:uctags_use_perl || !has('perl') || &ft ==# 'java'
    let l:ret = [[]]
    " Updates l:ret
    execute s:search[&ft]
    " The previous execution can result in a empty list.  The caller needs a 2
    "   dimentinal list returned.
    return empty(l:ret) ? [[]] : l:ret
  endif

  perl UpdateSynFilter(
        \ scalar VIM::Eval('a:1'),
        \ scalar VIM::Eval('a:2'),
        \ scalar VIM::Eval('&ft'))
  " If @lines in Perl is empty, Perl returns (Not using VIM::DoCommand()), so
  "   we return a list of an empty list.
  return [[]]
endfunction

" TODO Rename
" Languages that use include directives, namespaces etc..
let s:inc_lan = ['cpp', 'c', 'asm', 'cs', 'python', 'java']

" TODO Rename
" Pattern used to find include direcetives, namespaces etc.. of the given
"   language.
let s:pat_lang =
      \ {
      \   'asm'     : ['%include'],
      \   'cpp'     : ['\s*#\s*include\s\+"\{1\}.*"\{1\}', '#\s*include'],
      \   'c'       : ['\s*#\s*include\s\+"\{1\}.*"\{1\}', '#\s*include'],
      \   'go'      : ['import'],
      \   'cs'      :
      \     ['using\s\+.*;', '\s*namespace\s\+', '\%\(using\|namespace\)'],
      \   'python'  : [
      \     '^\s*import\s\+[a-zA-Z0-9._]\+',
      \     '^\s*from\s\+[a-zA-Z0-9._]\+\s\+import\s.\+$',
      \     '\%\(^\s*from\|\%\(^\s*\|\s\+\)import\)\s\+'],
      \   'java'    : ['\s*import\s\+[a-zA-Z0-9.]\+;', '\s*package\s\+[a-zA-Z0-9.]\+;', '\%\(package\|import\)']
      \ }

" TODO Document
" Updates the syn file for the current buffer.  This function does not actually
"   do the updating of the syn file, and barely even handles the syn file.
" When using the command UpdateSynFile, a:src_file is specified with
"   expand('%').  That is the FIRST call.  Calling this function with any other
"   filename, you will not get desired results because where the updating of
"   the actual syn file happens (s:UpdateSyn()), the way the syn file is
"   located, is done the same way with expand('%').
" All recursive calls after the FIRST call, a:src_file will be a filename that
"   is specified in the tags file.
" a:1 is l:sourced_syn
function! s:UpdateSynFor(src_file, ...)
  if &ft ==? 'go' && !g:uctags_enable_go | return | endif
  " TODO Document
  " TODO Use Log namespace
  if assert_false(g:uctags_max_syn && a:0 && a:1 >= g:uctags_max_syn, s:max_syn_msg)
    if g:uctags_verbose
      echohl warningMsg | echomsg v:errors[-1] | echohl None
    endif

    return
  endif
  let l:a2 = a:0 ? copy(a:2) : []
  let l:used_src_files = a:0 ? a:3 : []

  let l:is_cs       = &ft ==? 'cs'
  let l:sourced_syn = a:0 ? a:1 : 0

  " Remove quotes
  let l:src_file  = substitute(a:src_file, "\\(\"\\|\'\\)", '', 'g')
  let l:is_py = &ft ==? 'python'
  let l:is_java = &ft ==? 'java'

  let l:src_syn_file = l:src_file . '.syn'
  let l:ofile = a:0 ? a:4 : a:src_file
  if !count(s:inc_lan, tolower(&ft))
    " Current language doesn't support include directives.
    return l:src_syn_file
  " Current language supports include directives
  elseif filereadable(l:src_syn_file)
    if !count(l:used_src_files, l:src_file)
      " Found syn file for a:src_file; update it
      call s:UpdateSyn(l:src_syn_file)
      let l:sourced_syn += 1
      call add(l:used_src_files, l:src_file)
    endif
  else

    " Can't find syn file for a:src_file
    " During the FIRST call,
    " Escapes special characters
    let l:safe_src_file = escape(l:src_file, '^.$\*')
    " Try to find
    let l:lines = s:UpdateSynFilter(l:safe_src_file, l:src_file)
    if empty(l:lines[0]) | return | endif

    for l:f in l:is_cs || l:is_py || l:is_java ? l:lines : l:lines[-1:1]
      let l:src_file      = l:f[1]
      let l:src_syn_file  = l:src_file . '.syn'
      if filereadable(l:src_syn_file)
        if !count(l:used_src_files, l:src_file)
          call s:UpdateSyn(l:src_syn_file)
          let l:sourced_syn += 1
          call add(l:used_src_files, l:src_file)
        endif
      endif
    endfor
  endif

  if l:is_java && a:src_file !=# l:ofile | return | endif

  for l:f in exists('l:lines') && (l:is_cs || l:is_py || l:is_java)
        \ ? l:lines
        \ : [[0, l:src_file]]
    let l:src_file = l:f[1]
    if !filereadable(l:src_file) | return | endif
    let l:pat   = s:pat_lang[&ft]
    let l:list  = []

    for l:p in l:pat[:-2 + len(l:pat) == 1]
      " XXX COMBAK XXX Instead of a:2, it may be better to use l:used_src_files
      call extend(l:list, filter(UCTags#Utils#FilterFile(l:src_file, 'v:val =~#', l:p), '!count(l:a2, v:val)'))
    endfor

    " We are going to change the meaning of a:2; a:2 is now going to be header
    "   header files that we have already grabbed headers from!  Not headers
    "   that we have compared the tags against the source file.
    " This feature wont be implemented with the first commit changing a:2 to
    "   l:a2.  It shouldl be implemented in the commit after that.
    for l:src_file in l:list
      if a:0 && count(a:2, l:src_file) | continue | endif
      call s:UpdateSynFor(substitute(
            \   l:src_file, '^.*' . l:pat[-1] . '\s\+', '', 'g'),
            \ l:sourced_syn, extend(l:a2, [l:src_file]), l:used_src_files, l:ofile)
    endfor
  endfor

  return l:src_syn_file
endfunction

function! UCTags#Highlight#UpdateSynFile(file)
  echomsg 'Doing shit..  This may be a while'
  execute 'source' s:UpdateSynFor(a:file)

endfunction

let s:max_syn_msg = 'Max amount of sourced syn files for a particular file reached'

" Iterates through each tag in a:tags.  Filters out all tags that {kind} isn't
"   present in g:uctags_kind_to_hlg
function! UCTags#Highlight#CreateSynFiles(tags)
  let l:index = g:uctags_use_readtags ? 4 : 5
  " COMBAK Revise
  let l:skip =
        \ 'has_key(g:uctags_skip_kind_for, tolower(v:val[3][5:]))'
        \ . '? !count(g:uctags_skip_kind_for[tolower(v:val[3][5:])],'
        \     . 'tolower(v:val[l:index][9:])) '
        \   . "&& !count(g:uctags_skip_kind_for[tolower(v:val[3][5:])], 'all')"
        \ . ': 1'
  let l:file  = ''
  let l:lines = []

  " Filters through a:tags accepting tags where the {kind} of tag is present
  "   present in dictionary g:uctags_kind_to_hlg as a key.  We do this because
  "   we only want to accept tags that have a highlight group to be linked to.
  " Filter through the results of the previous filter, only accepting tags
  "   that obey the following condition:
  "     The {kind} of tag not be present in dictionary g:uctags_skip_kind_for
  "     If {kind} of tag is present in dictionary g:uctags_skip_kind_for, the
  "       language for the corresponding tag can't be present in the dictionary
  "       g:uctags_skip_kind_for[{kind}]
  " Iterates through the results of the previous filter.
  " We read the syn file of the current tag of the iteration and store each
  "   line in a list using readfile().  If the syn file doesn't exists, an
  "   empty list will represent said syn file.
  " A group-name for {kind} is generated by first search g:uctags_lang_map for
  "   language of the current tag and using the value that the language is
  "   mapped to.  If there isn't one, the language is used as is.  Then we do
  "   the same for {kind}; g:uctags_hl_group_map is searched for {kind}, and
  "   the value that {kind} maps to (Or using {kind} itself if there isn't one)
  "   and concoatinate the result to the result of the language for the current
  "   tag.
  " If g:uctags_match_map has the language of the current tag as a key and
  "   g:uctags_match_map[{language}] has {kind} as a key, a positive result is
  "   stored.  Otherwise negative results are stored.
  "
  "   If negaitve results were store, and g:uctags_match_map doesn't have
  "   {kind} as a key, the current iteration is skipped and continued onto the
  "   next iteration.
  "
  " A match for current iterated tag {kind} is built.  The start and end part
  "   of the match is retrieved from the dictionary g:uctags_match_map using
  "   the results of the previous check.
  "
  "   {kind} is used as a key to retrieve the pattern for the start and end of
  "   the match.
  "
  "   If the results from the previous check were positive, the pattern is
  "   retrieved from g:uctags_match_map[{language}].  If thy were negative, the
  "   pattern is retrieved from g:uctags_match_map.
  "
  "   The middle of the match; the actual 'tag' is at index 0 of the current
  "   iterated tag.
  " A link is built to link the previously generated group-name to a unambigious
  "   highlight group retrieved from g:uctags_kind_to_hlg using {kind} as a
  "   key.
  " The built match is added to a list of matches.
  " The built link is executed.
        "\ filter(a:tags, 'has_key(g:uctags_kind_to_hlg, tolower(v:val[3][5:]))'),
  let l:tags = filter(a:tags, l:skip)
  " Use keyword for kinds that have only keyword characters, and use match for
  "   kinds that contain keyword and non keyword characters.
  let l:use_keyword       = g:uctags_use_keyword && !g:uctags_use_only_match

  " Use keyword for kinds that have only keyword characters, and skip kinds
  "   that have non keyword characters.
  let l:use_only_keyword  = l:use_keyword && g:uctags_skip_non_keyword
  " if l:use_only_keyword, kinds that contain non keyword characters are
  "   skipped; otherwise all kinds are passed.
  for l:v in l:use_only_keyword
        \ ? filter(l:tags, "!(l:use_only_keyword && v:val[0] !~? '^\k\+$')")
        \ : l:tags

    " TODO Rename
    let l:tfile   = l:v[1]
    if empty(l:file)
      let l:file  = l:tfile . '.syn'
    endif

    if l:file !=# l:tfile
      if !empty(l:lines)
        call UCTags#Utils#Writefile(uniq(sort(l:lines)), l:file)
      endif

      let l:file  = l:tfile . '.syn'
      let l:lines = UCTags#Utils#Readfile(l:file)
    endif

    let l:kind  = tolower(l:v[3][5:])
    let l:lang  = tolower(l:v[l:index][9:])
    let l:group = GetGroup(l:lang, l:kind)

    " Don't forget the space
    let l:command = 'keyword '
    let l:tag     = l:v[0]
    if !l:use_only_keyword
      let l:has_key = has_key(g:uctags_match_map, l:lang)
            \ && has_key(g:uctags_match_map[l:lang], l:kind)

      let l:match   = !l:has_key && !has_key(g:uctags_match_map, l:kind)
            \ ? g:uctags_default_match
            \ : get(l:has_key
            \   ? g:uctags_match_map[l:lang]
            \   : g:uctags_match_map, l:kind)

      let l:is_keyword  = l:tag =~? '^\k\+$'
      " Use keyword if l:use_keyword and l:is_keyword only if
      "   g:uctags_use_keyword_over_match or l:match equals
      "   g:uctags_default_match
      let l:use_keyword = l:use_keyword && l:is_keyword
            \ && (g:uctags_use_keyword_over_match
            \   || l:match == g:uctags_default_match)
      " Don't forget the space
      let l:command = l:use_keyword ? l:command : 'match '
      let l:tag     = l:use_keyword
            \ ? l:tag
            \ : l:match.start . escape(l:tag, '$.*~\^[]/') . l:match.end
    endif

    " if l:use_keyword and l:tag contains only keyword characters, use `syn
    "   keyword`, otherwise use `syn match`
    " If l:use_only_keyword or l:use_keyword, use `syn keyword`
    let l:syn =  'syn ' . l:command . l:group . ' ' . l:tag
      call add(l:lines, l:syn)
  endfor

  if !empty(l:lines)
    call UCTags#Utils#Writefile(uniq(sort(l:lines)), l:file)
  endif
endfunction
