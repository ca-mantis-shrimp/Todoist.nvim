local config = require("Todoist.config")

describe("initial plugin config", function()
	it("should return the default if a key is not available from the given options", function()
		local expected_default = ""

		assert.are.equal(expected_default, config.api_key)
	end)

	it("should set the options for the module with the table in question", function()
		local opts = { api_key = "some key", default_window_type = "float" }

		config.setup(opts)

		assert.are.same(opts.api_key, config.api_key)
		assert.are.same(opts.default_window_type, config.default_window_type)
	end)
end)
