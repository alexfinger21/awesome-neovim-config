local cmp = require("cmp")

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },   -- <-- LSP first
    { name = "vsnip" },
    { name = "nvim_lua" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),

  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),

  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buf]",
        path = "[Path]",
        nvim_lua = "[Lua]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

vim.diagnostic.config({
  virtual_text = {
    prefix = '⚡',
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

