local tree_converter = require("Todoist.tree.display")

describe("displaying the todoist tree as buffer lines", function()
	it("can return a list of buffer lines given a full tree", function()
		local projects = {
			{
				name = "Inbox",
				type = "project",
				depth = 0,
				collapsed = false,
				children = {
					{
						name = "Test Task",
						type = "task",
						checked = false,
						depth = 1,
						collapsed = false,
						children = {},
					},
				},
			},
			{
				name = "Test Project",
				type = "project",
				depth = 0,
				collapsed = true,
				children = {
					{
						name = "Test Task",
						type = "task",
						checked = false,
						depth = 1,
						collapsed = false,
						children = {},
					},
				},
			},
		}

		local buffer_lines = tree_converter.get_buffer_lines_from_tree(projects)

		local expected_output = {
			"v  * Inbox",
			"| [ ] Test Task",
			">  * Test Project",
		}

		assert.are.equal(vim.inspect(buffer_lines), vim.inspect(expected_output))
	end)
end)
