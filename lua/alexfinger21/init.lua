require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd" }, -- add more servers as needed
})

-- capabilities from nvim-cmp (optional but recommended)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- configure clangd using lspconfig
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
  capabilities = capabilities,
  -- you can also add on_attach, cmd, etc. here
})


require("alexfinger21.remap")
require("alexfinger21.set")
