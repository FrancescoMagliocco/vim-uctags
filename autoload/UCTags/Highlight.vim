" File:         Highlight.vim
" Last Change:  08/08/2019
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

" TODO There is a lot of counting and adding going on, we can save some lines
"   by creating a function to do both for us.

" COMBAK There is a Perl variant of this, but it is only used when
"   UpdateSynFilter is called, but we aren't calling it anymore.  I'm not sure
"   if the Perl variant of this is more efficient and faster than this or not.
function! s:SearchPython(src_file)
  let l:ret = []
  for l:src_file in a:src_file
    let l:src_file = l:src_file[2]
    let l:dir =
          \ substitute(
          \   substitute(l:src_file, '^.*from\s\+\(\S\+\)\+.*', '\1', 'g'),
          \   '\.', '/', 'g')
    if isdirectory(l:dir)
      if filereadable(l:dir . '.py') | echomsg 'Readable' l:dir . '.py' | endif
      let l:reta =
            \ filter(
            \   map(
            \     split(
            \       substitute(
            \         l:src_file,
            \         'from\s\+[a-zA-Z0-9._]\+\s\+import\s\+\(.\+\)\+$',
            \         '\1',
            \         'g'
            \       ), ',\s*'),
            \     "[l:dir . '/' . split(v:val)[0] . '.py']"
            \   ), 'filereadable(v:val[0])')
      if !count(l:ret, l:reta)
        if type(l:reta) == v:t_list
          call extend(l:ret, filter(l:reta, '!count(l:ret, v:val)'))

        else
          call add(l:ret, l:reta)
        endif
      endif
      if filereadable(l:dir . '/__main__.py')
        let l:reta = [l:dir . '/__main__.py']
        if !count(l:ret, l:reta)
          call add(l:ret, l:reta)
        endif
      endif

      if filereadable(l:dir . '/__init__.py')
        let l:reta = [l:dir . '/__init__.py']
        if !count(l:ret, l:reta)
          call add(l:ret, l:reta)
        endif
      endif

    elseif filereadable(l:dir . '.py')
      let l:reta = [l:dir . '.py']
      if !count(l:ret, l:reta)
        call add(l:ret, l:reta)
      endif
    endif
  endfor
    return l:ret
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

