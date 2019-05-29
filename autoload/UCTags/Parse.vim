" Last Change:  05/29/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Parse')
  finish
endif
let g:loaded_UCTags_Parse = 1

if g:uctags_use_perl && has('perl')
  function! UCTags#Parse#GetTags()
    if !filereadable(g:uctags_tags_file)
      echoerr 'no tags file'
      finish
    endif
    perl << EOF
      use warnings;
      my $file = VIM::Eval('g:uctags_tags_file');
      open FH, "<", $file;
      my @lines;
      while (my $line = <FH>) {
        next if $line =~ /^!_TAG/; 
        chomp $line; 
        my @cols = split /\t/, $line;
        s/'/''/g for @cols;
        push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
        }

      my $x = '[' . join(', ', @lines) . ']';
      close FH;
      VIM::DoCommand("return $x");
EOF
  endfunction
else
  function! UCTags#Parse#GetTags()
    if !filereadable(g:uctags_tags_file)
      echoerr 'no tags file'
      finish
    endif

    if g:uctags_verbose
      echohl warningMsg | echomsg "Don't have Perl!" | echohl None
    endif

    return map(
          \ filter(readfile(g:uctags_tags_file), "v:val !~# '^!_TAG'"),
          \ "split(v:val, '\t')")
  endfunction
endif
