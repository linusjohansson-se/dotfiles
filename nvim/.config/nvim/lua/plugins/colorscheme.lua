return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        groups = {
          all = {
            ["@lsp.type.extensionMethod"] = { link = "@function" },
          ["@lsp.type.method"]         = { link = "@function" },
          ["@lsp.type.property"]       = { link = "@variable.member" },
          ["@lsp.type.field"]          = { link = "@variable.member" },
          ["@lsp.type.namespace"]      = { link = "@module" },
          ["@lsp.type.interface"]      = { link = "@type" },
          ["@lsp.type.struct"]         = { link = "@type" },
          ["@lsp.type.enumMember"]     = { link = "@constant" },
          ["@lsp.type.typeParameter"]  = { link = "@type" },
          ["@lsp.type.delegate"]       = { link = "@type" },
          },
        },
      })
      vim.cmd("colorscheme carbonfox")
    end,
  },
}
