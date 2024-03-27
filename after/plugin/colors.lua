function colorMyPencils(color)
    color = color or "catppuccin-latte"
    vim.cmd.colorscheme(color)
    vim.api.nvim_command("highlight Normal guibg=#fcf1d2")  

    vim.api.nvim_set_hl(1, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(1, "NormalFloat", {bg = "none"})
end

colorMyPencils()
