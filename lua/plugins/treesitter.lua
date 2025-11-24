return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
	    highlight = {
		enable = true,
	    },
	    indent = { enable = true },
	    autotage = { enable = true },
	    ensure_installed = {
		"lua",
		"php",
		"css",
		"javascript",
		"java",
		"cpp",
		"bash",
		"dart",
		"fsharp",
		"python",
		"html",
		"json",
		"sql",
	    },
	    auto_install = false,
	})
    end
}
