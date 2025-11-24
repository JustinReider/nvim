local projects = {
	team05 = {
		source = "/home/justin/Documents/Web/Team05",
		target = "/opt/lampp/htdocs",
	},
}

local function deploy(name)
	local p = projects[name]

	if not p then
		vim.notify("Project '" .. name .. "' does not exist.", vim.log.levels.ERROR)
		return
	end

	vim.notify("Deploy started: " .. name)

	vim.fn.jobstart({
		"rsync", "-av", "--delete", "--no-perms",
		"--no-owner", "--no-owner", "--no-group",
		p.source .. "/", p.target .. "/"
	}, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("Deploy succesful: " .. name)
			else
				vim.notify("Deploy failed: exit " .. code, vim.log.levels.ERROR)
			end
		end
	})
end

vim.api.nvim_create_user_command("Deploy", function(opts)
	deploy(opts.args)
end, {
	nargs = 1,                    -- one argument
	complete = function()
		return vim.tbl_keys(projects) -- Tab Completion
	end
})
