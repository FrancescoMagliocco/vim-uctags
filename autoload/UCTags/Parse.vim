" Last Change:  06/03/2019
" Maintainer:   FrancescoMagliocco
" License:      GNU General Public License v3.0

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_UCTags_Parse')
  finish
endif
let g:loaded_UCTags_Parse = 1

if has('perl')
  function! DefPerl()
    perl << EOF
      use warnings;
      sub GetTags {
        my $tag_file = VIM::Eval('g:uctags_tags_file');
        open(my $tags, "<", $tag_file)
          or die "Couldn't open '$tag_file' $!";

        my @lines = ();
        while (my $line = <$tags>) {
          next if $line =~ /^!_TAG/;
          chomp $line;
          push @lines, [split(/\t/, $line)];
        }
        #             for $i ( 0 .. $#lines ) {
        #$aref = $lines[$i];
        #$n = @$aref - 1;
        #for $j ( 0 .. $n ) {
        #    print "elt $i $j is $lines[$i][$j]";
        #}
        #   }

        return @lines;
      }

      sub TestTags {
      my @lines = GetTags;
             for $i ( 0 .. $#lines ) {
        $aref = $lines[$i];
        $n = @$aref - 1;
        for $j ( 0 .. $n ) {
            print "elt $i $j is $lines[$i][$j]";
        }
           }

      }

      sub GetTagsVim {
        my $tag_file = VIM::Eval('g:uctags_tags_file');
        open(my $tags, "<", $tag_file)
          or die "Couldn't open '$tag_file' $!";
        my @lines;
        while (my $line = <$tags>) {
          next if $line =~ /^!_TAG/;
          chomp $line;
          my @cols = split /\t/, $line;
          s/'/''/g for @cols;
          push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
          #push @lines, '[' . join(', ', map { "'$_'" } (s/'/''/gr for split(/ t/, $line)));
        }

        my $x = '[' . join(', ', @lines) . ']';
        VIM::DoCommand("return $x");
        #return "return $x";
      }
      #     use warnings;
      #     sub GetTags {
      #       my $tag_file = VIM::Eval('g:uctags_tags_file');
      #       open(my $tags, "<", $tag_file)
      #         or die "Couldn't open '$tag_file' $!";
      #       # So we can create an array of arrays..
      #       my @lines = ();
      #       while (my $line = <$tags>) {
      #         next if $line =~ /^!_TAG/;
      #         chomp $line;
      #         my @cols = split(/\t/, $line);
      #         push @lines, [@cols];
      #         }
      #       for $i ( 0 .. $#lines ) {
      # 	$aref = $lines[$i];
      # 	$n = @$aref - 1;
      # 	for $j ( 0 .. $n ) {
      # 	    print "elt $i $j is $lines[$i][$j]";
      # 	}
      #     }
      #       
      #     }
      #     sub GetTagsVim {
      #       use warnings;
      #       my $file = VIM::Eval('g:uctags_tags_file');
      #       open FH, "<", $file;
      #       my @lines;
      #       while (my $line = <FH>) {
      #         next if $line =~ /^!_TAG/; 
      #         chomp $line; 
      #         my @cols = split /\t/, $line;
      #         s/'/''/g for @cols;
      #         push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
      #         }
      # 
      #       my $x = '[' . join(', ', @lines) . ']';
      #       close FH;
      #       VIM::DoCommand("return $x");
      #       }
EOF
  endfunction
  call DefPerl()
endif

function! UCTags#Parse#GetTags()
  if !g:uctags_use_perl || !has('perl')
    return s:GetTags()
  endif

  if !filereadable(g:uctags_tags_file)
    echoerr 'no tags file'
    finish
  endif
  perl GetTagsVim
  perl << EOF
  #    use warnings;
  #  if (VIM::Eval('a:0')) {
  #    GetTagsVim;
  #  } else {
  #    return GetTags;
  #  }
      #use warnings;
      #my $file = VIM::Eval('g:uctags_tags_file');
      #open FH, "<", $file;
      #my @lines;
      #while (my $line = <FH>) {
      #  next if $line =~ /^!_TAG/; 
      #  chomp $line; 
      #  my @cols = split /\t/, $line;
      #  s/'/''/g for @cols;
      #  push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
      #  }

      #my $x = '[' . join(', ', @lines) . ']';
      #close FH;
      #VIM::DoCommand("return $x");
EOF
endfunction

function! s:GetTags()
  if !filereadable(g:uctags_tags_file)
    echoerr 'no tags file'
    finish
  endif

  if g:uctags_verbose
    echohl warningMsg | echomsg 'Not using Perl!' | echohl None
  endif

  return map(
        \ filter(readfile(g:uctags_tags_file), "v:val !~# '^!_TAG'"),
        \ "split(v:val, '\t')")
endfunction
