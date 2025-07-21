-- set termguicolors to enable highlight groups
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true


local open = true

local function toggle_tree()
    local api = require("nvim-tree.api")
    open = not open

    if open then
        api.tree.open()
    else
        api.tree.close()
    end
end

local function t_on_attach(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '<leader>z', toggle_tree)
end

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
      local filepath = vim.api.nvim_buf_get_name(args.buf)
      print("Opened file: " .. filepath)
      toggle_tree()
  end
})


--setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  on_attach = t_on_attach
})


