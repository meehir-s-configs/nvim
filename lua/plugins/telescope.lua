return {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        require('telescope').setup({})

        local telescope_builtins = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', telescope_builtins.find_files, {})
        vim.keymap.set('n', '<C-p>', telescope_builtins.git_files, {})

        vim.keymap.set('n', '<leader>pws', function()
            local current_word = vim.fn.expand("<cword>")
            telescope_builtins.grep_string({ search = current_word })
        end)

        vim.keymap.set('n', '<leader>pWs', function()
            local current_bigword = vim.fn.expand("<cWORD>")
            telescope_builtins.grep_string({ search = current_bigword })
        end)

        vim.keymap.set('n', '<leader>ps', function()
            local search_query = vim.fn.input("Grep > ")
            telescope_builtins.grep_string({ search = search_query })
        end)

        vim.keymap.set('n', '<leader>vh', telescope_builtins.help_tags, {})
    end
}
