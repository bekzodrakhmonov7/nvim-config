return {
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        -- load only for Python buffers (optional but nice)
        ft = { "python" },
        keys = {
            -- keymap to open the venv picker
            { "<leader>cv", "<cmd>VenvSelect<CR>", desc = "Select Python venv" },
        },
        opts = {
            options = {
                activate_venv_in_terminal = true, -- use venv in terminals from Neovim
                set_environment_variables = true, -- export PATH + VIRTUAL_ENV/CONDA_PREFIX
                require_lsp_activation = false, -- don't wait for LSP to start
            },
            on_venv_activate_callback = function(_venv)
                -- restart all active LSPs for current workspace
                vim.cmd("LspRestart")
            end,
        },
    },
}
