local M = {}

M.create_floating_window = function(buffer_id)
	local window = vim.api.nvim_open_win(buffer_id, true, {
		relative = "editor",
		width = 100,
		height = 100,
		row = 5,
		col = 5,
		style = "minimal",
	})

	return window
end

return M
