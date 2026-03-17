-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "<leader>r", ":!python %<CR>", { desc = "Run current Python file" })
vim.keymap.set("n", "<leader>r", function()
    local file = vim.fn.expand("%:p")
    local python = require("venv-selector").python() or "python"
    local cmd = python .. " " .. vim.fn.shellescape(file)

    local shell_cmd = string.format("printf '%%s\\n\\n' %s; %s", vim.fn.shellescape(cmd), cmd)

    local Terminal = require("toggleterm.terminal").Terminal
    local runner = Terminal:new({
        cmd = shell_cmd,
        hidden = false,
        direction = "horizontal",
        close_on_exit = false, -- keep window open so you can read output
    })
    runner:toggle()
end, { desc = "Run current Python file (float)" })

vim.keymap.set("n", "<leader>m", function()
    vim.cmd("silent! bufdo bwipeout")
    require("snacks").dashboard.open()
end, { desc = "Open LazyVim Dashboard" })

vim.keymap.set("n", "<F2>", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "LSP Rename (F2)" })
