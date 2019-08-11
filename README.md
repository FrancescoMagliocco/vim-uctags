# Vim-UCTags
A Universal-Ctags highlighter

This README until it is fully finished is going to be a shit show, and
everything will be all over the place until I have everything in place.

Vim-UCTags is a [Vim][vim] plugin that utilizes [Universal-Ctags][uctags] in
such a way to make highlighting syntax more accurate by using the tags
generated.  This is done efficiently where a [Syn File][syn-files] is created
for every file that has an associated tag, rather than creating one massive Syn
File and sourcing it.  Creating one massive Syn File and sourcing it can cause
severe performance issues in Vim, even when doing something as simple as just
moving the cursor; furthermore, even powerful PC's can face performance issues
from massive Syn Files being sourced.  For accuracy, Vim-UCTags also recognizes
[include directives][inc-dir] for a select few languages (More are to be
supported as development continues).  An include directive that has an available
[include file][inc-file] and [include Syn File][inc-syn-file] is used to
highlight only tags that are present in a [source file][src-file].  If an
include Syn File has tags that a source file doesn't, those tags will be
ignored; why try to highlight something that isn't there.

## Requirements
Vim-UCTags has one mandatory requirement: [Universal-Ctags][uctags], which can
be built from source at [GitHub][uctags-repo], or installed using your package
manager.

### apt-get
For Debian and Debian derivatives, you can run the following in a terminal of
your choosing:

```bash
sudo apt-get -fV install universal-ctags --no-install-recommends
```

### pacman
For Arch Linux and Arch Linux derivatives, you can run the following in a
terminal of your choosing:

```bash
pacman -Syu universal-ctags-git
```
<sup>**NOTE:** You may need to issue this through `sudo` if you do not have
sufficient privileges.</sup>

Additionally, you will need the `find` command―provided by the
*findutils*<sup>\*</sup> (Should be installed by default if on
Linux)<sup>\*\*</sup> package.  
<sup>\* Package name based on Debian repositories.</sup>  
<sup>\*\* If not installed by default, consult your package manager.</sup>

## Optional Dependencies
Vim-UCTags has some optional, by **highliy** recommended, dependencies.  As of
right now, there is only one optional dependency; however, more may be
introduced later on in development.

### Perl
I can not emphasize enough the gain in performance when using Perl, especially
on large projects.  You do not need any knowledge whatsoever on how to use Perl
to take advantage of what it offers.

See [Compiling Vim with Perl Interface][perl-compiling] for instructions on how
to compile Vim with the Perl Interface.  If you installed Vim using your package
manager, all that should be required is for Perl to be installed―if not already.

#### Perl Prerequisites
In order for Vim-UCTags to utilize Perl, there is one prerequisite: The
function [list2re][list2re]―provided by the [Data::Munge][data-munge]
module―therefore `Data::Munge` being a dependent and furthermore required to be
installed to satisfy this prerequisite.

You can use your package manager or [CPAN][cpan] (See [How to install CPAN
modules][installing-modules]) to install the mentioned modules.

##### apt-get
If you're on Debian and Debian derivatives, enter the following into a terminal
of your choosing:

```bash
sudo apt-get -fV install libdata-munge-perl --no-install-recommends
```

##### pacman
If you're on Arch Linux and Arch Linux derivatives, enter the following into a
terminal of your choosing:

```bash
pacman -Syu perl-data-munge
```
<sup>**NOTE:** You may need to issue this through `sudo` if you do not have
sufficient privileges.</sup>  
<sup>I am unsure if this is the correct package as I do not use Arch
Linux.</sup>

## Installing
If you don't know how to install a plugin or need assistance, this section will
demonstrate how to do so using a few plugin managers.  Additionally, included
will be links to their respected repositories, in case you wish to check them
out.

If you're new to plugin managers and don't know what to choose, you can try them
all and see which one suites your needs and prefer more.  I personally use
[Vundle][vundle].

<sup>You are not limited to use these plugin managers.  If you use a different
one that isn't listed above, Vim-UCTags will still work as intended.</sup>

