local request_generator = require("Todoist.request_utilities")

describe("unit tests for todoist requests", function()
	it("should produce a proper sync request", function()
		local sync_request = request_generator.create_sync_request("good key", "*", {
			request_generator.todoist_resource_types[1],
			request_generator.todoist_resource_types[2],
			request_generator.todoist_resource_types[3],
		})

		assert.are.same(sync_request.headers.Authorization, "Bearer good key")
		assert.are.same(sync_request.data.sync_token, "*")
		assert.are.same(sync_request.data.resource_types, '["projects", "items", "notes"]')
	end)

	it("should be able to reduce a successful response down to a table with only todoist types", function()
		local response = {
			full_synce = true,
			temp_id_mapping = {},
			projects = { { id = 1, name = "test_project" } },
			items = { { id = 1, content = "test_task" } },
			project_notes = { { id = 1, content = "test comment" } },
		}

		local reduced_response = request_generator.reduce_response(response)

		assert.are.same(
			vim.inspect({
				projects = { { id = 1, name = "test_project" } },
				items = { { id = 1, content = "test_task" } },
				project_notes = { { id = 1, content = "test comment" } },
			}),
			vim.inspect(reduced_response)
		)
	end)

	it("should be able to process a successful request response", function()
		local response = {
			status = 200,
			body = vim.json.encode({
				full_sync = true,
			}),
		}

		local processed_response = request_generator.process_response(response)

		assert(processed_response.full_sync)
	end)
end)
