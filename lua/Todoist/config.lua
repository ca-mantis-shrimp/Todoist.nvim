local M = {}

M.defaults = {
	api_key = {
		env_variable = "TODOIST_API_KEY",
		file_path = "",
		cmd = "",
	},
	ui = {
		ui_type = "float",
	},
}

function M.get_api_key(api_key_opts)
	M.api_key = nil
	if api_key_opts.env_variable ~= nil then
		M.api_key = os.getenv(api_key_opts.env_variable)
	end
	if api_key_opts.file_path ~= nil then
		M.api_key = vim.fn.readfile(api_key_opts.file_path)[1]
	end
	if api_key_opts.cmd ~= nil then
		M.api_key = vim.fn.system(api_key_opts.cmd)
	end
end

function M.setup(options)
	M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})

	M.get_api_key(M.options.api_key)
end

M.setup()

return M
