return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- =========================================================
            -- 0. Keybinds & "Magic Fix" Setup (Runs when LSP attaches)
            -- =========================================================
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    -- [Standard] Code Action Menu (<leader>ca)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

                    -- [Magic] Auto-Include (<leader>ai)
                    -- Finds and applies "Add include" or "Import" actions instantly
                    vim.keymap.set('n', '<leader>ai', function()
                        local params = vim.lsp.util.make_range_params()
                        params.context = { diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 }) }

                        vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, actions, context)
                            if err or not actions or next(actions) == nil then return end
                            
                            for _, action in pairs(actions) do
                                local title = action.title:lower()
                                if title:match("add include") or title:match("import") then
                                    if action.edit then
                                        vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                                    elseif action.command then
                                        vim.lsp.buf.execute_command(action.command)
                                    end
                                    -- Optional: Notify user what happened
                                    vim.notify("Auto-Fixed: " .. action.title, vim.log.levels.INFO)
                                    return
                                end
                            end
                            vim.notify("No header fix found", vim.log.levels.WARN)
                        end)
                    end, { buffer = ev.buf, desc = "Auto Include Header" })
                end,
            })

            -- =========================================================
            -- 1. Configure Servers (Define the config first)
            -- =========================================================
            
            -- Clangd
            vim.lsp.config.clangd = {}
            
            -- Lua LS
            vim.lsp.config.lua_ls = {
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
            }

            -- Rust Analyzer
            vim.lsp.config.rust_analyzer = {
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = { enable = false }
                    }
                }
            }

            -- Others
            vim.lsp.config.pyright = {}
            vim.lsp.config.jdtls = {}
            vim.lsp.config.gopls = {}
            vim.lsp.config.ts_ls = {}

            -- =========================================================
            -- 2. Enable Servers (Activate them)
            -- =========================================================
            local servers = { "clangd", "lua_ls", "rust_analyzer", "pyright", "jdtls", "gopls", "ts_ls" }
            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end
        end,
    }
}
