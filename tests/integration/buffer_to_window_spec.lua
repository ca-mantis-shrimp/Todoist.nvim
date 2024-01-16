local buffer_api = require("Todoist.buffer")
local window_api = require("Todoist.window")

describe("displaying the todoist buffer as a window", function()
	it("can display the buffer in a floating window", function()
		local buffer_id =
			buffer_api.create_buffer_with_lines(true, false, { "* v Inbox", "   [ ] Test Task", "* > Test Project" })
		local window_id = window_api.create_floating_window(buffer_id)

		local window_buffer_id = vim.api.nvim_win_get_buf(window_id)

		assert.equals(buffer_id, window_buffer_id)
	end)
end)
