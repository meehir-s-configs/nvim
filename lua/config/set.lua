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
-- Folding logic
-- ============================

-- Use Treesitter for folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Keep folds open by default when opening a file
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.supports_method("textDocument/foldingRange") then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

-- clean fold view
function _G.FormatFold()
    local fStart = vim.v.foldstart
    local fEnd = vim.v.foldend
    local lCount = fEnd - fStart + 1
    local tLine = vim.fn.getline(fStart)

    return tLine .. " ⋯ [" .. lCount .. " lines]"
end

vim.opt.foldtext = "v:lua.FormatFold()"

-- add clickable folding icon and replace the view of them with nerd font arrows
vim.opt.foldcolumn = "1"
vim.opt.fillchars = {
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
}

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
