return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- Required for the UI pickers
      "mfussenegger/nvim-dap", -- Required for debugging
    },
    config = function()
      local dotnet = require("easy-dotnet")
      dotnet.setup({
        -- This will automatically use Roslyn and netcoredbg
        lsp = {
          enabled = true,
          preload_roslyn = true,
        },
        terminal = function(path, action, args)
          -- This opens a terminal in a vertical split for run/test/build
          local commands = {
            run     = string.format("dotnet run --project %s %s", path, args or ""),
            test    = string.format("dotnet test %s %s", path, args or ""),
            restore = string.format("dotnet restore %s %s", path, args or ""),
            build   = string.format("dotnet build %s %s", path, args or ""),
            watch   = string.format("dotnet watch --project %s %s", path, args or ""),
          }
          vim.cmd("vsplit")
          vim.cmd("term " .. (commands[action] or ("dotnet " .. action .. " " .. path)))
        end,
      })

      -- Keymaps for the terminal warrior
      vim.keymap.set("n", "<leader>cs", function()
        local view = require("easy-dotnet.ui-modules.project-view")
        if view.is_open() then
          vim.cmd("bwipeout") -- This closes the buffer
        else
          dotnet.project_view()
        end
      end, { desc = "Toggle C# Solution View" })
      vim.keymap.set("n", "<leader>dr", function()
        dotnet.run()
      end, { desc = "Dotnet Run" })
      vim.keymap.set("n", "<leader>dt", function()
        dotnet.test_solution()
      end, { desc = "Dotnet Test Solution" })
      vim.keymap.set("n", "<leader>db", function()
        dotnet.build_solution()
      end, { desc = "Dotnet Build Solution" })
    end,
  },
}
