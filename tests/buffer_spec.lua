local buffer = require("Todoist.buffer")

describe("buffer functionality", function()
	it("Can Attach to a buffer the first line", function()
		local buffer_id = buffer.Create_buffer_with_lines(true, false, { "Hello World" })

		local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, 1, true)

		assert.equals("Hello World", lines[1])
	end)
end)
