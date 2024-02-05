local config = require("Todoist.config")
local request = require("Todoist.request")
local curl = require("plenary.curl")

describe("integrating the curl wrapper with the config module", function()
	it("should return a proper sync table with a proper api key", function()
		-- This is the api key for a test account that was made specifically for integration test purposes
		local opts = { api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", default_window_type = "float" }
		config.config(opts)

		local projects = curl.request(request.create_sync_request(config.api_key))

		assert(projects.full_sync)
	end)

	it("should fail if given a an invalid key", function()
		local opts = { api_key = "bad key", default_window_type = "float" }
		config.config(opts)

		local error = curl.request(request.create_sync_request(config.api_key))

		assert(error.status == 403)
	end)

	it("should be able to extract todoist types from response", function()
		local opts = { api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", default_window_type = "float" }

		local projects = curl.request(request.create_sync_request(opts.api_key))

		local reduced_response = request.reduce_response(projects)

		assert(
			#reduced_response.projects > 0
				and #reduced_response.items > 0
				and #reduced_response.project_notes > 0
				and reduced_response.full_sync == nil
				and reduced_response.temp_id_mapping == nil
		)
	end)
end)
