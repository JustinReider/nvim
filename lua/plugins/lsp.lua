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
}
