local tree_converter = require("Todoist.model")
local tree = require("nui.tree")

describe("Converting Todoist Types into nui.nvim Tree", function()
	it("Can convert a single, empty inbox project into a Tree", function()
		local inbox_node = tree_converter.convert_to_node(inbox_project)

		assert.is_true(inbox_node.data == inbox_project)
	end)

	it("Can convert two, empty nodes into a Tree", function()
		local node_list, buffer_number = { tree.Node({}), tree.Node({}) }, 1

		local small_tree = tree_converter.convert_to_tree(buffer_number, node_list)

		assert.is_true(small_tree.bufnr == 1)
	end)
	it("Can get the node from a tree using the id function", function()
		local buffer_id = 1
		local search_id = "52"
		local empty_tree = tree({
			bufnr = buffer_id,
			nodes = { tree.Node({ id = search_id }), tree.Node({ id = "0" }) },
			get_node_id = function(node)
				return node.id
			end,
		})

		local queried_node = empty_tree:get_node(search_id)

		assert.is_true(queried_node.id == search_id)
	end)
end)

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
