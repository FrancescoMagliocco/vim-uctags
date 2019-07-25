# vim-uctags
A Universal-Ctags highlighter

This README until it is fully finished is going to be a shit show, and
everything will be all over the place until I have everything in place.

## Requirements
Vim-UCTags has one mandatory requirement: [Universal-CTags][uctags]; which can
be built from source at [GitHub][uctags-repo], or installed using your package
manager.

### apt-get
For Debian and Debian derivatives, you can run the following in a terminal of
your choosing:
```bash
sudo apt-get -fV install universal-ctags --no-install-reommends
```

### pacman
For Arch Linux and Arch Linux derivatives, you can run the following in a
terminal of your choosing:
```bash
pacman -Syu universal-ctags-git
```

Additionally, you will need the `find` command, provided by the
*findutils*<sup>\*</sup> (Should be installed by default if on
Linux)<sup>\*\*</sup> package.  
<sup>\* Package name based on Debian repositories.</sup>  
<sup>\*\* If not installed by default, consult your package manager.</sup>

## Optional Dependencies
Vim-UCTags has some optional, but **highly** recommended, dependencies.  As of
right now, there is only one optional dependency, however, more may be
introduced later on in development.

### Perl
I can not emphasize enough the gain in performance when using Perl, especially
on large projects.  You do not need any knowledge whatsoever on how to use Perl
to take advantage of what it offers.

See [Compiling Vim with Perl Interface][perl-compiling] for instructions on how
to compile Vim with the Perl Interface.  If you installed Vim using your
package manager, all that should be required is for Perl to be installed if not
already.

<sup>**NOTE: I am unsure if vim-uctags will work on Windows or not.  If it does
not work on Windows, I do appologize, but until this plugin is finished and in
a working stable state, Windows support will not be a priority.**</sup>

## Installing
If you don't know how to install a plugin or need assistance; this section
will demonstrate how to do so using a few plugin managers.  Also included will
be links to their respected repositories, in case you wish to check them out.
If you're new to plugin managers and don't know what to choose; you can try
them all and see which one suits your needs and prefer more.  I personally use
[Vundle][vundle].  
<sup>You are not limited to using these plugin managers.  If you use a
different one that isn't listed below, Vim-UCTags will still work as
intended.</sup>

