return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ravitemer/mcphub.nvim",
		},
		opts = {
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_vars = true,
						make_slash_commands = true,
						show_result_in_chat = true
					}
				}
			},
			strategies = {
				chat = {
					name = "copilot",
					model = "claude-sonnet-4.5",
				},
				inline = {
					adapter = "anthropic",
				}

			},
		},
	},
}
