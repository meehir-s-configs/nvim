return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- 1. Configure Servers (Define the config first)
            
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

            -- 2. Enable Servers (Activate them)
            local servers = { "clangd", "lua_ls", "rust_analyzer", "pyright", "jdtls", "gopls", "ts_ls" }
            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end
        end,
    }
}
