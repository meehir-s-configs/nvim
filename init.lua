--vim.cmd [[set number]]
--vim.cmd [[colorscheme vim]]
--vim.o.termguicolors = false

require("config.remap")
require("config.lazy")
require("config.set")

vim.api.nvim_create_user_command('SetOverlay', function()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFA500", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFF99", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end, {})
