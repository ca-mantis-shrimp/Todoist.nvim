M = {}

local util = require("Todoist.util")

M.get_buffer_lines_from_tree = function(tree, node_function, functions)
	local lines = {}

	for _, node in pairs(tree) do
		lines = node_function(lines, node, functions)
	end

	return lines
end

M.add_buffer_lines_from_node = function(lines, node, functions)
	local indentation = functions["indentation"](node)
	local collapsed_icon = functions["collapsed"](node)
	local icon = functions[node.type](node)

	table.insert(lines, indentation .. collapsed_icon .. icon .. node.name)

	if util.length(node.children) == 0 or node.collapsed then
		return lines
	else
		for _, child in pairs(node.children) do
			M.add_buffer_lines_from_node(lines, child, functions)
		end
	end

	return lines
end

M.calculate_indentation = function(node)
	return vim.fn["repeat"]("| ", node.depth * 1)
end

M.get_collapsed_icon = function(node)
	if #node.children > 0 then
		if node.collapsed then
			return "> "
		else
			return "v "
		end
	else
		return " "
	end
end

M.icon_converters = { task = M.get_task_icon, project = M.get_project_icon }

M.get_project_icon = function(node)
	if node.archived then
		return "-> "
	else
		return " * "
	end
end
M.get_task_icon = function(node)
	if node.checked then
		return "[x]"
	else
		return "[ ]"
	end
end

return M
