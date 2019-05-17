function! s:test()
if len(filter(getline(1, line('$')), "v:val =~# '^\\s*#include\\s\\+<stdio.h>'"))
  syn keyword cBuiltInFunc clearerr fclose fdopen feof ferror fflush fgetc
  syn keyword cBuiltInFunc fgetpos fgets fileno fopen fprintf fpurge fputc
  syn keyword cBuiltInFunc fputs fread freopen fscanf fseek fsetpos ftell
  syn keyword cBuiltInFunc fwrite getc getechar gets getw mktemp perror putc
  syn keyword cBuiltInFunc putchar puts putw remove rewind scanf setbuf fuck
  syn keyword cBuiltInFunc setbuffer setlinebuf setvbuf sprintf sscanf strerror
  syn keyword cBuiltInFunc sys_errlist sys_nerr tempnam tmpfile tmpnam ungetc
  syn keyword cBuiltInFunc vfprintf vfscanf vprintf vscanf vsprintf vsscanf
  hi def link cBuiltInFunc functionName
endif
endfunction

augroup asdf
  autocmd!
  autocmd BufWrite *.c call s:test()
augroup END
