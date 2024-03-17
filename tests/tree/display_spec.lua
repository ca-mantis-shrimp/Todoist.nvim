local tree_converter = require("Todoist.tree.display")

describe("displaying the todoist tree as buffer lines", function()
	it("can return a list of buffer lines given a full task tree", function()
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
			"# Inbox",
			"[ ] Test Task",
			"# Test Project",
			"[ ] Test Task",
		}

		assert.are.equal(vim.inspect(buffer_lines), vim.inspect(expected_output))
	end)
	it("can return a list of buffer lines given projects and comments", function()
		local projects = {
			{
				name = "Inbox",
				type = "project",
				depth = 0,
				collapsed = true,
				children = {
					{
						name = "Test Hidden Comment",
						type = "project_note",
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
				collapsed = false,
				children = {
					{
						name = "Test Comment",
						type = "project_note",
						checked = false,
						depth = 1,
						collapsed = false,
						children = {},
					},
					{
						name = "Test Child Project",
						type = "project",
						depth = 1,
						collapsed = false,
						children = {},
					},
				},
			},
		}

		local buffer_lines = tree_converter.get_buffer_lines_from_tree(projects)

		local expected_output = {
			"# Inbox",
			"+ Test Hidden Comment",
			"# Test Project",
			"+ Test Comment",
			"## Test Child Project",
		}

		assert.are.equal(vim.inspect(buffer_lines), vim.inspect(expected_output))
	end)
end)
