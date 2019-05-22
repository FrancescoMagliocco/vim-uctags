# vim-uctags
A Universal-Ctags highlighter

This README until it is fully finished is going to be a shit show, and
everything will be all over the place until I have everything in place.

## Requirements
The only requirement is [Universal-Ctags][uctags] which can either be installed
by building it from source which is hosted on [GitHub][uctags-repo] or with
your package manager.

For Debian and Debian derivatives, you can run the following in a terminal of
your choosing:

  `sudo apt-get -fV install universal-ctags --no-install-reommends`

The `-fV` fixes and any broken dependencies (f) and shows full versions of
upgraded and installed packages (V).

The `--no-install-recommends` makes it so no recommended packages (Unneeded
shit) are installed.

For the command `DeleteAllSyn` you will need the `find` command provided by the
*findutils* package, which should be installed by default.

<sup>**NOTE: I am unsure if vim-uctags will work on Windows or not.  If it does
not work on Windows, I do appologize, but until this plugin is finished and in
a working stable state, Windows support will not be a priority.**</sup>

## Installing
I'm sure you know how to install a Plugin for Vim, but just in case you don't,
here is a demonstration using [Vundle][vundle].

### Vundle
Add the following to your .vimrc in the appropriate area:

  `Plugin 'FrancescoMagliocco/vim-uctags'`

Write and Close `:wq`, followed by opening a new instance of Vim and running
`:PluginInstall`

## Features
Vim-UCTags is full of features.  Some or complete and some aren't.  Some
features still need to be implemented and some are just a thought.  The list of
features you're about to see is not the full list, and there will be for sure
some features left out or forgotten.

### Syn Files
Syn files are simply a Vim script that consists of lines of `syn match`
commands that when `sourced` will *Highlight* all tags for the corresponding
file.  The corresponding file is determined by the name of the file itself.

For example a syn file with the name 'foobar.c.syn' would be for a file called
'foobar.c'.

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
- [ ] Option for max depth a header can be processed
- [ ] Option to limit how many lines can be searched to find a header

### Smart Syntax Files
Not to be confused with [Syn Files](#syn-files) but yes another stupid use of
the word *Smart*..

Syntax files for languages that have parts missing such as functions, will be
added.  For languages such as C that require a header for some functions, those
functions wont be highlighted unless the corresponding header is included.

## Future Features
- [ ] Option to specify additional *external* syn and tag files
- [ ] Config file for


[uctags]: https://ctags.io/ 'Universal Ctags'
[uctags-repo]: https://github.com/universal-ctags/ctags 'Universal Ctags Repo'
[vundle]:  https://github.com/VundleVim/Vundle.vim 'Plug-in manager for Vim'
