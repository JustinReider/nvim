return {
  ---------------------------------------------------------------------------
  -- Mason + mason-lspconfig + LSP Defaults (Neovim 0.11+)
  ---------------------------------------------------------------------------
  {
    -- mason-lspconfig ist jetzt unter mason-org
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",       -- liefert nur noch die Server-Configs
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      -- Server, die Mason für dich installieren soll
      ensure_installed = {
		"lua_ls",
		"intelephense",
		"cssls",
	    },
      -- installiert + ruft automatisch vim.lsp.enable() für die Server auf
      automatic_enable = true,
    },
    config = function(_, opts)
      -----------------------------------------------------------------------
      -- Mason + mason-lspconfig initialisieren
      -----------------------------------------------------------------------
      require("mason").setup()
      require("mason-lspconfig").setup(opts)

      -----------------------------------------------------------------------
      -- Globale LSP-Defaults (für ALLE Server) via vim.lsp.config('*', ...)
      -----------------------------------------------------------------------
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true })
          end

          -- Standard-LSP-Keymaps
          map("n", "gd", vim.lsp.buf.definition)
          map("n", "gD", vim.lsp.buf.declaration)
          map("n", "gi", vim.lsp.buf.implementation)
          map("n", "gr", vim.lsp.buf.references)
          map("n", "K",  vim.lsp.buf.hover)
          map("n", "<leader>rn", vim.lsp.buf.rename)
          map("n", "<leader>ca", vim.lsp.buf.code_action)
          map("n", "[d", vim.diagnostic.goto_prev)
          map("n", "]d", vim.diagnostic.goto_next)
          map("n", "<leader>fd", vim.diagnostic.open_float)
        end,
      })

      -----------------------------------------------------------------------
      -- Extra Config NUR für lua_ls
      -----------------------------------------------------------------------
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- sonst meckert lua_ls über "vim"
            },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -----------------------------------------------------------------------
      -- Diagnostics Style
      -----------------------------------------------------------------------
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        signs = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
      })

      -- WICHTIG:
      -- Kein vim.lsp.enable("lua_ls") hier!
      -- mason-lspconfig macht das automatisch für alle installierten Server.
    end,
  },

  ---------------------------------------------------------------------------
  -- Autocompletion (nvim-cmp + LuaSnip)
  ---------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,

          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}

