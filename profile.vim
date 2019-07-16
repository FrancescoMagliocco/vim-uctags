set nocp
function! Profile1(...)
  for n in range(1, a:1)

  endfor
endfunction

function! Profile2(...)
  for n in range(1, a:1)

  endfor
endfunction

profile start ./profile.txt
profile func Profile*
se lazyredraw
let times = 10000
call Profile1(times)
call Profile2(times)
quit!
