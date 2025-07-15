local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep String > ")})
end)

local old_path = vim.fn.expand('%:p:h')

vim.keymap.set("n", "<leader>en", function()
    if not string.find(vim.fn.expand("%:p:h"), vim.fn.stdpath("config")) then
        old_path = vim.fn.expand('%:p:h')
    end

    require("telescope.builtin").find_files {
        cwd = vim.fn.stdpath("config")
    }
end)

vim.keymap.set("n", "<leader>eo", function()
    require("telescope.builtin").find_files {
        cwd = old_path
    }
end)

