local requests = require("Todoist.query")

local mock_curl = {}

mock_curl.request = function(request_table)
	if string.find(request_table.headers.Authorization, "good key") ~= nil then
		return {
			full_synce = true,
			temp_id_mapping = {},
			projects = { { id = 1, name = "test_project" } },
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
end)
