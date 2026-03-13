-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Navigation
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

-- Diagnostics
map("n", "<leader>dn", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
map("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, { desc = "Prev Diagnostic" })

-- Refactoring & Actions
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Debugging
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Debug: Continue" })
map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Debug: Step Over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Debug: Step Into" })
map("n", "<S-F11>", function()
  require("dap").step_out()
end, { desc = "Debug: Step Out" })
map("n", "<S-F5>", function()
  require("dap").terminate()
end, { desc = "Stop Debugging (Shift+F5)" })
map("n", "<F7>", function()
  require("dapui").toggle()
end, { desc = "Toggle Debug UI (F7)" })
