return {
  {
    "akinsho/flutter-tools.nvim",
	Lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("flutter-tools").setup({
        widget_guides = { enabled = true },
        lsp = {
          capabilities = capabilities,
        },
      })
    end,
  },
}
