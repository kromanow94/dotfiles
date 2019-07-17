call plug#begin('~/.vim/plugged')

""" Integration {{{
  "" Plugin: Vim Git {{{
    " For syntax highlighting and other Git niceties
    Plug 'tpope/vim-git'
  "" }}}

  "" Plugin: Sherlock {{{
    " Add completion for command line mode ':' after a '/', and in command line mode '/' and '?'.
    " Using <C-Tab>, <C-S-Tab>
    Plug 'vim-scripts/sherlock.vim'
  "" }}}

  "" Plugin: Vim Startify {{{
    " A fancy start screen for Vim
    Plug 'mhinz/vim-startify'
    " A list of files to bookmark
    let g:startify_bookmarks=[
    \ '~/.vimrc',
    \ '~/.vim/plugins.vim',
    \]
    " A list of Vim regular expressions that filters recently used files
    let g:startify_skiplist=[
    \ 'COMMIT_EDITMSG',
    \ $VIMRUNTIME .'/doc',
    \ 'plugged/.*/doc',
    \ 'bundle/.*/doc',
    \]
  "" }}}

  "" Plugin: Gundo {{{
    " Make browsing Vim's powerful undo tree less painful
    Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
    " Map GundoToggle to <F12>
    nnoremap <silent> <F12> :GundoToggle<CR>
    " Set the horizontal width of Gundo graph
    let g:gundo_width=40
    " Force the preview window below current windows
    let g:gundo_preview_bottom=1
    " Set 1 to open the right side instead of the left
    let g:gundo_right=0
    " Disable Gundo entirely if machine not support python
    if has('python')
      " That's good, use defaults
    elseif has('python3')
      let g:gundo_prefer_python3 = 1
    else
      let g:gundo_disable=1
    endif
    " Rendering diff automatically with cursor move
    let g:gundo_auto_preview=1
  "" }}}

  "" Plugin: supertab {{{
    Plug 'ervandew/supertab'
    let g:SuperTabClosePreviewOnPopupClose = 1
  "" }}}

  "" Plugin: neocomplete {{{
    Plug 'Shougo/neocomplete'
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Enable neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
    	return neocomplete#close_popup() . "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  "" }}}

  "" Plugin: vim-clang {{{
    Plug 'justmao945/vim-clang'
    " disable auto completion for vim-clang because of neocomplete
    let g:clang_auto = 0
    " enable auto cheks
    let g:clang_check_syntax_auto = 1

    " default 'longest' can not work with neocomplete
    let g:clang_c_completeopt = 'menuone,noinsert'
    let g:clang_cpp_completeopt = 'menuone,noinsert'

    " use neocomplete
    " input patterns
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif

    " for c and c++
    let g:neocomplete#force_omni_input_patterns.c =
                \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp =
                \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

  "" }}}

  "" Plugin: vim-codefmt {{{
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'

    augroup autoformat_settings
        autocmd!
        autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
        autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
        autocmd FileType python AutoFormatBuffer yapf
    augroup END

  "" }}}



  "" Plugin: neosnippet {{{
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    
    imap <C-k>    <Plug>(neosnippet_expand_or_jump)
    smap <C-k>    <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>    <Plug>(neosnippet_expand_target)
  "" }}}

  "" Plugin: Vim Fugitive {{{
    " The best Git wrapper
    Plug 'tpope/vim-fugitive'
  "" }}}

  "" Plugin: Auto Pairs {{{
    " For intensely orgasmic commenting
    Plug 'jiangmiao/auto-pairs'
    " Shortcut for fast wrapping the word
    let g:AutoPairsShortcutFastWrap='<C-e>'
    " Insert the key at the Fly Mode jumped postion
    let g:AutoPairsShortcutBackInsert='<C-b>'
  "" }}}

  "" Plugin: Tagbar {{{
    " Easy way to browse the tags
    Plug 'majutsushi/tagbar'
    " Map TagbarToggle to <F10>
    nnoremap <silent> <F10> :TagbarToggle<CR>

    " Tagbar config
    let g:tagbar_type_go = {
    	\ 'ctagstype' : 'go',
    	\ 'kinds'     : [
    		\ 'p:package',
    		\ 'i:imports:1',
    		\ 'c:constants',
    		\ 'v:variables',
    		\ 't:types',
    		\ 'n:interfaces',
    		\ 'w:fields',
    		\ 'e:embedded',
    		\ 'm:methods',
    		\ 'r:constructor',
    		\ 'f:functions'
    	\ ],
    	\ 'sro' : '.',
    	\ 'kind2scope' : {
    		\ 't' : 'ctype',
    		\ 'n' : 'ntype'
    	\ },
    	\ 'scope2kind' : {
    		\ 'ctype' : 't',
    		\ 'ntype' : 'n'
    	\ },
    	\ 'ctagsbin'  : 'gotags',
    	\ 'ctagsargs' : '-sort -silent'
    \ }
  "" }}}

  "" Plugin: NERDTree {{{
    " Explore filesystem with Vim
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    " Map NERDTreeToggle to <F4>
    nnoremap <silent> <F4> :NERDTreeToggle<CR>
    " Ignore some extensions
    let NERDTreeIgnore=['.o$','.pyc$']
    " Show hidden files
    let NERDTreeShowHidden=1
    " Automatically open NERDTree when vim start up with no files
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
    " Close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
  "" }}}

  "" Plugin: NERDTree Git Plugin {{{
    " A plugin of NERDTree showing git status flags
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " Use this variable to change symbols
    let g:NERDTreeIndicatorMapCustom = {
    \ 'Modified'  : '*',
    \ 'Staged'    : '✚',
    \ 'Untracked' : '✭',
    \ 'Renamed'   : '➜',
    \ 'Unmerged'  : '═',
    \ 'Deleted'   : '✖',
    \ 'Dirty'     : '✗',
    \ 'Clean'     : '✔︎',
    \ 'Unknown'   : '?'
    \ }
  "" }}}

  "" Plugin: Vim Indent Guides {{{
    " Visually displaying indent levels
    Plug 'nathanaelkane/vim-indent-guides', { 'for': ['vim', 'json', 'markdown'] }
    " Disable automatically calculates the highlight colors
    let g:indent_guides_auto_colors=0
    " Customize the size of the indent guide
    let g:indent_guides_guide_size=1
    " Control which indent level to start showing guides from
    let g:indent_guides_start_level=1
    " Enable on Vim startup
    let g:indent_guides_enable_on_vim_startup=1
    " Specify a list of filetypes to disable the plugin for
    let g:indent_guides_exclude_filetype=['help', 'nerdtree']
    " Unset the default mapping '<Leader>ig'
    let g:indent_guides_default_mapping=0
  "" }}}

""" Programming {{{
  "" Plugin: vim-go {{{
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
    let g:go_list_type = "quickfix"
    let g:go_fmt_command = "goimports"
    
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
  "" }}}
    
  "" Plugin: Vim Polyglot {{{
    " A collection of language packs for Vim
    Plug 'sheerun/vim-polyglot'
    " No conceal in JSON
    let g:vim_json_syntax_conceal=0
    " Enable syntax highlighting for JSDocs
    let g:javascript_plugin_jsdoc=1
  "" }}}

  "" Plugin: Syntastic {{{
    " Syntax checking for Vim with external syntax checker
    Plug 'scrooloose/syntastic'
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_loc_list_height=5
    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
    " For C / C++
    let g:syntastic_cpp_compiler='clang++'
    let g:syntastic_cpp_compiler_options=' -std=c++11'
    let g:syntastic_cpp_checkers=['cppclean', 'cppcheck', 'cpplint']
    let g:syntastic_cpp_cpplint_exec = 'cpplint'
    let g:syntastic_cpp_cpplint_args="--verbose=3 --filter=-whitespace/indent"
    " let g:syntastic_cppcheck_config_file
    " let g:syntastic_cppclean_config_file
    " For Python
    let g:syntastic_python_checkers=['flake8']
    " For Scala & Java
    " let g:syntastic_scala_checkers=['fsc', 'scalac']
    " For Javascript & Node.JS
    let g:syntastic_javascript_checkers=['eslint']
    let s:eslint_path=system('PATH=$(npm bin):$PATH && which eslint')
    let b:syntastic_javascript_eslint_exec=substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
    " let g:syntastic_javascript_checkers = ['jshint']
    " For Shell Script(sh, bash)
    let g:syntastic_sh_checkers=['shellcheck']
  "" }}}

  "" Plugin: UltiSnips {{{
    " Snippet engine for Vim
    Plug 'SirVer/ultisnips'
    " Configure keys trigerring UltiSnips
    " let g:UltiSnipsExpandTrigger='<Tab>'
    let g:UltiSnipsExpandTrigger='<C-l>'
    " let g:UltiSnipsJumpForwardTrigger='<Tab>'
    " let g:UltiSnipsJumpForwardTrigger='<C-j>'
    " let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
    " let g:UltiSnipsJumpBackwardTrigger='<C-k>'
    " let g:UltiSnipsListSnippets='<Tab>l'
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit='vertical'
  "" }}}

  "" Plugin: Vim Snippets {{{
    " Snippets are separated from the engine (for UltiSnips)
    Plug 'honza/vim-snippets'
  "" }}}

  "" Plugin: Vim Surround {{{
    " All about surroundings: parenthless, brackets, quotes, XML tags, and more
    Plug 'tpope/vim-surround'
  "" }}}

  "" Plugin: NERD Commenter {{{
    " For intensely orgasmic commenting
    Plug 'scrooloose/nerdcommenter'
    " Comment the whole lines in visual mode
    let g:NERDCommentWholeLinesInVMode=1
    " Add space after the left delimiter and before the right delimiter
    let g:NERDSpaceDelims=1
    " Remove spaces around comment delimiters
    let g:NERDRemoveExtraSpaces=1
  "" }}}

  "" Plugin: Vim Multiple Cursors {{{
    " Bringing Sublime Text's awesome multiple selection feature into Vim
    Plug 'terryma/vim-multiple-cursors'
    " Turn off the default key bindings
    let g:multi_cursor_use_default_mapping=0
    " Configure custom key bindings
    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'
    " Quit and delete all existing cursor in visual mode after pressing quit key
    let g:multi_cursor_exit_from_visual_mode=1
    " Quit and delete all existing cursor in insert mode after pressing quit key
    let g:multi_cursor_exit_from_insert_mode=0
  "" }}}

  " Python
  "" Plugin: Jedi-Vim {{{
    " Vim binding for the autocompletion library Jedi
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    " Enable the default initialization routine
    let g:jedi#auto_initialization=1
    " Disable the default vim configuration
    let g:jedi#auto_vim_configuration=0
    " Show the function call signature window during writing arugments
    let g:jedi#show_call_signatures=1
    " Disable automatically starts completion upon typing
    let g:jedi#popup_on_dot=1
    " Automatically select the first entry upon starting completion
    let g:jedi#popup_select_first=0
    " Enable Jedi completions
    let g:jedi#completions_enabled=0
    " Open a new tab if use the go to
    let g:jedi#use_tabs_not_buffers=1
    " Don't want the docstring window to popup during compeletion
    autocmd FileType python setlocal completeopt-=preview
    " Key Bindings for Jedi-Vim
    let g:jedi#goto_assignments_command='<Leader>g'
    let g:jedi#goto_definitions_command='<Leader>d'
    let g:jedi#documentation_command='K'
    let g:jedi#usages_command='<Leader>n'
    let g:jedi#completions_command='<C-Space>'
    let g:jedi#rename_command='<Leader>r'
  "" }}}

  " HTML & CSS
  "" Plugin: Emmet {{{
    " Provide Zen-coding for Vim
    Plug 'mattn/emmet-vim', {
    \ 'for': [
    \   'html', 'haml', 'jinja', 'hbs', 'html.handlebars', 'xml',
    \   'css', 'less', 'sass'
    \ ]
    \}
    " Enable all functions, which is equal to
    " n: normal, i: insert: v: visual, a: all
    let g:user_emmet_mode='i'
    " Remap the default Emmet leader key <C-Y>
    let g:user_emmet_leader_key='<C-Y>'
    " Customize the behavior of the languages
    let g:user_emmet_settings={
    \ 'html': {
    \   'indentation' : '   ',
    \ },
    \ 'xml': {
    \   'extends': 'html',
    \ },
    \ 'haml': {
    \   'extends': 'html',
    \ },
    \ 'jinja': {
    \   'extends': 'html',
    \ },
    \ 'hbs': {
    \   'extends': 'html',
    \ },
    \ 'html.handlebars': {
    \   'extends': 'html',
    \ },
    \}
  "" }}}

  "" Plugin: Jinja {{{
    " Syntax file for vim with the ability to detect either HTML or Jinja
    Plug 'Glench/Vim-Jinja2-Syntax'
  "" }}}

  " Markdown
  "" Plugin: Vim Instant Markdown {{{
    " Instant markdown Previews from Vim
    Plug 'suan/vim-instant-markdown'
    " Only refresh on specific events
    let g:instant_markdown_slow=1
    " Manually control to launch the preview window
    " Command(:InstantMarkdownPreview)
    " let g:instant_markdown_autostart=1
  "" }}}

  " Verilog
  "" Plugin: Verilog and SystemVerilog {{{
    " Vim Syntax Plugin for Verilog and SystemVerilog
    Plug 'vhda/verilog_systemverilog.vim'
  "" }}}
""" }}}

""" Interface {{{
  "" Plugin: Airline {{{
    " Use statusline more effective
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    if exists('$DISPLAY')
      " Automatic population of the g:airline_symbols dictionary with
      " powerline symbols
      let g:airline_powerline_fonts=1
    endif
    " Specify theme for airline
    let g:airline_theme='tomorrow'
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#left_sep=''
    let g:airline#extensions#tabline#left_alt_sep='|'
    " Customize a left side of airline
    " let g:airline_section_b='%{strftime('%H:%M:%S')}'
    " Customize a right side of airline
    let g:airline_section_y='buf:%n [%{&fileformat}/%{strlen(&fenc)?&fenc:&enc}]'
    " Use airline's showmode
    set noshowmode
  "" }}}

  "" Plugin: ZoomWin {{{
    Plug 'vim-scripts/ZoomWin'
    nnoremap <silent> <F8> :ZoomWin<CR>
  "" }}}
""" }}}

""" Themes {{{
  "" Theme: Gruvbox {{{
    Plug 'morhetz/gruvbox'
    " Uses 256 color palette
    " Set option value to 16 to fallback
    let g:gruvbox_termcolors=256
    " Change darkmode contrast. Possible values are `soft`, `medium`, `hard`
    let g:gruvbox_contrast_dark='medium'
    " Change lightmode contrast. Possible values are `soft`, `medium`, `hard`
    let g:gruvbox_contrast_light='soft'
    " Change cursor background
    let g:gruvbox_hls_cursor='green'
    " Inverts indent guides
    let g:gruvbox_invert_indent_guides=0
  "" }}}

""" }}}




Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'  }

call plug#end()
