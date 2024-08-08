local model = require("Todoist.model")
local util = require("Todoist.util")
local test_project = {
	{
		is_archived = false,
		color = "lime_green",
		shared = false,
		inbox_project = true,
		id = 220474322,
		collapsed = false,
		child_order = 0,
		name = "Inbox",
		is_deleted = false,
		parent_id = nil,
		view_style = "list",
	},
}

describe("converting Todoist Data into the Node Model", function()
	it("can convert a dictionary of projects and comments as nodes", function()
		local types = {
			projects = test_project,
			project_notes = {
				{
					content = "test comment",
					id = "2992679862",
					project_id = "220474322",
					is_deleted = false,
				},
			},
			sections = {},
		}

		local converted_nodes = model.create_project_node_dictionary({}, types)

		assert(converted_nodes[1].type == "project" and converted_nodes[2].type == "project_note")
	end)
end)
