local util = require("Todoist.util")
local M = {}

M.write_file = function(path, content)
	local file, err = io.open(path, "w+")

	if not file then
		error("Error opening file: " .. err)
		return
	end

	if not type(content) == "table" then
		error("Content needs to be table of strings")
		return
	end

	local index = 1
	while index < #content do
		file:write(content[index] .. "\n")
		index = index + 1
	end
	file:write(content[index]) -- write last line without newline

	file:close()
end

M.read_file = function(path)
	local lines = {}
	local file, err = io.open(path, "r")

	if not file then
		error("Error opening file: " .. err)
		return
	end

	for line in file:lines() do
		table.insert(lines, line)
	end

	file:close()

	return lines
end
return M
