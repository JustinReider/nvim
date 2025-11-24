vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

--faster split navigation
vim.keymap.set("n", "<leader>s", vim.cmd.split)
vim.keymap.set("n", "<leader>v", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "<C-h>", "<C-W><C-H>")
vim.keymap.set("n", "<C-j>", "<C-W><C-J>")
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
