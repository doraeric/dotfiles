" Plugin manager - packer
" Common commands:
" - PackerSync
lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
" End of plugin manager

" set wildmode=longest,list,full
" set wildmenu
set wildmode=longest:full,full

" Incremental search
" Vim has good native incremental search function now, no plugin is needed
" https://vimhelp.org/cmdline.txt.html#c_CTRL-G
" https://www.reddit.com/r/vim/comments/hyxo4u/usefulness_of_ctrlg_and_ctrlt_while_searching/
set wildcharm=<C-z>
cnoremap <expr> <Tab>   getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"

" Edit file with sudo
" https://vi.stackexchange.com/questions/3561/settings-and-plugins-when-root-sudo-vim
" `sudo vim` won't load plugins
" To edit root files with plugins, choose one of the methods:
" - `sudo -e file`
" - `sudoedit file`
" - `vim file` and save with :Sw, not working for neovim
" command! -nargs=0 Sw w !sudo tee % > /dev/null

" Tab navigation mapping
" https://superuser.com/questions/410982
" https://vim.fandom.com/wiki/Alternative_tab_navigation
nnoremap H gT
nnoremap L gt

" old settings
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
au BufNewFile,BufRead *.mjs set filetype=javascript
autocmd FileType html,javascript,javascript.jsx setlocal ts=2 sts=2 sw=2
" cmap ebig5 e ++enc=big5
command Ebig5 e ++enc=big5
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
" Glaive codefmt clang_format_style='google'