### Vundle
If you use [Vundle][vundle] (What I personally use and recommend even though I
haven't tried many others) to manage your plugins, first place the following in
your .vimrc (Don't close Vim):
```vim
Plugin 'FrancescoMagliocco/vim-uctags'
```

While still in your .vimrc, run the following commands:
```vim
:source %
:PluginInstall
```

<sup>For Vundle version 0.10.2, replace *Plugin* with *Bundle* above.</sup>

### NeoBundle
If you use [NeoBundle][neobundle] to manage your plugins, first place the
following in your .vimrc (Don't close Vim):
```vim
NeoBundle 'FrancescoMagliocco/vim-uctags'
```

While still in your .vimrc, run the following commands:
```vim
:source %
:NeoBundleInstall
```

### VimPlug
If you use [VimPlug][vimplug] to manage your plugins, first place the following
in your .vimrc (Don't close Vim):
```vim
Plug 'FrancescoMagliocco/vim-uctags'
```

While still in your .vimrc, run the following commands:
```vim
:source %
:PlugInstall
```

### Pathogen
Unlike the previous 3 plugin managers, if you're using [Pathogen][pathogen] to
manage your plugins, the process is a bit different, but still still simple.
Just run the following commands in a terminal of your choosing:
```bash
cd ~/.vim/bundle
git clone https://github.com/FrancescoMagliocco/vim-uctags
```

## Features
Vim-UCTags is full of features; Vim-UCTags also changes how it functions on
occasion—sometimes frequently.  I am regularly profiling function and comparing
different approaches to achieve the same result but more efficiently.  

STILL NEEDS WORK
Some or complete and some aren't.  Some
features still need to be implemented and some are just a thought.  The list of
features you're about to see is not the full list, and there will be for sure
some features left out or forgotten.

### Syn Files
Syn Files are identical to Vim's [Syntax Files][vim-syn-files] except, rather
than be associated for a particular language, they are associated for a single
file; furthermore, **Syn FIles** are simply a Vim Script of either
*syn-keyword* commands, *syn-match* commands or both<sup>\*</sup>―the latter
being default.  
<sup>\* The option [g:uctags\_use\_keyword][use-keyword] is the main
contributor in using both *syn-keyword* and *syn-match* commands.</sup>

Hereafter, *source file* will be used to identify the file in the active buffer
of Vim.

Syn Files are named by appending *.syn* to a filename; that said, you can
easily recognize what  source file a Syn File is associated to―a Syn File with
name 'foobar.c.syn' would be associated to the source file 'foobar.c'.

Syn Files are created with the [:CreateSynFiles][createsynfiles] command.  When
executing `:CreateSynFiles`, a Syn File will be created for every file in the
tags file has a language homogeneous to the language of the source file
`:CreateSynFiles` was issued from.

#### Example
The source file 'foobar.c' is where `:CreateSynFiles` is issued from (*issued*
meaning that is where the user performed the command); all languages that are
homogeneous to the language of `C` will have Syn Files generated for them; this
includes `C++` as there isn't *much* distinction between the two, and in some
cases are interchangeable.  The same goes for when `C++` is the language of the
source file where `:CreateSynFiles` was issued from; all files in the tag file
that consist of the language `C` will have Syn Files generated as well.

### Smart Syn<sup>\*</sup>
<sup>\* Temporary name until a more conspicuous one rises.</sup>  
Hereafter, when referring to the term *include directive*; it will be ambiguous
such that, *import delclarations* i.e. C# `namespace`s, Python `import`'s and
anything alike, are validly represented.

Hereafter, the term *include file* will refer to the file regarded in the
include directive.  
```c
// include directive
#include "include-file.h"
```

Hereafter, the term *source Syn File* will used to identify the [Syn
File][syn-files] associated with the source file, whether or not it exists.

Hereafter, the term *include Syn File* will used to identify the Syn File
associated with the include file, whether or not it exists.

For languages that implement use of include directives; when executing the
[:UpdateSynFile][updatesynfile] command, the source file which `:UpdateSynFile`
was issued from will have each line (With respect to what option
[g:uctags\_max\_lines\_header\_search][max-lines-header-search] is set to)
analyzed for an include directive.  If an include directive is found and the
include file exists along with the include Syn File, each line of the include
Syn File will be parsed retrieving the last section―a *pattern* or *keyword*;
the latter being

CHECK HOW *SYN-MATCH* and *SYN-KEYWORD* COME INTO PLAY!  ARE THEY TREATED
DIFFERENTLY?

be compared against ever line in the source file, looking for a match.  If
there is a match, the line in the include Syn File that had its
*pattern/keyword* matched; that whole line will be appended to the source Syn
File―only if the source Syn File doesn't already contain an exact replica of
the line.

After the include Syn File has had each line compared against each line of the
source Syn File, the include file is now analyzed just as the source file
was.  The only difference is, now if an include directive is found, the include
Syn File for the **new** include file wont be compared against each line of the
include file which is being analyzed.  Instead, the **new** include Syn File
(include Syn File for the previous mentioned **new** include file) will be
compared against the source file just like before.  This is because we are
updating the source Syn File.

This process continues there are no more include directives found or if the
limit set in option [g:uctags\_max\_syn][max-syn] is reached―whatever comes
first.

Every include file that is analyzed is kept track of so that same include file
isn't analyzed more than once.

They include Syn Files are left intact and untouched.  Only the source Syn File
is modified.

<sup>NOTE: The word 'Highlight' is *italicised* because at the current stage of
development, *Highlighting* isn't *exactly* done automatically.  If you change
buffers in a way that a buffer containing highlighted tags isn't visible
anymore; those highlighted tags wont be highlighted anymore when coming back to
that buffer.  This is done intentionally while in development stage.  The
final product will maintain highlights navigating through buffers whether the
visibility of a buffer changes or not.</sup>

### Smart Syn
For now I am calling this Smart Syn just because I don't know what else to call
this feature.

Essentially what this feature does is, for languages that use the `#include`
directive and equivalent (An equivalent would be the Go language using the
`import` declaration which still needs a lot of work.  Less than bare basic
support the `import` declarations is supported right now) such as C and C++,
reading tags to be highlighted, the file that is to be highlighted has every
line searched for an `#include` directive.  Once one is found, if there is a
syn file associated with that header, that syn file is `sourced`.  Whether a
syn file for the header existed or not, that header is now searched for
`#include` directives as well and if there is a syn file associated with that
header, it to is sourced.  This process is continued until there are no more
headers.

The way these headers are found is done so through a long and sometimes
confusing procedure.  If there are multiple headers in the initial file that is
to be highlighted, they will not be skipped.  Same goes for if there are
multiple headers inside of a header; they will not be skipped.  However, during
this *procedure*, if the syn file for a header has already been sourced, it
will NOT be sourced again.  No matter where a header may be; there could be a
header foobar.h in the initial file to be highlighted, and the **exact** same
header could be included deep 50 levels in another header..  It will not be
sourced.  Emphasis on *exact* is because, the way a header is declared to be
**exactly** the same as some other header is not only by the name of the
header, but the path as well.  There can be multiple headers with the same
name, but only one with that name in a given path.

#### Planned Implementations for Smart Syn
- [x] Option for max depth a header can be processed
- [x] Option to limit how many lines can be searched to find a header

### Smart Syntax Files
Not to be confused with [Syn Files][syn-files] but yes another stupid use of
the word *Smart*..

Syntax files for languages that have parts missing such as functions, will be
added.  For languages such as C that require a header for some functions, those
functions wont be highlighted unless the corresponding header is included.

## Future Features
- [ ] Option to specify additional *external* syn and tag files
- [ ] Config file for



## Global Options
This section will break down each global option, explaining what the option
does, if the option depends on another option or options, whether or not those
options to be set and what they outcome will be with different combinations of
options.  The default value for options will also be shown where applicable.
The default of some options will require you to refer to the source code.

### g:uctags\_executable
**Default: 'ctags-universal'**  
Name of the universal-ctags executable.  Typically the default should suffice.
If you built universal-ctags manually and didn't change `--program-prefix` or
`program-transform-name`, set `g:uctags_execuable` to *'ctags'* (Shown below)
in your *.vimrc*.
```vim
let g:uctags_executable = 'ctags'
```

#### NOTE
If you did change `--program-prefix`, make sure to append *ctags* to
`g:uctags_execuable`:

##### Examples
If you're confused as to if you need to include a dash (*-*) when setting
`g:uctags_executable`, the following should give you some clarification.
`--program-prefix=my`
```vim
let g:uctags_executable = 'myctags'
```
`--program-prefix=my-`
```vim
let g:uctags_executable = 'my-ctags'
```
`--program-prefix=my-ctags`
```vim
let g:uctags_executable = 'my-ctagsctags'
```

##### TODO
- [ ] Make the example more appealing

### g:uctags\_extra\_args
**Default: {}**  
Extra arguments to pass to universal-ctags.  Extra arguments are specified
using a dictionary.  The format to specify extra arguments is
`{argument}=:{value}`.  The equal sign is needed.  If the argument you're
specifying, doesn't take a value, such as `-R` (*Recursion*), just give an
empty string (*''*) for `{value}`.  Even though `-R` does not take a value, the
equal sign is needed.

Everything specified in `g:uctags_extra_args`, has a higher precedence over the
default arguments provided internally.  `g:uctags_extra_args`
will be appended to the internal arguments vim-uctags passes to
universal-ctags.  If you want to change a default argument, do so here, not by
changing  [g:uctags\_args][args].  You are likely to break
vim-uctags if you change `g:uctags_args`.  Be careful when disabling different
*kinds*, as that may break vim-uctags as well.

Vim-uctags will not be able to understand the tags file, if the option
`--fields` contains the `-K` flag.  Consequently, the `--fields` option will
require the `+K` flag.  From the current development state, the *kind* of tag,
must be described as a *full-name* and not a *single-letter*.  In the future
this is likely to change.

In order for vim-uctags to parse the tag file, vim-uctags requires the option
`--fields` to contain the `+z` or `+{kind}`, and `+l` or `+{language}` flags.

Universal-ctags allows a select few options to licitly be specified numerous
times.  Unfortunately, due to the structure of dictionaries, if an option is
specified numerously, only the latter will be validated.

#### NOTE
If both `g:uctags_args` and `g:uctags_extra_args` hold the same option,
whatever was stored in `g:uctags_args` by that option, will be discarded and
replaced with what `g:uctags_extra_args` holds for that option.  This includes
the default arguments that make vim-uctags operable.  There **will** be a fix
for this.

### g:uctags\_use\_keyword
**Default: 0**  
When `g:uctags_use_keyword` is enabled, Vim will use *syn-keyword* (If
[g:uctags\_use\_only\_match][use-only-match] is disabled) and *syn-match* (If
[g:uctags\_skip\_non\_keyword][skip-non-keyword] is disabled) when
highlighting.

It is not recommended to use *syn-keyword* for highlighting.  Even though
*syn-keyword* is a lot faster, you will run into issues with that tags that
have the same name, but are of different *kinds*.

#### TODO
- [ ] Explain in more detail

### g:uctags\_skip\_non\_keyword
**Default: 0**  
If `g:uctags_skip_non_keyword` is enabled, any patterns in
[g:uctags\_match\_map][match-map] that aren't equal to
[g:uctags\_default\_match][default-match] will be skipped.

#### NOTE
In order for `g:uctags_skip_non_keyword` to successfully work,
[g:uctags\_use\_keyword][use-keyword] needs to be enabled, and
[g:uctags\_use\_only\_match][use-only-match] needs to be disabled.

### g:uctags\_use\_only\_match
When `g:uctags_use_only_match` is enabled, Vim will **only** use the much
slower, but much *much* more accurate *syn-match*.

The option `g:uctags_use_only_match` has a higher precedence than
[g:uctags\_use\_keyword][use-keyword],
[g:uctags\_skip\_non\_keyword][skip-non-keyword] and
[g:uctags\_use\_keyword\_over\_match][use-keyword-over-match].
Regardless if any the aforementioned options are enabled or not, will not affect
`g:uctags_use_only_match`.  Thus, `g:uctags_use_only_match` will perform as
intended no matter the situation.

### g:uctags\_use\_keyword\_over\_match
**Default: 0**  
`g:uctags_use_keyword_over_match` applies to when a pattern in
[g:uctags\_match\_map][match-map] is equal to
[g:uctags\_default\_match][default-match], or if there isn't an entry
for the patterns corresponding *kind*.

It is not recommended to use *syn-keyword* for highlighting.  Even though
*syn-keyword* is a lot faster, you will run into issues with that tags that
have the same name, but are of different *kinds*.

#### TODO
- [ ] Explain in more detail

### g:uctags\_max\_lines\_header\_search
**Default: 0**  
Maximum lines to search files of languages that support include directives
(*And alike*), for an include directive.  Setting a limit will increase
performance as whole files wont be searched.  The downfall however is, if there
is an include directive beyond what `g:uctags_max_lines_header_search` is set
to, vim-uctags will won't know about it, and any tags that may have been defined
with respect to the file associated with the include directive, will not be
highlighted for the active buffer.

### g:uctags\_use\_perl
**Default: 1 (If Vim is compiled with the `+perl` feature)**  
Each function that utilizes Perl, will first check if Vim has support for Perl.
If Perl isn't supported, the Vim variant functions will be used.  It is highly
recommended to use Perl, especially for larger projects with an exceedingly
amount of tags.  You **will** notice an enormous increase in performance.  You
do not need any knowledge of how to use Perl.

### g:uctags\_max\_syn
**Default: 0 (Unlimited)**  
Maximum amount of [syn files][syn-files] to be processed and included when
updating the syn file for the active buffer.

Syn files are named by appending *.syn* to the end of a file name.

Foo.c has a syn file called Foo.c.syn.  
The active buffer is Foo.c.  
Foo.c contains include directives for Bar.h, FooBar.h and BarFoo.h.  
Each header has a syn file; Bar.h.syn, FooBar.h.syn and BarFoo.h.syn.

Setting `g:uctags_max_syn` to 2, will only process **one** of those syn files,
and update the syn file for Foo.c.  This is because the syn file for Foo.c
(Foo.c.syn) counts as one syn file.

The order for which include directives are shown in Foo.c, does not determine
the order the syn files of the aforementioned include directives will be
processed.  There is no guarantee of the order due to sorting and removing
duplicates.

For projects that have piles of include directives in a single source file,
setting a limit for how many syn files can be processed and included can
improve performance substantially.  However, the same drawback as in
[g:uctags\_max\_lines\_header\_search][max-lines-header-search] is
perpetual.

#### TODO
- [ ] Make any value less than or equal to 0, unlimited

### g:uctags\_skip\_kind\_for
**Default: See plugin/uctags/uctags_globals.vim**  
Skips highlighting a specific *kind* for a particular language, or all
languages.  This is done so using a dictionary.  The format is
`{kind}:[{languages|all}]`.  The key `{kind}` is a string of the *kind* of tag.
The value `[{languages|all}]` must be a list containing languages you wish to
skip highlighting `{kind}` for, or all.

To see a full of *kinds*, run the command `ctags-universal --list-kinds-full`,
or `ctags-universal --list-kinds<language>` for language specific *kinds*.

To see a list of supported languages, run the command `ctags-universal
--list-languages`.

#### TODO
- [ ] Properly link *plugin/uctags/uctags_globals.vim*
- [ ] Give examples

### g:uctags\_kind\_to\_hlg
**Default: See plugin/uctags/uctags_globals.vim**  
Maps each *kind* to a group-name when creating syn files.  This motive is for
granular control on how

#### TODO
- [ ] Properly link *plugin/uctags/uctags_globals.vim*
- [ ] Finish document
- [ ] Give examples

### g:uctags\_default\_match
**Default: { 'start' : '/\<',  'end' : '\>/' }**  

#### TODO
- [ ] Finish document

### g:uctags\_match\_map
**Default: See plugin/uctags/uctags_globals.vim**  
A dictionary containing *kinds* that map to a pattern to be used for when using
*syn-match* during highlighting.  There is two formats that can be used.
`{kind}:{ 'start':{start-pattern}, 'end':{end-pattern} }` and `{lang}:[{kind}:{ 
'start':{start-pattern}, 'end':{end-pattern} }]`

The former binds for every *kind*, barring *kind* is not bound to the language
in operation, thus the latter has the higher precedence.

#### TODO
- [ ] Properly link *plugin/uctags/uctags_globals.vim*
- [ ] Elaborate and enlighten
- [ ] Finish document
- [ ] Give examples

### g:uctags\_args
**Default: See plugin/uctags/uctags_globals.vim**  
Discards all arguments vim-uctags passes to universal-ctags, in favor of what
`g:uctags_args` is set to.  This is not recommended, as this will likely break
vim-uctags, resulting in vim-uctags operating in a way that wasn't intended.

#### TODO
- [ ] Properly link *plugin/uctags/uctags_globals.vim*
- [ ] Create a *pre* and *post* option of strings for options to be prefixed
and appended to `g:uctags_args` and
[g:uctags\_extra\_args][extra-args] respectively.

### g:uctags\_hl\_group\_map
**Default: See plugin/uctags/uctags_globals.vim**  

### g:uctags\_lang\_map
**Default: See plugin/uctags/uctags_globals.vim**  

## Commands

### UpdateTags

### CreateSynFiles

### UpdateSynFile

### DeleteAllSyn

## Some Notes and Issues
When language is Python and using Perl, if there is a module that is just the
literal dot (.), it will be highlighted as a module; however, when not using
Perl, it wont be.  With that said, when Updateing a Syn File, Syn Files
generated while using Perl may have more lines than a when not using Perl.

For Python, if modules and improts span multiple lines, the wont be
highlgihted; I haven't implemented that yet.

[uctags]: https://ctags.io/ 'Universal Ctags'
[uctags-repo]: https://github.com/universal-ctags/ctags 'Universal Ctags Repo'
[perl-compiling]: https://vimhelp.org/if_perl.txt.html#perl-compiling 'Compiling Vim with Perl Interface'
[vundle]:  https://github.com/VundleVim/Vundle.vim 'Vundle, the plug-in manager for Vim'
[neobundle]: https://github.com/Shougo/neobundle.vim 'Next generation Vim package manager'
[vimplug]: https://github.com/junegunn/vim-plug 'Minimalist Vim Plugin Manager'
[pathogen]: https://github.com/tpope/vim-pathogen 'pathogen.vim: manage your runtimepath'
[vim-syn-files]: https://vimhelp.org/syntax.txt.html#%3Asyn-files 'Vim Syntax Files'
[syn-files]: #synfiles 'Syn Files'
[executable]: #guctags_executable 'g:uctags_executable'
[extra-args]: #guctags_extra_args 'g:uctags_extra_args'
[use-keyword]: #guctags_use_keyword 'g:uctags_use_keyword'
[skip-non-keyword]: #guctags_skip_non_keyword 'g:uctags_skip_non_keyword'
[use-only-match]: #guctags_use_only_match 'g:uctags_use_only_match'
[use-keyword-over-match]: #guctags_use_keyword_over_match 'g:uctags_use_keyword_over_match'
[max-lines-header-search]: #guctags_max_lines_header_search 'g:uctags_max_lines_header_search'
[use-perl]: #guctags_use_perl 'g:uctags_use_perl'
[max-syn]: #guctags_max_syn 'g:uctags_max_syn'
[skip-kind-for]: #guctags_skip_kind_for 'g:uctags_skip_kind_for'
[kind-to-hlg]: #guctags_kind_to_hlg 'g:uctags_kind_to_hlg'
[default-match]: #guctags_default_match 'g:uctags_default_match'
[match-map]: #guctags_match_map 'g:uctags_match_map'
[args]: #guctags_args 'g:uctags_args'
[hl-group-map]: #guctags_hl_group_map 'g:uctags_hl_group_map'
[lang-map]: #guctags_lang_map 'g:uctags_lang_map'
[updatetags]: #updatetags ':UpdateTags'
[createsynfiles]: #createsynfiles ':CreateSynFiles'
[updatesynfile]: #updatesynfile ':UpdateSynFile'
[deleteallsyn]: #deleteallsyn ':DeleteAllSyn'
