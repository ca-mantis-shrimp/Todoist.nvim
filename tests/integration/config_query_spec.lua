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

		local expected_dictionary = {
			items = {
				{
					[added_at] = "2024-01-07T19:06:15.687701Z",
					[added_by_uid] = "47679819",
					[assigned_by_uid] = vim.NIL,
					[checked] = false,
					[child_order] = 1,
					[collapsed] = false,
					[completed_at] = vim.NIL,
					[content] = "Test Task",
					[day_order] = -1,
					[description] = "",
					[due] = vim.NIL,
					[duration] = vim.NIL,
					[id] = "7568186805",
					[is_deleted] = false,
					[labels] = {},
					[parent_id] = vim.NIL,
					[priority] = 1,
					[project_id] = "2326329373",
					[responsible_uid] = vim.NIL,
					[section_id] = vim.NIL,
					[sync_id] = vim.NIL,
					[updated_at] = "2024-01-07T19:06:15Z",
					[user_id] = "47679819",
					[v2_id] = "6RJQ8GwqwfvPMj9j",
					[v2_parent_id] = vim.NIL,
					[v2_project_id] = "6RJQ8Cx2Xf2Q84RC",
					[v2_section_id] = vim.NIL,
				},
				{
					[added_at] = "2024-01-07T19:06:48.484070Z",
					[added_by_uid] = "47679819",
					[assigned_by_uid] = vim.NIL,
					[checked] = false,
					[child_order] = 1,
					[collapsed] = false,
					[completed_at] = vim.NIL,
					[content] = "Test Project Task",
					[day_order] = -1,
					[description] = "",
					[due] = vim.NIL,
					[duration] = vim.NIL,
					[id] = "7568188188",
					[is_deleted] = false,
					[labels] = {},
					[parent_id] = vim.NIL,
					[priority] = 1,
					[project_id] = "2326329411",
					[responsible_uid] = vim.NIL,
					[section_id] = vim.NIL,
					[sync_id] = vim.NIL,
					[updated_at] = "2024-01-07T19:06:48Z",
					[user_id] = "47679819",
					[v2_id] = "6RJQ8MrccjmmJM2m",
					[v2_parent_id] = vim.NIL,
					[v2_project_id] = "6RJQ8JRMWPH6vmpF",
					[v2_section_id] = vim.NIL,
				},
				{
					[added_at] = "2024-01-07T19:07:04.610799Z",
					[added_by_uid] = "47679819",
					[assigned_by_uid] = vim.NIL,
					[checked] = false,
					[child_order] = 1,
					[collapsed] = false,
					[completed_at] = vim.NIL,
					[content] = "Test Sub-Task",
					[day_order] = -1,
					[description] = "",
					[due] = vim.NIL,
					[duration] = vim.NIL,
					[id] = "7568188837",
					[is_deleted] = false,
					[labels] = {},
					[parent_id] = "7568188188",
					[priority] = 1,
					[project_id] = "2326329411",
					[responsible_uid] = vim.NIL,
					[section_id] = vim.NIL,
					[sync_id] = vim.NIL,
					[updated_at] = "2024-01-07T19:07:04Z",
					[user_id] = "47679819",
					[v2_id] = "6RJQ8QFv9Fv84jHm",
					[v2_parent_id] = "6RJQ8MrccjmmJM2m",
					[v2_project_id] = "6RJQ8JRMWPH6vmpF",
					[v2_section_id] = vim.NIL,
				},
			},
			projects = {
				{
					[child_order] = 0,
					[collapsed] = false,
					[color] = "charcoal",
					[created_at] = "2024-01-07T19:05:53Z",
					[id] = "2326329373",
					[inbox_project] = true,
					[is_archived] = false,
					[is_deleted] = false,
					[is_favorite] = false,
					[name] = "Inbox",
					[parent_id] = vim.NIL,
					[shared] = false,
					[sync_id] = vim.NIL,
					[updated_at] = "2024-01-07T19:05:53Z",
					[v2_id] = "6RJQ8Cx2Xf2Q84RC",
					[view_style] = "list",
				},
				{
					[child_order] = 1,
					[collapsed] = false,
					[color] = "teal",
					[created_at] = "2024-01-07T19:06:33Z",
					[id] = "2326329411",
					[is_archived] = false,
					[is_deleted] = false,
					[is_favorite] = false,
					[name] = "Test Project",
					[parent_id] = vim.NIL,
					[shared] = false,
					[sync_id] = vim.NIL,
					[updated_at] = "2024-01-07T19:06:33Z",
					[v2_id] = "6RJQ8JRMWPH6vmpF",
					[view_style] = "list",
				},
			},
		}

		assert.are.same(expected_dictionary, reduced_response)
	end)
end)
