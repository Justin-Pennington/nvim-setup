return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local cmp = require('cmp')
        cmp.setup {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-k>'] = cmp.mapping.confirm({ select = true }),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
            },
            sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'buffer', keyword_length = 3 },
                { name = 'path' },
            },
            formatting = {
                format = function(entry, vim_item)
                    local abbrev = {
                        buffer = "buf",
                        nvim_lsp = "LSP",
                        nvim_lua = "nvim",
                        path = "path",
                        luasnip = "snip",
                        cmdline = "cmd"
                    }
                    local source = entry.source.name
                    vim_item.menu = "[" .. abbrev[source] .. "]"
                    return vim_item
                end
            }
        }
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'path' },
                { name = 'cmdline' },
            }
        })
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            }
        })
        vim.api.nvim_set_keymap('i', '<c-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { noremap = true, silent = true })
    end
}
