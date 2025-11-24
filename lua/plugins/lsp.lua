return {
	---------------------------------------------------------------------------
	-- Mason + mason-lspconfig + LSP
	---------------------------------------------------------------------------
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function(_, opts)
			local servers = {
				"lua_ls", --lua
				"html", --html
				"cssls", --css
				"intelephense", --php
				"ts_ls", --js/ts
				"eslint",
				"sqlls", --sql
				"jdtls", --java
				"pyright", --python
				"bashls", --bash
				"jsonls", --json
				"fsautocomplete", --fsharp
			}

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = true,
			})

			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- Versuche für jeden Server eine Extra-Config aus lua/lsp/<name>.lua zu laden
			for _, server in ipairs(servers) do
				local ok, extra = pcall(require, "lsp." .. server)
				if ok then
					vim.lsp.config(server, extra)
				end
			end
		end,
	},

	---------------------------------------------------------------------------
	-- nvim-cmp + LuaSnip
	---------------------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
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
				-- keymaps
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = function()
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end,
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
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
			})
			-- autopairs integration
			cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	},
}
