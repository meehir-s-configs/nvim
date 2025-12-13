vim.opt.nu = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.cmd.colorscheme("gruvbox")
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFA500", bg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFF99", bg = "NONE" })
--vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2F334D", fg = "NONE" , blend = 100 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

--vim.o.winborder = "rounded"

vim.diagnostic.config({
    float = { border = "rounded" },
})
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover({ border = 'rounded' })
end, { desc = 'Hover Documentation' })

--[[vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = "rounded" } -- You can use "single", "double", or "rounded"
)]]
