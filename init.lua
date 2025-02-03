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
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.insertTextMode = 1
capabilities.textDocument.completion.completionItem.resolveSupport = {
	  properties = { "documentation", "detail", "additionalTextEdits" }
  }
  capabilities.textDocument.signatureHelp.signatureInformation.parameterInformation = {
	    labelOffsetSupport = true
    }
    capabilities.textDocument.hover.contentFormat = { "markdown", "plaintext" }
    capabilities.textDocument.definition.linkSupport = true
    capabilities.textDocument.references.contextSupport = true
    capabilities.textDocument.documentHighlight = { dynamicRegistration = true }
    capabilities.textDocument.codeAction = { dynamicRegistration = true }
    capabilities.textDocument.codeLens = { dynamicRegistration = true }
    capabilities.textDocument.documentSymbol = { dynamicRegistration = true }
    capabilities.textDocument.rename = { dynamicRegistration = true }
    capabilities.textDocument.formatting = { dynamicRegistration = true }
    capabilities.textDocument.rangeFormatting = { dynamicRegistration = true }
    capabilities.textDocument.onTypeFormatting = { dynamicRegistration = true }
    capabilities.textDocument.foldingRange = { dynamicRegistration = true }
    capabilities.textDocument.completion.dynamicRegistration = true
require'lspconfig'.pyright.setup{}
require'lspconfig'.ts_ls.setup{
    on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover()
            vim.api.nvim_command('wincmd J')
        end, opts)
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
    end,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 500
    }
}

vim.diagnostic.config({
    update_in_insert = true
})

vim.call('plug#end')

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
k.set('n', '<C-p>', ':call CocAction(\'runCommand\', \'prettier.formatFile\')<CR>', {noremap=true, silent=true})

local cmp = require('cmp')

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered({
            border = 'single',
            max_width = 80,
            max_height = 12,
            scrollable = true
        })
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }
})

vim.cmd.colorscheme('yugen')
