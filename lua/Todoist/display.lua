M = {}

local util = require("Todoist.util")

M.add_buffer_lines_from_node = function(lines, node, indentation_function, collapsed_function, icon_converters)
	local indentation = indentation_function(node)
	local collapsed_icon = collapsed_function(node)
	local icon = icon_converters[node.type](node)

	table.insert(lines, indentation .. collapsed_icon .. icon .. node.name)

	if util.length(node.children) == 0 then
		return line_copy
	else
		for _, child in pairs(node.children) do
			M.add_buffer_lines_from_node(lines, child, indentation_function, collapsed_function, icon_converters)
		end
	end

	return line_copy
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
		return "->"
	else
		return "*"
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
