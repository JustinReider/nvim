local function enable_transparency()
end

local function is_ssh()
	return vim.env.SSH_CONNECTION ~= nil
		or vim.env.SSH_CLIENT ~= nil
		or vim.env.SSH_TTY ~= nil
end

return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
			transparent = true,
			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				}
			end,
		},
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd.colorscheme("kanagawa-dragon")
			if not is_ssh() then
				--enable_transparency()
			end
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			options = {
				theme = 'kanagawa',
				icons_enabled = true,
			}
		}
	},
}
