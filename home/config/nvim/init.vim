"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Install dein
if (!isdirectory(expand('$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim')))
  call system('git clone https://github.com/Shougo/dein.vim $XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim')
endif

set runtimepath+=$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state(expand('$XDG_CONFIG_HOME/nvim/dein'))
  call dein#begin(expand('$XDG_CONFIG_HOME/nvim/dein'))
  call dein#add(expand('$XDG_CONFIG_HOME/nvim/dein/repos/github.com/Shougo/dein.vim'))

  " Add or remove your plugins here like this:
  " call dein#add('Shougo/neosnippet.vim')
  call dein#add('wsdjeg/dein-ui.vim')
  call dein#add('nanotech/jellybeans.vim', {'hook_add': "colo jellybeans | let g:jellybeans_overrides = {'background': { 'ctermbg': 'none', '256ctermbg': 'none' }}"})
  call dein#add('vim-airline/vim-airline')
  call dein#add('bling/vim-bufferline', {'hook_add': "let g:bufferline_echo=0"})
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('tpope/vim-surround')
  call dein#add('godlygeek/tabular')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('scrooloose/nerdtree', {'hook_add': 'map <C-n> :NERDTreeToggle<CR>'})
  call dein#add('qpkorr/vim-bufkill')
  call dein#add('SirVer/ultisnips', {'hook_add': 'let g:UltiSnipsExpandTrigger="<C-j>"|let g:UltiSnipsJumpForwardTrigger="<c-b>"|let g:UltiSnipsJumpBackwardTrigger="<c-z>"'})
  call dein#add('honza/vim-snippets')
  " YouCompleteMe
  " sudo apt install build-essential cmake python3-dev
  " cd $XDG_CONFIG_HOME/nvim/dein/repos/github.com/Valloric/YouCompleteMe && python3 install.py --clang-completer
  " call dein#add('Valloric/YouCompleteMe', {'build': 'python3 install.py --clang-completer', 'hook_add': 'let g:ycm_server_python_interpreter=system("printf `command -v python3`")'})
  " call dein#add('wakatime/vim-wakatime', {'hook_add': 'let $WAKATIME_HOME = $XDG_CONFIG_HOME."/wakatime"', 'build': 'mkdir -p "$XDG_CONFIG_HOME/wakatime"'})
  " web plugins
  " call dein#add('pangloss/vim-javascript')
  " call dein#add('mxw/vim-jsx') " strange auto re indent behaviour when insert to js file
  " call dein#add('posva/vim-vue')
  " call dein#add('mattn/emmet-vim')
  " call dein#add('othree/html5.vim')
  " test environment
  " call dein#add('guns/xterm-color-table.vim') " :XtermColorTable
  " call dein#add('vim-syntastic/syntastic')
  call dein#add('google/vim-maktaba', {'merged' : 0})
  call dein#add('google/vim-codefmt', {'merged' : 0})
  call dein#add('google/vim-glaive', {'merged' : 0})

  " Required:
  call dein#end()
  call dein#save_state()
endif
" common functions
" call dein#build()
" call dein#install()
" https://github.com/Shougo/dein.vim/issues/71
" call dein#recache_runtimepath()
" DeinUpdate
call glaive#Install()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
let g:loaded_python_provider = 1

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
tmap <C-j> <C-\><C-n><C-w>j
tmap <C-k> <C-\><C-n><C-w>k
tmap <C-h> <C-\><C-n><C-w>h
tmap <C-l> <C-\><C-n><C-w>l
map + <C-W>+
map - <C-W>-
map <Right>  <C-w>>
map <Left>  <C-w><

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on
  augroup vimStartup
    au!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
  augroup END
endif " has("autocmd")

set splitbelow splitright
set number relativenumber
set ai
set hlsearch
" Indent settings
set expandtab     " insert spaces rather than a tab when press <TAB>
set tabstop=4     " how many spaces does a real '\t' char look like
set softtabstop=4 " how many spaces does the final indent look, affects <TAB>, <BS> and <DEL>
set shiftwidth=4  " move n columns when type `>>`
autocmd FileType html setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
" set t_Co=256
nnoremap <tab> :bn<CR>
nnoremap <S-tab> :bp<CR>
set hidden
set foldmethod=syntax
set foldlevel=20

" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = expand('$XDG_CONFIG_HOME/nvim/ycm_extra_conf.py')
let g:ycm_python_binary_path = 'python3'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_key_invoke_completion = '<c-k>'
" [auto-complete without <c-space>](https://github.com/ycm-core/YouCompleteMe/issues/2817)
" let g:ycm_semantic_triggers = { 'c': [ 're!\w{3}' ], 'cpp': [ 're!\w{3}' ] }

" neovim wiki says t_Co has no effect, but :let &t_Co=8 do change the variable
" Plugin 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
au BufNewFile,BufRead *.mjs set filetype=javascript
autocmd FileType html,javascript,javascript.jsx setlocal ts=2 sts=2 sw=2
cmap ebig5 e ++enc=big5
let g:is_posix=1

" c++ https://stackoverflow.com/questions/28217118/vim-indents-c-c-functions-badly-when-the-type-and-name-are-in-different-lines
" set cino+=t0
" https://www.systutorials.com/how-to-make-vim-indent-c11-lambdas-correctly/
" https://github.com/zma/vim-config/blob/master/.vimrc
setlocal cino+=g-1,j1,(0,ws,Ws,N+s,t0,g0,+0

" template
if has("autocmd")
  augroup templates
    autocmd BufNewFile CMakeLists.txt 0r ~/.config/nvim/templates/CMakeLists.txt
  augroup END
endif

" https://wiki.josephhyatt.com/dotfiles/.vimrc
" google format
augroup autoformat_settings
  " sudo apt install clang-format
  " autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  if executable("clang-format")
    autocmd FileType c,cpp,proto setlocal equalprg=clang-format\ -style=google
  endif
  autocmd Filetype c,cpp setlocal ts=2 sw=2 expandtab
  " autocmd FileType python AutoFormatBuffer yapf
augroup END
" use google style for clang-format
" call :FormatCode when editing
Glaive codefmt clang_format_style='google'
