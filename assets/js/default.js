var baseDir = "";
var def = baseDir + "definitions.html";
var install = baseDir + "installing.html";
var dict = {
  uctagsHome: ["index.html", "Vim-UCTags"],
  ctags: ["https://ctags.io", "Universal-Ctags"],
  ctagsDocs: ["http://docs.ctags.io/en/latest/news.html",
    "Universal-Ctags Docs"],
  ctagsReadtags: ["http://docs.ctags.io/en/latest/news.html#readtags",
    "Readtags"],
  ctagsRepo: ["https://github.com/universal-ctags/ctags",
    "Universal Ctags Repo"],
  perlCompiling: ["https://vimhelp.org/if_perl.txt.html#perl-compiling",
    "Compiling Vim with Perl Interface"],
  vundle: ["https://github.com/VundleVim/Vundle.vim",
    "Vundle, the plug-in manager for Vim"],
  neoBundle: ["https://github.com/Shougo/neobundle.vim",
    "Next generation Vim package manager"],
  vimPlug: ["https://github.com/junegunn/vim-plug",
    "Minimalist Vim Plugin Manager"],
  pathogen: ["https://github.com/tpope/vim-pathogen",
    "pathogen.vim: manage your runtimepath"],
  vimSynFiles: ["https://vimhelp.org/syntax.txt.html#%3Asyn-files",
    "Vim Syntax Files"],
  vimBufWritePost: ["https://vimhelp.org/autocmd.txt.html#BufWritePost",
    "BufWritePost"],
  dataMunge: ["https://metacpan.org/pod/Data::Munge",
    "Data::Munge - various utility functions"],
  list2re: ["https://metacpan.org/pod/Data::Munge#list2re-LIST",
    "list2re LIST"],
  cpan: ["https://www.cpan.org/", "Comprehensive Perl Archive Network"],
  cpanInstallingModules: ["https://www.cpan.org/modules/INSTALL.html",
    "How to install CPAN modules"],
  synFiles: [baseDir + "synfiles.html", "Syn Files"],
  executable: [baseDir + "guctagsexecutable.html", "g:uctags_executable"],
  tagsFile: [baseDir + "guctagstagsfile.html", "g:uctags_tags_file"],
  extraArgs: [baseDir + "guctagsextraargs.html", "g:uctags_extra_args"],
  useKeyword: [baseDir + "guctagsusekeyword.html", "g:uctags_use_keyword"],
  skipNonKeyword: [baseDir + "guctagsskipnonkeyword.html",
    "g:uctags_skip_non_keyword"],
  useOnlyMatch: [baseDir + "guctagsuseonlymatch.html",
    "g:uctags_use_only_match"],
  useKeywordOverMatch: [baseDir + "guctagsusekeywordovermatch.html",
    "g:uctags_use_keyword_over_match"],
  usePerl: [baseDir + "guctagsuseperl.html", "g:uctags_use_perl"],
  maxSyn: [baseDir + "guctagsmaxsyn.html", "g:uctags_max_syn"],
  skipKindFor: [baseDir + "guctagsskipkindfor.html",
    "g:uctags_skip_kind_for"],
  kindToHlg: [baseDir + "guctagskindtohlg.html", "g:uctags_kind_to_hlg"],
  defaultMatch: [baseDir + "guctagsdefaultmatch.html",
    "g:uctags_default_match"],
  matchMap: [baseDir + "guctagsmatchmap.html", "g:uctags_match_map"],
  args: [baseDir + "guctagsargs.html", "g:uctags_args"],
  hlGroupMap: [baseDir + "guctagshlgroupmap.html", "g:uctags_hl_group_map"],
  langMap: [baseDir + "guctagslangmap.html", "g:uctags_lang_map"],
  updateTags: [baseDir + "updatetags.html", ":UpdateTags"],
  CreateSynFiles: [baseDir + "createsynfiles.html", ":CreateSynFiles"],
  updateSynFiles: [baseDir + "updatesynfiles.html", ":UpdateSynFiles"],
  deleteAllSyn: [baseDir + "deleteallsyn.html", ":DeleteAllSyn"],
  srcFile: [def + "#source-file", "Source File Definition"],
  srcSynFile: [def + "#source-syn-file", "Source Syn FIle Definition"],
  incDir: [def + "#include-directive", "Include Directive Defintion"],
  incFile: [def + "#include-file", "Include File Defintion"],
  incSynFile: [def + "#inc-syn-file", "Include Syn File Defintion"],
  vim: ["https://www.vim.org/", "Vim - the ubiquitous text editor"],
  vundleInstall: [install + "#vundle", "Install using Vundle"],
  neoBundleInstall: [install + "#neobundle", "Install using NeoBundle"],
  vimPlugInstall: [install + "#vimplug", "Install using VimPlug"],
  pathogenInstall: [install + "#pathogen", "Install using Pathogen"]
};
function ready() {
  var elements = document.getElementsByTagName('a');

  for (var i = 0; i < elements.length; i++) {
    if (dict.hasOwnProperty(elements[i].id)) {
      elements[i].setAttribute("href", dict[elements[i].id][0]);
      elements[i].setAttribute("title", dict[elements[i].id][1]);
    }
  }
}
document.addEventListener("DOMContentLoaded", ready);