return {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
      },
      debounce_delay = 1000,
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "gitcommit", "neo-tree" }) then
          return true
        end
        return false
      end,
    },
  },
}
