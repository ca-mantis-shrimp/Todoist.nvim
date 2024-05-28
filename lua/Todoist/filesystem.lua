local M = {}

M.write_file = function(path, content)
	local file, err = io.open(path, "w+")

	assert(file, "invalid file for writing", err)

	assert(type(content) == "table", "Content needs to be table of strings", tostring(content))

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

	assert(file, "Error opening file: ", err)

	for line in file:lines() do
		table.insert(lines, line)
	end

	file:close()

	return lines
end
return M
