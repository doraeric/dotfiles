-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd('packadd packer.nvim')

local packer = require('packer')

packer.init({
    opt_default=true,
})

-- Color schemes are recommended to be optional because
-- they can always be found whether it's in `start` or `opt` dirs.
-- To temporary disable a plugin, comment the line `cond=true`
-- Commenting out a plugin will make packer want to remove it
return packer.startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    -- https://github.com/morhetz/gruvbox/issues/375
    use({
        'morhetz/gruvbox',
        config=[=[ vim.cmd [[
        let g:gruvbox_transparent_bg = 1
        colorscheme gruvbox
        highlight Normal ctermbg=NONE guibg=NONE
        ]] ]=],
        cond=true,
    })
    use({
        'vim-airline/vim-airline',
        -- FIXME enable powerline?
        -- The color is not correct if you didn't call
        -- `colorscheme gruvbox` after loading the plugin
        -- maybe it's because ctermbg=NONE
        setup=[=[ vim.cmd [[
        let g:airline_powerline_fonts = 1
        ]] ]=],
        config=[=[ vim.cmd [[
        let g:gruvbox_transparent_bg = 1
        colorscheme gruvbox
        highlight Normal ctermbg=NONE guibg=NONE
        ]] ]=],
        cond=true,
    })
    use('vim-airline/vim-airline-themes')
    use({
        'scrooloose/nerdtree',
        config=[=[ vim.cmd [[
        map <C-n> :NERDTreeToggle<CR>
        ]] ]=],
        cond=true,
    })
    use({
        'jistr/vim-nerdtree-tabs',
        -- config=[=[ vim.cmd [[
        -- map <C-n> <plug>NERDTreeTabsToggle<CR>
        -- ]] ]=],
        cond=true,
    })
    -- YouCompleteMe
    -- let g:ycm_server_python_interpreter=system("printf `command -v python3`")
    use({
        'ycm-core/YouCompleteMe',
        cond=true,
        run='./install.py --clangd-completer --rust-completer',
    })
    use({
        'davidhalter/jedi-vim',
        cond=true,
    })
    use({
        'ervandew/supertab',
        cond=true,
        config=[=[ vim.g["SuperTabDefaultCompletionType"] = "<c-n>" ]=]
    })
    use({
        'python-mode/python-mode',
        ft = 'python',
        -- config=[=[ vim.g["pymode_folding"] = 1 ]=]
    })
    use({
        'nvim-treesitter/nvim-treesitter',
        cond=true,
        run = ':TSUpdate',
    })
    use({
        'jiangmiao/auto-pairs',
        cond=true,
    })
    use({
        'lambdalisue/suda.vim',
        -- cmd={'SudaRead', 'SudaWrite', 'Sw'},
        config=[=[ vim.cmd [[
        command! -nargs=? -complete=file Sw SudaWrite
        ]] ]=],
    })
    use({
        'wakatime/vim-wakatime',
        cond=true,
    })
    use({
        'junegunn/fzf',
        cond=true,
    })
    use({
        'junegunn/fzf.vim',
        cond=true,
    })
    use({
        'christoomey/vim-tmux-navigator',
        cond=true,
    })
    use({
        'tpope/vim-sleuth',
        cond=true,
    })
    --[[ Need time to check the old settings
    --  call dein#add('bling/vim-bufferline', {'hook_add': "let g:bufferline_echo=0"})
    --  call dein#add('tpope/vim-surround')
    --  call dein#add('godlygeek/tabular')
    -- call dein#add('qpkorr/vim-bufkill')
    -- call dein#add('SirVer/ultisnips', {'hook_add': 'let g:UltiSnipsExpandTrigger="<C-j>"|let g:UltiSnipsJumpForwardTrigger="<c-b>"|let g:UltiSnipsJumpBackwardTrigger="<c-z>"'})
    -- call dein#add('honza/vim-snippets')
    -- " web plugins
    -- " call dein#add('pangloss/vim-javascript')
    -- " call dein#add('mxw/vim-jsx') " strange auto re indent behaviour when insert to js file
    -- " call dein#add('posva/vim-vue')
    -- " call dein#add('mattn/emmet-vim')
    -- " call dein#add('othree/html5.vim')
    -- " test environment
    -- " call dein#add('guns/xterm-color-table.vim') " :XtermColorTable
    -- " call dein#add('vim-syntastic/syntastic')
    -- call dein#add('google/vim-maktaba', {'merged' : 0})
    -- call dein#add('google/vim-codefmt', {'merged' : 0})
    -- call dein#add('google/vim-glaive', {'merged' : 0})
    --]]
    -- Not used plugins now, keep for future reference
    -- use({
    --     'bling/vim-bufferline',
    --     setup=[=[ vim.cmd [[
    --     let g:bufferline_echo=0
    --     ]] ]=],
    --     cond=true,
    -- })
    -- use({
    --     'nanotech/jellybeans.vim',
    --     config=[=[ vim.cmd [[
    --     let g:jellybeans_overrides = {'background': { 'ctermbg': 'none', '256ctermbg': 'none' }}
    --     colorscheme jellybeans
    --     ]] ]=],
    --     cond=true,
    -- })
end)
