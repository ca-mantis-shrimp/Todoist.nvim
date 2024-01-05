local tree_converter = require("Todoist.display")

describe("displaying the todoist tree as buffer lines", function()
	it("can return a project with a task as an array of buffer lines", function()
		local project = {
			[1] = {
				name = "Inbox",
				type = "project",
				children = {
					[2] = {
						name = "Test Task",
						type = "task",
						checked = false,
						children = {},
					},
				},
			},
		}

		local expected_output = {
			"v * Inbox",
			"| [ ] Test Task",
		}
		local buffer_lines = tree_converter.convert_to_buffer_lines(project)
		assert.are.equal(vim.inspect(buffer_lines), vim.inspect(expected_output))
	end)
	it("can calculate indentation based on depth of a node", function()
		local no_indentation = tree_converter.calculate_indentation({ depth = 0 })
		local indentation = tree_converter.calculate_indentation({ depth = 1 })

		assert.are.equal(no_indentation, "")
		assert.are.equal(indentation, "| ")
	end)

	it("can return the proper icon given a task completion status", function()
		local checked_icon = tree_converter.get_task_icon({ checked = true })
		local unchecked_icon = tree_converter.get_task_icon({ checked = false })

		assert.are.equal(checked_icon, "[x]")
		assert.are.equal(unchecked_icon, "[ ]")
	end)

	it("can return the proper collased icon given collapse status", function()
		local collapsed_icon = tree_converter.get_collapsed_icon({ has_children = true, collapsed = true })
		local uncollapsed_icon = tree_converter.get_collapsed_icon({ has_children = true, collapsed = false })
		local no_children = tree_converter.get_collapsed_icon({ has_children = false })

		assert.are.equal(collapsed_icon, ">")
		assert.are.equal(uncollapsed_icon, "v")
		assert.are.equal(no_children, "")
	end)
	it("can return the proper project icon given archived status", function()
		local archived_icon = tree_converter.get_project_icon({ archived = true })
		local unarchived_icon = tree_converter.get_project_icon({ archived = false })

		assert.are.equal(archived_icon, "->")
		assert.are.equal(unarchived_icon, "*")
	end)
end)
