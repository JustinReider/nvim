return {
	{
		'goerz/jupytext.vim',
		config = function()
			vim.g.jupytext_fmt = 'py' -- konvertiert .ipynb → .py beim Öffnen
		end
	},
	{
		'benlubas/molten-nvim',
		version = '^1.0.0',
		build = ':UpdateRemotePlugins',
		lazy = false,
		init = function()
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_image_provider = "none"
			vim.g.python3_host_prog = '/usr/bin/python3'
		end
	}
}
