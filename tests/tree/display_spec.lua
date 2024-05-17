local tree_converter = require("Todoist.tree.display")

describe("displaying the todoist tree as buffer lines", function()
	it("can return a list of buffer lines given a full task tree", function()
		local projects = {
			{
				name = "Inbox",
				type = "project",
				id = 123,
				depth = 0,
				collapsed = false,
				children = {
					{
						name = "Test Task",
						type = "task",
						checked = false,
						id = 234,
						depth = 1,
						collapsed = false,
						children = {},
					},
				},
			},
			{
				name = "Test Project",
				type = "project",
				id = 345,
				depth = 0,
				collapsed = true,
				children = {
					{
						name = "Test Task",
						type = "task",
						checked = false,
						id = 456,
						depth = 1,
						collapsed = false,
						children = {},
					},
				},
			},
		}

		local buffer_lines = tree_converter.get_buffer_lines_from_tree(projects)

		local expected_output = {
			"# Inbox|>123",
			"[ ] Test Task|>234",
			"# Test Project|>345",
			"[ ] Test Task|>456",
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
				id = 123,
				children = {
					{
						name = "Test Hidden Comment",
						type = "project_note",
						depth = 1,
						id = 234,
						collapsed = false,
						children = {},
					},
				},
			},
			{
				name = "Test Project",
				id = 345,
				type = "project",
				depth = 0,
				collapsed = false,
				children = {
					{
						name = "Test Comment",
						type = "project_note",
						id = 456,
						checked = false,
						depth = 1,
						collapsed = false,
						children = {},
					},
					{
						name = "Test Child Project",
						id = 567,
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
			"# Inbox|>123",
			"+ Test Hidden Comment|>234",
			"# Test Project|>345",
			"+ Test Comment|>456",
			"## Test Child Project|>567",
		}

		assert.are.equal(vim.inspect(buffer_lines), vim.inspect(expected_output))
	end)
end)
