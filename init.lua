local vim = vim
local Plug =  vim.fn['plug#']
local o = vim.opt
local k = vim.keymap

vim.call('plug#begin')

Plug('bettervim/yugen.nvim')
Plug('nvim-tree/nvim-tree.lua')
Plug('windwp/nvim-autopairs')
Plug('neovim/nvim-lsp')
Plug('neovim/nvim-lspconfig')
Plug('sbdchd/neoformat') 
Plug('hrsh7th/nvim-cmp', { branch = 'stable' } )
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')
Plug('alvan/vim-closetag')

vim.o.updatetime = 1000

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
})

vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

vim.call('plug#end')

local cmp = require('cmp')

cmp.setup({
	      sources = cmp.config.sources({
		        	{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, {
				{ name = 'buffer' },
				{ name = 'path' },
			})
								
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.pyright.setup{}
require'lspconfig'.ts_ls.setup({
	capabilities = capabilities
})

o.number = true
o.tabstop = 4
o.smartindent = true
o.shiftwidth = 4
o.expandtab = true
o.splitbelow = true
o.termguicolors = true
o.updatetime = 300

require('nvim-tree').setup()
require('nvim-autopairs').setup()

k.set('n', '<C-n>', ':new +resize10 term://zsh<CR>', { noremap=true, silent=true })
k.set('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap=true, silent=true })
k.set('n', '<C-p>', ':Neoformat prettier<CR>', { noremap=true, silent=true })

vim.cmd.colorscheme('yugen')
