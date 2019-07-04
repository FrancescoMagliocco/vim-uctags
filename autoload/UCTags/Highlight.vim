" File:         Highlight.vim
" Last Change:  07/04/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Highlight')
  finish
endif
let g:loaded_UCTags_Highlight = 1

let g:uctags_enable_go = get(g:, 'uctags_enable_go', 0)
" TODO Rename
" Languages that use include directives, namespaces etc..
let s:inc_lan = ['cpp', 'c', 'asm', 'cs']

" TODO Rename
" Pattern used to find include direcetives, namespaces etc.. of the given
"   language.
let s:pat_lang =
      \ {
      \   'asm' : ['', '%include', ''],
      \   'cpp' : ['\s*', '#include', '\s\+"\{1\}.*"\{1\}'],
      \   'c'   : ['\s*', '#include', '\s\+"\{1\}.*"\{1\}'],
      \   'go'  : ['', 'import', ''],
      \   'cs'  : ['', 'using', '\s\+.*;']
      \ }

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

" TODO Rename
" TODO Document this
let s:search =
      \ {
      \   'cpp' : 'let l:ret = filter(filter(UCTags#Parse#GetTags(), '
      \     . "'v:val[1] =~# a:1'), \"v:val[0] ==# split(a:2, '/')[-1]\")",
      \   'c'   : 'let l:ret = filter(filter(UCTags#Parse#GetTags(), '
      \     . "'v:val[1] =~# a:1'), \"v:val[0] ==# split(a:2, '/')[-1]\")",
      \   'cs'  : "let l:ret = filter(UCTags#Tags#Kind('namespace'), "
      \     . "\"v:val[0] ==# '\" . a:2[:-2] . \"'\")"
      \ }

