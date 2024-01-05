local tree_converter = require("Todoist.display")

describe("displaying the todoist tree as buffer lines", function()
	it("can calculate indentation based on depth of a node", function()
		local depth = 1

		local indentation = tree_converter.calculate_indentation(depth)

		assert.are.equal(indentation, "  ")
	end)

	it("can return the proper icon given a task completion status", function()
		local task_checked = true

		local checked_icon = tree_converter.get_task_icon(task_checked)
		local unchecked_icon = tree_converter.get_task_icon(not task_checked)

		assert.are.equal(checked_icon, "[x]")
		assert.are.equal(unchecked_icon, "[ ]")
	end)
end)
