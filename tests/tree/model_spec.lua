local tree_converter = require("Todoist.tree.model")

describe("Modeling Todoist for Display:", function()
	it("can convert a project dictionary into a tree", function()
		local nodes = { [1] = { parent_id = 2, children = {} }, [2] = { children = {} } }
		local expected_output = { [2] = { children = { [1] = { parent_id = 2, children = {} } } } }

		local tree = tree_converter.create_tree(nodes)

		assert.are.equal(vim.inspect(tree), vim.inspect(expected_output))
	end)
	it("can update a tree with depth", function()
		local test_tree = {
			[1] = { test = "test" },
			[2] = { test = "test" },
			[3] = { test = "test" },
		}

		local depth_calculator = function(node, depth)
			node.depth = depth
		end

		local expected_tree = {
			[1] = { depth = 0, test = "test" },
			[2] = { depth = 0, test = "test" },
			[3] = { depth = 0, test = "test" },
		}

		local updated_tree = tree_converter.set_tree_depth_immutably(test_tree, depth_calculator)

		assert.are.equal(vim.inspect(expected_tree), vim.inspect(updated_tree))
	end)
	it("can can add the depth of a root node and its' children", function()
		local layered_node = {
			[1] = {
				parent_id = nil,
				children = {
					[2] = {
						parent_id = 1,
						children = {
							[3] = {
								parent_id = 2,
								children = {},
							},
						},
					},
				},
			},
		}

		local expected_node = {
			[1] = {
				parent_id = nil,
				depth = 0,
				children = {
					[2] = {
						parent_id = 1,
						depth = 1,
						children = {
							[3] = {
								parent_id = 2,
								depth = 2,
								children = {},
							},
						},
					},
				},
			},
		}

		tree_converter.set_node_depth_from_root(layered_node[1], 0)

		assert.are.equal(vim.inspect(expected_node), vim.inspect(layered_node))
	end)
end)