" We probably don't need this anymore
" TODO Rename
" TODO Document this
" For cs, gets all tags of kind 'namespace'
"let s:search =
"      \ {
"      \   'cpp' : 'let l:ret = filter(filter(UCTags#Tags#GetTags(), '
"      \     . "'v:val[1] =~# a:1'), \"v:val[0] ==# split(a:2, '/')[-1]\")",
"      \   'c'   : 'let l:ret = filter(filter(UCTags#Tags#GetTags(), '
"      \     . "'v:val[1] =~# a:1'), \"v:val[0] ==# split(a:2, '/')[-1]\")",
"      \   'cs'  : "let l:ret = filter(UCTags#Tags#Kind('namespace'), "
"      \     . "\"v:val[0] ==# '\" . a:2[:-2 + (a:2[-1:] !=# ';')] . \"'\")",
"      \   'python' : 'let l:ret = s:SearchPython(a:2)',
"      \   'java'  : 'let l:ret = s:SearchJava(a:2)'
"      \ }

" We probably don't need this anymore
let s:search =
      \ {
      \   'cpp' : "let l:ret = filter(UCTags#Tags#Kind('header'), "
      \     . "'v:val[1] ==# a:2')",
      \   'c'   : "let l:ret = filter(UCTags#Tags#Kind('header'), "
      \     . "'v:val[1] =~# a:1')",
      \   'cs'  : "let l:ret = filter(UCTags#Tags#Kind('namespace'), "
      \     . "\"v:val[0] ==# '\" . a:2[:-2 + (a:2[-1:] !=# ';')] . \"'\")",
      \   'python' : 'let l:ret = s:SearchPython(a:2)',
      \   'java'  : 'let l:ret = s:SearchJava(a:2)'
      \ }
" TODO Needs to be renamed
" This is never used anymore
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

" We can take out the first item.
let s:inc_kind =
      \ {
      \   'c'       : [['header', "(and (eq? $kind \"header\") (eq? $input \"a:1\") (not (substr? $pattern \"<\")))"]],
      \   'cpp'       : [['header', "(and (eq? $kind \"header\") (eq? $input \"a:1\") (not (substr? $pattern \"<\")))"]],
      \   'cs'        : [['namespace', "(and (eq? $kind \"namespace\") (eq? $input \"a:1\"))"],
      \                   ['using', "(and (eq? $kind \"using\") (eq? $input \"a:1\") (not (prefix? $name \"System.\")) (not (eq? $name \"System\")))"]],
      \   'python'    : [['module', "(and (eq? $input \"a:1\") (eq? $kind \"module\"))"]]
      \ }

" We probably don't need this anymore
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
function! s:UpdateSynFor(src_file, ...)
  if &ft ==? 'go' && !g:uctags_enable_go | return | endif
  " TODO Document
  " TODO Use Log namespace
  if assert_false(g:uctags_max_syn && s:sourced_syn >= g:uctags_max_syn, s:max_syn_msg)
    if g:uctags_verbose
      echohl warningMsg | echomsg v:errors[-1] | echohl None
    endif

    return
  endif

  let l:cur_inc_files = copy(s:inc_files)

  let l:is_cs       = &ft ==? 'cs'

  " Remove quotes
  let l:src_file  = substitute(a:src_file, "\\(\"\\|\'\\)", '', 'g')
  let l:is_py = &ft ==? 'python'
  let l:is_java = &ft ==? 'java'

  let l:src_syn_file = l:src_file . '.syn'
  if !count(s:inc_lan, tolower(&ft))
    " Current language doesn't support include directives.
    return l:src_syn_file
  " Current language supports include directives
  elseif filereadable(l:src_syn_file)
    if !count(s:used_src_syn_files, l:src_file)
      " Found syn file for a:src_file; update it
      call s:UpdateSyn(l:src_syn_file)
      let s:sourced_syn += 1
      call add(s:used_src_syn_files, l:src_file)
    else
      echomsg "This shouldn't be reachable: !count(l:used_src_files, l:src_file)"
    endif
  else
    " This can be reached if a file is empty, as an empty file will not have
    "   Syn File associated with it.
    if 0
      " We probably don't need this anymore, but just incase s:UpdateSynFilter
      "   is used again, we will keep it here for now.
" =============================================================================
    echomsg 'no find'
    echomsg l:src_file
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
        if !count(s:used_src_syn_files, l:src_file)
          call s:UpdateSyn(l:src_syn_file)
          let s:sourced_syn += 1
          call add(s:used_src_syn_files, l:src_file)
        else
          echomsg "This shouldn't be reachable: !count(l:used_src_files, l:src_file)"
        endif
      else
        echomsg "This shouldn't be reachable: filereadable(l:src_syn_file)"
      endif
    endfor
  endif
  endif
" =============================================================================

  if l:is_java && a:src_file !=# s:src_file | return | endif

  " We can probably take out this loop, and just use the body.
  for l:f in exists('l:lines') && (l:is_cs || l:is_py || l:is_java)
        \ ? l:lines
        \ : [[0, l:src_file]]
    let l:src_file = l:f[1]

    " COMBAK XXX Should this be continue rather thtan return?
    " Checking if this message is ever actually output
    if !filereadable(l:src_file)
      echomsg 'not readable'
    echomsg l:src_file
       return
    endif

    let l:pat   = s:pat_lang[&ft]
    let l:list  = []

    for l:kind in s:inc_kind[&ft]
      
      " First grab all headers in l:src_file
      " Using plural as there could be more than one file found
      for l:inc_dir in l:is_py
            \ ? s:SearchPython(UCTags#Tags#Readtags(l:kind[1], l:src_file))
            \ : UCTags#Tags#Readtags(l:kind[1], l:src_file)
        " If include file is already readable, we don't need to search for it
        " Cur dir: .
        " Active buffer file: ./foo/bar.h
        " ./foo/bar.h has include directive: foobar.h
        " There is a foobar.h in .
        " If originally the include directive in bar.h―foobar.h―was supposed
        "   to be located in ./foo, ./foobar.h will still be considered as the
        "   intended file even though that may have not been what was desired.
        if filereadable(l:inc_dir[0])
          if !count(s:inc_files, l:inc_dir[0])
            call add(l:list, l:inc_dir[0])
            call add(s:inc_files, l:inc_dir[0])
            continue
          endif
        endif

        " When the language is Pyhon, behond this point does not need to be
        "   reached.
        if l:is_py | continue | endif

        let l:inc_files = UCTags#Tags#FindFile(l:inc_dir[0])
        " If no include files were found, l:inc_files will be an empty list;
        "   otherwise l:inc_files will be a tag.
        if len(l:inc_files)
          " Multiple include files for an include directive were found
          if len(l:inc_files) > 1
            if count(l:src_file, '/')
              " This is only applicable if the language is C or C++.
              " This isn't done very cleanly. We are just truncating the file
              "   name of l:src_file so we just have the directory.  We replace
              "   any forward slashes (/) with underscores, concatinating the
              "   $name of tag associeated with l:inc_dir, replacing periods
              "   with an underscore, followed by making it all upercase―We
              "   will call this our HeaderGuard.  With the HeaderGuard, we
              "   search the tags file for a $name that can suffix our
              "   HeaderGuard and make sure the $kind is a 'macro'.
              "
              "   Example: If l:src_file was 'libfoo/bar.h', we truncate the
              "     file name so we have just the directory―libfoo/.  We
              "     replace the forward slash with an underscore.  Now we have
              "     'libfoo_'.
              "
              "     Lets say the $name of tag for l:inc_dir is 'header.h'.  We
              "     concatinate 'header.h' onto 'libfoo_' to get
              "     'libfoo_header.h'.  Finally we replace the periods with an
              "     underscore and make it all uppercase which results in:
              "     LIBFOO_HEADER_H
              "
              "     Typically a HeaderGuard wont actually be prefixed with
              "     'lib'.  The 'lib' part is usually just what is required for
              "     compiling; with that being said, there probably wont be a
              "     tag $name of 'LIBFOO_HEADER_H'; however, there could be a
              "     tag $name of 'FOO_HEADER_H' which is why we search for a
              "     tag $name that can suffix our HeaderGuard.
              "
              " COMBAK Maybe move the mechanics to UCTags#Tags#HeaderGuard() so
              "   we can take advantage of Perl when implementing the Perl
              "   variant.
              let l:h = UCTags#Tags#HeaderGuard(
                    \ toupper(
                    \   join(split(l:src_file, '/')[:-2], '_')
                    \   . '_' . substitute(l:inc_dir[0], '\.', '_', 'g')))
            endif
            " Check if a headerguard was found
            if exists('l:h') && len(l:h)
              " Multiple headerguards were found
              if len(l:h) > 1
                echomsg 'Multiple headerguards found!'
                " l:inc_dir[0] is the $name of the tag; if there are multiple
                "   HeaderGuards found for any $name, those same HeaderGuards
                "   will always be found for that $name.  Because the results
                "   are uniform, we can add l:inc_dir[0] to the list of include
                "   files so it can be skipped if encountered again.
                if !count(s:inc_files, l:inc_dir[0])
                  call add(s:inc_files, l:inc_dir[0])
                endif

                echomsg 'This is hopefully never reached..'
                continue
              endif
            
              " There is only one HeaderGuard found.  Use $file of the tag
              "   accocieated with the HeaderGuard to select appropriate
              "   include file.  Process the include file as if there was only
              "   one found originally.
              "let l:inc_files = filter(l:inc_files, 'v:val[1] ==# l:h[0][1]')
              call filter(l:inc_files, 'v:val[1] ==# l:h[0][1]')
            endif
          endif

          " Check if include file has already been found
          if !count(s:inc_files, l:inc_files[0][1])
            if filereadable(l:inc_files[0][1])
              call add(l:list, l:inc_files[0][1])
            endif

              call add(s:inc_files, l:inc_files[0][1])
          endif

          " We continue to the next iteration as we have already found the
          "   include file for l:inc_files[0][1] (Or we know there is no
          "   include file for l:inc_dir[0]―$name).
          continue
        endif

        " l:inc_dir[0] is the $name of the tag; if we can't find a file for any
        "   $name, we can add it to the list of found include files so $name
        "   can be skipped if encountered again.
        call add(s:inc_files, l:inc_dir[0])
      endfor
    endfor

    for l:src_file in l:list
      " We shouldn't have to check if 
      if count(l:cur_inc_files, l:src_file)
        echomsg "This souldn't be reachable: l:src_file in l:list"
        continue
      endif
      call s:UpdateSynFor(l:src_file)
    endfor
  endfor

  return l:src_syn_file
endfunction

function! UCTags#Highlight#UpdateSynFile(file)
  echomsg 'Doing shit..  This may be a while'
  let s:inc_files = []
  let s:used_src_syn_files = []
  let s:src_file = a:file
  let s:sourced_syn = 0
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

  " NOTE: This is taking up a lot of lines, possibly move this to the documents
  "   to save lines
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
