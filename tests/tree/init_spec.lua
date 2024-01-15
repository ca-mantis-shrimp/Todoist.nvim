local tree_converter = require("Todoist.tree")

describe("Modeling Todoist for Display:", function()
	it("can convert a project dictionary into a tree", function()
		local nodes = { [1] = { parent_id = 2, children = {} }, [2] = { children = {} } }
		local expected_output = {
			[2] = {
				depth = 0,
				children = {
					[1] = {
						parent_id = 2,
						depth = 1,
						children = {},
					},
				},
			},
		}

		local tree = tree_converter.create_tree(nodes)

		assert.are.equal(vim.inspect(tree), vim.inspect(expected_output))
	end)
end)
