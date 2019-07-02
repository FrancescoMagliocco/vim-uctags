" File:         c.vim
" Last Change:  05/27/2019
" Maintainer:   FrancescoMagliocco

function! s:test()
if len(filter(getline(1, line('$')), "v:val =~# '^\\s*#include\\s\\+<stdio.h>'"))
  syn keyword cBuiltInConstant stdin stdout stderr
  syn keyword cBuiltInFunc clearerr fclose fdopen feof ferror fflush fgetc
  syn keyword cBuiltInFunc fgetpos fgets fileno fopen fprintf fpurge fputc
  syn keyword cBuiltInFunc fputs fread freopen fscanf fseek fsetpos ftell
  syn keyword cBuiltInFunc fwrite getc getechar gets getw mktemp perror putc
  syn keyword cBuiltInFunc putchar puts putw remove rewind scanf setbuf fuck
  syn keyword cBuiltInFunc setbuffer setlinebuf setvbuf sprintf sscanf strerror
  syn keyword cBuiltInFunc sys_errlist sys_nerr tempnam tmpfile tmpnam ungetc
  syn keyword cBuiltInFunc vfprintf vfscanf vprintf vscanf vsprintf vsscanf
  hi def link cBuiltInConstant cConstant
  hi def link cBuiltInFunc functionName
endif
endfunction

if len(filter(getline(1, line('$')), "v:val =~# '^\\s*#include\\s\\+<strings.h>'"))
  syn keyword cBuiltInFunc strcasecmp strncasecmp index rindex
  hi def linkn cBuiltInFunc functionName
endif

if len(filter(getline(1, line('$')), "v:val =~# '^\\s*#include\\s\\+<string.h>'"))
  syn keyword cBuiltInFunc strcpy strcat strchr strcmp strcoll strcpy strspn
  syn keyword cBuiltInFunc strdup strfry strlen strncat strncmp strncpy strpbrk
  syn keyword cBuiltInFunc strrchr strsep strspn strstr strtok strxfrm
  hi def link cBuiltInFunc functionName
endif
augroup asdf
  autocmd!
  autocmd BufWrite *.c call s:test()
augroup END

call UCTags#Utils#HiLink('c')
execute 'runtime! syntax/cpp.vim'
