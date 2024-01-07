local window = require("Todoist.window")

describe("Neovim Lua API", function()
	it("Can Test that a window was successfully created and shown on the current screen", function()
		local buffer_id = vim.api.nvim_create_buf(false, true)

		local window = window.create_floating_window(buffer_id)

		assert.is_true(vim.api.nvim_win_is_valid(window))
	end)
end)
