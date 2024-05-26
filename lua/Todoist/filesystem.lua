local M = {}

M.write_file = function(path, content)
	local file, err = io.open(path, "w+")

	if not file then
		error("Error opening file: " .. err)
		return
	end

	file:write(content)
	file:close()
end

return M
