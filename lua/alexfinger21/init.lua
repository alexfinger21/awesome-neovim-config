local mason_registry = require("mason-registry")

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "vue_ls", "ts_ls" }, -- add more servers as needed
})

-- Find the Vue language server install path
local vue_language_server_path =
  mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"

-- capabilities from nvim-cmp (optional but recommended)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- configure clangd using lspconfig
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
    capabilities = capabilities,
    -- you can also add on_attach, cmd, etc. here
})

lspconfig.ts_ls.setup({
    capabilities = capabilities,
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" }
            }
        }
    },
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx",
        "typescript", "typescriptreact", "typescript.tsx",
        "vue",
    }
})

lspconfig.vue_ls.setup({
    capabilities = capabilities
})

require("alexfinger21.remap")
require("alexfinger21.set")
