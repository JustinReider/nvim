---------------------------------------------------------------------------
-- nvim-cmp + LuaSnip
---------------------------------------------------------------------------
return {
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
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),

					-- Auswahl bestätigen
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- Navigation
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.snippet and vim.snippet.expandable() then
							vim.snippet.expand()
						elseif vim.snippet and vim.snippet.active() then
							vim.snippet.jump(1)
						else
							fallback()
						end
					end, { "i", "s"}),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.snippet and vim.snippet.active() then
							vim.snippet.jump(-1)
						else
							fallback()
						end
					end, { "i", "s"}),

					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
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
