return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        local requiredParsers = {
            "vimdoc", "javascript", "typescript", "c", "cpp", "lua", "rust", "go",
            "jsdoc", "bash", "hyprlang", "python", "java", "r", "markdown", "markdown_inline"
        }

        local alreadyInstalled = require("nvim-treesitter.config").get_installed()

        local parsersToInstall = vim.iter(requiredParsers)
            :filter(function(targetParser)
                return not vim.tbl_contains(alreadyInstalled, targetParser)
            end)
            :totable()

        require("nvim-treesitter").install(parsersToInstall)
    end,
}
