return {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional: only load when you toggle it
    event = { "InsertLeave", "TextChanged" }, -- save when you leave insert mode or change text
    opts = {
      enabled = true, -- start auto-save when the plugin is loaded
      trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save
      debounce_delay = 1000, --If you feel it saves to fast after you stop writing, then change this
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        -- Don't save for special file types (like git commits or the file tree)
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "gitcommit", "neo-tree" }) then
          return true
        end
        return false
      end,
    },
  },
}
