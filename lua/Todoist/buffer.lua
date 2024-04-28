local M = {}
local function remove_newlines(lines)
	for i, str in ipairs(lines) do
		lines[i] = string.gsub(str, "\n", "")
	end
end

M.create_buffer_with_lines = function(listed, scratch, lines)
	local buffer_id = vim.api.nvim_create_buf(listed, scratch)

	remove_newlines(lines)

	vim.bo[buffer_id].filetype = "projects"

	vim.api.nvim_buf_set_lines(buffer_id, 0, -1, true, lines)

	return buffer_id
end

M.create_buffer_from_file = function(path, lines)
	local file_path = vim.fn.stdpath("cache") .. "todoist.projects"
	io.open(file_path, "w"):write(lines)
end

return M
