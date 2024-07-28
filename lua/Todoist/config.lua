local M = {}

M.config = function(opts)
	assert(opts.api_key, "api key is required for operation of Todoist.nvim")

	M.api_key = opts.api_key
	M.default_window_type = opts.default_window_type or "floating"
	M.logging = opts.logging or true
	M.indent_on_buf_enter = opts.indent_on_buf_enter or true
end

return M
