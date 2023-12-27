local tree_converter = require("Todoist.model")
local tree = require("nui.tree")

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

		assert.is_true(inbox_node["id"] ~= nil)
	end)

	it("Can get the node from a tree using the id function", function()
		local buffer_id = 1
		local search_id = "52"

		local empty_tree =
			tree_converter.create_todoist_tree(buffer_id, { tree.Node({ id = search_id }), tree.Node({ id = "0" }) })

		local queried_node = empty_tree:get_node(search_id)
		assert.is_true(queried_node.id == search_id)
		assert.is_true(empty_tree.bufnr == 1)
	end)

	it("can convert a list of projects to a list of nodes", function()
		local project_list = { { id = "321", name = "something else" }, { id = "123", name = "Test Project" } }

		local node_list = tree_converter.convert_to_node_list(project_list)

		assert.is_true(#node_list == 2)
	end)
end)
