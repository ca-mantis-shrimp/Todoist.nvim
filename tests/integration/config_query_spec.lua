local config = require("Todoist.config")
local query = require("Todoist.query")
local curl = require("plenary.curl")

describe("integrating the curl wrapper with the config module", function()
	it("should return a proper sync table with a proper api key", function()
		-- This is the api key for a test account that was made specifically for integration test purposes
		local opts = { api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", default_window_type = "float" }
		config.setup(opts)

		local projects = query.get_all_projects(config.api_key, curl)

		assert(projects.full_sync)
	end)

	it("should fail if given a an invalid key", function()
		local opts = { api_key = "bad key", default_window_type = "float" }
		config.setup(opts)

		local error = query.get_all_projects(config.api_key, curl)

		assert(error.status == 403)
	end)

	it("should be able to extract todoist types from response", function()
		local opts = { api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", default_window_type = "float" }

		local projects = query.get_all_projects(opts.api_key, curl)

		local reduced_response = query.reduce_response(projects)

		assert(#reduced_response.projects > 0 and #reduced_response.items > 0)
	end)
end)
