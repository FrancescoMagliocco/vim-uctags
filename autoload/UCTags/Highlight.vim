" Last Change:  05/22/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Highlight')
  finish
endif
let g:loaded_UCTags_Highlight = 1

" If any optional arguments are given, do a dry run and output some info
function! UCTags#Highlight#Highlight(kind, ...)
  let l:kind = tolower(a:kind)
  if !has_key(g:uctags_kind_to_hlg, l:kind)
    echoerr 'No support yet for' l:kind
    return
  endif

  " Filter out kinds that aren't a:kind
  " Filter out out languages val, for a:kind key present in
  "   g:uctags_skip_hl_for:
  "     Check if g:uctags_skip_hl_for has key a:kind:
  "       IF key a:kind is present:
  "         Check if val contains tolower(strpart(v:val[5], 9)), i.e language
  "           IF val contains said language:
  "             returned index is NOT < 0; therefore filtered out.
  "           ELSEIF cal does NOT contain said language:
  "             returned index IS < 0; therefore NOT filtered out.
  "       ELSEIF key a:kind is NOT present:
  "         1; therefore NOT filtered out.
  " Sort
  " Removed any duplicates XXX Some languages like C# allow multiple
  "   definitions of methods, given they have different signatures.  This will
  "   essentially remove all except one.
  "
  " COMBAK Another way to do this would be to call a function within the filter
  "   and pass a:kind.  
  " XXX I'm worried that if there is a significant amount of tags that Vim will
  "   halt until all the filtering is done.  TODO I wanted to implement the new
  "   channel and job system.  I'm just not sure if that is possible for
  "   situtations like this.
  let l:skip =
        \ 'has_key(g:uctags_skip_kind_for, l:kind)'
        \ . '? index(g:uctags_skip_kind_for[l:kind],'
        \     . 'tolower(v:val[5][9:])) < 0'
        \ . ': 1'

  " I HAVE REMOVED UNIQ to use filescope
  for l:v in (sort(
        \ filter(
        \   filter(
        \     UCTags#Parse#GetTags(), "v:val[3] ==? 'kind:" . l:kind . "'"),
        \   l:skip)))
    let l:lang  = tolower(strpart(l:v[5], 9))
    let l:group = get(g:uctags_lang_map, l:lang, l:lang)
          \ . get(g:uctags_hl_group_map, l:kind, l:kind)
    if a:0
      echomsg l:lang
      continue
    endif
    
    let l:has_key = has_key(g:uctags_match_map, l:lang)

    " If neither g:uctags_match_map[l:lang] or g:uctags_match_map has key
    "   l:kind, there isn't a pattern to match l:kind for l:lang.
    if !l:has_key && !has_key(g:uctags_match_map, l:kind)
      continue
    endif

    " Using l:match =
    "     \ get(g:uctags_match_map[l:lang], l:kind, g:uctags_match_map[l:kind)
    "   Throws an error if l:kind is not present in g:uctags_match_map even if
    "   l:kind is present in g:uctags_match_map[l:kind]
    let l:match = get(
          \ l:has_key ? g:uctags_match_map[l:lang] : g:uctags_match_map, l:kind)

    let l:lines = []
    if filereadable(l:lang . '.syn')
      let l:lines = readfile(l:lang . '.syn')
    endif


    let l:syn = 'syntax match ' . l:group . ' ' . l:match.start . escape(l:v[0]) . l:match.end
    let l:link = 'hi link' . ' ' . l:group . ' ' . g:uctags_kind_to_hlg[l:kind]
    if index(l:lines, l:syn) < 0
      call add(l:lines, l:syn)
      if index(l:lines, l:link)
        call add(l:lines, l:link)
      endif

      call writefile(l:lines, l:lang . '.syn')
    endif
    continue
  endfor
endfunction

" XXX I THINK the UpdateSyn function replaces this...
function! UCTags#Highlight#High(tags, ...)

  let l:skip =
        \ 'has_key(g:uctags_skip_kind_for, tolower(v:val[3][5:]))'
        \ . '? index(g:uctags_skip_kind_for[tolower(v:val[3][5:])],'
        \     . 'tolower(v:val[5][9:])) < 0'
        \ . ': 1'
  " Took out the :t
  let l:file = expand('%') . '.syn'
  " The reason why we are using silent! is bcause if l:file doesn';t exists, an
  "   empty list is returned which is okay.
  silent! let l:lines = readfile(l:file)
  " I took out the uniq and sort
  for l:v in 
        \ filter(
        \   filter(
        \     filter(a:tags, "v:val[1] =~? fnameescape(expand('%')) . '$'"),
        \     'has_key(g:uctags_kind_to_hlg, tolower(v:val[3][5:]))'), l:skip)
    let l:kind = tolower(l:v[3][5:])
    let l:lang  = tolower(l:v[5][9:])
    let l:group = get(g:uctags_lang_map, l:lang, l:lang)
          \ . get(g:uctags_hl_group_map, l:kind, l:kind)
    if a:0
      echomsg l:lang
      echomsg l:kind
      echomsg l:group
      continue
    endif
    
    let l:has_key = has_key(g:uctags_match_map, l:lang)
          \ && has_key(g:uctags_match_map[l:lang], l:kind)

    if !l:has_key && !has_key(g:uctags_match_map, l:kind)
      continue
    endif

    let l:match = get(
          \ l:has_key ? g:uctags_match_map[l:lang] : g:uctags_match_map, l:kind)
    let l:syn = 'syntax match ' . l:group . ' ' . l:match.start . escape(l:v[0]) . l:match.end
    let l:link = 'hi link' . ' ' . l:group . ' ' . g:uctags_kind_to_hlg[l:kind]
      call add(l:lines, l:syn)
    execute 'hi link' l:group g:uctags_kind_to_hlg[l:kind]
  endfor

  call writefile(uniq(sort(l:lines)), l:file)
endfunction

let s:inc_lan = ['cpp', 'c']
let s:pat_lang = { 'cpp': '#include', 'c': '#include', 'go': 'import'}

" XXX We need to implement a check for this so this is (The part that looks
"   through each file of includes and continues) is only done on languages that
"   actually havve something like this.
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
function! UCTags#Highlight#ReadTags(file, ...)
  
  " Remove quotes
  let l:file = substitute(a:file, "\\(\"\\|\'\\)", '', 'g') 
  let l:ofile = l:file

  let l:ftype = &ft
  echomsg l:ftype
  if l:ftype ==? 'go' && a:0 >= 2  &&  fnameescape(l:file) !~? '\.go$'
    echomsg a:2
    echomsg a:2[:-len(split(a:2, '/'))]
    let l:file = a:2[:-(len(split(a:2, '/')[-1])+1)] . substitute(l:file, '\(\.\/\|\/\)', '', 'g') . '.go'
    echomsg l:file
    execute 'source' l:file . '.syn'
    return
  endif
  " Use for relative path
  

  " syn file for l:file
  let l:syn_file = l:file . '.syn'
  " If the syn file for a:file is readable, we source it.  
  " If the syn file for a:file is not readable, ods are the header that was
  "   passed to a:file is relative to that of the file it was included in, and
  "   the current directory we are in, is not relative to that path.
  if filereadable(l:syn_file)
    " We source the syn file for a:file, then we search each line of a:file
    "   looking to see if there was any includes.
    execute 'source' l:syn_file
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
    "   ./boo/bar/FooBar.h does ot exist
    "   We search each tag and try to match index 1 with foo/bar/FooBar.h
    "   We match bar/foo/foo/bar/FooBar.h
    "   We need to now source the syn file for it
    " We can't use l:file because when we split l:file with pattern '/', what was
    "   substituted here will still be in l:file when we only the file name.
    let l:tfile = fnameescape(l:file)
    " Go through tags file search for index 1 to match l:tfile
    " Filter out all that don't match the file name without the path of l:file
    "   at index 0 of each tag.  Index 1 will match any tag that is in l:file
    "   which there could be many, so we only need the one that index 0 matches
    "   just the file name without the path of a:file.  There could be multiple
    "   tags in index 0 that are the same file name of a:file, so to
    "   differentiate and get the correct one, we search index 1 of each tag
    "   for the pattern included in the header.
    let l:lines = filter(filter(UCTags#Parse#GetTags(), 'v:val[1] =~# l:tfile'), "v:val[0] ==# split(l:file, '/')[-1]")

    if empty(l:lines) | return | endif
    " It may be safe here to now set l:file to l:lines[1] as we will need the
    "   file for the when matching includes
    let l:file = l:lines[1]
    " If there is no match, something probal went wrong, and we return and
    "   continue what was going on prevvilsy which may have been the samething
    "   process.  If l:lines is empty, there is no file to read for the next
    "   part.

    " If l:lines[1] . '.syn' is readable, we source
    "   it.
    let l:syn_file = l:file . '.syn'
    if filereadable(l:syn_file)
      execute 'source' l:syn_file
    endif
  endif

  " l:lines wont be set if the syn file for a:file was readable in the first
  "   place
  " If l:lines[1] is readable, we can read that file and filter out all except
  "   includes.
  if !filereadable(l:file) | return | endif
  let l:pat = s:pat_lang[l:ftype]
  " Read each line from l:lines[1] and filter out all lines that aren't
  "   including a header.
  " We are sorting and removing any dublicates just incase there is a header
  "   that is included twice in a file by mistake or even if it was including
  "   twice intentially.  We don't want to source that same syn file for a
  "   header twice.
  "   import\s\+(\n\(\s\(\(\w\+\s\)\?\"\w\+\(\(\/\|\.\)\w\+\)\?\"\)\n\)*)
  "echomsg filter(readfile(l:file), "v:val =~# '^import\\s\\+(\\n\\(\\s\\(\\(\\w\\+\\s\\)\\?\\\"\\w\\+\\(\\(\\/\\|\\.\\)\\w\\+\\)\\?\\\"\\)\\n\\)*)'")
  "echo join(readfile(l:file), "\n") =~? '\nimport ('
  echo join(readfile(l:file), "\n") =~? 'import\s\+(\n\(\s\(\(\w\+\s\)\?\"\w\+\(\(\/\|\.\)\w\+\)\?\"\)\n\)*)'
  "echomsg join(readfile(l:file), '\n') =~? 'import\\s\\+(\\n\\(\\s\\(\\(\\w\\+\\s\\)\\?\\\"\\w\\+\\(\\(\\/\\|\\.\\)\\w\\+\\)\\?\\\"\\)\\n\\)*)'
  return
  let l:list = uniq(sort(filter(readfile(l:file), "v:val =~# '\\s*" . l:pat . "\\s\\+\"\\{1\\}.*\"\\{1\\}'")))
  "let l:list = uniq(sort(filter(readfile(l:file), "v:val =~# '\\s*#include\\s\\+\"\\{1\\}.*\"\\{1\\}'")))
  " We could probably take out any duplicates that  may be in a:1 and l:list
  "   when extended together, but that would just make the iteration longer
  for l:file in l:list
    " Since this funcion can be recursive, we only attempt to read tags for
    "   includes on files that aren't already to be read, which is why we send
    "   the current list as an optinal so we don't read something twice.  This
    "   isn't to say that this still can't happen.  There can be an include
    "   that is read and taking out of the list from iteration, but that maybe
    "   included in some other header again.
    if a:0 && index(a:1, l:file) >= 0 | continue | endif
    call UCTags#Highlight#ReadTags(substitute(l:file, '^.*' . l:pat . '\s\+', '', 'g'), extend(a:0 ? a:1 : [], l:list), l:ofile)
    "call UCTags#Highlight#ReadTags(substitute(l:file, '^.*#include\s\+', '', 'g'), extend(a:0 ? a:1 : [], l:list), l:ofile)
  endfor

endfunction

" Iterates through each tag in a:tags.  Filters out all tags that {kind} isn't
"   present in g:uctags_kind_to_hlg
function! UCTags#Highlight#UpdateSyn(tags)
  let l:skip =
        \ 'has_key(g:uctags_skip_kind_for, tolower(v:val[3][5:]))'
        \ . '? index(g:uctags_skip_kind_for[tolower(v:val[3][5:])],'
        \     . 'tolower(v:val[5][9:])) < 0'
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
  for l:v in 
        \ filter(filter(a:tags, 'has_key(g:uctags_kind_to_hlg, tolower(v:val[3][5:]))'), l:skip)
    
    " TODO Rename
    let l:tfile = l:v[1]
    if empty(l:file)
      let l:file = l:tfile . '.syn'
    endif

    if l:file !=# l:tfile
      if !empty(l:lines)
        call  writefile(uniq(sort(l:lines)), l:file)
      endif
      let l:file = l:tfile . '.syn'
      " The reason why we are using silent! is bcause if l:file doesn';t
      "   exists, an empty list is returned which is okay.
      silent! let l:lines = readfile(l:file)
    endif

    let l:kind = tolower(l:v[3][5:])
    let l:lang  = tolower(l:v[5][9:])
    let l:group = get(g:uctags_lang_map, l:lang, l:lang)
          \ . get(g:uctags_hl_group_map, l:kind, l:kind)
    if a:0
      echomsg l:lang
      echomsg l:kind
      echomsg l:group
      continue
    endif
    
    let l:has_key = has_key(g:uctags_match_map, l:lang)
          \ && has_key(g:uctags_match_map[l:lang], l:kind)

    if !l:has_key && !has_key(g:uctags_match_map, l:kind)
      continue
    endif

    let l:match = get(
          \ l:has_key ? g:uctags_match_map[l:lang] : g:uctags_match_map, l:kind)

    let l:syn = 'syntax match ' . l:group . ' ' . l:match.start . escape(l:v[0], '$.*~\^[]/') . l:match.end
    let l:link = 'hi link' . ' ' . l:group . ' ' . g:uctags_kind_to_hlg[l:kind]
      call add(l:lines, l:syn)
    execute 'hi link' l:group g:uctags_kind_to_hlg[l:kind]
  endfor

  if !empty(l:lines)
    call writefile(uniq(sort(l:lines)), l:file)
  endif

endfunction

let s:lang_map =
      \ {
      \   'c++'         : '\(c++\|cplusplus\|cpp\|cc\)',
      \   'c#'          : '\(csharp\|c#\)',
      \   'javascript'  : '\(javascript\|jscript\|js\)',
      \ }

" Call UCTags#Parse#GetTags() filters out all tags except that of a:lang.
"   Returns the result.
function! UCTags#Highlight#Lang(lang)
  let l:lang = a:lang
  for [l:k, l:v] in items(s:lang_map)
    if l:lang =~? l:v
      let l:lang = l:k
      break
    endif
  endfor

  return filter(UCTags#Parse#GetTags(), "v:val[5] ==? 'language:" . l:lang . "'")
endfunction

function! UCTags#Highlight#Methods()
  call UCTags#Highlight#Highlight('method')
endfunction
