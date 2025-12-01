return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require('harpoon')
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Harpoon add to list' })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon toggle quick menu' })
        vim.keymap.set("n", "<leader>fl", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open harpoon window" })
        vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end, { desc = 'Harpoon view previous' })
        vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = 'Harpoon view next' })
    end
}
