local model = require("Todoist.model")

local tree = require("Todoist.tree")
local tree_display = require("Todoist.tree.display")

local util = require("Todoist.util")
local sample_projects = {
	{
		child_order = 0,
		collapsed = false,
		color = "charcoal",
		created_at = "2024-01-07T19:05:53Z",
		id = "2326329373",
		inbox_project = true,
		is_archived = false,
		is_deleted = false,
		is_favorite = false,
		name = "Inbox",
		parent_id = nil,
		shared = false,
		sync_id = nil,
		updated_at = "2024-01-07T19:05:53Z",
		v2_id = "6RJQ8Cx2Xf2Q84RC",
		view_style = "list",
	},
	{
		child_order = 1,
		collapsed = false,
		color = "teal",
		created_at = "2024-01-07T19:06:33Z",
		id = "2326329411",
		is_archived = false,
		is_deleted = false,
		is_favorite = false,
		name = "Test Project",
		parent_id = nil,
		shared = false,
		sync_id = nil,
		updated_at = "2024-01-07T19:06:33Z",
		v2_id = "6RJQ8JRMWPH6vmpF",
		view_style = "list",
	},
}
describe("integration between todoist model and the tree converter", function()
	it("converts a flat list of nodes into a tree", function()
		local todoist_items = {
			projects = sample_projects,
			items = {
				{
					added_at = "2024-01-07T19:06:15.687701Z",
					added_by_uid = "47679819",
					assigned_by_uid = nil,
					checked = false,
					child_order = 1,
					collapsed = false,
					completed_at = nil,
					content = "Test Task",
					day_order = -1,
					description = "",
					due = nil,
					duration = nil,
					id = "7568186805",
					is_deleted = false,
					labels = {},
					parent_id = nil,
					priority = 1,
					project_id = "2326329373",
					responsible_uid = nil,
					section_id = nil,
					sync_id = nil,
					updated_at = "2024-01-07T19:06:15Z",
					user_id = "47679819",
					v2_id = "6RJQ8GwqwfvPMj9j",
					v2_parent_id = nil,
					v2_project_id = "6RJQ8Cx2Xf2Q84RC",
					v2_section_id = nil,
				},
				{
					added_at = "2024-01-07T19:06:48.484070Z",
					added_by_uid = "47679819",
					assigned_by_uid = nil,
					checked = false,
					child_order = 1,
					collapsed = false,
					completed_at = nil,
					content = "Test Project Task",
					day_order = -1,
					description = "",
					due = nil,
					duration = nil,
					id = "7568188188",
					is_deleted = false,
					labels = {},
					parent_id = nil,
					priority = 1,
					project_id = "2326329411",
					responsible_uid = nil,
					section_id = nil,
					sync_id = nil,
					updated_at = "2024-01-07T19:06:48Z",
					user_id = "47679819",
					v2_id = "6RJQ8MrccjmmJM2m",
					v2_parent_id = nil,
					v2_project_id = "6RJQ8JRMWPH6vmpF",
					v2_section_id = nil,
				},
				{
					added_at = "2024-01-07T19:07:04.610799Z",
					added_by_uid = "47679819",
					assigned_by_uid = nil,
					checked = false,
					child_order = 1,
					collapsed = false,
					completed_at = nil,
					content = "Test Sub-Task",
					day_order = -1,
					description = "",
					due = nil,
					duration = nil,
					id = "7568188837",
					is_deleted = false,
					labels = {},
					parent_id = "7568188188",
					priority = 1,
					project_id = "2326329411",
					responsible_uid = nil,
					section_id = nil,
					sync_id = nil,
					updated_at = "2024-01-07T19:07:04Z",
					user_id = "47679819",
					v2_id = "6RJQ8QFv9Fv84jHm",
					v2_parent_id = "6RJQ8MrccjmmJM2m",
					v2_project_id = "6RJQ8JRMWPH6vmpF",
					v2_section_id = nil,
				},
			},
		}

		local nodes = model.create_task_node_dictionary(todoist_items)

		local new_tree = tree.create_tree(nodes)
		local tree_lines = tree_display.get_buffer_lines_from_tree(new_tree)

		assert.are.equal(util.length(new_tree), 2)
		assert.are.equal(util.length(tree_lines), 5)
	end)
	it("can create the project overview from tests tasks", function()
		local project_overview = {

			projects = sample_projects,
			project_notes = {
				{
					content = "Hello 2",
					id = "2992679862",
					is_deleted = false,
					posted_at = "2018-08-14T10:56:50.000000Z",
					posted_uid = "2671355",
					project_id = "2326329373",
					file_attachment = {
						file_type = "text/plain",
						file_name = "File1.txt",
						file_size = 1234,
						file_url = "https://example.com/File1.txt",
						upload_state = "completed",
					},
					{
						content = "Second Test",
						id = "2992679683",
						is_deleted = false,
						posted_at = "2018-08-14T10:56:50.000000Z",
						posted_uid = "2671355",
						project_id = "2326329411",
						file_attachment = {
							file_type = "text/plain",
							file_name = "File1.txt",
							file_size = 1234,
							file_url = "https://example.com/File1.txt",
							upload_state = "completed",
						},
					},
				},
			},
		}

		local nodes = model.create_project_node_dictionary(project_overview)

		local new_tree = tree.create_tree(nodes)
		local tree_lines = tree_display.get_buffer_lines_from_tree(new_tree)

		assert.are.equal(util.length(new_tree), 2)
		assert.are.equal(util.length(tree_lines), 3)
	end)
end)
