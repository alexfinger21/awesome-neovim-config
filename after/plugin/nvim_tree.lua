-- set termguicolors to enable highlight groups
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local open = true
local ignore_bufs = {
    NvimTree = true,
    Help = true
}

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

vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function(args)
        local buf = args.buf
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")

        if string.len(ft) == 0 or ignore_bufs[ft] then
            return
        end

        local filepath = vim.api.nvim_buf_get_name(args.buf)
        open = true
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


