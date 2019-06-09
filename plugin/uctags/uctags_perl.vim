" File:         uctags_perl.vim
" Last Change:  06/08/2019
" Maintainer:   FrancescoMagliocco

if (exists('g:uctags_enabled') && !g:uctags_enabled)
      \ || !exists('g:loaded_uctags')
      \ || exists('g:loaded_uctags_perl')
  finish
endif
let g:loaded_uctags_perl   = 1

if has('perl')
  function! DefPerl()
    perl << EOF
      use List::Util qw(first none any);
      use Data::Munge qw(list2re);
      use warnings;
      use strict;
      our $curbuf;
      my %trans = (
          '\%\(' => '(?:',
          '\('   => '(',
          '\)'   => ')',
          '\|'   => '|',
          #          '\.'   => '.',
          # Do these need to be escaped?
          '\<'   => '\\b',
          '\>'   => '\\b',
          '\ze'  => '',
          '\zs'  => '',
          '\\\\s' => '\s',
          '\\\\S' => '\S',
          '\\\\+' => '+',
          '\+',   => '+',
          '\{',   => '{',
          '\}',   => '}',
          '\\\\{' => '{',
          '\\\\}' => '}',
          '\"'    => '"',

          '('    => '\\(',
          ')'    => '\\)',
          '|'    => '\\|',
          #'.'    => '\\.',
          '{'     => '\\{',
          '}'     => '\\}',
          '+'     => '\\+'
      );

      sub UpdateSyn {
        my ($arg) = @_;
        die "Need an argument for " . (caller(0))[3] if not $arg;
        my $file = VIM::Eval("expand('%')");

        # syn file for the current Vim buffer
        open my $buf_syn, "<", "$file.syn"
          or die "Couldn't open '$file' $! " . (caller(0))[3];
        my @buf = <$buf_syn>;

        #my $so = VIM::Eval('a:1');
        open my $in_syn, "<", "$arg"
          or die "Couldn't open '$arg' $! " . (caller(0))[3];
        #open(my $in_syn, "<", VIM::Eval('a:1'));
        #        my $curbuf;
        my @lines =  $curbuf->Get(1 .. VIM::Eval('line("$")'));
        while (my $line = <$in_syn>) {
          my $str = +(split(' ', $line))[-1];
          $str = substr($str, 1, -1);
          my $re = list2re keys %trans;
          $str =~ s/($re)/$trans{$1}/g;
            next if none { m/$str/g } @lines;
            next if any {$_ eq $line} @buf;
            push @buf, $line;
        }

        close $buf_syn;
        open my $out_syn, ">", "$file.syn"
          or die "Couldn't write '$file' $! " . (caller(0))[3];
        foreach (@buf) {
          print $out_syn $_;
          }
        close($out_syn);
        close $in_syn;
        }

      sub GetTags {
        my $tag_file = VIM::Eval('g:uctags_tags_file');
        open my $tags, "<", $tag_file
          or die "Couldn't open '$tag_file' $! " . (caller(0))[3];

        my @lines = ();
        while (my $line = <$tags>) {
          next if $line =~ /^!_TAG/;
          chomp $line;
          push @lines, [split(/\t/, $line)];
        }

        return @lines;
      }

      sub GetTagsVim {
        my $tag_file = VIM::Eval('g:uctags_tags_file');
        open my $tags, "<", $tag_file
          or die "Couldn't open '$tag_file' $!" . (caller(0))[3];
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
      }

      sub GetLang {
        my ($lang) = @_;
        my $pat = lc($lang) eq 'c' ? '(?:\bc|c\+\+)(?!\S)' : "\\b$lang(?!\\S)";
        return grep { $_->[5] =~ /language:$pat/gi } GetTags;
      }

      sub GetLangVim {
        my ($lang) = @_;
        die("Need an argument for " . (caller(0))[3]) if not $lang;
        my $pat = lc($lang) eq 'c' ? '(?:\bc|c\+\+)(?!\S)' : "\\b$lang(?!\\S)";
        #my @langs = grep { $_->[5] =~ /language:$pat/gi } GetTags;
        my @lines;
        foreach (grep { $_->[5] =~ /language:$pat/gi } GetTags) {
          my @cols = @$_;
          s/'/''/g for @cols;
          push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
        }
        my $x = '[' . join(', ', @lines) . ']';
        VIM::DoCommand("return $x");
      }

      # TODO New Name
      sub UpdateSynFilter {
        my ($tfile, $file) = @_;
        my @l = grep { $_->[1] =~ /$tfile/ } GetTags;
        my $str = +(split('/', $file))[-1];
        my @lines = grep { @$_[0] eq $str } @l;
        my @a = @{$lines[-1]};
        s/'/''/g for @a;
        my $ret =  '[' . join(', ', map { "'$_'" } @a) . ']';
 
        VIM::DoCommand("return $ret");
      }

      sub Readfile {
        my ($file) = @_;
        open my $in_file, "<", "$file"
          or die "Couldn't open '$file' $! " . (caller(0))[3];
        return <$in_file>;

      }

      sub ReadfileVim {
        my ($file, $arg2) = @_;
        open my $in_file, "<", "$file"
          or die "Couldn't open '$file' $! " . (caller(0))[3];
        my @lines;
        my $count = 0;
        while (defined(my $line = <$in_file>)
            and not ($arg2 and ++$count  >= $arg2)) {
          chomp $line;
          push @lines, $line =~ s/'/''/gr;
        }

        #my $ret =  '[' . join(', ', map { "'$_'" } @lines) . ']';
        VIM::DoCommand(
          "return " . '[' . join(', ', map { "'$_'" } @lines) . ']');
      }

      sub FilterVim {
        my ($arg1, @arg2) = @_;
        my $re = list2re keys %trans;
        $arg1 =~ s/($re)/$trans{$1}/g;
        my @filter = grep { m/$arg1/g } @arg2;
        chomp for @filter;
        s/'/''/g for @filter;
        VIM::DoCommand(
          "return " . '[' . join(', ', map { "'$_'" } @filter) . ']');

      }
EOF
  endfunction
  call DefPerl()
endif
