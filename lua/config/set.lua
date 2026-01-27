-- ============================
-- 1. Standard Options
-- ============================
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

-- ============================
-- 2. Colorscheme Logic (NEW)
-- ============================

-- Define the cosmetics you want applied to EVERY theme
local function apply_cosmetics()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFA500", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFF99", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Define the global function to switch themes safely
function SetColorscheme(name)
    local ok, _ = pcall(vim.cmd.colorscheme, name)
    if ok then
        apply_cosmetics()
    else
        print("Colorscheme " .. name .. " not found!")
    end
end

-- Define the user command :UseTheme <name>
vim.api.nvim_create_user_command("UseTheme", function(opts)
    SetColorscheme(opts.args)
end, {
    nargs = 1,
    complete = "color",
})

-- Initialize your default theme on startup
SetColorscheme("rose-pine-moon")

-- ============================
-- 3. Diagnostics & Keymaps
-- ============================

vim.diagnostic.config({
    float = { border = "rounded" },
})

vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({ border = 'rounded' })
end, { desc = 'Hover Documentation' })
