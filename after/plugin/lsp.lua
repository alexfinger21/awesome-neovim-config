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

-- vimspector
vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])

--set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: do not insert text until a selection is made
-- noselect: do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for cursorhold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

-- fixed column for diagnostics to appear
-- show autodiagnostic popup on cursor hover_range
-- goto previous / next diagnostic warning / error 
-- show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

vim.diagnostic.config({
  virtual_text = {
    prefix = '⚡',
    spacing = 2,
  },
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
  bg = "#fff0f0", -- warm pale red
  fg = "#990000", -- deep red
})

-- warning: stronger yellow background
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
  bg = "#fff6b0", -- bright pale yellow
  fg = "#8a6d00", -- dark golden yellow
})

-- info: warm creamy yellow
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {
  bg = "#fef7c3", -- soft vanilla
  fg = "#5a5a00", -- olive/brown text
})

-- hint: yellowish mint
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {
  bg = "#fdfdcc", -- light yellow-green
  fg = "#3b5f00", -- earthy green
})

-- open floating diagnostic message
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostics in float" })

-- go to next diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

-- go to previous diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- set location list with diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- turn off diagnostics
vim.keymap.set("n", "<leader>dl", function ()
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0})) do
        vim.lsp.buf_detach_client(0, client.id)
    end
end)
