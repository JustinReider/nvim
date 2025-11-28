return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local servers = {
				"dart",
				"javadbg",
			}

			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				ensure_installed = servers,
				automatic_enable = true,
			})

			dapui.setup()

			-- Auto UI open/close
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Simple Keymaps
			local map = vim.keymap.set
			map("n", "<F5>", function() dap.continue() end)
			map("n", "<F10>", function() dap.step_over() end)
			map("n", "<F11>", function() dap.step_into() end)
			map("n", "<F12>", function() dap.step_out() end)
			map("n", "<leader>db", function() dap.toggle_breakpoint() end)
			map("n", "<leader>du", function() dapui.toggle() end)
		end,
	},
}
