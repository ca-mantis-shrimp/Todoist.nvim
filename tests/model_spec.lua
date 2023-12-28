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

		for key, _ in ipairs(inbox_project) do
			assert.is_true(inbox_node[key] ~= nil)
		end
	end)

	it("Can get the node from a tree using the id function", function()
		local test_node = tree.Node({ id = "1" })

		local queried_node_id = tree_converter.get_node_id(test_node)

		assert.is_true(queried_node_id == "1")
	end)

	it("can convert a list of projects to a list of nodes", function()
		local project_list = { { id = "321", name = "something else" }, { id = "123", name = "Test Project" } }

		local node_list = tree_converter.convert_to_node_list(project_list)

		assert.is_true(#node_list == 2)
	end)

	it("can render a project node properly", function()
		local buffer_number = vim.api.nvim_create_buf(true, false)

		local test_tree = tree({
			bufnr = buffer_number,
			get_node_id = function(node)
				return node.id
			end,
			nodes = { tree.Node({ id = "1", text = "Test Project" }) },
		})

		local node_representation = tree_converter.prepare_node_func(test_tree:get_node("1"))

		assert.is_true(node_representation == "Test Project")
	end)
end)
