vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = 'Open file viwer' })
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = 'Write buffer' })
vim.keymap.set("n", "D", '"_D', { noremap = true, desc = "Delete without yank" })

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

--lsp keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Diagnostics
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	end,
})

--faster split navigation
vim.keymap.set("n", "<leader>s", vim.cmd.split, { desc = 'Horizontal split window' })
vim.keymap.set("n", "<leader>v", vim.cmd.vsplit, { desc = 'Vertical split window' })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = 'Quit' })
vim.keymap.set("n", "<C-h>", "<C-W><C-H>")
vim.keymap.set("n", "<C-j>", "<C-W><C-J>")
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")

--Clear search with leader + /
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>")
