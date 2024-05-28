local config = require("Todoist.config")

describe("initial plugin config", function()
	it("should return error if a key is not available from the given options", function()
		local status, error = pcall(config.config, {})

		assert.are.equal(error, "./lua/Todoist/config.lua:4: api key is required for operation of Todoist.nvim")
		assert(status == false)
	end)

	it("should set the options for the module with the table in question", function()
		local opts = { api_key = "some key", default_window_type = "float" }

		config.config(opts)

		assert.are.same(opts.api_key, config.api_key)
		assert.are.same(opts.default_window_type, config.default_window_type)
	end)
end)
