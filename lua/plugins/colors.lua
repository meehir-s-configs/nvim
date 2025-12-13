return{
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                --style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                contrast = "soft",            -- Set contrast to "soft"
                transparent_mode = true,      -- Enable transparent background
                terminal_colors = true,       -- Apply terminal colors
                --[[italic = {                    -- Configure italic styles
                comments = false,
                strings = true,
                emphasis = true,
                operators = false,
                folds = true,
                },]]
            })
            vim.o.background = 'dark'
            vim.cmd.colorscheme("gruvbox")
        end
    },
    {
        "/sainnhe/gruvbox-material",
        name = "gruvbox-material",
        config = function()
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_background = 'soft'
            vim.cmd.colorscheme('gruvbox-material')
        end
    },
}
