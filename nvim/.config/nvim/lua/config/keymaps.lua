-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

if vim.g.vscode then
  local vscode = require("vscode")

  -- Navigation
  map("n", "gd", function() vscode.action("editor.action.revealDefinition") end, { desc = "Go to Definition" })
  map("n", "gr", function() vscode.action("editor.action.goToReferences") end, { desc = "Find References" })
  map("n", "gi", function() vscode.action("editor.action.goToImplementation") end, { desc = "Go to Implementation" })

  -- Diagnostics
  map("n", "<leader>dn", function() vscode.action("editor.action.marker.next") end, { desc = "Next Diagnostic" })
  map("n", "<leader>dp", function() vscode.action("editor.action.marker.prev") end, { desc = "Prev Diagnostic" })

  -- Refactoring & Actions
  map("n", "<F2>", function() vscode.action("editor.action.rename") end, { desc = "Rename Symbol" })
  map("n", "<leader>ca", function() vscode.action("editor.action.quickFix") end, { desc = "Code Action" })
  map("n", "<leader>cd", function() vscode.action("editor.action.showHover") end, { desc = "Line Diagnostics" })

  -- UI Toggles
  map("n", "<leader>ut", function() vscode.action("editor.action.inlayHints.toggleInlayHintsForFile") end, { desc = "Toggle Inlay Hints" })

  -- Search
  map("n", "<leader>/", function() vscode.action("workbench.action.findInFiles") end, { desc = "Global Search" })

  -- File Tree
  map("n", "<leader>e", function() vscode.action("workbench.action.toggleSidebarVisibility") end, { desc = "Toggle File Tree" })

  -- AI
  map("n", "<leader>ac", function()
    vscode.action("workbench.action.terminal.new")
    vim.defer_fn(function()
      vscode.action("workbench.action.terminal.sendSequence", { args = { { text = "claude\n" } } })
    end, 1000)
  end, { desc = "Claude Code" })
  map("n", "<leader>ao", function()
    vscode.action("workbench.action.terminal.new")
    vim.defer_fn(function()
      vscode.action("workbench.action.terminal.sendSequence", { args = { { text = "opencode\n" } } })
    end, 1000)
  end, { desc = "OpenCode" })

  -- Collapse all panes
  map("n", "<Esc>", function()
    vscode.action("workbench.action.closeSidebar")
    vscode.action("workbench.action.closePanel")
    vscode.action("workbench.action.closeAuxiliaryBar")
  end, { desc = "Collapse all panes" })
else
  -- Navigation
  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
  map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

  -- UI Toggles
  map("n", "<leader>ut", function()
    local enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not enabled)
  end, { desc = "Toggle Inlay Hints" })

  local types_dimmed = false
  map("n", "<leader>uT", function()
    types_dimmed = not types_dimmed
    local hl = types_dimmed and { fg = "#3a3a3a" } or {}
    vim.api.nvim_set_hl(0, "@type", hl)
    vim.api.nvim_set_hl(0, "@type.builtin", hl)
    vim.api.nvim_set_hl(0, "@type.qualifier", hl)
  end, { desc = "Toggle Type Annotation Visibility" })

  -- Diagnostics
  map("n", "<leader>dn", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
  map("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, { desc = "Prev Diagnostic" })

  -- Refactoring & Actions
  map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
end

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
