-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Visual Studio Style Keybindings
local map = vim.keymap.set

-- Navigation
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition (F12)" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References (Shift+F12)" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation (Ctrl+F12)" })

-- Refactoring & Actions
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename (F2)" })
map("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Quick Fix (Ctrl+.)" })

-- Debugging (Assuming you have nvim-dap installed)
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Start Debug/Continue (F5)" })
map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint (F9)" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over (F10)" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into (F11)" })
map("n", "<S-F11>", function()
  require("dap").step_out()
end, { desc = "Step Out (Shift+F11)" })
map("n", "<S-F5>", function()
  require("dap").terminate()
end, { desc = "Stop Debugging (Shift+F5)" })
