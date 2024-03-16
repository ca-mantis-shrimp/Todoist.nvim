local M = {}

M.create_split_window = function(buffer_id)
	local window = vim.api.nvim_open_win(buffer_id, true, {
		split = "left",
		win = 0,
	})

	return window
end

return M
