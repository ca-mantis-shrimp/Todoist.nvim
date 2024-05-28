local filesystem = require("Todoist.filesystem")
local todoist_path = vim.fn.stdpath("cache") .. "/Todoist"
if not io.open(todoist_path, "r") then
	vim.fn.mkdir(todoist_path, "p")
end

if not io.open(todoist_path .. "/test", "r") then
	vim.fn.mkdir(todoist_path .. "/test", "p")
end

describe("filesystem functionality", function()
	it("Can Write to a file", function()
		local test_content = { "test content", "another line" }
		local test_file_path = vim.fn.stdpath("cache") .. "/Todoist/test/file_output.txt"

		local success, _ = pcall(filesystem.write_file, test_file_path, test_content)

		local file_contents = io.open(test_file_path, "r"):read("*a")
		assert(success)
		assert.are.equals(file_contents, "test content\nanother line")
	end)

	it("can read a file from a path", function()
		local expected_content = { "test content", "another line" }

		local test_file_path = vim.fn.stdpath("cache") .. "/Todoist/test/file_read.txt"
		io.output(test_file_path)

		io.write(expected_content[1], "\n", expected_content[2])

		io.close()

		local success, file_contents = pcall(filesystem.read_file, test_file_path)

		assert(success)
		assert.are.equals(vim.inspect(file_contents), vim.inspect(expected_content))
	end)
end)
