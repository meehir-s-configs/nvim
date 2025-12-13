vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--[[vim.keymap.set('n', 'K', function()
  nvim_set_keymapm.lsp.buf.hover({ border = 'rounded' })
end, { desc = 'Hover Documentation' })]]


--Error Diagnostics
vim.api.nvim_set_keymap('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','[d',':lua vim.diagnostic.goto_prev()<CR>',{noremap=true, silent = true})
vim.api.nvim_set_keymap('n',']d',':lua vim.diagnostic.goto_next()<CR>',{noremap=true, silent = true})