" TODO Needs to be renamed
"
function! s:UpdateSynFilter(...)
  " TODO Use Log namespace
  " Just incase less than 2 argments are given
  if a:0 < 2 | echoer 'Need 2 arguments!' | endif

  if !g:uctags_use_perl || !has('perl')
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

  let l:is_cs       = &ft ==? 'cs'
  let l:sourced_syn = a:0 ? a:1 : 0

  " Remove quotes
  let l:src_file  = substitute(a:src_file, "\\(\"\\|\'\\)", '', 'g')
  " Was used for when ft is go..  I think
  let l:ofile = l:src_file

  let l:src_syn_file = l:src_file . '.syn'
  if index(s:inc_lan, tolower(&ft)) < 0
    " Current language doesn't support include directives.
    return l:src_syn_file
  " Current language supports include directives
  elseif filereadable(l:src_syn_file)
    " Found syn file for a:src_file; update it
    call s:UpdateSyn(l:src_syn_file)
    let l:sourced_syn += 1
  else
    " Can't find syn file for a:src_file
    " During the FIRST call, 
    " Escapes special characters
    let l:safe_src_file = escape(l:src_file, '^.$\*')
    " Try to find
    let l:lines = s:UpdateSynFilter(l:safe_src_file, l:src_file)
    if empty(l:lines[0]) | return | endif

    for l:f in l:is_cs ? l:lines : l:lines[-1:1]
      let l:src_file = l:f[1]
      let l:src_syn_file = l:src_file . '.syn'
      if filereadable(l:src_syn_file)
        call s:UpdateSyn(l:src_syn_file)
        let l:sourced_syn += 1
      endif
    endfor
  endif

  for l:f in exists('l:lines') && l:is_cs ? l:lines : [[0, l:src_file]]
    let l:src_file = l:f[1]
    if !filereadable(l:src_file) | return | endif
    let l:pat = s:pat_lang[&ft]
    let l:list = uniq(sort(
          \ UCTags#Utils#FilterFile(l:src_file, 'v:val =~#', join(l:pat, ''))))
    for l:src_file in l:list
      if a:0 && index(a:2, l:src_file) >= 0 | continue | endif
      call s:UpdateSynFor(substitute(
            \   l:src_file, '^.*' . l:pat[1] . '\s\+', '', 'g'),
            \ l:sourced_syn, extend(a:0 ? a:2 : [], l:list), l:ofile)
    endfor
  endfor

  return l:src_syn_file
endfunction

function! UCTags#Highlight#UpdateSynFile(file)
  echomsg 'Doing shit..  This may be a while'
  execute 'source' s:UpdateSynFor(a:file)

endfunction

" TODO The implementation for python, java etc..  Is going to be different...
" Source a:file . '.syn' if it is readable
" If it's not readable, it may not be relative to the current directory.
" Search for a:file in each tag at index 1 for match so we can get the relative
"   path to the tag file
" We could source it then continue through the rest of the function if a:0, or
"   we could call the function again with the newly found a:file and pass a:1
"   if a:0, BUT!  That may result in a recursive loop if the file still can't
"   be found..  So it may just be best to just source it then continue through
"   the function..   Or could check if it is readable then call the funcion
"   again, but that would kind of be redundant as there is already a check for
"   the readable part..
"
"
" XXX XXX XXX XXX This may not be needed anymore...  It may be replacable with
"   UCTags#Highlight#UpdateSynFile() function
let s:max_syn_msg = 'Max amount of sourced syn files for a particular file reached'
function! UCTags#Highlight#ReadTags(file, ...)
  if &ft ==? 'go' && !g:uctags_enable_go | return | endif
  if assert_false(g:uctags_max_syn && a:0 && a:1 >= g:uctags_max_syn, s:max_syn_msg)
    if g:uctags_verbose
      echohl warningMsg | echomsg v:errors[-1] | echohl None
    endif

    return
  endif

  let l:sourced_syn = a:0 ? a:1 : 0

  " Remove quotes
  let l:file = substitute(a:file, "\\(\"\\|\'\\)", '', 'g')
  let l:ofile = l:file

  if g:uctags_enable_go
    if &ft ==? 'go' && a:0 >= 2  &&  fnameescape(l:file) !~? '\.go$'
      let l:file = a:3[:-(len(split(a:3, '/')[-1])+1)] . substitute(
            \ l:file, '\(\.\/\|\/\)', '', 'g') . '.go'
      execute 'source' l:file . '.syn'
      let l:sourced_syn += 1
    endif
  endif

  " syn file for l:file
  let l:syn_file = l:file . '.syn'
  " If the syn file for a:file is readable, we source it.
  " If the syn file for a:file is not readable, ods are the header that was
  "   passed to a:file is relative to that of the file it was included in, and
  "   the current directory we are in, is not relative to the header.
  if filereadable(l:syn_file)
    " We source the syn file for a:file, then we search each line of a:file
    "   looking to see if there was any includes.
    throw 'Needs implementation!'
      "call UCTags#Highlight#TestSyn(l:syn_file)
    "execute 'source' l:syn_file
    let l:sourced_syn += 1
  elseif index(s:inc_lan, tolower(&ft)) < 0
    return
  else
    " To get around the current directoy not be relative to that of a:file, we
    "   we need to search  the tag file and match that relative path so we can
    "   get the the location to a:file relative to the tags file.
    "
    "   Example:
    "   FooBar.c has #include "foo/bar/FooBar.h"
    "   FooBar.c is located in bar/foo
    "   The current directory we are in is ./ (Obviously)
    "   The current directory has the tags file
    "   ./foo/bar/FooBar.h does ot exist
    "   We search each tag and try to match index 1 with foo/bar/FooBar.h
    "   We match bar/foo/foo/bar/FooBar.h
    "   We need to now source the syn file for it
    " We can't use l:file because when we split l:file with pattern '/', what was
    "   substituted here will still be in l:file when we only the file name.
    let l:tfile = escape(l:file, '^.$\*')
    " Index 1 is the location of a file, and files usually have more than one
    "   tag, and becuase they have more than one tag, that file will be listed
    "   multiple times.  We only need the tag that equals just the filename of
    "   l:file (So without the path) at index 0.  In order for this to work
    "   correctly, we need to have the kind 'file' enabled on universal-ctags.
    "   Now just like at index 1, even though we were looking for just the
    "   filename of l:file at index 0; being that it is just the name of a
    "   file, there is a chance that there is more than one file that has the
    "   same as l:file.  l:file is the actual text that followed an include
    "   directive; our problem was that it was relative to the file that was
    "   including it.  Because we were looking for tags that equal the filename
    "   of l:file at index 0, we can search through those tags and look for a
    "   tag l:file will match to the end at index 1.  The beginning  of index 1
    "   will be different than l:file which is why we are matching rather than
    "   checking for the text at index 1 to be equal to l:file.  The reason for
    "   this is, because we have the kind 'file' enabled on universal-ctags;
    "   once we match l:file to the end of one of the tags that index 0 was
    "   equal to just the filename of l:file..  We have found the location of
    "   the header we were looking for.
    let l:lines = s:UpdateSynFilter(l:tfile, l:file)
    "let l:lines = filter(filter(UCTags#Parse#GetTags(),
    "      \ 'v:val[1] =~# l:tfile'), "v:val[0] ==# split(l:file, '/')[-1]")[-1]

    if empty(l:lines) | return | endif
    let l:file = l:lines[1]
    let l:syn_file = l:file . '.syn'
    if filereadable(l:syn_file)
      throw 'Needs implementation!'
      "call UCTags#Highlight#TestSyn(l:syn_file)
      "execute 'source' l:syn_file
      let l:sourced_syn += 1
    endif
  endif

  if !filereadable(l:file) | return | endif
  let l:pat = s:pat_lang[&ft]
  " We are sorting and removing any dublicates just incase there is a header
  "   that is included twice in a file by mistake or even if it was including
  "   twice intentially.  We don't want to source that same syn file for a
  "   header twice.
  "   import\s\+(\n\(\s\(\(\w\+\s\)\?\"\w\+\(\(\/\|\.\)\w\+\)\?\"\)\n\)*)
  "echo split(matchstr(join(readfile(l:file), "\n"),
  "      \ 'import\s\+(\n\(\s\(\(\w\+\s\)\?\"\w\+\(\(\/\|\.\)\w\+\)\?\"\)\n\)*)'),
  "      \ "\n")

  let l:list = uniq(sort(filter(
        \ UCTags#Utils#Readfile(l:file, g:uctags_max_lines_header_search),
        \ "v:val =~# '\\s*" . l:pat . "\\s\\+\"\\{1\\}.*\"\\{1\\}'")))
  " We could probably take out any duplicates that  may be in a:1 and l:list
  "   when extended together, but that would just make the iteration longer
  for l:file in l:list
    " Since this funcion can be recursive, we only attempt to read tags for
    "   includes on files that aren't already in queue to be read, which is why
    "   we send the current list as an optinal so we don't read something
    "   twice.
    if a:0 && index(a:2, l:file) >= 0 | continue | endif
    call UCTags#Highlight#ReadTags(substitute(
          \   l:file, '^.*' . l:pat . '\s\+', '', 'g'),
          \ l:sourced_syn, extend(a:0 ? a:2 : [], l:list), l:ofile)
    "call UCTags#Highlight#ReadTags(substitute(l:file, '^.*#include\s\+', '', 'g'), extend(a:0 ? a:1 : [], l:list), l:ofile)
  endfor

