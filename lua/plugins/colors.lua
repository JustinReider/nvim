local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

local function is_ssh()
    return vim.env.SSH_CONNECTION ~= nil
        or vim.env.SSH_CLIENT ~= nil
        or vim.env.SSH_TTY ~= nil
end

return {
    {
        "rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	opts = {
	    theme = "wave",
	    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
	},
        config = function(_, opts)
	    require("kanagawa").setup(opts)
	    vim.cmd.colorscheme("kanagawa")
            if not is_ssh() then
                enable_transparency()
            end
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            options = {
                theme = 'kanagawa',
                icons_enabled = true,
            }
        }
    },
}
