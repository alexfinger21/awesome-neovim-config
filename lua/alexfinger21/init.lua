local mason_registry = require("mason-registry")

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ts_ls", "pylsp" }, -- add more servers as needed
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { ".clangd", "compile_commands.json", ".git" },
  on_attach = on_attach,
  settings = { -- optional clangd settings
    clangd = {
      fallbackFlags = { "-std=c++17" },
    }
  }
})

vim.lsp.enable("clangd")

vim.lsp.config("pylsp", {
    cmd = { "pylsp" },
    filetypes = { "python" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pyflakes = { enabled = true },
                pycodestyle = { enabled = true },
                mccabe = { enabled = true },
                jedi_completion = { enabled = true },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signatures = { enabled = true },
                jedi_symbols = { enabled = true },
            }
        }
    }
})
vim.lsp.enable("pylsp")

require("alexfinger21.remap")
require("alexfinger21.set")
