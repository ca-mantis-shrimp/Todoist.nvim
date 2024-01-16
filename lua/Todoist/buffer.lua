local M = {}
M.create_buffer_with_lines = function(listed, scratch, lines)
	local buffer_id = vim.api.nvim_create_buf(listed, scratch)

	vim.api.nvim_buf_set_lines(buffer_id, 0, -1, true, lines)

	return buffer_id
end

return M
