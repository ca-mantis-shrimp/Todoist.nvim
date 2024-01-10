local M = {}

M.api_key = ""
M.default_window_type = "float"

M.setup = function(opts)
	M.api_key = opts.api_key
	M.default_window_type = opts.default_window_type
end

return M
