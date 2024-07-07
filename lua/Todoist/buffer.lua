local M = {}
local function remove_newlines(lines)
	for i, str in ipairs(lines) do
		lines[i] = string.gsub(str, "\n", "")
	end
end

M.create_buffer_with_lines = function(listed, scratch, lines, buf_name)
	local buffer_id = vim.api.nvim_create_buf(listed, scratch)

	remove_newlines(lines)

	vim.bo[buffer_id].filetype = "projects"

	vim.api.nvim_buf_set_lines(buffer_id, 0, -1, true, lines)
	if not pcall(vim.api.nvim_buf_set_name, buffer_id, buf_name) then
		return buffer_id
	end

	return buffer_id
end

return M
