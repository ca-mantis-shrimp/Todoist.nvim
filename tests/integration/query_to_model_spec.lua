local query = require("Todoist.query")
local curl = require("plenary.curl")
local model = require("Todoist.model")

describe("integration between the query module and the todoist model", function()
	it("should be able to create a node dictionary from a successful query", function()
		local response = query.get_all_projects("e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", curl)
		local reduced_response = query.reduce_response(response)

		local node_dictionary = model.create_node_dictionary(reduced_response)

		local expected_dictionary = {
			[2326329373] = {
				child_order = 0,
				children = {},
				collapsed = false,
				color = "charcoal",
				inbox_project = true,
				is_archived = false,
				is_deleted = false,
				name = "Inbox",
				type = "project",
				view_style = "list",
			},
			[2326329411] = {
				child_order = 1,
				children = {},
				collapsed = false,
				color = "teal",
				is_archived = false,
				is_deleted = false,
				name = "Test Project",
				type = "project",
				view_style = "list",
			},
			[7568186805] = {
				checked = false,
				child_order = 1,
				collapsed = false,
				content = "Test Task",
				day_order = -1,
				description = "",
				due = vim.NIL,
				is_deleted = false,
				labels = {},
				parent_id = vim.NIL,
				priority = 1,
				sync_id = vim.NIL,
				type = "task",
			},
			[7568188188] = {
				checked = false,
				child_order = 1,
				collapsed = false,
				content = "Test Project Task",
				day_order = -1,
				description = "",
				due = vim.NIL,
				is_deleted = false,
				labels = {},
				parent_id = vim.NIL,
				priority = 1,
				sync_id = vim.NIL,
				type = "task",
			},
			[7568188837] = {
				checked = false,
				child_order = 1,
				collapsed = false,
				content = "Test Sub-Task",
				day_order = -1,
				description = "",
				due = vim.NIL,
				is_deleted = false,
				labels = {},
				parent_id = "7568188188",
				priority = 1,
				sync_id = vim.NIL,
				type = "task",
			},
		}

		assert.are.equal(vim.inspect(node_dictionary), vim.inspect(expected_dictionary))
	end)
end)
