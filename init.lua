local vim = vim
local Plug =  vim.fn['plug#']
local o = vim.opt
local k = vim.keymap

vim.call('plug#begin')

Plug('bettervim/yugen.nvim')
Plug('neoclide/coc.nvim', { ['branch'] = 'release'})
Plug('nvim-tree/nvim-tree.lua')
Plug('windwp/nvim-autopairs')
Plug('prisma/vim-prisma')

require'lspconfig'.pyright.setup{}

vim.call('plug#end')

o.number = true
o.tabstop = 4
o.smartindent = true
o.shiftwidth = 4
o.expandtab = true
o.splitbelow = true
o.termguicolors = true

require('nvim-tree').setup()
require('nvim-autopairs').setup()

k.set('n', '<C-n>', ':new +resize10 term://zsh<CR>', { noremap=true, silent=true })
k.set('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap=true, silent=true })
k.set('n', '<C-p>', ':call CocAction(\'runCommand\', \'prettier.formatFile\')<CR>', {noremap=true, silent=true})

vim.cmd.colorscheme('yugen')
