" File:         uctags_perl.vim
" Last Change:  06/11/2019
" Maintainer:   FrancescoMagliocco
" vim: ft=perl

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
          '\<'   => '\b',
          '\>'   => '\b',
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

          '('    => '\(',
          ')'    => '\)',
          '|'    => '\|',
          '{'     => '\{',
          '}'     => '\}',
          '+'     => '\+'
      );

      sub UpdateSyn {
        my ($arg) = @_;
        die "Need an argument for " . (caller(0))[3] unless $arg;
        my $file = VIM::Eval("expand('%')");

        my @buf = Readfile("$file.syn");

        open my $in_syn, "<", "$arg"
          or die "Couldn't open '$arg' $! " . (caller(0))[3];
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

        Writefile("$file.syn", @buf);
      }

      sub Writefile {
        my($file, @lines) = @_;
        open my $fh, ">", $file;
        print $fh $_ for @lines;
        close $fh;
      }

      sub GetTags {
        my $tag_file = VIM::Eval('g:uctags_tags_file');

        open my $tags, "<", $tag_file
          or die "Couldn't open '$tag_file' $! " . (caller(0))[3];

        my @lines = ();
        while (my $line = <$tags>) {
          next if $line =~ /^!_TAG/;
          chomp $line;
          $line =~ s/\R//g;
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
          $line =~ s/\R//g;
          my @cols = split /\t/, $line;
          s/'/''/g for @cols;
          push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
        }

        VIM::DoCommand('return [' . join(', ', @lines) . ']');
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
        my @lines;
        foreach (grep { $_->[5] =~ /language:$pat/gi } GetTags) {
          my @cols = @$_;
          s/'/''/g for @cols;
          push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
        }

        VIM::DoCommand('return [' . join(', ', @lines) . ']');
      }

      # TODO New Name
      sub UpdateSynFilter {
        my ($tfile, $file, $lang) = @_;

        my $is_cs = $lang eq 'cs';
        my $str = $is_cs ? 'scope:namespace:' . substr $file, 0, -1 : (split('/', $file))[-1];
        my $idx = $is_cs ? 6 : 0;
        my @lines = grep { ($is_cs ? scalar @$_ > 6 : $_->[1] =~ /$tfile/) and $_->[$idx] eq $str } GetTags;
        return unless @lines;
        my @a = @{$lines[-1]};
        s/'/''/g for @a;

        VIM::DoCommand('return [' . join(', ', map { "'$_'" } @a) . ']');
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
          $line =~ s/\R//g;
          push @lines, $line =~ s/'/''/gr;
        }

        VIM::DoCommand(
          'return [' . join(', ', map { "'$_'" } @lines) . ']');
      }

      sub FilterVim {
        my ($arg1, @arg2) = @_;
        my $re = list2re keys %trans;
        $arg1 =~ s/($re)/$trans{$1}/g;
        my @filter = grep { m/$arg1/g } @arg2;
        chomp for @filter;
        s/\R//g for @filter;
        s/'/''/g for @filter;
        VIM::DoCommand(
          'return [' . join(', ', map { "'$_'" } @filter) . ']');

      }
EOF
  endfunction
  call DefPerl()
endif
