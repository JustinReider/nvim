return {
	{
		'github/copilot.vim',
		config = function()
			--disable copilot by on startup
			vim.g.copilot_enabled = false
			--disable default tab mapping
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			--toggle copilot with <leader>ai
			vim.keymap.set("n", "<leader>ai", function()
				vim.g.copilot_enabled = not vim.g.copilot_enabled
				if vim.g.copilot_enabled then
					print("Copilot enabled")
				else
					print("Copilot disabled")
				end
			end, { noremap = true, silent = true })
			--accept copilot suggestion with <C-y>
			vim.keymap.set("i", "<C-y>", 'copilot#Accept("<CR>")', {
				silent = true, expr = true, replace_keycodes = false
			})
		end,
	},
}
