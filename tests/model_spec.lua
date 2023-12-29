local tree_converter = require("Todoist.model")

describe("Converting Todoist Lists into Trees", function()
	it("can convert some projects into a dictionary", function()
		local minimal_projects = {
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
		}
		local example_output = {
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
			},
		}
		local converted_dictionary = tree_converter.convert_projects_to_dictionary(minimal_projects)

		assert.are.equal(vim.inspect(example_output), vim.inspect(converted_dictionary))
	end)

	it("can create a tree from dictionary of nodes", function()
		local nodes = { [1] = { parent_id = 2, children = {} }, [2] = { children = {} } }
		local expected_output = { [2] = { children = { [1] = { parent_id = 2, children = {} } } } }

		local tree = tree_converter.convert_to_todoist_tree(nodes)

		assert.are.equal(vim.inspect(tree), vim.inspect(expected_output))
	end)
end)
