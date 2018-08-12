" .vimrc
"
" Load general conf file
if filereadable(expand("\~/.vim/general.vim"))
  source \~/.vim/general.vim
endif

" Mapping conf fie
if filereadable(expand("\~/.vim/key-mapping.vim"))
  source \~/.vim/key-mapping.vim
endif

" Plugins
if filereadable(expand("\~/.vim/plugins.vim"))
  source \~/.vim/plugins.vim
endif