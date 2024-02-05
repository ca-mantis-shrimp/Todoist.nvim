local M = {}

M.config = function(opts)
	M.api_key = opts.api_key or error("api_key required for Todoist.nvim to work", 2)
	M.default_window_type = opts.default_window_type or "floating"
end

return M
