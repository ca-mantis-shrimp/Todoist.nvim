local tree_converter = require("Todoist.tree.display")
local util = require("Todoist.util")

local functions = {
	indentation = function(node)
		return vim.fn["repeat"]("| ", node.depth * 1)
	end,
	collapsed = function(node)
		if util.length(node.children) > 0 then
			if node.collapsed then
				return "> "
			else
				return "v "
			end
		else
			return ""
		end
	end,
	task = function(node)
		return "[ ] "
	end,
	project = function(node)
		return " * "
	end,
}
describe("displaying the todoist tree as buffer lines", function()
	it("can return a list of buffer lines given a full tree", function()
		local lines = {}

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

		local function node_function(input_lines, node, functions)
			local indentation = functions["indentation"](node)
			local collapsed_icon = functions["collapsed"](node)
			local icon = functions[node.type](node)

			table.insert(lines, indentation .. collapsed_icon .. icon .. node.name)

			if util.length(node.children) == 0 or node.collapsed then
				return lines
			else
				for _, child in pairs(node.children) do
					node_function(lines, child, functions)
				end
			end

			return input_lines
		end

		local buffer_lines = tree_converter.get_buffer_lines_from_tree(projects, node_function, functions)

		local expected_output = {
			"v  * Inbox",
			"| [ ] Test Task",
			">  * Test Project",
		}

		assert.are.equal(vim.inspect(lines), vim.inspect(expected_output))
	end)
	it("can return a project with a task as an array of buffer lines", function()
		local lines = {}

		local project = {
			name = "Inbox",
			type = "project",
			depth = 0,
			collapsed = false,
			children = {
				[2] = {
					name = "Test Task",
					type = "task",
					checked = false,
					depth = 1,
					collapsed = false,
					children = {},
				},
			},
		}

		local buffer_lines = tree_converter.add_buffer_lines_from_node(lines, project, functions)

		local expected_output = {
			"v  * Inbox",
			"| [ ] Test Task",
		}
		assert.are.equal(vim.inspect(lines), vim.inspect(expected_output))
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
		local collapsed_icon = tree_converter.get_collapsed_icon({ children = { {} }, collapsed = true })
		local uncollapsed_icon = tree_converter.get_collapsed_icon({ children = { {} }, collapsed = false })
		local no_children = tree_converter.get_collapsed_icon({ children = {} })

		assert.are.equal(collapsed_icon, "> ")
		assert.are.equal(uncollapsed_icon, "v ")
		assert.are.equal(no_children, " ")
	end)
	it("can return the proper project icon given archived status", function()
		local archived_icon = tree_converter.get_project_icon({ archived = true })
		local unarchived_icon = tree_converter.get_project_icon({ archived = false })

		assert.are.equal(archived_icon, "-> ")
		assert.are.equal(unarchived_icon, " * ")
	end)
end)
