return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- =========================================================
            -- 0. Keybinds
            -- =========================================================
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>ai', function()
                        vim.lsp.buf.code_action({
                            apply = true,
                            filter = function(action)
                                local title = action.title:lower()
                                return title:match("add include") or title:match("import") or title:match("include <")
                            end,
                            context = { only = { "quickfix" } }
                        })
                    end, { buffer = ev.buf, desc = "Auto Include Header" })
                end,
            })

            -- =========================================================
            -- 1. Configure Overrides
            -- =========================================================

            -- Lua LS: Override default settings
            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc')) then
                            return
                        end
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME }
                        }
                    })
                end,
                settings = { Lua = {} }
            })

            -- Rust Analyzer
            vim.lsp.config('rust_analyzer', {
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = { enable = false }
                    }
                }
            })

            -- Clangd:
            -- vim.lsp.config('clangd', { cmd = { "clangd", "--background-index" } })

            -- =========================================================
            -- 2. Enable Servers
            -- =========================================================
            -- The plugin 'nvim-lspconfig' automatically populates the defaults.
            -- You just need to enable them.

            local servers = { "clangd", "lua_ls", "rust_analyzer", "pyright", "jdtls", "gopls", "ts_ls" }
            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end
        end,
    }
}
