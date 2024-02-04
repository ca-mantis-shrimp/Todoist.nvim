local requests = require("Todoist.query")

local mock_curl = {}

mock_curl.request = function(request_table)
	if string.find(request_table.headers.Authorization, "good key") ~= nil then
		return {
			full_synce = true,
			temp_id_mapping = {},
			projects = { { id = 1, name = "test_project" } },
			project_notes = {},
			tasks = {},
		}
	else
		return {
			exit = 0,
			status = 403,
			headers = {},
			body = "",
		}
	end
end

describe("unit tests for todoist requests", function()
	it("should return a table of projects", function()
		local projects = requests.get_all_projects("good key", mock_curl)

		assert.are.same(
			vim.inspect({
				full_synce = true,
				temp_id_mapping = {},
				projects = { { id = 1, name = "test_project" } },
				project_notes = {},
				tasks = {},
			}),
			vim.inspect(projects)
		)
	end)

	it("should return the full response when failed", function()
		local projects = requests.get_all_projects("bad key", mock_curl)
		assert.are.same(
			vim.inspect({
				exit = 0,
				status = 403,
				headers = {},
				body = "",
			}),
			vim.inspect(projects)
		)
	end)

	it("should be able to reduce a successful response down to a table with only todoist types", function()
		local response = {
			full_synce = true,
			temp_id_mapping = {},
			projects = { { id = 1, name = "test_project" } },
			items = { { id = 1, content = "test_task" } },
			project_notes = { { id = 1, content = "test comment" } },
		}

		local reduced_response = requests.reduce_response(response)

		assert.are.same(
			vim.inspect({
				projects = { { id = 1, name = "test_project" } },
				items = { { id = 1, content = "test_task" } },
				project_notes = { { id = 1, content = "test comment" } },
			}),
			vim.inspect(reduced_response)
		)
	end)
end)
