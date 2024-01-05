M = {}

M.calculate_indentation = function(node)
	return vim.fn["repeat"]("| ", node.depth * 1)
end

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

M.get_collapsed_icon = function(node)
	if node.has_children then
		if node.collapsed then
			return ">"
		else
			return "v"
		end
	else
		return ""
	end
end

return M
