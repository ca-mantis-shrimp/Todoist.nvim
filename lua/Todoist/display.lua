M = {}

M.calculate_indentation = function(depth)
	return vim.fn["repeat"](" ", depth * 2)
end

M.get_task_icon = function(task_checked)
	if task_checked then
		return "[x]"
	else
		return "[ ]"
	end
end

return M
