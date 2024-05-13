local tree = require("Todoist.tree")
local tree_display = require("Todoist.tree.display")

local buffer = require("Todoist.buffer")

describe("putting the tree into a buffer", function()
	it("can translate a dictionary into a tree", function()
		local nodes = {
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
			},
			[102835615] = {
				name = "Task1",
				description = "",
				checked = 0,
				priority = 1,
				due = nil,
				all_day = false,
				day_order = 0,
				labels = {},
				parent_id = 220474322,
				child_order = 1,
				collapsed = 0,
				date_added = "2016-08-01T13:19:45Z",
				in_history = 0,
				is_deleted = 0,
				sync_id = nil,
				children = {},
				type = "task",
			},
			[2992679862] = {
				name = "Test Comment",
				parent_id = 220474322,
				is_deleted = false,
				type = "project_note",
			},
			[220185923] = {
				order = 1,
				name = "Test Comment",
				parent_id = 220474322,
				is_deleted = false,
				type = "section",
			},
		}

		local new_tree = tree.create_tree(nodes)
		local tree_lines = tree_display.get_buffer_lines_from_tree(new_tree)

		local tree_buffer = buffer.create_buffer_with_lines(true, true, tree_lines)

		assert(tree_buffer ~= nil)
	end)
end)
