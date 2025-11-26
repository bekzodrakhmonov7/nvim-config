return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        lazy = false, -- load immediately so keymaps work on startup
        config = function()
            -- 1. Basic ToggleTerm setup
            require("toggleterm").setup({
                size = 20, -- default height for horizontal terminal
                open_mapping = [[<c-\>]], -- Ctrl+\ toggles a terminal (built-in mapping)
                hide_numbers = true, -- don't show line numbers in terminal buffers
                shade_terminals = true, -- slightly darken terminal background
                shading_factor = 2, -- how much to darken (1 = light, 3 = dark)
                start_in_insert = true, -- when you open terminal, you're already typing
                insert_mappings = true, -- allow toggle in insert mode
                persist_size = true, -- remember terminal size
                direction = "horizontal", -- "float" | "horizontal" | "vertical" | "tab"
                close_on_exit = true, -- close the terminal buffer when process exits
                shell = vim.o.shell, -- use your default shell (bash, zsh, etc.)
                float_opts = {
                    border = "curved", -- round-ish border around the floating terminal
                    winblend = 0, -- transparency, 0 = solid
                },
            })

            -- 3. NORMAL MODE KEYMAPS (global)
            -- <leader>tt = toggle a general-purpose terminal window
            vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {
                desc = "Toggle terminal",
            })

            -- 4. TERMINAL MODE KEYMAPS (better navigation)
            -- When you're INSIDE the terminal, you usually want:
            --   Esc to exit insert mode in terminal and go normal-mode
            --   <C-h/j/k/l> to move between windows
            function _G.set_terminal_keymaps()
                local opts = { noremap = true }
                local wk = vim.keymap.set
                local term_opts = { buffer = 0 }

                -- go back to normal-mode in the terminal with Esc
                wk("t", "<esc>", [[<C-\><C-n>]], term_opts)

                -- window navigation from terminal
                wk("t", "<C-h>", [[<C-\><C-n><C-w>h]], term_opts)
                wk("t", "<C-j>", [[<C-\><C-n><C-w>j]], term_opts)
                wk("t", "<C-k>", [[<C-\><C-n><C-w>k]], term_opts)
                wk("t", "<C-l>", [[<C-\><C-n><C-w>l]], term_opts)
            end

            -- This autocommand calls set_terminal_keymaps() every time a terminal opens
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "term://*",
                callback = function()
                    _G.set_terminal_keymaps()
                end,
            })
        end,
    },
}
