local filesystem = require("Todoist.filesystem")
local todoist_path = vim.fn.stdpath("cache") .. "/Todoist"
if not io.type(io.open(todoist_path, "r")) then
	vim.fn.mkdir(todoist_path, "p")
end

if not io.type(io.open(todoist_path .. "/test", "r")) then
	vim.fn.mkdir(todoist_path .. "/test", "p")
end

describe("filesystem functionality", function()
	it("Can Write to a file", function()
		local test_content = "test content"
		local test_file_path = vim.fn.stdpath("cache") .. "/Todoist/test/file_output.txt"

		filesystem.write_file(test_file_path, test_content)

		file_contents = io.open(test_file_path, "r"):read("*a")

		assert.are.equals(test_content, file_contents)
	end)
end)
