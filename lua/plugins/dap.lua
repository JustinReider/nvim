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
			map("n", "<F5>", dap.continue, { desc = 'DAP continue' })
			map("n", "<F10>", dap.step_over, { desc = 'DAP step over' })
			map("n", "<F11>", dap.step_into, { desc = 'DAP step into' })
			map("n", "<F12>", dap.step_out, { desc = 'DAP step out' })
			map("n", "<leader>db", dap.toggle_breakpoint, { desc = 'DAP toggle breakpoint' })
      		map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = 'DAP set breakpoint condition' })
			map("n", "<leader>du", dapui.toggle, { desc = 'DAP toggle UI' })
		end,
	},
}
