local tree_converter = require("Todoist.model")

describe("Converting Todoist Types into nui.nvim Tree", function()
	it("Can convert a single, empty inbox project into a Tree", function()
		local inbox_project = {
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
		}

		local inbox_node = tree_converter.convert_to_node(inbox_project)

		assert.is_true(inbox_node.data == inbox_project)
	end)
end)