### Vundle
If you use [Vundle][vundle] (Which is what I personally use and recommend even
though I haven't tried many others) to manage your plugins, first place the
following in your *.vimrc* (Don't close Vim after doing so):

```vim
Plugin 'FrancesoMagliocco/vim-uctags'
```

While still in your *.vimrc*, run the following commands:

```vim
:source %
:PluginInstall
```

<sup>For Vundle version < 0.10.2, replace *Plugin* with *Bundle*.</sup>

### NeoBundle
If you use [NeoBundle][neobundle] to manage your plugins, first place the
following in your *.vimrc* (Don't close Vim after doing so):

```vim
NeoBundle 'FrancescoMagliocco/vim-uctags'
```

While still in your *.vimrc*, run the following commands:

```vim
:source %
:NeoBundleInstall
```

### VimPlug
If you use [VimPlug][vimplug] to manage your plugins, first place the following
in your *.vimrc* (Don't close Vim after doing so):

```vim
Plug 'FrancescoMagliocco/vim-uctags'
```

While still in your *.vimrc*, run the following commands:

```vim
:source %
:PlugInstall
```

### Pathogen
Unlike the previous 3 plugin managers, if you're using [Pathogen][pathogen] to
manage your plugins, the process is a bit different, but still simple.  Just run
the following commands in a terminal of your choosing:

```bash
cd ~/.vim/bundle
git clone https://github.com/FrancescoMagliocco/vim-uctags
```

If you get an error about a directory not existing, all you need to do is create
the directory using the following commands:

```bash
cd ~
mkdir -p .vim/bundle
```

## Definitions
In order to understand this **README** more effectively, the meaning of a few
distinct terms are to be made ambiguous, but still correlative.  Furthermore,
recognized words will be used sequentially to form lucid phrases.  All
definitions hold applicable throughout any encounters in this text unless
explicitly specified.

### *source file*
The phrase *source file* is used to identify the file in the current active
buffer of Vim: When you press <kbd>i</kbd> and start typing... The buffer that
you're typing in is the *source file*.

### *source Syn File*
The phrase *source Syn File* will be used to identify the [Syn File][syn-files]
associated with the [source file][src-file].  The *source Syn File* may not
always exists when being referred to.

### *include directive*
When referring to the term *include directive*, it will be ambiguous such that,
*import delcarations* i.e. `C#` `namespace`, `Python` `import` and anything
alike; are validly represented.

### *include file*
The phrase *include file* will refer to the file regarded in an [include
directive][inc-dir].

```c
// include directive
#include "include-file.h"
```

### *include Syn File*
The phrase *include Syn File* will be used to identify the [Syn File][syn-files]
associated with the [include file][inc-file].  The *include Syn File* may not
always exists when being referred to.

## Features
Vim-UCTags is full of features!  Vim-UCTags also changes how it functions on
occasion―sometimes frequently.  I am regularly profile functions and comparing
different approaches to achieve the same results but more efficiently.

Missing highlighting for some languages have been added:
- javascript
- c
- c#

**THIS MAY NOT HAVE TO BE INCLUDED**  
Max depth an include Syn File can be processed

Critical Args are always passed with soon an option being implemented to disable
them.

Universal-Ctags doesn't recognize `using foo.bar;` as an *import*; a custom
regex pattern has been added to bypass this.  There is no option to turn it off.

**STILL NEEDS WORK**  
Some features still need to be implemented and some are just a thought.  The
list of features you're about to see is not the full list, and there will be for
sure some features left out or forgotten.

### Syn Files
Syn Files are identical to Vim's [Syntax Files][vim-syn-files] except, rather
than be associated for a particular language, they are associated for a single
file.  Furthermore, **Syn Files** are simply a Vim Script of either
*syn-keyword* commands, *syn-match* commands or both<sup>\*</sup>―*syn-match*
being the default.  
<sup>\* The option [g:uctags\_use\_keyword][use-keyword] is the main contributor
in using both *syn-keyword* and *syn-match* commands.</sup>

Syn Files are named by appending *.syn* to a filename.  That being said, you can
easily recognize what source file<sup>\*</sup> a Syn File is associated to: A
Syn File with name *foobar.c.syn* would be associated to the source
file<sup>\*</sup> *foobar.c*.  
<sup>\* *source file* is not to be confused with [source file][src-file] in this
context.  In this context, *source file* refers to any file that can have a Syn
File generated for.</sup>

Syn Files are created with the [:CreateSynFiles][createsynfiles] command.  When
executing `:CreateSynFiles`, a Syn File will be created for every file in the
tags file that is a language homogeneous to the language of the [source
file][src-file] which `:CreateSynFils` was issued from.

#### Example
The source file *foobar.c* is where `:CreateSynFiles` was issued from (*issued*
meaning: That is where the user executed the `:CreateSynFiles` command).  All
files in the tag file with languages homogeneous to the language of `C`, will
have Syn Files generated for them; this includes the language `C++` as there
isn't *much* distinction between the two, and in some cases are interchangeable.
The same goes for when `C++` is the language of the source file where
`:CreateSynFiles` was issued from: all files in the tag file that consist of the
language `C` will have Syn Files generated as well.

### Smart Syn
Prior to highlighting a [source file][src-file] of languages that utilize
[include directives][inc-dir], the tags file is searched for any include
directive that the source file has.  With those found include directives,
Vim-UCTags attempts to locate the corresponding [include file][inc-file] for
each of the include directives.

Each include file found is then added to two different lists:
1. Used for iterating the found include files
2. Used for keeping track of what include files have been found―we will refer to
   this one as the *skip list*―so we don't analyze an [include Syn
   File][inc-syn-file] associated with the include file more than once during
   recursive iterations (Even if there is no include Syn File for an include
   file, we sill keep track so we know to skip it if encountered again)

We iterate the found include files, skipping ones that don't have an include Syn
File.  For include files that do have one, the *syn-pattern* or *syn-keyword*
section in each line of the include Syn File is compared against each line in
the source file, looking for a match.

If a match is found and the [source Syn File][src-syn-file] doesn't contain an
exact replica of the whole line *syn-pattern* or *syn-keyword* was part of; that
whole line will be appended to the source Syn File.

<sup>Though it would be more efficient to check if the source Syn File doesn't
already contain an exact replica of the whole line *syn-pattern* or
*syn-keyword* was part of; we wouldn't be able to remove *syn-pattern* and
*syn-keyword* commands from the source Syn File for *syn-patterns* or
*syn-keywords* that aren't present in the source file.</sup>

After the *syn-pattern* or *syn-keyword* section in each line of the include Syn
File has been compared to each line in the source file, the include file
associated with the include Syn File is then treated in a similar way the source
file was:

> The tags file is searched for any include directives the include file
> contains.  Vim-UCTags attempts to locate the include file for each found
> include directive, ignoring ones that are already in the *skip list*.  All
> newly found include files are added to the two previously mentioned lists and
> each include file that has an include Syn File is compared to the source file,
> performing the same operation as before.

This process continues until there are no more include directives found or if
the limit set in option [g:uctags\_max\_syn][max-syn] is reached―whatever comes
first.

### Smart Syntax Files
Not to be confused with [Syn Files][syn-files].

Syntax files for languages that have missing highlights for such as functions,
will be added.

For languages such as `C`―languages that utilize [include
directives][inc-dir]―those functions wont be highlighted unless the appropriate
header is included.

### Recognizes Header Guards
This feature has just recently been implemented.  When working with the
languages `C` and `C++`, after searching the tags for
[include directives][inc-dir]; if multiple [include files][inc-file] are found
for an include directive, the way the correct include file is selected is by
taking the directory of the file the include directive was found in and prefix
it to the file name the multiple include files were found under.  We replace any
forward slashes (*/*) and periods (*.*) with underscores (*\_*) and make the
whole string uppercase.  We use this to correlate a macro tag (Tags of $kind
*"macro"*) in the tags file and cross reference the *$input* section of the
macro tag to the *$input* section of each tag of the include files found for the
include directive, selecting the include file where the *$inputs* cross
referenced are indistinguishable.

## Future Features
- [ ] Option to specify additional *external* [Syn][syn-files] and tag files
- [ ] Have Vim-UCTags read a `config` file if present in the project root
directory

## Global Options
This section will break down each global option, explaining what the option
does, if the option depends on another option or options, whether or not those
options need to be set and what the outcome will be with different combinations
of options.  The default value of options will also be shown where applicable.
The default of some options will require you to refer to the source code.

### g:uctags\_executable
**Default: 'ctags-universal'**  
Name of the Universal-Ctags executable.  Typically the default should suffice.

If you built Universal-Ctags manually and you didn't change `--program-prefix`
or `--program-transform-name`, set `g:uctags_executable` to *'ctags'* (Shown
below)

#### NOTE
If you did change `--program-prefix`, make sure to append *ctags* to
`g:uctags_executable`

##### Examples:
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

#### TODO
- [ ] Make the examples more appealing

### g:uctags\_tags\_file
**Default: 'tags'**  
The file to be used for when generating and looking for tags.  This value will
be passed as an argument to the `-f` parameter for Universal-Ctags.

### g:uctags\_pre\_args
**Default: See _plugin/uctags/uctags\_globals.vim_**  
These arguments are prepended to [g:uctags\_args][args]; hence, they will
**PREVAIL IS NOT ACCURATE** prevail over `g:uctags_args`.

The purpose for this is when the precedence of arguments is significant,
specifying them here will assure they will appear before `g:uctags_args` and
[g:uctags\_extra\_args][extra-args].

#### Example
Take into consideration that you want to enable all *$kinds* with the exception
of `C` *variables*.  To achieve this, one might be tempted to do the following:

```vim
if !exists('g:uctags_extra_args')
  let g:uctags_extra_args = {}
endif

let g:uctags_extra_args['--kinds-all='] = '*'
let g:uctags_extra_args['--kinds-c=']   = '-{variable}'
```

At first glance, this looks appropriate: `--kinds-c='-{variable}'` has a higher
precedence, but if you recall, dictionaries in Vim guarantee no order; the order
is arbitrary.  With that said, `--kinds-c='-{variable}'` could appear before
`--kinds-all='*'` resulting the latter having precedence; furthermore, producing
undesirable results: *variable* will still be enabled for the language `C` as
`--kinds-all='*'` will override `--kinds-c='-{variable}'`.

To successfully achieve the desired results, we would perform the following:

```vim
if !exists('g:uctags_pre_args')
  let g:uctags_pre_args = {}
endif

let g:uctags_pre_args['--kinds-all='] = '*'

if !exists('g:uctags_extra_args')
  let g:uctags_extra_args = {}
endif

let g:uctags_extra_args['--kinds-c='] = '-{variable}'
```

Now *variable* for the language `C` is guaranteed to be disabled.

#### Issues
Currently, along with [g:uctags\_args][args], `g:uctags_pre_args` does
hold some crucial arguments that Vim-UCTags depends on in order function
accordingly.  Therefore, changing `g:uctags_pre_args` in your *.vimrc* could
prove to be fatal.

#### TODO
- [x] Have critical *args* be defined in a script scope variable
- [ ] Have critical *pre-args* be defined in a script scoped variable
- [x] Have critical *post-args* be defined in a script scoped variable
- [ ] Have a global option to disable critical arguments―could prove useful for
debugging.

### g:uctags\_extra\_args
**Default: {}**  
Extra arguments to pass to Universal-Ctags.

Extra arguments are specified using a dictionary.  The format to specify extra
arguments is:  

    {option}[=]:{value}

The equal sign is only needed if the option requires a value.  `{value}` is
always needed even if the option doesn't require a value; in such case, just
give an empty string (*''*) for `{value}`:

```vim
if !exists('g:uctags_extra_args')
  let g:uctags_extra_args = {}
endif

let g:uctags_extra_args['-R'] = ''
```

Everything specified in `g:uctags_extra_args`, has a higher precedence than the
arguments provided internally by [g:uctags\_args][args].  As a
consequence, if `g:uctags_extra_args` and `g:uctags_args` have identical keys,
the value in `g:uctags_extra_args` will replace the value in `g:uctags_args` for
the identical key.

All keys in `g:uctags_extra_args` that are unique, will be appended to
`g:uctags_args`.

```vim
if !exists('g:uctags_args')
  let g:uctags_args = {}
endif

if !exists('g:uctags_extra_args')
  let g:uctags_extra_args = {}
endif

let g:uctags_args['-R']           = ''
let g:uctags_args['--kinds='] = '*'
let g:uctags_args['--kinds-c=']   = '+{header}'

let g:uctags_extra_args['--recurse']  = ''
let g:uctags_extra_args['--kind=']    = ''
let g:uctags_extra_args['--kind-C='] = '-{header}'

```

Every key here is unique, even though the options in keys for `g:uctags_args`
have the exact same meaning as the options in keys for `g:uctags_extra_args`;
however, the results are different as their `{values}` are different.

For keys `-R` and `--recurse`, the results of both are equivalent; however, the
remaining keys is where we run into confliction:
- The keys `--kinds` and `--kind` in `g:uctags_args` and `g:uctags_extra_args`
  respectively, are unique as the former has a *s* appended, whereas the latter
  does not.  Furthermore, the value for each of these keys have different
  results, and which one to prove significant is inconclusive.
- The keys `--kinds-c` and `--kind-C` in `g:uctags_args` and
  `g:uctags_extra_args` respectively, are unique for the same reason as
  mentioned in the previous point: the former has a *s* appended, whereas the
  latter does not.  Moreover, similar to the previous point, the value for each
  of these keys have different results, and which one to prove significant is
  inconclusive.
  
  You may have noticed the *c* in the former is lowercase, whereas in the latter
  it is uppercase.  This is neglected as each key in `g:uctags_args` and
  `g:uctags_extra_args` are converted to lowercase.

If you want to change the value of a default argument, do so here, not by
changing `g:uctags_args`.  You are likely to break Vim-UCTags if change
`g:uctags_args`

Vim-UCTags will not be able to understand the tags file if the option `--fields`
contains the `-K` flag.  Consequently, the `--fields` option requires the `+K`
flag to function correctly.  From the current development state, the *$kind* of
tag must be described as a *full-name* and not a *single-letter*.  In the
future, this is likely to change.

In order for Vim-UCTags to parse the tag file, Vim-UCTags requires the option
`--fields` to contain the `+z` (or `+{kind}`) and `+l` (or `+{language}`) flags.

#### WARNING
If both `g:uctags_args` and `g:uctags_extra_args` hold the same option―key―,
whatever was stored in the former for that option, will be discarded and
replaced with what `g:uctags_extra_args` held for that option.  This includes
critical arguments that make Vim-UCTags function correctly.  There **will** be a
fix for this.

#### TODO
- [x] Create option `g:uctags_pre_args`
- [ ] Create option `g:uctags_post_args`
- [x] When parsing args, convert to lowercase
- [ ] When parsing args, recognize similar options: `-R` and `--recurse` are the
same.  `--kinds` and `--kind` are the same.  Doing this will have the added
ability to warn on invalid arguments

### g:uctags\_use\_keyword
**Default: 0**  
When enabled, Vim will use *syn-keyword* (If
[g:uctags\_use\_only\_match][use-only-match] is disabled) and *syn-match* (If
[g:uctags\_skip\_non\_keyword][skip-non-keyword] is disabled) when highlighting.

The way Vim-UCTags determines whether or not a tag can be highlighted using *syn-keyword*, is if the pattern in [g:uctags\_match\_map][match-map] for the *$kind* being highlighted is equal to [g:uctags\_default\_match][default-match].  If there is no key for *$kind* in `g:uctags_match_map`, `g:uctags_default_match` is used, resulting in *syn-keyword* being applicable.

If the pattern for *$kind* is not equal to `g:uctags_default_match`, then *$kind* isn't applicable to use *syn-keyword*.

**SAYING HIGHLIGHTING IS INCORRECT...partially**

If [g:uctags\_use\_only\_match][use-only-match] is enabled, any option that requires `g:uctags_use_keyword`, will be disabled implicitly, regardless the state of `g:uctags_use_keyword`.

It is not recommended to use *syn-keyword* for highlighting.  Even though
*syn-keyword* is a lot faster than *syn-match*, it is also a lot less accurate
than *syn-match* and you will run into issues with tags that have the same
*$name* but are of different *$kinds*.

#### TODO
- [ ] Explain in more detail
- [ ] Give example

### g:uctags\_skip\_non\_keyword
**Default: 0**  
When enabled, any patterns in [g:uctags\_match\_map][match-map] that aren't
equal to [g:uctags\_default\_match][default-match] will be skipped.

`g:uctags_skip_non_keyword` relies on:
- [g:uctags\_use\_keyword][use-keyword] being enabled
- [g:uctags\_use\_only\_match][use-only-match] being disabled

### g:uctags\_use\_only\_match
**Default: 1**  
When enabled, Vim will **only** use the much slower, but much **much** more
accurate *syn-match*.

`g:uctags_use_only_match` has a higher precedence than:
- [g:uctags\_use\_keyword][use-keyword]
- [g:uctags\_skip\_non\_keyword][skip-non-keyword]
- [g:uctags\_use\_keyword\_over\_match][use-keyword-over-match]

Regardless the state of the mentioned options; `g:uctags_use_only_match` will
not be affected when enabled.

### g:uctags\_use\_keyword\_over\_match
**Default: 0**  
This applies to when a pattern in [g:uctags\_match\_map][match-map] is equal to
[g:uctags\_default\_match][default-match], or if there isn't an entry for the
pattern corresponding to *$kind*―which in that case, `g:uctags_default_match` is
used, resulting in the former condition binding.  In these conditions, *syn-keyword* will be used instead of *syn-match*.

If a pattern in `g:uctags_match_map` does exist, then *syn-match* will still be used for the *$kind* key `{kind}` that pattern was a value of.

`g:uctags_use_keyword_over_match` relies on:
- [g:uctags\_use\_keyword][use-keyword] being enabled
- [g:uctags\_use\_only\_match][use-only-match] being disabled

It is not recommended to use *syn-keyword* for highlighting.  Even though
*syn-keyword* is a lot faster than *syn-match*, it is also a lot less accurate
than *syn-match* and you will run into issues with tags that have the same
*$name* but are of different *$kinds*.

### g:uctags\_use\_perl
**Default: 1 (If Vim is compiled with the `+perl` feature)**  
Each function that utilizes Perl will first check if Vim has support for Perl
compiled.  If Perl isn't supported, the Vim variant functions will be used.

It is highly recommended to use Perl, especially for larger projects with an
exceedingly amount of tags.  You **will** notice an increase in performance.

You do not need any knowledge whatsoever on how to use Perl to take advantage of
what it offers.

### g:uctags\_use\_readtags
**Default: 1**  
As mentioned on the official [Universal-Ctags][uctags] [Docs][uctags-docs] about
[readtags][readtags]:

> Currently this feature is only available on platforms where `fmemopen` is
> available as part of libc.  Filtering in readtags is an experimental feature.

Prior to the implementation of this feature into Vim-UCTags, the way tags were
searched was by manually parsing through the entire tags file.  From a coding
point of view, this was very tedious and on occasion was a bottleneck,
especially when the tags file had an immense amount of lines.  With that said,
the performance increase is most likely marginal at best with hope in being
greater in the future.

Similar to [g:uctags\_use\_perl][use-perl], there are Vim and Perl variant
procedures that are utilized when not using `readtags`.

### g:uctags\_max\_syn
**Default: 0 (Unlimited)**  
Determines the max amount of [Syn Files][syn-files] to be processed and included
when updating the [source Syn File][src-syn-file] with the command
[:UpdateSynFile][updatesynfile].

Setting this to 1 will only process and update the source Syn File.

For projects that have an abundant amount of [include directives][inc-dir] in a
single [source file][src-file], or where stacks of include directives are found
several levels deep; setting a limit for how many can be processed and included
can improve performance substantially.  The downfall however is, some
*objectts*―and I use the term *objects* loosely here―may not be highlighted if
the *object* was defined in a include directive deeper than what
`g:uctags_max_syn` was set to.

#### TODO
- [ ] Make values any less than 0 be unlimited, so 0 can be specified to
determine nothing is to be done when [Updating a Syn File][updatesynfile].

### g:uctags\_skip\_kind\_for
**Default: See _plugin/uctags/uctags\_globals.vim_**  
Specifies *$kinds* of tags for particular (Or all) languages be skipped and not
have *syn-match* and/or *syn-keywords* created for, when [Syn Files][syn-files]
are being created (Or updated) as a result from executing the
[:CreateSynFiles][createsynfiles] command.  This is done so using a dictionary.
The format is:

    {kind}: [{languages|all}]

The key `{kind}` is a string of the *$kind* of tag you wish to disable creating
*syn-match* and *syn-keyword* commands for, for the list of *languages*
specified in value `[{languages|all}]`.

The order for which the list of items appears in the value for key `{kind}` is
insignificant.  If the list of items contains the item *all*, no matter the
position, *all* languages for the *$kind* key `{kind}` the item *all* was part
of, will not have *syn-match* and *syn-keyword* commands created for:

```vim
if !exists('g:uctags_skip_kind_for')
  let g:uctags_skip_kind_for = {}
endif

let g:uctags_skip_kind_for['local'] = ['c', 'c++', 'all']
```

For the example above, not only will languages `C` and `C++` have *syn-match*
and *syn-keywords* commands for the *local* *$kind* of tag skipped and not
created, but no *syn-match* and *syn-keyword* commands will be created for any
*local* *$kind* of tag.

To see a full list of *$kinds*, run the following command in a terminal of your
choosing:

```bash
universal-ctags --list-kinds-full
```

If you want to see a list of language specific *$kinds*, run the following in a
terminal of your choosing:

```bash
universal-ctags --list-kinds-<language>
```

To see a list of languages supported by Universal-Ctags, run the following
command in a terminal of your choosing:

```bash
ctags-universal --list-languages
```

<sup>**NOTE:** `&ft` will not always be a valid language supported by
Universal-Ctags.  For the language `C#`, `&ft` expands to `cs`, and in all cases
except **maybe** when using `readtags`, `cs` will not be valid.  `c#` however
will work no matter the case.  Languages are not case sensitive.  They are all
converted to lowercase internally in Vim-UCTags.</sup>

### g:uctags\_kind\_to\_hlg
**Default: See _plugin/uctags/uctags\_globals.vim_**  
Maps each *$kind* to a *group-name* when creating [Syn Files][syn-files].  This
motive is for granular control on how

#### TODO
- [ ] Finish document
- [ ] Give examples

### g:uctags\_default\_match
**Default: { 'start' : '/\\<', 'end' : '\\>/' }**  
If there isn't a key for a *$kind* in [g:uctags\_match\_map][match-map], this will be used.

This is also used to determine whether or not a *$kind* in `g:uctags_match_map` can be highlighted using the *syn-keyword* command.

#### TODO
- [ ] Finish document

### g:uctags\_match\_map
**Default: See _plugins/uctags/uctags\_globals.vim_**  
A dictionary containing *$kinds* that map to a pattern to be used for when using
*syn-match* during creating (Or updating) [Syn Files][syn-files].

There is two formats that can be used:
1. `{kind}: { 'start': {start-pattern}, 'end': {end-pattern} }`
2. `{lang}: [{kind}: { 'start': {start-pattern}, 'end': {end-pattern} }]`

The former binds for *$kind*, barring *$kind* is not bound to the language of
the [source file][src-file]; thus, the latter having precedence.

```vim
if !exists('g:uctags_match_map')
  let g:uctags_match_map = {}
endif

let g:uctags_match_map['c++'] =
      \ { 'member': { 'start': '/\%\(\.\|->\)\<\zs', 'end': '\>/' } }

let g:uctags_match_map['c#']  =
      \ { 'method': { 'start': '/\<', 'end': '\ze\s*\%\((\|<\)/' },
      \   'field' : { 'start': '/\<', 'end': '\>\(\s*(\)\@!/' } }

let g:uctags_match_map['go']  = { 'member': g:uctags_default_match }

" Lets refer to these as 'global patterns'
let g:uctags_match_map['member'] = { 'start': '/\<', 'end': '\ze\s*(/' }
let g:uctags_match_map['method'] = { 'start': '/\<', 'end': '\ze(/' }
let g:uctags_match_map['field']  = { 'start': '/\<', 'end': '\ze(/' }

```

Lets break this down, first taking a look at the last 3 lines:
1. The last 3 lines demonstrate how the last format is used, and define *global
     patterns* for the following *$kinds*:
   - *"member"*
   - *"method"*
   - *"field"*

   These patterns will be used for every *$kind* of all languages, except for
   languages there is already a key for, and that key has a *key-value pair*
   that has a key of one the three *$kinds*.

2. `let g:uctags_match_map['c++']` demonstrates how the first format is used,
   and defines pattern for the *$kind* *"member"*.

   In the first point, the *$kind* *"member"* was already defined, but the
   pattern used is different than that of what was defined for the *$kind*
   *"member"* when the language of the source file is `C++`.

   The global pattern for the *$kind* *"member"* may be suitable for most
   languages, but for some such as `C++`, and many others; using the global
   pattern wont accurately highlight a *member*.  Therefore, using the global
   pattern for the *syn-pattern* section of a *syn-match* command when creating
   Syn Files, wont always be appropriate, which is why we define different
   patterns for languages that the global patterns wouldn't be appropriate for.

3. For `let g:uctags_match_map['c#']`, the principle is the same as the second
   point: The global patterns for the *$kind* *"method"* and *"field"* aren't
   appropriate to be used if the source file is of language `C#`.

   The reason why `C#` is shown here, is just so you can see that you can
   defined multiple *$kinds* for a particular language.

4. Lastly, `let g:uctags_match_map['go']`, similar to when the language of the
   source file was `C++`; the global pattern for the *$kind* *"member"* is not
   appropriate for when the source file is of the language `go`.

   For the language `go`, the
   [default pattern][default-match]―`g:uctags_default_match`―is appropriate,
   which is why we have assigned it to be used for the *$kind* *"member"* for
   the `go` language.

Languages used in `g:uctags_match_map` are required to be lowercase, and be
specified identically to how Universal-Ctags would (Ignoring case: the languages
need to be in lowercase).  To see a list of languages supported by
Universal-Ctags and how a language should be represented, run the following
command in a terminal of your choosing:

```bash
ctags-universal --list-languages
```

### g:uctags\_args
**Default: See _plugin/uctags/uctags\_globals.vim_**  
Discards all arguments Vim-UCTags passes to Universal-Ctags, in favor of what
this is set to.

This is not recommended, as this will likely break Vim-UCTags, resulting in
Vim-UCTags operating in a way that wasn't intended.

#### TODO
- [ ] Have an internal variable be the default args, that way this variable can be the one that overrides the default args resulting in `g:uctags_extra_args` actually being used for *extra* args.

### g:uctags\_hl\_group\_map
**Default: See _plugin/uctags/uctags\_globals.vim_**  
Using a dictionary, changes how *$kinds* are represented for when forming a *group-name* during the creation of [Syn Files][syn-files].

Most entries in this dictionary only modify the first letter in a *$kind* by making it an uppercase.  This makes the *group-name* easier to read making the *$language* (See [g:uctags\_lang\_map][lang-map]) and *$kind* section more transparent.

The format for this dictionary is very simple:

    {original-kind}: {modified-kind}

Keys must be of how *$kinds* are represented by Universal-Ctags, with the exception of case: the case must be lower.  For value `{modified-kind}`, this is where the textual representation is changed.  Make sure the change palpable.  As mentioned previously, typically the first letter of *$kind* is made uppercase:

```vim
if !exists('g:uctags_hl_group_map')
  let g:uctags_hl_group_map = {}
endif

let g:uctags_hl_group_map['header'] = 'Header'
```

Another common use is to shorten the form of some *$kinds* whether it be to follow the naming convention used in Vim, or Syntax plugins.

```vim
if !exists('g:uctags_hl_group_map')
  let g:uctags_hl_group_map = {}
endif

let g:uctags_hl_group_map['function'] = 'Func'
```

Some Syntax plugins like to use the phrase *Func* for the *$kind* *function*.  Unfortunately, at the current state of development, there is no way to specify and change the textual representation of *$kinds* for each individual language.  Further on in development, this is likely to change as the naming convention for one Syntax plugin, may be different for another.  

#### TODO
- [ ] Rename this variable; it's not exactly correlative
- [ ] Finish document
- [ ] Give examples
- [ ] Ability to change textual representation of *$kinds* for each individual language

### g:uctags\_lang\_map
**Default: See _plugin/uctags/uctags\_globals.vim_**  
Changes how languages are represented for when creating a *group-name* during the creation of [Syn Files][syn-files].

Some languages have long names and are inconvenient to type out and can take up a lot of screen space.  An example would be the language `reStructuredText`.

Some languages also have special characters that depending on where the language is used, could possibly cause problems such as during parsing, or when used in regular expression.  Some examples are: `C++` and `C#`.  Moreover, there may already be a prototypical *group-name* for a particular language and *$kind*, and if it is ubiquitous—like for *group-names* in Vim—it is ideal to follow it.

To achieve this, we use a simple dictionary of the following format:

    {full-language}: {short-language}

Both `{full-langauge}` and `{short-lanfuage}` are pretty unequivocal:

- `{full-language}` would be the full representation of a language.
- `{short-language}` would be a shorter or conventional representation of `{full-language}`

```vim
if !exists('g:uctags_lang_map')
  let g:uctags_lang_map = {}
endif

let g:uctags_lang_map['reStructuredText`] = 'rst'
let g:uctags_lang_map['c++']              = 'cpp'
let g:uctags_lang_map['c#']               = 'cs'
```

Language `reStructredText`, customarily uses *rst* as its formal representation—primarily for convenience.

For the remaining two: c++` and `c#`; it is encouraged to use *cpp* and *cs* as their representation respectively.

Any *$kind* of language `reStructuredText' will have `rst` prefixed to the *group-name*.  For *$kind* *header*: *rst* will be prefixed to the value in [g:uctags\_hl\_group\_map][uctags-hl-group-map].  If there is no key *header* in `g:uctags_hl_group_map`, the *$kind* will be used as is: *rstheader*

Keys are required to be lowercase as when searching for a key, the key used to lookup a key in the dictionary is converted to lowercase.

Acronym 


#### TODO
- [ ] Finish document
- [ ] Give examples

## Commands

### UpdateTags
Initially, the tags file ([g:uctags\_tags\_file][tags-file]) does not generate
automatically.  First you must execute the `:UpdateTags` command.  Once you have
done so, or if `g:uctags_tags_file` already exists, `:UpdateTags` will be
triggered every time the [BufWritePost][bufwritepost] event is triggered (Only
if `g:uctags_tags_file` exists).

The reason why tags aren't generated after `BufWritePost` event when the
`g:uctags_tags_file` doesn't exists, is to prevent tag files being created when
tag files aren't needed.

### CreateSynFiles
When executed, a [Syn File][syn-files] is created for every tag that is of a language homogeneous to the language of the [source file][src-file] `:CreateSynFiles` was issued from.

If Syn Files already exist or have been updated with the command [:UpdateSynFile][updatesynfile], th

### UpdateSynFile

### DeleteAllSyn
Simply deletes all [Syn Files][syn-files] by executing the following command:

```bash
find . -name '*.syn' -delete
```

This will effectively delete any and **all** files that are suffixed with
*.syn*.  The command is recursive and starts from the directory the command was
issued from.

## Notes
When the language is `Python` and using Perl, if there is a module that is just
a literal dot (*.*), when creating [Syn Files][syn-files], the literal dot will
be seen as a module and have highlighted accordingly; however, when not using
Perl, it wont be.  With that said, when updating a Syn File, Syn Files generated
while using Perl may have more lines than when not using Perl.

For `Python`, if modules and imports span multiple lines, Universal-Ctags wont
recognize so.  Highlighting will occasionally be inaccurate.  A work around
would be to parse the files manually.

Some *fields* in `C#` still wont have highlight lines created for.

## Known Issues
I've noticed that when building Universal-Ctags from source, language `maven2`
was not recognized.

[uctags]: https://ctags.io/ 'Universal Ctags'
[uctags-docs]: http://docs.ctags.io/en/latest/news.html 'Universal Ctags Docs'
[uctags-repo]: https://github.com/universal-ctags/ctags 'Universal Ctags Repo'
[perl-compiling]: https://vimhelp.org/if_perl.txt.html#perl-compiling 'Compiling Vim with Perl Interface'
[vundle]:  https://github.com/VundleVim/Vundle.vim 'Vundle, the plug-in manager for Vim'
[neobundle]: https://github.com/Shougo/neobundle.vim 'Next generation Vim package manager'
[vimplug]: https://github.com/junegunn/vim-plug 'Minimalist Vim Plugin Manager'
[pathogen]: https://github.com/tpope/vim-pathogen 'pathogen.vim: manage your runtimepath'
[vim-syn-files]: https://vimhelp.org/syntax.txt.html#%3Asyn-files 'Vim Syntax Files'
[bufwritepost]: https://vimhelp.org/autocmd.txt.html#BufWritePost 'BufWritePost'
[readtags]: http://docs.ctags.io/en/latest/news.html#readtags 'Readtags'
[data-munge]: https://metacpan.org/pod/Data::Munge 'Data::Munge - various utility functions'
[list2re]: https://metacpan.org/pod/Data::Munge#list2re-LIST 'list2re LIST'
[cpan]: https://www.cpan.org/ 'Comprehensive Perl Archive Network'
[installing-modules]: https://www.cpan.org/modules/INSTALL.html 'How to install CPAN modules'
[syn-files]: #syn-files 'Syn Files'
[executable]: #guctags_executable 'g:uctags_executable'
[tags-file]: #guctags_tags_file 'g:uctags_tags_file'
[extra-args]: #guctags_extra_args 'g:uctags_extra_args'
[use-keyword]: #guctags_use_keyword 'g:uctags_use_keyword'
[skip-non-keyword]: #guctags_skip_non_keyword 'g:uctags_skip_non_keyword'
[use-only-match]: #guctags_use_only_match 'g:uctags_use_only_match'
[use-keyword-over-match]: #guctags_use_keyword_over_match 'g:uctags_use_keyword_over_match'
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
[src-file]: #source-file 'Source File Definition'
[src-syn-file]: #source-syn-file 'Source Syn File Definition'
[inc-dir]: #include-directive 'Include Directive Definition'
[inc-file]: #include-file 'Include File Definition'
[inc-syn-file]: #include-syn-file 'Include Syn File Definition'
[vim]: https://www.vim.org/ 'Vim - the ubiquitous text editor'
