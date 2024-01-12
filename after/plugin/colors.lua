function colorMyPencils(color)
    color = color or "catppuccin-latte"
    vim.cmd.colorscheme(color)
    vim.api.nvim_command("highlight Normal guibg=#FDF6E3")  

    vim.api.nvim_set_hl(1, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(1, "NormalFloat", {bg = "none"})
end

colorMyPencils()
