return {
	'goerz/jupytext.vim',
	config = function()
		vim.g.jupytext_fmt = 'py' -- konvertiert .ipynb → .py beim Öffnen
	end
}
