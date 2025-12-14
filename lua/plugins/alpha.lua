return {
	{
		'Shatur/neovim-session-manager',
		config = function()
			local config = require('session_manager.config')
			require('session_manager').setup({
				autoload_mode = config.AutoloadMode.Disabled,
			})
			require('telescope').load_extension('ascii')
		end,
	},
	{
		"MaximilianLloyd/ascii.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		'goolord/alpha-nvim',
		dependencies = { 'Shatur/neovim-session-manager' },
		config = function()
			local alpha = require('alpha')
			local dashboard = require('alpha.themes.dashboard')

			-- Set header
			dashboard.section.header.val = require('ascii').art.text.neovim.dos_rebel;

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("n", "󰈔 New File", ":ene <BAR> startinsert <CR>"),
				dashboard.button("ff", "󰈞 Find File", ":Telescope find_files<CR>"),
				dashboard.button("r", "󰋚 Recent Files", ":Telescope oldfiles<CR>"),
				dashboard.button("fg", "󰱼 Find Text", ":Telescope live_grep<CR>"),
				dashboard.button("fm", "󰌌 Keybindings", ":Telescope keymaps<CR>"),
				dashboard.button("s", "󰦛 Restore Session", ":SessionManager load_last_session<CR>"),
				dashboard.button("ls", "󰁯 Load Session", ":SessionManager load_current_dir_session<CR>"),
				dashboard.button("p", "󰏖 Plugins", ":Lazy<CR>"),
				dashboard.button("q", "󰗼 Quit", ":qa<CR>"),
			}

			alpha.setup(dashboard.config)
		end,
	},
}
