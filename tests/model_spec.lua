local model = require("Todoist.model")

describe("converting Todoist Data into the Node Model", function()
	it("can convert a dictionary of types into a dictionary of nodes", function()
		local todoist_list = {
			projects = {
				{
					is_archived = false,
					color = "lime_green",
					shared = false,
					inbox_project = true,
					id = "220474322",
					collapsed = false,
					child_order = 0,
					name = "Inbox",
					is_deleted = false,
					parent_id = nil,
					view_style = "list",
				},
			},
			items = {
				{
					user_id = 1,
					responsible_uid = nil,
					sync_id = nil,
					added_by_uid = 1,
					assigned_by_uid = 1,
					day_order = -1,
					parent_id = nil,
					all_day = false,
					child_order = 1,
					collapsed = 0,
					date_added = "2016-08-01T13:19:45Z",
					priority = 1,
					id = 102835615,
					content = "Task1",
					description = "",
					in_history = 0,
					is_deleted = 0,
					due = nil,
					project_id = 176637191,
					checked = 0,
					labels = {},
				},
			},
		}

		local converted_nodes = model.create_node_dictionary(todoist_list)

		local expected_nodes = {
			[220474322] = {
				name = "Inbox",
				parent_id = nil,
				inbox_project = true,
				collapsed = false,
				color = "lime_green",
				child_order = 0,
				is_archived = false,
				is_deleted = false,
				view_style = "list",
				children = {},
				type = "project",
				children = {},
			},
			[102835615] = {
				name = "Task1",
				description = "",
				checked = 0,
				priority = 1,
				due = nil,
				all_day = false,
				day_order = -1,
				labels = {},
				parent_id = 176637191,
				child_order = 1,
				collapsed = 0,
				date_added = "2016-08-01T13:19:45Z",
				in_history = 0,
				is_deleted = 0,
				sync_id = nil,
				type = "task",
				children = {},
			},
		}

		assert.are.equal(vim.inspect(expected_nodes), vim.inspect(converted_nodes))
	end)
end)
