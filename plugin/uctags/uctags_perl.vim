" File:         uctags_perl.vim
" Last Change:  05/20/2020
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
      use Data::Dumper;
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
          $str =~ s/\( (\S+) \) \\ @!/(?!$1)/gxx if any { m/\\ @!/gxx } $str;
          $str =~ s/\( (\S+) \) \\ @<!/(?<!$1)/gxx if any { m/\\ @<!/gxx } $str;
            my $no_match = none { m/$str/g } @lines;
            # TODO I should be able to ommit the $_
            if (any {$_ eq $line} @buf) {
              # The parenthesis were a percaution meassure
              (@buf = grep { $_ ne $line } @buf) if $no_match;
              next;
            }

            #next if $no_match;
            # XXX Might be able to do push @buf, $line if not $no_match;
            #push @buf, $line;
            push @buf, $line if not $no_match;
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

        return FixTags($tags);
      }

      sub FixTags {
        my ($tags) = @_;
        my @lines;
        while (my $line = <$tags>) {
          next if $line =~ /^!_TAG/;
          chomp $line;
          $line =~ s/\R//g;
          push @lines, [split(/\t/, $line)];
        }

        return @lines;
      }

      sub FixTagsVim {
        my ($tags) = @_;
        my @lines;
        while (my $line = <$tags>) {
          next if $line =~ /^!_TAG/;
          chomp $line;
          $line =~ s/\R//g;
          my @cols = split(/\t/, $line);
          s/'/''/g for @cols;
          push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
        }

        return @lines;
      }

      sub GetTagsVim {
        my $tag_file = VIM::Eval('g:uctags_tags_file');
        open my $tags, "<", $tag_file
          or die "Couldn't open '$tag_file' $!" . (caller(0))[3];
        ReturnVimRawList(FixTagsVim($tags));
      }

      sub GetLangPat {
        my ($lang) = @_;
        my $pat = "(eq? \$language \"$lang\")";
        $pat = "(or $pat (eq? \$language \"C++\"))" if lc($lang) eq 'c';
        return $pat;
      }

      sub GetLang {
        my ($lang, $use_readtags) = @_;
        if ($use_readtags) {
          open(my $fh, '-|', "VIM::Eval('g:uctags_readtags') -e -t VIM::Eval('g:uctags_tags_file') -Q '" . GetLangPat($lang) . "' -l");
          return FixTags($fh);
        }

        my $pat = lc($lang) eq 'c' ? '(?:\bc|c\+\+)(?!\S)' : "\\b$lang(?!\\S)";

        return grep { $_->[5] =~ /language:$pat/gi } GetTags;
      }

      sub GetLangVim {
        my ($lang, $use_readtags) = @_;
        die("Need an argument for " . (caller(0))[3]) if not $lang;
        my @lines;

        if ($use_readtags) {
            my $readtags = VIM::Eval('g:uctags_readtags');
          open(my $fh, '-|', "$readtags -e -t tags -Q '" . GetLangPat($lang) . "' -l");
          return ReturnVimRawList(FixTagsVim($fh));

          return VIM::DoCommand('return [' . join(', ', @lines) . ']');
        }

        my $pat = lc($lang) eq 'c' ? '(?:\bc|c\+\+)(?!\S)' : "\\b$lang(?!\\S)";
        foreach (grep { $_->[5] =~ /language:$pat/gi } GetTags) {
          my @cols = @$_;
          s/'/''/g for @cols;
          push @lines, '[' . join(', ', map { "'$_'" } @cols) . ']';
        }

        ReturnVimRawList(@lines);
      }

      sub UpdateSynFilterPython {
        my ($src_file) = @_;
        my $dir = $src_file;
        $dir =~ s/^\s*from\s+(\S+)+.*/$1/g;
        $dir =~ s/\./\//g;
        my $main_py = $dir . '/__main__.py';
        my $init_py = $dir . '/__init__.py';
        if (-d $dir) {
          $src_file =~ s/^\s*from\s+[a-zA-Z0-9._]+\s+import\s+(.+)+$/$1/g;
          my @ret = (
            grep { -e substr($_->[1], 1, -1) }
            map { [0, "'$dir/" . (split(' ', $_))[0] .  ".py'"] }
            split(',\s*', $src_file));
          unshift @ret, [0, "'$main_py'"] if -e $main_py;
          unshift @ret, [0, "'$init_py'"] if -e $init_py;
          return ReturnVimRawListList(scalar @ret ? @ret : []);
        }

        $dir .= '.py';
        return ReturnVimRawListList(-e -r $dir ? [0, "'$dir'"] : []);
      }

      # TODO New Name
      sub UpdateSynFilter {
        my ($tfile, $file, $lang, $use_readtags) = @_;
        return UpdateSynFilterPython($file) if lc($lang) eq 'python';

        my $is_cs = lc($lang) eq 'cs';
        my $str =
          ($is_cs and ((length($file) - 1) == rindex($file, ';')))
            ? substr($file, 0, -1)
            : (split('/', $file))[-1];
        my @lines = grep {
          ($is_cs ? 1 : $_->[1] =~ /$tfile/) and $_->[0] eq $str
          # NOTE This was auto formatted..  Don't know how I feel about it..
        } $is_cs ? GetKind('namespace', $use_readtags) : GetTags;
        return unless @lines;
        ReturnVimListList(@lines);
      }

      sub Readfile {
        my ($file) = @_;
        open my $in_file, "<", "$file"
          or die "Couldn't open '$file' $! " . (caller(0))[3];
        return <$in_file>;
      }

      sub ReturnVimListList {
        my (@listlist) = @_;
        my @ret;
        for my $list (@listlist) {
          s/'/''/g for @$list;
          push @ret, '[' . join(', ', map { "'$_'" } @$list) . ']';
        }

        VIM::DoCommand('return [' . join(', ', @ret) . ']');
      }

      sub ReturnVimRawListList {
        my (@listlist) = @_;
        my @ret;
        for my $list (@listlist) {
          push @ret, '[' . join(', ', @$list) . ']';
        }

        return ReturnVimRawList(@ret);
      }

      sub ReturnVimRawList {
        my (@list) = @_;
        VIM::DoCommand(
          'return [' . join(', ', @list) . ']');
      }

      sub ReturnVimList {
        my (@list) = @_;
        VIM::DoCommand(
          'return [' . join(', ', map { "'$_'" } @list) . ']');
      }

      sub ReturnVimDict {
        my (@list) = @_;
        VIM::DoCommand(
          'return {' . join(', ', map { "'$_' : '$_'" } @list) . '}');
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

        ReturnVimList(@lines);
      }

      sub FilterVim {
        my ($arg1, @arg2) = @_;
        my $re = list2re keys %trans;
        $arg1 =~ s/($re)/$trans{$1}/g;
        my @filter = grep { m/$arg1/g } @arg2;
        chomp for @filter;
        s/\R//g for @filter;
        s/'/''/g for @filter;
        ReturnVimList(@filter);
      }

      sub GetKindVim {
        my ($kind, $use_readtags) = @_;
        ReturnVimListList(GetKind($kind, $use_readtags));
      }

      sub GetKind {
        my ($kind, $use_readtags) = @_;
        if ($use_readtags) {
          # Why wont the VIM::Eval work inside where $readtags is?
          # I have it working like that above somehwere (Not exactly tested, but
          #   seemed to have been working for the one that was in there prior.
            my $readtags = VIM::Eval('g:uctags_readtags');
          open(my $fh, '-|', "$readtags -e -t tags -Q '(eq? \$kind \"$kind\")' -l");
          return FixTags($fh);
        }

        return grep { $_->[3] =~ /kind:$kind/g } GetTags;
      }

      sub GetTagsWithNamespace {
        my ($namespace, $use_readtags) = @_;
        return grep { $_->[0] eq $namespace } GetKind('namespace', $use_readtags);
      }

      sub ReturnVim {
        VIM::DoCommand("return '$_[0]'");
      }

      sub HasFile
      {
        my ($arg, $use_readtags) = @_;
        my $re = list2re keys %trans;
        $arg =~ s/($re)/$trans{$1}/g;
        for my $tag (GetKind('file', $use_readtags)) {
          return ReturnVim($tag->[1]) if $tag->[0] =~ /$arg/;
        }

        ReturnVim('');
      }
EOF
  endfunction
  call DefPerl()
endif
