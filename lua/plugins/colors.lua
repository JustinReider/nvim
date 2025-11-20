local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

local function is_ssh()
    return vim.env.SSH_CONNECTION ~= nil
        or vim.env.SSH_CLIENT ~= nil
        or vim.env.SSH_TTY ~= nil
end

function LineNumberColors()
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = '#6da9bf', bold = true })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = '#9c04f9', bold = true })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = '#6da9bf', bold = true })
end

return {
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme "tokyonight"
            if not is_ssh() then
                enable_transparency()
            end
            LineNumberColors()
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            options = {
                theme = 'tokyonight',
                icons_enabled = true,
            }
        }
    },
}
