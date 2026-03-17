return {
    "Ackeraa/todo.nvim",
    -- We remove 'cmd = "Todo"' and use 'keys' to handle the lazy-loading dynamically
    keys = {
        {
            "<leader>td",
            function()
                -- 1. Calculate the path dynamically EVERY time the key is pressed
                local todo_dir = vim.fn.stdpath("data") .. "/project_todos"
                if vim.fn.isdirectory(todo_dir) == 0 then
                    vim.fn.mkdir(todo_dir, "p")
                end

                local cwd = vim.fn.getcwd()
                local safe_filename = cwd:gsub("[\\/:]", "_") .. ".txt"
                local project_todo_path = todo_dir .. "/" .. safe_filename

                -- 2. Update the plugin with the new path
                require("todo").setup({
                    opts = {
                        file_path = project_todo_path,
                    },
                })

                -- 3. Open the window
                vim.cmd("Todo")
            end,
            desc = "Toggle Project Todo List",
        },
    },
    config = function()
        -- Create an Auto Command to configure the 'todo' filetype
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "todo",
            callback = function(event)
                -- 1. Map 'q' to close ALL plugin windows cleanly
                vim.keymap.set("n", "q", "<cmd>lua require('todo').window:close()<cr>", {
                    buffer = event.buf,
                    silent = true,
                    desc = "Close Todo",
                })

                -- 2. Safely unmap the author's hardcoded <Esc> mapping
                pcall(vim.keymap.del, "n", "<Esc>", { buffer = event.buf })

                -- 3. Turn off nvim-cmp (autocompletion) for this buffer
                pcall(function()
                    require("cmp").setup.buffer({ enabled = false })
                end)

                -- 4. Optional: Turn off spellcheck/suggestions for this buffer too
                vim.opt_local.spell = false
            end,
        })
    end,
}
