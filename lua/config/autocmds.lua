-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "requirements.txt", "pyproject.toml", "Pipfile", "poetry.lock" },
    callback = function()
        -- optional: only in Python projects
        if vim.bo.filetype == "python" or vim.fn.glob("**/*.py") ~= "" then
            vim.cmd("LspRestart")
        end
    end,
})

-- Mark brand-new Python buffers
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.py",
    callback = function(args)
        -- mark this buffer as newly created
        vim.b[args.buf].is_new_python_file = true
    end,
})

-- On first save of a new Python file, restart LSP once
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.py",
    callback = function(args)
        local bufnr = args.buf
        if vim.b[bufnr].is_new_python_file then
            vim.b[bufnr].is_new_python_file = nil -- only once
            local clients = vim.lsp.get_clients({ bufnr = bufnr })
            if #clients > 0 then
                vim.cmd("LspRestart")
            end
        end
    end,
})