endfunction

" Iterates through each tag in a:tags.  Filters out all tags that {kind} isn't
"   present in g:uctags_kind_to_hlg
function! UCTags#Highlight#CreateSynFiles(tags)
  " COMBAK Revise
  let l:skip =
        \ 'has_key(g:uctags_skip_kind_for, tolower(v:val[3][5:]))'
        \ . '? index(g:uctags_skip_kind_for[tolower(v:val[3][5:])],'
        \     . "tolower(v:val[5][9:])) < 0 && index(g:uctags_skip_kind_for[tolower(v:val[3][5:])], 'all') < 0"
        \ . ': 1'
  let l:file = ''
  let l:lines = []

  " FIXME Sorting the results by index 1, i.e the file a given tag is located
  "   in, will probably improve performance greatly as we wont have to keep
  "   reading and writing files every time a following iteration is of a tag
  "   that doesn't share the same location is the tag from the previous
  "   iteration.  Instead we will only have to write and read a file after we
  "   have parsed through each tag of a given location.
  "
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
  let l:use_keyword = g:uctags_use_keyword && !g:uctags_use_only_match

  " Use keyword for kinds that have only keyword characters, and skip kinds
  "   that have non keyword characters.
  let l:use_only_keyword = l:use_keyword && g:uctags_skip_non_keyword
  " if l:use_only_keyword, kinds that contain non keyword characters are
  "   skipped; otherwise all kinds are passed.
  for l:v in l:use_only_keyword
        \ ? filter(l:tags, "!(l:use_only_keyword && v:val[0] !~? '^\k\+$')")
        \ : l:tags

    " TODO Rename
    let l:tfile = l:v[1]
    if empty(l:file)
      let l:file = l:tfile . '.syn'
    endif

    if l:file !=# l:tfile
      if !empty(l:lines)
        call UCTags#Utils#Writefile(sort(l:lines), l:file)
        "call writefile(uniq(sort(l:lines)), l:file)
      endif

      let l:file = l:tfile . '.syn'
      " The reason why we are using silent! is bcause if l:file doesn';t
      "   exists, an empty list is returned which is okay.
      "silent! let l:lines = readfile(l:file)
      let l:lines = UCTags#Utils#Readfile(l:file)
    endif

    let l:kind  = tolower(l:v[3][5:])
    let l:lang  = tolower(l:v[5][9:])
    let l:group = GetGroup(l:lang, l:kind)

    " Don't forget the space
    let l:command = 'keyword '
    let l:tag = l:v[0]
    if !l:use_only_keyword
      let l:has_key = has_key(g:uctags_match_map, l:lang)
            \ && has_key(g:uctags_match_map[l:lang], l:kind)

      let l:match = !l:has_key && !has_key(g:uctags_match_map, l:kind)
            \ ? g:uctags_default_match
            \ : get(l:has_key
            \   ? g:uctags_match_map[l:lang]
            \   : g:uctags_match_map, l:kind)

      let l:is_keyword = l:tag =~? '^\k\+$'
      " Use keyword if l:use_keyword and l:is_keyword only if
      "   g:uctags_use_keyword_over_match or l:match equals
      "   g:uctags_default_match
      let l:use_keyword = l:use_keyword && l:is_keyword
            \ && (g:uctags_use_keyword_over_match
            \   || l:match == g:uctags_default_match)
      " Don't forget the space
      let l:command = l:use_keyword ? l:command : 'match '
      let l:tag = l:use_keyword
            \ ? l:tag
            \ : l:match.start . escape(l:tag, '$.*~\^[]/') . l:match.end
    endif

    " COMBAK Revise from here
    "if !l:has_key && !has_key(g:uctags_match_map, l:kind)
    "  let l:match = g:uctags_default_match
      "continue
    "else
    "  let l:match = get(
    "        \ l:has_key ? g:uctags_match_map[l:lang] : g:uctags_match_map, l:kind)
    "endif
    " COMBAK To here

    " if l:use_keyword and l:tag contains only keyword characters, use `syn
    "   keyword`, otherwise use `syn match`
    " If l:use_only_keyword or l:use_keyword, use `syn keyword`
    let l:syn =  'syn ' . l:command . l:group . ' ' . l:tag
    "let l:syn = 'syntax match ' . l:group . ' '
    "      \ . l:match.start
    "      \ . escape(l:v[0], '$.*~\^[]/')
    "      \ . l:match.end
      call add(l:lines, l:syn)
  endfor

  if !empty(l:lines)
    call UCTags#Utils#Writefile(sort(l:lines), l:file)
  endif
endfunction
