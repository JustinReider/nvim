return {
	{
		"olimorris/codecompanion.nvim",
		version = "v17.33.0",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"ravitemer/mcphub.nvim"
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
					keymaps = {
						accept_change = {
							modes = { n = "ga" },
						},
						reject_change = {
							modes = { n = "gr" },
							opts = { nowait = true },
						},
					},
				},
				workflow = {
					adapter = "copilot",
				},
			},
			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									default = "claude-sonnet-4.5",
								},
							},
						})
					end,
				},
			},
			display = {
				action_palette = {
					width = 95,
					height = 15,
					prompt = "Prompt ", -- Prompt used for interactive LLM calls
					provider = "default",
					opts = {
						show_preset_actions = true, -- Show the preset actions in the action palette?
						show_preset_prompts = true, -- Show the preset prompts in the action palette?
						title = "CodeCompanion actions", -- The title of the action palette
					},
				},
			},
		},
		vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }),
		vim.keymap.set({ "n", "v" }, "<C-i>", "<cmd>CodeCompanion<cr>", { noremap = true, silent = true })
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" }
	},
}
